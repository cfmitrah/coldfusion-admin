/**
*
* @file  /model/managers/EventAgendaSettings.cfc
* @author - MG
* @description - This will manage all of Event Agenda Settings.
*
*/

component output="false" displayname="Agenda" accessors="true" extends="app.model.base.DAO" {
	/*
	* Gets agenda settings for an event
	* @event_id The ID of the event
	* @agenda_setting_id
	* @layout_type The layout type for the agenda page
	* @group_by The grouping for the agenda display
	* @sub_group_by The sub grouping for the agenda display
	* @settings This is a JSON string
	*/
	public struct function EventAgendaSettingsGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventAgendaSettingsGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, variable="event_id" );
		sp.addParam( type="out", dbvarname="@agenda_setting_id", cfsqltype="cf_sql_integer", variable="agenda_setting_id" );
		sp.addParam( type="out", dbvarname="@layout_type", cfsqltype="cf_sql_varchar", variable="layout_type" );
		sp.addParam( type="out", dbvarname="@group_by", cfsqltype="cf_sql_varchar", variable="group_by" );
		sp.addParam( type="out", dbvarname="@sub_group_by", cfsqltype="cf_sql_varchar", variable="sub_group_by" );
		sp.addParam( type="out", dbvarname="@settings", cfsqltype="cf_sql_longvarchar", variable="settings" );

		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
	/*
	* Creates or Updates agenda settings for an event
	* @event_id The ID of the event
	* @agenda_setting_id
	* @layout_type The layout type for the agenda page
	* @group_by The grouping for the agenda display
	* @sub_group_by The sub grouping for the agenda display
	* @settings This is a JSON string
	*/
	public numeric function EventAgendaSettingsSet(
		required numeric event_id,
		numeric agenda_setting_id=0,
		required string layout_type,
		required string group_by,
		required string sub_group_by,
		required string settings
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventAgendaSettingsSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="inout", dbvarname="@agenda_setting_id", cfsqltype="cf_sql_integer", value=arguments.agenda_setting_id, null=( !arguments.agenda_setting_id ), variable="agenda_setting_id" );
		sp.addParam( type="in", dbvarname="@layout_type", cfsqltype="cf_sql_varchar", value=arguments.layout_type, maxlength=50 );
		sp.addParam( type="in", dbvarname="@group_by", cfsqltype="cf_sql_varchar", value=arguments.group_by, maxlength=50 );
		sp.addParam( type="in", dbvarname="@sub_group_by", cfsqltype="cf_sql_varchar", value=arguments.sub_group_by, maxlength=50 );
		sp.addParam( type="in", dbvarname="@settings", cfsqltype="cf_sql_longvarchar", value=arguments.settings );
		result = sp.execute();
		return result.getProcOutVariables().agenda_setting_id;
	}
	/*
	* Gets all of the agenda grouping info like Disintct start dates and caetgories
	* @event_id The id of the event
	*/
	public struct function AgendasGroupingInfoGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendasGroupingInfoGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="categories", resultset=1 );
		sp.addProcResult( name="dates", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
}