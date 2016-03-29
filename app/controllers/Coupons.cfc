component extends="$base" accessors="true" {
	property name="couponsManager" setter="true" getter="true";
	property name="eventsManager" setter="true" getter="true";

	public void function before( rc ) {
		rc['sidebar'] = "sidebar.event.details";
		rc['event_id'] = getCurrentEventID();
		if( !rc.event_id ){
			redirect("event.select");
		}
		rc['event_name'] = getEventsManager().getEventName( event_id=rc.event_id );
		super.before( rc );
		return;
	}
	/**
	* I am the event pages listing
	*/
	public void function default( rc ) {
		var listing_config = {
			"table_id": "coupons_listing",
			"ajax_source": "coupons.listing?event_id=" & getSessionManageUserFacade().getValue( "current_event_id" ),
			"columns": "code,description,start_on,end_on,coupon_type,value,limit,used,active,options",
			"aoColumns": [
				{
					"data": "code",
					"sTitle": "Code"
				},
				{
					"data": "description",
					"sTitle": "Description"
				},
				{
					"data": "start_on",
					"sTitle": "Start On"
				},
				{
					"data": "end_on",
					"sTitle": "End On"
				},
				{
					"data": "coupon_type",
					"sTitle": "Type",
					"bSortable": false
				},
				{
					"data": "value",
					"sTitle": "Value",
					"bSortable": false
				},
				{
					"data": "limit",
					"sTitle": "Limit"
				},
				{
					"data": "used",
					"sTitle": "Used"
				},
				{
					"data": "active",
					"sTitle": "Active"
				},
				{
					"data": "options",
					"sTitle": "Options",
					"bSortable": false
				}
			]
		};
		rc['table_id'] = listing_config.table_id;
		listing_config['ajax_source'] = buildURL( (structKeyExists(listing_config,'ajax_source') ? listing_config.ajax_source: '') );
		rc['columns'] = listing_config.columns;
		getCfStatic()
			.includeData( listing_config )
			.include( "/css/pages/common/listing.css" )
			.include( "/js/pages/common/listing.js" )
			.include("/js/pages/coupons/coupons.js");

		return;
	}
	/**
	* Returns a listing based on a given id
	*/
	public any function listing( rc ) {
		var params = {
			'start' = 0,
			'length' = 10,
			'SEARCH[VALUE]' = "",
			'ORDER[0][COLUMN]' = "0",
			'ORDER[0][DIR]' = "ASC"
		};
		var data = {};
		var columns = [ "code", "description", "start_on", "end_on", "coupon_type", "value", "limit", "used", "active", "options" ];
		structAppend(params, rc);
		params['results'] = params.length;
		params['sort_column'] = columns[ params['ORDER[0][COLUMN]'] + 1 ];
		params['sort_direction'] = params['ORDER[0][DIR]'];
		params['search'] = params['SEARCH[VALUE]'];
		data = getCouponsManager().getEventCoupons( argumentCollection=params );

		getFW().renderData( "json", data );
		return;
	}
	/**
	* I am the page details for a given page
	*/
	public void function detail( rc ) {
		if( !structKeyExists( rc, "coupon_id") || ( structKeyExists( rc, "coupon_id" ) && !isNumeric( rc.coupon_id ) ) ) {
			rc['coupon_id'] = 0;
		}
		if( !structKeyExists( rc, "coupon" ) ) {
			rc['coupon'] = {};
		}
		structAppend(rc.coupon, getCouponsManager().getCouponDetails( coupon_id=rc.coupon_id, event_id=rc.event_id ), false );
		rc['coupon']['mode'] = "Create";
		if( rc.coupon.coupon_id ) {
			rc['coupon']['mode'] = "Update";
		}else {
			rc['coupon']['coupon_type'] = 'Flat';
		}
		rc['checked']['yes'] = "checked=""checked""";
		rc['checked']['no'] = "";
		getCfStatic()
			.include("/js/pages/coupons/details.js");
		return;
	}
	/**
	* I save a page
	*/
	public void function doSave( rc ) {
		if( structKeyExists( rc, "coupon") && isStruct( rc.coupon ) && getFormUtilities().exists( fields="active,coupon_id,code,description,value,start_on,end_on,limit,registration_type_ids,coupon_type", scope=rc.coupon ) ) {
			// get the current working event id
			rc['coupon']['event_id'] = rc.event_id;
			rc['coupon']['limit'] = val( rc.coupon.limit );
			// save the page
			rc['coupon_id'] = getCouponsManager().save( argumentCollection=rc.coupon );
			if( val( rc.coupon_id ) ) {
				getAlertBox().addSuccessAlert( "Coupon was saved." );
				redirect( "coupons" );
			}else {
				getAlertBox().addErrorAlert( "The was a problem while trying to save the coupon." );
				redirect( action="coupons.detail" );
			}
		}
		return;
	}
	/**
	* deletes a coupon
	*/
	public any function delete( rc ) {
		// disassociate the media to a company, event, session
		if( structKeyExists( rc, "coupon_id" ) ) {
			getCouponsManager().deleteCoupon( argumentCollection=rc );
		}
		getFW().renderData( "json", { 'success': true } );
		return;
	}
}