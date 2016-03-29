/**
*
* @file  /model/dao/ClientReport.cfc
* @author - JG
* @description
*
*/
component accessors="true" extends="app.model.base.Dao" {

	/*
	* Gets all of the ClientReports for an event
	* @event_id The id of the event
	*/
	public struct function genericProcExecute( required string proc ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "[" & proc & "]"
		});
		sp.addProcResult( name="data", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}	
	/*
	* Gets all of the ClientReports for an event
	* @event_id The id of the event
	*/
	public struct function ClientReportsGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "ClientReportsGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="list", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}	
	/*
	* Gets a ClientReport by Client_report_id
	* @Client_report_id The id of the coupon
	* @event_id (optional) The id of the event
	* @label (optional) A label description for the report
	* @sproc The stored procedure to call for the report
	* @params (optional) JSON for any parameters needed for the report
	* @header (optional) JSON for a header to put on the report
	*/
	public numeric function ClientReportGet(
		required numeric client_report_id,
		required numeric event_id=0,
		string label="",
		string sproc="",
		string params="",
		string header="",
		string created=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "ClientReportGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@client_report_id", cfsqltype="cf_sql_integer", value=arguments.client_report_id );
		sp.addParam( type="inout", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, null=( !arguments.event_id ), variable="event_id" );
		sp.addParam( type="inout", dbvarname="@label", cfsqltype="cf_sql_varchar", value=arguments.label, maxlength=150, null=( !len( arguments.label ) ), variable="label" );
		sp.addParam( type="inout", dbvarname="@sproc", cfsqltype="cf_sql_varchar", value=arguments.sproc, maxlength=500, null=( !len( arguments.sproc ) ), variable="sproc" );
		sp.addParam( type="inout", dbvarname="@params", cfsqltype="cf_sql_longvarchar", value=arguments.params, null=( !len( arguments.params ) ), variable="params" );
		sp.addParam( type="inout", dbvarname="@header", cfsqltype="cf_sql_longvarchar", value=arguments.header, null=( !len( arguments.header ) ), variable="header" );
		sp.addParam( type="inout", dbvarname="@created", cfsqltype="cf_sql_timestamp", value=arguments.created, null=( !len( arguments.created ) ), variable="created" );
		sp.addProcResult( name="report", resultset=1 );
		result = sp.execute();
		return result.getProcOutVariables().event_id;
	}	
}	