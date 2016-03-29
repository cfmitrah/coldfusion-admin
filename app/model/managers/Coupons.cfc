/**
*
* @file  /model/managers/Pages.cfc
* @author
* @description
*
*/
component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="CouponDao" getter="true" setter="true";
	/**
	* I get all of the Pages for an event
	*/
	public struct function getEventCoupons(
		required numeric event_id=0,
		start=0
		results=10,
		sort_column="title",
		sort_direction="ASC",
		numeric draw = 1
	 ) {
		var event_coupons = getCouponDao().RegistrationCouponsList( argumentCollection=arguments ).result;
		var type_classes = {
			'no_charge' = "label-warning",
			'discount' = "label-success",
			'flat' = "label-primary",
			'percent' = "label-info",
			'unknown' = "label-danger"
		};

		return {
			"draw": arguments.draw,
			"recordsTotal": isDefined("event_coupons.total") ? event_coupons.total : event_coupons.recordCount,
			"recordsFiltered":  isDefined("event_coupons.total") ? event_coupons.total : event_coupons.recordCount,
			"data": queryToArray(
				recordset=event_coupons, 
				columns=listAppend( event_coupons.columnList, "options" ),
				map=function( row, index, columns ){
				if( row.coupon_type == "percent" ){
					row['value'] = numberformat(row.value,'9.99') & "%";
				}
				else{
					row['value'] = dollarFormat( row.value );
				}
				row['limit'] = isnull(row.limit) ? "Unlimited" : row.limit;
				row['coupon_type'] = "<span class=""label " & type_classes[row.coupon_type.replaceAll( " ", "_" )] & """>" & row.coupon_type & "</span>";
				row['start_on'] = dateTimeFormat( row.start_on, "mm/dd/yyyy h:mm tt");
				row['end_on'] = dateTimeFormat( row.end_on, "mm/dd/yyyy h:mm tt");
				row['active'] = " " & yesNoFormat( row.active );
				row['options'] = "<a href=""coupons/detail/coupon_id/" & row.coupon_id & """ class=""btn btn-primary btn-sm"">Manage</a>";
				if( !isnull(row.used) && !row.used ){
					row['options'] &= "&nbsp;<a href=""##"" class=""delete btn btn-danger btn-sm"" data-coupon_id=""" & row.coupon_id & """>Delete</a>";
				}
				return row;
			})
		};
	}
	/**
	* I save a Coupon
	* @coupon_id (optional) The id of the coupon, NULL means add
	* @event_id The id of the event
	* @description (optional) A description for the coupon
	* @limit (optional) The number of times that the coupon can be used
	* @flat (optional) A flat rate to be charged to be applied
	* @discount (optional) A discount to be applied
	* @percentage (optional) A percentage to be take off of the order
	* @no_charge (optional) Whether or not not charges should be applied
	* @start_on (optional) The date that the discount is valid from
	* @end_on (optional) The date that the discount is valid until
	* @active (optional) Whether or not the coupon is active
	* @registration_type_ids Comma-delimited list of registration_type_ids
	*/
	public any function save(
		required numeric coupon_id=0,
		required numeric event_id,
		required string code,
		string description="",
		required string coupon_type,
		numeric value=0,
		numeric limit=0,
		string start_on="",
		string end_on="",
		boolean active=1,
		string registration_type_ids=""
	) {
		// save the coupon
		return getCouponDao().RegistrationCouponSet( argumentCollection=arguments );
	}
	/*
	* Gets the registration coupon for an event
	* @coupon_id The id of the Coupon
	* @event_id The id of the event
	*/
	public struct function getCouponDetails( required numeric coupon_id, required numeric event_id ) {
		var coupon = getCouponDao().RegistrationCouponGet( argumentCollection=arguments );

		// restrictions
		coupon['restrictions'] = queryToArray( recordset=coupon.restrictions );
		coupon['restriction_cnt'] = arrayLen( coupon.restrictions );
		return coupon;
	}

	/**
	* Disassociate Media to an Element
	*/
	public void function deleteCoupon( required numeric coupon_id, required numeric event_id ) {
		getCouponDao().RegistrationCouponRemove( coupon_id=arguments.coupon_id, event_id=arguments.event_id );
		return;
	}
	/*
	* Gets a coupon if it is is valid and meets all of the criteria
	* @code The coupon code
	* @event_id The id of the event
	* @registration_type_id The id of the registration type
	*/
	public struct function validate( 
		required string code,
		required numeric event_id,
		erequired numeric registration_type_id
	) {
		var validate_info = getCouponDao().RegistrationCouponValidate( argumentCollection:arguments );

		if( validate_info.valid  ) {
			validate_info['value'] = decimalFormat( validate_info.value );
			validate_info['code'] = arguments.code;
		}else {
			getAlertBox().addErrorAlert( "Sorry! But we were not able to apply this {" & arguments.code & "} promo code." );
		}
		return validate_info;
	}
}