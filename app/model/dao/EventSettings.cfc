/**
* I am the DAO for the EventSettings object
* @file  /model/dao/EventSettings.cfc
* @author 
*/
component accessors="true" extends="app.model.base.Dao" {

	/*
	* Gets a Event Page
	* @event_id The event id
	* @key The identifying key
	*/
	public struct function EventSettingAllGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventSettingAllGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="result1", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result1
		};
	}
	/*
	* Gets a Event Setting
	* @event_id The event id
	* @key The identifying key
	*/
	public struct function EventSettingByKeyGet(
		required numeric event_id,
		required string key
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventSettingByKeyGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, variable="event_id" );
		sp.addParam( type="inout", dbvarname="@key", cfsqltype="cf_sql_varchar", value=arguments.key, maxlength=100, variable="key" );
		sp.addParam( type="out", dbvarname="@s_value", cfsqltype="cf_sql_varchar", variable="s_value" );
		sp.addParam( type="out", dbvarname="@d_value", cfsqltype="cf_sql_timestamp", variable="d_value" );
		sp.addParam( type="out", dbvarname="@n_value", cfsqltype="cf_sql_integer", variable="n_value" );
		sp.addParam( type="out", dbvarname="@b_value", cfsqltype="cf_sql_bit", variable="b_value" );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
	/*
	* Creates or Updates an Event Setting and Returns the Event Setting ID
	* @event_setting_id (optional) The id of the Setting, NULL means add
	* @event_id The id of the event
	* @key The key used to identify the setting in the event
	* 
	*/
	public numeric function EventSettingSet(
		numeric event_setting_id=0,
		required numeric event_id,
		required string key,
		string s_value="",
		string d_value="",
		numeric n_value=0,
		boolean b_value
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {};
		var params = arguments;
		var b_value_null = isnull( arguments.b_value );
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventSettingSet"
		});
		trim_fields( params );  // trim all of the inputs
		if( b_value_null ) {
        	params.b_value = false;
        }
		sp.addParam( type="inout", dbvarname="@event_setting_id", cfsqltype="cf_sql_integer", value=arguments.event_setting_id, null=( !arguments.event_setting_id ), variable="event_setting_id" );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@key", cfsqltype="cf_sql_varchar", value=arguments.key, maxlength=100 );
		sp.addParam( type="in", dbvarname="@s_value", cfsqltype="cf_sql_varchar", value=arguments.s_value, maxlength=1000 );
		sp.addParam( type="in", dbvarname="@d_value", cfsqltype="cf_sql_timestamp", value=arguments.d_value, null=( !isdate( arguments.d_value ) ) );
		sp.addParam( type="in", dbvarname="@n_value", cfsqltype="cf_sql_integer", value=arguments.n_value, null=( !arguments.n_value ) );
		sp.addParam( type="in", dbvarname="@b_value", cfsqltype="cf_sql_bit", value=int( !!params.b_value ), null=b_value_null );

		result = sp.execute();
		return result.getProcOutVariables().event_setting_id;
	}
}