/**
* 
* I am the DAO for the Registration Types object
* @file  /model/dao/RegistrationType.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/*
	* Creates or Updates a Registration Type and Returns the ID
	* @registration_type_id (optional) The id of the registration_type, NULL means add
	* @event_id The id of the event to add the type too
	* @registration_type The registration type
	* @valid_from When the registration type is valid from
	* @valid_to When the registration type is valid to
	* @active Whether or not the registration type is active
	*/
	public numeric function RegistrationTypeSet(
		numeric registration_type_id=0,
		required numeric event_id,
		required string registration_type,
		string access_code="",
		string valid_from="",
		string valid_to="",
		boolean active="",
		numeric sort=0,
		boolean group_allowed=false
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationTypeSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id, null=( !arguments.registration_type_id ), variable="registration_type_id" );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@registration_type", cfsqltype="cf_sql_varchar", value=arguments.registration_type, maxlength=150 );
		sp.addParam( type="in", dbvarname="@access_code", cfsqltype="cf_sql_varchar", value=arguments.access_code, null=( !len( arguments.access_code ) ), maxlength=25 );
		sp.addParam( type="in", dbvarname="@valid_from", cfsqltype="cf_sql_timestamp", value=arguments.valid_from, null=( !isdate( arguments.valid_from ) ) );
		sp.addParam( type="in", dbvarname="@valid_to", cfsqltype="cf_sql_timestamp", value=arguments.valid_to, null=( !isdate( arguments.valid_to ) ) );
		sp.addParam( type="in", dbvarname="@active", cfsqltype="cf_sql_bit", value=arguments.active, null=( !len( arguments.active ) ) );
		sp.addParam( type="in", dbvarname="@sort", cfsqltype="cf_sql_integer", value=arguments.sort, null=( !arguments.sort ) );
		sp.addParam( type="in", dbvarname="@group_allowed", cfsqltype="cf_sql_bit", value=arguments.group_allowed );
		result = sp.execute();
		return result.getProcOutVariables().registration_type_id;
	}	/**
	* I get a registration type
	* @registration_type_id The ID of the registration type that you want to get
	* @event_id the Event ID for the registration type
	*/
	public struct function registrationTypeGet( required numeric event_id, numeric registration_type_id=0 ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "RegistrationTypeGet"
		});
		
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );		
		sp.addProcResult( name="registration_type", resultset=1 );
		sp.addProcResult( name="registration_pricing", resultset=2 );
		
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
			};
	}
	/*
	* Gets the registration volume discount for an event
	* @registration_price_id The id of the registration price
	*/
	public struct function RegistrationPriceByTypeGet(
		required numeric registration_type_id
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationPriceByTypeGet"
		});
		sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );
		sp.addParam( type="out", dbvarname="@registration_price_id", cfsqltype="cf_sql_integer", variable="registration_price_id" );
		sp.addParam( type="out", dbvarname="@valid_from", cfsqltype="cf_sql_timestamp", variable="valid_from" );
		sp.addParam( type="out", dbvarname="@valid_to", cfsqltype="cf_sql_timestamp", variable="valid_to" );
		sp.addParam( type="out", dbvarname="@price", cfsqltype="cf_sql_money", variable="price" );
		sp.addParam( type="out", dbvarname="@is_default", cfsqltype="cf_sql_bit", variable="is_default" );

		result = sp.execute();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
}
