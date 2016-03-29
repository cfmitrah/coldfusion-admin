/**
* I am the DAO for the Content object
* @file  /model/dao/Event.cfc
* @author 
*/
component accessors="true" extends="app.model.base.Dao" {
	/*
	* Creates or Updates an Content and Returns the Content ID
	* @content_id (optional) The id of the Content, NULL means add
	* @event_id The id of the event
	* @key The key used to identify the content in the event
	* @body The Content
	*/
	public numeric function ContentSet(
		numeric content_id=0,
		required numeric event_id,
		required string key,
		string content=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "ContentSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@content_id", cfsqltype="cf_sql_integer", value=arguments.content_id, null=( !arguments.content_id ), variable="content_id" );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@key", cfsqltype="cf_sql_varchar", value=arguments.key, maxlength=50 );
		sp.addParam( type="in", dbvarname="@content", cfsqltype="cf_sql_longvarchar", value=arguments.content, null=( !len( arguments.content ) ) );

		result = sp.execute();
		return result.getProcOutVariables().content_id;
	}
	/*
	* Gets a event content
	* @content_id The content id
	*/
	public struct function ContentGet( required numeric content_id ) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "ContentGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@content_id", cfsqltype="cf_sql_integer", value=arguments.content_id, variable="content_id" );
		sp.addParam( type="out", dbvarname="@event_id", cfsqltype="cf_sql_integer", variable="event_id" );
		sp.addParam( type="out", dbvarname="@key", cfsqltype="cf_sql_varchar", variable="key" );
		sp.addParam( type="out", dbvarname="@content", cfsqltype="cf_sql_longvarchar", variable="content" );

		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
	/*
	* Gets a Event Page
	* @event_id The event id
	* @key The identifying key
	*/
	public struct function ContentByKeyGet(
		required numeric event_id,
		required string key
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "ContentByKeyGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, variable="event_id" );
		sp.addParam( type="inout", dbvarname="@key", cfsqltype="cf_sql_varchar", value=arguments.key, maxlength=50, variable="key" );
		sp.addParam( type="out", dbvarname="@content_id", cfsqltype="cf_sql_integer", variable="content_id" );
		sp.addParam( type="out", dbvarname="@content", cfsqltype="cf_sql_longvarchar", variable="content" );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
}