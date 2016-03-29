/**
* I am the DAO for the Event Staff
* @file  /model/dao/EventStaff.cfc
*
*/

component accessors="true" extends="app.model.base.Dao" {
	/*
	* Associates a Staff User to a Event
	* @event_id The id of the event
	* @user_id The id of the user
	*/
	public void function EventStaffAdd(
		required numeric event_id,
		required numeric user_id,
		string role="Admin"
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventStaffAdd"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		sp.addParam( type="in", dbvarname="@role", cfsqltype="cf_sql_varchar", value=arguments.role, maxlength=100, value=trim( arguments.role ), null=(!len(trim(arguments.role))) );

		result = sp.execute();
		return;
	}
	/*
	* Remove a User to a Event Association
	* @event_id The id of the event
	* @user_id The id of the user
	*/
	public void function EventStaffRemove(
		required numeric event_id,
		required numeric user_id
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventStaffRemove"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		result = sp.execute();
		return;
	}
	/*
	* Gets all of the events a user has access to
	* @user_id The user id
	*/
	public struct function EventStaffByUserGet( required numeric user_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventStaffByUserGet"
		});
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		sp.addProcResult( name="events", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().events
		};
	}
	
}