/**
*
* I am the DAO for the Registration Types object
* @file  /model/dao/RegistrationTypes.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {
	/*
	* Gets all of the remaining registration types available for an autoresponder type
	* @event_id The id of the event
	* @autoresponder_type The type of autoresponder
	* @active Filter for active column.  NULL returns all
	*/
	public struct function RegistrationTypesByAutoresponderGet(
		required numeric event_id,
		required string autoresponder_type,
		boolean active=1
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationTypesByAutoresponderGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@autoresponder_type", cfsqltype="cf_sql_varchar", value=arguments.autoresponder_type, maxlength=50 );
		sp.addParam( type="in", dbvarname="@active", cfsqltype="cf_sql_bit", value=arguments.active, null=( !len( arguments.active ) ) );
		sp.addProcResult( name="types", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}

	/**
	* I get the the Registration Types for an event
	* @event_id The ID of the event that you want the Registration Types for
	*/
	public struct function registrationTypesGet( required numeric event_id, boolean active ) {
		var sp = new StoredProc();
		var result = {};
		var active_null = isnull( arguments.active );
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "RegistrationTypesGet"
		});
		if( active_null ) {
        	arguments.active = false;
        }
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@active", cfsqltype="cf_sql_bit", value=int( !!arguments.active ), null=active_null );
		sp.addProcResult( name="registration_types", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Gets all of the registration types for an event
	* @event_id The event id
	* @start The row to start on
	* @results The number of results to return
	* @sort_column The column to sort by
	* @sort_direction The direction to sort
	* @search a Keyword to filter the results on
	*/
	public struct function RegistrationTypesList(
		required numeric event_id,
		numeric start=1,
		numeric results=10,
		string sort_column="registration_type",
		string sort_direction="ASC",
		string search=""
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationTypesList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", value=arguments.sort_column, maxlength=50, null=( !len( arguments.sort_column ) ) );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", value=arguments.sort_direction, maxlength=4, null=( !len( arguments.sort_direction ) ) );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", value=arguments.search, maxlength=400, null=( !len( arguments.search ) ) );
		sp.addProcResult( name="registration_types", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().registration_types
		};
	}
}
