/**
* I am the DAO for the CustomReport object
* @file  /model/dao/CustomReport.cfc
* @author - JG
*/
component accessors="true" extends="app.model.base.Dao" {
	/*
	* Gets all of the CustomReports for an event
	* @event_id The id of the event
	*/
	public struct function CustomReportsGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CustomReportsGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="report", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Removes a CustomReport
	* @custom_report_id The id of the CustomReport
	*/
	public struct function CustomReportRemove( required numeric custom_report_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CustomReportRemove"
		});
		sp.addParam( type="in", dbvarname="@custom_report_id", cfsqltype="cf_sql_integer", value=arguments.custom_report_id );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}	
	/*
	* Gets a CustomReport by custom_report_id
	* @custom_report_id The id of the coupon
	* @event_id (optional) The id of the event
	* @label (optional) A label description for the report
	* @fields (optional) The fields to display for the report
	* @attendee_types (optional) String of the choosen registration_type_id's
	* @attendee_statuses (optional) String of the choosen attende_status's
	* @range_from (optional) Date range from
	* @range_to (optional) Date range to
	* @agendas (optional) A string of the selected agenda_ids for the report
	* @filters (optional) A string of the advanced filters for the report
	*/
	public any function CustomReportGet(
		required numeric custom_report_id,
		numeric event_id=0,
		string label="",
		string fields="",
		string attendee_types="",
		string attendee_statuses="",
		string range_from="",
		string range_to="",
		string agendas="",
		string filters="",
		string payment_processors="",
		numeric balance_due=0,
		string balance_due_operator=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CustomReportGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@custom_report_id", cfsqltype="cf_sql_integer", value=arguments.custom_report_id );
		sp.addParam( type="inout", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, null=( !arguments.event_id ), variable="event_id" );
		sp.addParam( type="inout", dbvarname="@label", cfsqltype="cf_sql_varchar", value=arguments.label, maxlength=150, null=( !len( arguments.label ) ), variable="label" );
		sp.addParam( type="inout", dbvarname="@fields", cfsqltype="cf_sql_longvarchar", value=arguments.fields, null=( !len( arguments.fields ) ), variable="fields" );
		sp.addParam( type="inout", dbvarname="@attendee_types", cfsqltype="cf_sql_varchar", value=arguments.attendee_types, maxlength=1000, null=( !len( arguments.attendee_types ) ), variable="attendee_types" );
		sp.addParam( type="inout", dbvarname="@attendee_statuses", cfsqltype="cf_sql_varchar", value=arguments.attendee_statuses, maxlength=1000, null=( !len( arguments.attendee_statuses ) ), variable="attendee_statuses" );
		sp.addParam( type="inout", dbvarname="@range_from", cfsqltype="cf_sql_date", value=arguments.range_from, null=( !len( arguments.range_from ) ), variable="range_from" );
		sp.addParam( type="inout", dbvarname="@range_to", cfsqltype="cf_sql_date", value=arguments.range_to, null=( !len( arguments.range_to ) ), variable="range_to" );
		sp.addParam( type="inout", dbvarname="@agendas", cfsqltype="cf_sql_longvarchar", value=arguments.agendas, null=( !len( arguments.agendas ) ), variable="agendas" );
		sp.addParam( type="inout", dbvarname="@filters", cfsqltype="cf_sql_longvarchar", value=arguments.filters, null=( !len( arguments.filters ) ), variable="filters" );
		sp.addParam( type="inout", dbvarname="@payment_processors", cfsqltype="cf_sql_longvarchar", value=arguments.payment_processors, null=( !len( arguments.payment_processors ) ), variable="payment_processors" );
		sp.addParam( type="inout", dbvarname="@balance_due", cfsqltype="cf_sql_money", value=arguments.balance_due, null=( !arguments.balance_due ), variable="balance_due" );
		sp.addParam( type="inout", dbvarname="@balance_due_operator", cfsqltype="cf_sql_varchar", value=arguments.balance_due_operator, maxlength=10, null=( !len( arguments.balance_due_operator ) ), variable="balance_due_operator" );
		sp.addProcResult( name="fields", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().fields,
			'proc_vars'	 = result.getProcOutVariables()
		};
	}
	/*
	* Creates or Updates an CustomReports and Returns the ID
	* @custom_report_id (optional) The id of the coupon, NULL means add
	* @event_id The id of the event
	* @label A label description for the report
	* @fields The fields to display for the report
	* @attendee_types (optional) String of the choosen registration_type_id's
	* @attendee_statuses (optional) String of the choosen attende_status's
	* @range_from (optional) Date range from
	* @range_to (optional) Date range to
	* @agendas (optional) A string of the selected agenda_ids for the report
	* @filters (optional) A string of the advanced filters for the report
	* @payment_processor_list (optional) Comma seperated list of payment_processor_id's to filter to
	* @balance_due (optional) balance due to filter to
	* @balance_due_operator (optional) balance due operator
	*/
	public numeric function CustomReportSet(
		required numeric custom_report_id,
		required numeric event_id,
		required string label,
		required string fields,
		string attendee_types="",
		string attendee_statuses="",
		string range_from="",
		string range_to="",
		string agendas="",
		string filters="",
		string payment_processors="",
		numeric balance_due=0,
		string balance_due_operator=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CustomReportSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@custom_report_id", cfsqltype="cf_sql_integer", value=arguments.custom_report_id, null=( !arguments.custom_report_id ), variable="custom_report_id" );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@label", cfsqltype="cf_sql_varchar", value=arguments.label, maxlength=150 );
		sp.addParam( type="in", dbvarname="@fields", cfsqltype="cf_sql_longvarchar", value=arguments.fields );
		sp.addParam( type="in", dbvarname="@attendee_types", cfsqltype="cf_sql_varchar", value=arguments.attendee_types, maxlength=1000, null=( !len( arguments.attendee_types ) ) );
		sp.addParam( type="in", dbvarname="@attendee_statuses", cfsqltype="cf_sql_varchar", value=arguments.attendee_statuses, maxlength=1000, null=( !len( arguments.attendee_statuses ) ) );
		sp.addParam( type="in", dbvarname="@range_from", cfsqltype="cf_sql_date", value=arguments.range_from, null=( !len( arguments.range_from ) ) );
		sp.addParam( type="in", dbvarname="@range_to", cfsqltype="cf_sql_date", value=arguments.range_to, null=( !len( arguments.range_to ) ) );
		sp.addParam( type="in", dbvarname="@agendas", cfsqltype="cf_sql_longvarchar", value=arguments.agendas, null=( !len( arguments.agendas ) ) );
		sp.addParam( type="in", dbvarname="@filters", cfsqltype="cf_sql_longvarchar", value=arguments.filters, null=( !len( arguments.filters ) ) );
		sp.addParam( type="in", dbvarname="@payment_processors", cfsqltype="cf_sql_longvarchar", value=arguments.payment_processors, null=( !len( arguments.payment_processors ) ) );
		sp.addParam( type="in", dbvarname="@balance_due", cfsqltype="cf_sql_money", value=arguments.balance_due, null=( !arguments.balance_due ) );
		sp.addParam( type="in", dbvarname="@balance_due_operator", cfsqltype="cf_sql_varchar", value=arguments.balance_due_operator, maxlength=10, null=( !len( arguments.balance_due_operator ) ) );
		result = sp.execute();
		return result.getProcOutVariables().custom_report_id;
	}	
	/*
	* Gets all of the Attendee Registrations for an event
	* @registration_type_id_list (optional) Comma seperated list of registration_type_id's to filter to
	* @attendee_status_list (optional) Comma seperated list of attendee_status's to filter to
	* @agenda_id_list (optional) Comma seperated list of agenda_id's to filter to
	* @registration_date_from (optional) Date to filter from
	* @registration_date_to (optional) Date to filter to
	*/
	public struct function CustomReportingReport(
		required numeric event_id,
		required string registration_type_id_list=0,
		string attendee_status_list="",
		required string agenda_id_list=0,
		string registration_date_from="",
		string registration_date_to="",
		string filters=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CustomReportingReport"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@registration_type_id_list", cfsqltype="cf_sql_longvarchar", value=arguments.registration_type_id_list, null=( !len( arguments.registration_type_id_list ) ) );
		sp.addParam( type="in", dbvarname="@attendee_status_list", cfsqltype="cf_sql_longvarchar", value=arguments.attendee_status_list, null=( !len( arguments.attendee_status_list ) ) );
		sp.addParam( type="in", dbvarname="@agenda_id_list", cfsqltype="cf_sql_longvarchar", value=arguments.agenda_id_list, null=( !len( arguments.agenda_id_list ) ) );
		sp.addParam( type="in", dbvarname="@registration_date_from", cfsqltype="cf_sql_timestamp", value=arguments.registration_date_from, null=( !len( arguments.registration_date_from ) ) );
		sp.addParam( type="in", dbvarname="@registration_date_to", cfsqltype="cf_sql_timestamp", value=arguments.registration_date_to, null=( !len( arguments.registration_date_to ) ) );
		sp.addParam( type="in", dbvarname="@filters", cfsqltype="cf_sql_longvarchar", value=arguments.filters, null=( !len( arguments.filters ) ) );
		sp.addProcResult( name="results", resultset=1 );
		sp.addProcResult( name="agenda_labels", resultset=2 );
		sp.addProcResult( name="labels", resultset=3 );
		sp.addProcResult( name="event_details", resultset=4 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}	
}