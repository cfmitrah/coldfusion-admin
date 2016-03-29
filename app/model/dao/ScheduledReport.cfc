/**
* I am the DAO for the Airline object
* @file  /model/dao/ScheduledReport.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {
	/*
	* Gets all of the Report Scheduless that need to be sent
	* @schedule_date (optional) The date to check for scheduled reports.  If NULL will default to current date
	*/
	public struct function ReportsToSend( required string schedule_date ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "ReportsToSend"
		});
		sp.addParam( type="in", dbvarname="@schedule_date", cfsqltype="cf_sql_timestamp", value=arguments.schedule_date, null=( !len( arguments.schedule_date ) ) );
		sp.addProcResult( name="report", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Gets a Email
	* @email_id The email_id
	*/
	public struct function EmailGet( required numeric email_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EmailGet"
		});
		sp.addParam( type="in", dbvarname="@email_id", cfsqltype="cf_sql_integer", value=arguments.email_id );
		sp.addProcResult( name="email", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().email
		};
	}
	/*
	* Gets all of the Report Schedule Information
	* @report_schedule_id The id of the Report Schedule
	* @event_id (output) The id of the Event
	* @subject@ (output) The subject/name of the Report Schedule
	* @report (output) The report that needs to be run and sent
	* @report_settings (output) The settings for the report that needs to be run and sent
	* @from_email_id (output) The from email
	* @to_email (output) The to email(s)
	* @begin_on (output) Date to begin sending the report on
	* @end_on (output) Date to stop sending the report on 
	* @frequency (output) The frequency of the report (Daily, Weekly, Monthly)
	* @day (output) The day to send on.  For Monthly, then the day of the month.  For Daily 1=Sun, 2=Mon, 3=Tue, 4=Wed, 5=Thu, 6=Fri, 7=Sat
	* @created (output) The date the report schedule was created
	*/
	public struct function ReportScheduleGet(
		required numeric report_schedule_id,
		required numeric event_id,
		string subject="",
		string report="",
		string report_settings="",
		required numeric from_email_id=0,
		string to_email="",
		string begin_on="",
		string end_on="",
		string frequency="",
		numeric day=0,
		string created=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "ReportScheduleGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@report_schedule_id", cfsqltype="cf_sql_integer", value=arguments.report_schedule_id );
		sp.addParam( type="inout", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, null=( !arguments.event_id ), variable="event_id" );
		sp.addParam( type="inout", dbvarname="@subject", cfsqltype="cf_sql_varchar", value=arguments.subject, maxlength=150, null=( !len( arguments.subject ) ), variable="subject" );
		sp.addParam( type="inout", dbvarname="@report", cfsqltype="cf_sql_varchar", value=arguments.report, maxlength=150, null=( !len( arguments.report ) ), variable="report" );
		sp.addParam( type="inout", dbvarname="@report_settings", cfsqltype="cf_sql_varchar", value=arguments.report_settings, maxlength=2000, null=( !len( arguments.report_settings ) ), variable="report_settings" );
		sp.addParam( type="inout", dbvarname="@from_email_id", cfsqltype="cf_sql_bigint", value=arguments.from_email_id, null=( !arguments.from_email_id ), variable="from_email_id" );
		sp.addParam( type="inout", dbvarname="@to_email", cfsqltype="cf_sql_varchar", value=arguments.to_email, maxlength=2000, null=( !len( arguments.to_email ) ), variable="to_email" );
		sp.addParam( type="inout", dbvarname="@begin_on", cfsqltype="cf_sql_date", value=arguments.begin_on, null=( !len( arguments.begin_on ) ), variable="begin_on" );
		sp.addParam( type="inout", dbvarname="@end_on", cfsqltype="cf_sql_date", value=arguments.end_on, null=( !len( arguments.end_on ) ), variable="end_on" );
		sp.addParam( type="inout", dbvarname="@frequency", cfsqltype="cf_sql_varchar", value=arguments.frequency, maxlength=10, null=( !len( arguments.frequency ) ), variable="frequency" );
		sp.addParam( type="inout", dbvarname="@day", cfsqltype="cf_sql_tinyint", value=arguments.day, null=( !arguments.day ), variable="day" );
		sp.addParam( type="inout", dbvarname="@created", cfsqltype="cf_sql_timestamp", value=arguments.created, null=( !len( arguments.created ) ), variable="created" );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		structAppend( data, result.getProcResultSets() );
		return data;
	}
	
	
	
	/*
	* Gets all of the Report Scheduless for an Event
	* @event_id The id of the event
	*/
	public struct function ReportSchedulesGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "ReportSchedulesGet"
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
	* Creates or Updates a Report Schedule and Returns the Report Schedule ID
	* @report_schedule_id (output) The id of the Report Schedule, if NULL new record will be created
	* @event_id (output) The id of the Event
	* @subject@ (output) The subject/name of the Report Schedule
	* @report (output) The report that needs to be run and sent
	* @report_settings (output) The settings for the report that needs to be run and sent
	* @from_email_id (output) The from email
	* @to_email_id (output) The to email
	* @begin_on (output) Date to begin sending the report on
	* @end_on (output) Date to stop sending the report on 
	* @frequency (output) The frequency of the report (Daily, Weekly, Monthly)
	* @day (output) The day to send on.  For Monthly, then the day of the month.  For Daily 1=Sun, 2=Mon, 3=Tue, 4=Wed, 5=Thu, 6=Fri, 7=Sat
	*/
	public struct function ReportScheduleSet(
		numeric report_schedule_id=0,
		required numeric event_id,
		required string subject,
		required string report,
		required string report_settings,
		required numeric from_email_id,
		required string to_email,
		required string begin_on,
		required string end_on,
		required string frequency,
		numeric day=0
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "ReportScheduleSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@report_schedule_id", cfsqltype="cf_sql_integer", value=arguments.report_schedule_id, null=( !arguments.report_schedule_id ), variable="report_schedule_id" );
		sp.addParam( type="inout", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, variable="event_id" );
		sp.addParam( type="inout", dbvarname="@subject", cfsqltype="cf_sql_varchar", value=arguments.subject, maxlength=150, variable="subject" );
		sp.addParam( type="inout", dbvarname="@report", cfsqltype="cf_sql_varchar", value=arguments.report, maxlength=150, variable="report" );
		sp.addParam( type="inout", dbvarname="@report_settings", cfsqltype="cf_sql_varchar", value=arguments.report_settings, maxlength=2000, variable="report_settings" );
		sp.addParam( type="inout", dbvarname="@from_email_id", cfsqltype="cf_sql_bigint", value=arguments.from_email_id, variable="from_email_id" );
		sp.addParam( type="inout", dbvarname="@to_email", cfsqltype="cf_sql_varchar", value=arguments.to_email, maxlength=2000, variable="to_email" );
		sp.addParam( type="inout", dbvarname="@begin_on", cfsqltype="cf_sql_date", value=arguments.begin_on, variable="begin_on" );
		sp.addParam( type="inout", dbvarname="@end_on", cfsqltype="cf_sql_date", value=arguments.end_on, variable="end_on" );
		sp.addParam( type="inout", dbvarname="@frequency", cfsqltype="cf_sql_varchar", value=arguments.frequency, maxlength=10, variable="frequency" );
		sp.addParam( type="inout", dbvarname="@day", cfsqltype="cf_sql_tinyint", value=arguments.day, null=( !arguments.day ), variable="day" );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
	/*
	* Creates or Updates an Email and Returns the Email ID
	* @email_id (optional) The id of the email, NULL means add
	* @email_type The type of email address
	* @email The actual email address
	* @opt_out Whether or not the given email address has opted out of notifications, advertisments, etc.
	* @verified Whether or not the email address has been verified
	*/
	public numeric function EmailSet(
		numeric email_id=0,
		string email_type="",
		required string email,
		boolean opt_out=1,
		boolean verified=0
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EmailSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@email_id", cfsqltype="cf_sql_bigint", value=arguments.email_id, null=( !arguments.email_id ), variable="email_id" );
		sp.addParam( type="in", dbvarname="@email_type", cfsqltype="cf_sql_varchar", value=arguments.email_type, maxlength=50, null=( !len( arguments.email_type ) ) );
		sp.addParam( type="in", dbvarname="@email", cfsqltype="cf_sql_varchar", value=arguments.email, maxlength=300 );
		sp.addParam( type="in", dbvarname="@opt_out", cfsqltype="cf_sql_bit", value=arguments.opt_out, null=( !len( arguments.opt_out ) ) );
		sp.addParam( type="in", dbvarname="@verified", cfsqltype="cf_sql_bit", value=arguments.verified, null=( !len( arguments.verified ) ) );
		result = sp.execute();
		return result.getProcOutVariables().email_id;
	}
}