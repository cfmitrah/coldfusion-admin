/**
* I am the DAO for the Speaker object
* @file  /model/dao/Speaker.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {
	/*
	* Activates a Registration Coupon Discount
	* @coupon_id The id of the coupon
	* @event_id The id of the event
	*/
	public void function RegistrationCouponActivate( required numeric coupon_id, required numeric event_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationCouponActivate"
		});
		sp.addParam( type="in", dbvarname="@coupon_id", cfsqltype="cf_sql_integer", value=arguments.coupon_id );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.execute();
		return;
	}
	/*
	* Deactivates a Registration Coupon Discount
	* @coupon_id The id of the coupon
	* @event_id The id of the event
	*/
	public void function RegistrationCouponDeactivate( required numeric coupon_id, required numeric event_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationCouponDeactivate"
		});
		sp.addParam( type="in", dbvarname="@coupon_id", cfsqltype="cf_sql_integer", value=arguments.coupon_id );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.execute();
		return;
	}
	/*
	* Checks to see if a Coupon Code has already been used for a event
	* @event_id The event id
	* @code The slug to check
	* @in_use (output) Whether or not the code exists
	*/
	public struct function RegistrationCouponExists( required numeric event_id, required string code ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationCouponExists"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@code", cfsqltype="cf_sql_varchar", value=arguments.code, maxlength=25 );
		sp.addParam( type="inout", dbvarname="@in_use", cfsqltype="cf_sql_bit", value=arguments.in_use, variable="in_use" );
		result = sp.execute();
		return result.getProcOutVariables().in_use;
	}
	/*
	* Gets the registration coupon for an event
	* @coupon_id The id of the Coupon
	* @event_id The id of the event
	*/
	public struct function RegistrationCouponGet(
		required numeric coupon_id,
		required numeric event_id
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationCouponGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@coupon_id", cfsqltype="cf_sql_integer", value=arguments.coupon_id, variable="coupon_id" );
		sp.addParam( type="inout", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, variable="event_id" );
		sp.addParam( type="out", dbvarname="@code", cfsqltype="cf_sql_varchar", variable="code" );
		sp.addParam( type="out", dbvarname="@description", cfsqltype="cf_sql_varchar", variable="description" );
		sp.addParam( type="out", dbvarname="@coupon_type", cfsqltype="cf_sql_varchar", variable="coupon_type" );
		sp.addParam( type="out", dbvarname="@value", cfsqltype="cf_sql_money", variable="value" );
		sp.addParam( type="out", dbvarname="@start_on", cfsqltype="cf_sql_timestamp", variable="start_on" );
		sp.addParam( type="out", dbvarname="@end_on", cfsqltype="cf_sql_timestamp", variable="end_on" );
		sp.addParam( type="out", dbvarname="@limit", cfsqltype="cf_sql_integer", variable="limit" );
		sp.addParam( type="out", dbvarname="@used", cfsqltype="cf_sql_integer", variable="used" );
		sp.addParam( type="out", dbvarname="@active", cfsqltype="cf_sql_bit", variable="active" );
		sp.addProcResult( name="restrictions", resultset=1 );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		structAppend( data, result.getProcResultSets() );
		return data;
	}
	/*
	* Removes a Registration Coupon Discount
	* @coupon_id The id of the coupon
	* @event_id The id of the event
	*/
	public void function RegistrationCouponRemove( required numeric coupon_id, required numeric event_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationCouponRemove"
		});
		sp.addParam( type="in", dbvarname="@coupon_id", cfsqltype="cf_sql_integer", value=arguments.coupon_id );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.execute();
		return;
	}
	/*
	* Associates a Restricted Registration Type to a Coupon
	* @coupon_id The id of the Coupon
	* @registration_type_id The id of the Registration Type
	*/
	public void function RegistrationCouponRestrictionAdd( required numeric coupon_id, required numeric registration_type_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationCouponRestrictionAdd"
		});
		sp.addParam( type="in", dbvarname="@coupon_id", cfsqltype="cf_sql_integer", value=arguments.coupon_id );
		sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );
		sp.execute();
		return;
	}
	/*
	* Removes a Restricted Registration Type from a Coupon
	* @coupon_id The id of the Coupon
	* @registration_type_id The id of the Registration Type
	*/
	public void function RegistrationCouponRestrictionRemove( required numeric coupon_id, required numeric registration_type_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationCouponRestrictionRemove"
		});
		sp.addParam( type="in", dbvarname="@coupon_id", cfsqltype="cf_sql_integer", value=arguments.coupon_id );
		sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );
		sp.execute();
		return;
	}
	/*
	* Gets the registration coupon restrictions for an event
	* @coupon_id The id of the Discount
	*/
	public struct function RegistrationCouponRestrictionsGet( required numeric coupon_id, required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationCouponRestrictionsGet"
		});
		sp.addParam( type="in", dbvarname="@coupon_id", cfsqltype="cf_sql_integer", value=arguments.coupon_id );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="restrictions", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().restrictions
		};
	}
	/*
	* Updates the registration coupon restrictions
	* @registration_type_ids Comma-delimited list of registration_type_ids
	* @coupon_id The coupon id
	*/
	public void function RegistrationCouponRestrictionsSet( required string registration_type_ids, required numeric coupon_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationCouponRestrictionsSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@registration_type_ids", cfsqltype="cf_sql_varchar", value=arguments.registration_type_ids, null=( !len( arguments.registration_type_ids ) ), maxlength=500 );
		sp.addParam( type="in", dbvarname="@coupon_id", cfsqltype="cf_sql_integer", value=arguments.coupon_id );
		sp.execute();
		return;
	}
	/*
	* Creates or Updates an Registration Coupon and Returns the ID
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
	public numeric function RegistrationCouponSet(
		required numeric coupon_id=0,
		required numeric event_id,
		required string code,
		string description="",
		required string coupon_type,
		required numeric value,
		numeric limit=0,
		string start_on="",
		string end_on="",
		boolean active=1,
		string registration_type_ids=""
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationCouponSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@coupon_id", cfsqltype="cf_sql_integer", value=arguments.coupon_id, null=( !arguments.coupon_id ), variable="coupon_id" );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@code", cfsqltype="cf_sql_varchar", value=arguments.code, maxlength=25 );
		sp.addParam( type="in", dbvarname="@description", cfsqltype="cf_sql_varchar", value=arguments.description, maxlength=300, null=( !len( arguments.description ) ) );
		sp.addParam( type="in", dbvarname="@coupon_type", cfsqltype="cf_sql_varchar", value=arguments.coupon_type );
		sp.addParam( type="in", dbvarname="@value", cfsqltype="cf_sql_money", value=arguments.value, null=( !arguments.value ) );
		sp.addParam( type="in", dbvarname="@limit", cfsqltype="cf_sql_integer", value=arguments.limit, null=( !arguments.limit ) );
		sp.addParam( type="in", dbvarname="@start_on", cfsqltype="cf_sql_timestamp", value=arguments.start_on, null=( !isDate( arguments.start_on ) ) );
		sp.addParam( type="in", dbvarname="@end_on", cfsqltype="cf_sql_timestamp", value=arguments.end_on, null=( !isDate( arguments.end_on ) ) );
		sp.addParam( type="in", dbvarname="@active", cfsqltype="cf_sql_bit", value=arguments.active, null=( !len( arguments.active ) ) );
		sp.addParam( type="in", dbvarname="@registration_type_ids", cfsqltype="cf_sql_varchar", value=arguments.registration_type_ids, null=( !len( arguments.registration_type_ids ) ), maxlength=500 );
		result = sp.execute();
		return result.getProcOutVariables().coupon_id;
	}
	/*
	* Gets all of the registration coupons for an event
	* @event_id The id of the event
	*/
	public struct function RegistrationCouponsGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationCouponsGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="coupons", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().coupons
		};
	}
	/*
	* Gets all of the Coupons
	* @event_id A event ID to pull specific pages for
	* @start The row to start on
	* @results The number of results to return
	* @sort_column The column to sort by
	* @sort_direction The direction to sort
	* @search a Keyword to filter the results on
	*/
	public struct function RegistrationCouponsList(
		required numeric event_id,
		numeric start=1,
		numeric results=10,
		string sort_column="code",
		string sort_direction="ASC",
		string search=""
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationCouponsList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", value=arguments.sort_column, maxlength=50, null=( !len( arguments.sort_column ) ) );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", value=arguments.sort_direction, maxlength=4, null=( !len( arguments.sort_direction ) ) );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", value=arguments.search, maxlength=200, null=( !len( arguments.search ) ) );
		sp.addProcResult( name="coupons", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().coupons
		};
	}
	/*
	* Gets a coupon if it is is valid and meets all of the criteria
	* @code The coupon code
	* @event_id The id of the event
	* @registration_type_id The id of the registration type
	*/
	public struct function RegistrationCouponValidate(
		required string code,
		required numeric event_id,
		required numeric registration_type_id
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationCouponValidate"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@code", cfsqltype="cf_sql_varchar", value=arguments.code, maxlength=25 );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );
		sp.addParam( type="out", dbvarname="@valid", cfsqltype="cf_sql_bit", variable="valid" );
		
		sp.addParam( type="out", dbvarname="@coupon_id", cfsqltype="cf_sql_integer", variable="coupon_id" );
		sp.addParam( type="out", dbvarname="@description", cfsqltype="cf_sql_varchar", variable="description" );
		sp.addParam( type="out", dbvarname="@coupon_type", cfsqltype="cf_sql_varchar", variable="coupon_type" );
		sp.addParam( type="out", dbvarname="@value", cfsqltype="cf_sql_money", variable="value" );
		sp.addParam( type="out", dbvarname="@start_on", cfsqltype="cf_sql_timestamp", variable="start_on" );
		sp.addParam( type="out", dbvarname="@end_on", cfsqltype="cf_sql_timestamp", variable="end_on" );
		sp.addParam( type="out", dbvarname="@limit", cfsqltype="cf_sql_integer", variable="limit" );
		sp.addParam( type="out", dbvarname="@used", cfsqltype="cf_sql_integer", variable="used" );
		sp.addParam( type="out", dbvarname="@active", cfsqltype="cf_sql_bit", variable="active" );
		
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
}