/**
*
* @file  /model/dao/Agenda.cfc
* @author - JG
* @description
*
*/

component accessors="true" extends="app.model.base.Dao" {
	/*
	* Returns the email template info and list of recipients to recieve emails with placeholder values
	* @event_id The id of the event
	* @communication_id The id of the communication
	* @communication_schedule_id The id of the communication schedule
	*/
	public struct function CommunicationRecipientsGet(
		required numeric communication_id,
		required numeric communication_schedule_id
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CommunicationRecipientsGet"
		});
		sp.addParam( type="in", dbvarname="@communication_id", cfsqltype="cf_sql_integer", value=arguments.communication_id );
		sp.addParam( type="in", dbvarname="@communication_schedule_id", cfsqltype="cf_sql_integer", value=arguments.communication_schedule_id );
		sp.addProcResult( name="template", resultset=1 );
		sp.addProcResult( name="email_records", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Gets all of the Communication Scheduless that need to be sent
	* 	use this list of communicaitons to call CommunicationRecipientsGet for each
	*/
	public struct function CommunicationsToSend( date schedule_date ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CommunicationsToSend"
		});
		sp.addParam( type="in", dbvarname="@schedule_date", cfsqltype="cf_sql_timestamp", value=arguments.schedule_date, null=( !len( arguments.schedule_date ) ) );
		sp.addProcResult( name="emails", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Gets all of the Communication Information
	* @communication_id The id of the Communication
	* @event_id OUTPUT of event_id of the Communicaiton
	* @label OUTPUT of label of the Communicaiton
	* @subject OUTPUT of subject of the Communicaiton
	* @body OUTPUT of body of the Communicaiton
	* @from_email_id OUTPUT of from_email_id of the Communicaiton
	* @from_email OUTPUT of from_email of the Communicaiton
	* @header_media_id OUTPUT of header_media_id of the Communicaiton
	* @header_filename OUTPUT of header_filename of the Communicaiton
	*/
	public struct function CommunicationGet(
		required numeric communication_id,
		numeric event_id=0,
		string label="",
		string subject="",
		string body="",
		numeric from_email_id=0,
		string from_email="",
		numeric header_media_id=0,
		string header_filename="",
		string bcc=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CommunicationGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@communication_id", cfsqltype="cf_sql_integer", value=arguments.communication_id, variable="communication_id" );
		sp.addParam( type="out", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, null=( !arguments.event_id ), variable="event_id" );
		sp.addParam( type="out", dbvarname="@label", cfsqltype="cf_sql_varchar", value=arguments.label, maxlength=150, null=( !len( arguments.label ) ), variable="label" );
		sp.addParam( type="out", dbvarname="@subject", cfsqltype="cf_sql_varchar", value=arguments.subject, maxlength=300, null=( !len( arguments.subject ) ), variable="subject" );
		sp.addParam( type="out", dbvarname="@body", cfsqltype="cf_sql_longvarchar", value=arguments.body, null=( !len( arguments.body ) ), variable="body" );
		sp.addParam( type="out", dbvarname="@from_email_id", cfsqltype="cf_sql_bigint", value=arguments.from_email_id, null=( !arguments.from_email_id ), variable="from_email_id" );
		sp.addParam( type="out", dbvarname="@from_email", cfsqltype="cf_sql_varchar", value=arguments.from_email, maxlength=300, null=( !len( arguments.from_email ) ), variable="from_email" );
		sp.addParam( type="out", dbvarname="@header_media_id", cfsqltype="cf_sql_bigint", value=arguments.header_media_id, null=( !arguments.header_media_id ), variable="header_media_id" );
		sp.addParam( type="out", dbvarname="@header_filename", cfsqltype="cf_sql_varchar", value=arguments.header_filename, maxlength=200, null=( !len( arguments.header_filename ) ), variable="header_filename" );
		sp.addParam( type="inout", dbvarname="@bcc", cfsqltype="cf_sql_varchar", value=arguments.bcc, maxlength=500, null=( !len( arguments.bcc ) ), variable="bcc" );
		sp.addProcResult( name="schedule", resultset=1 );
		sp.addProcResult( name="log", resultset=2 );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		structAppend( data, result.getProcResultSets() );
		return data;
	}
	/*
	* Creates or Updates a Communication and Returns the Communication ID
	* @communication_id The id of the Communication
	* @event_id The id of the event
	* @label A friendly label for the Communication
	* @subject A subject for the email communication
	* @body The body of the email
	* @from_email The From email address for the communication
	* @header_media_id The media_id for the header image
	*/
	public numeric function CommunicationSet(
		numeric communication_id=0,
		required numeric event_id,
		required string label,
		required string subject,
		required string body,
		required string from_email,
		numeric header_media_id=0,
		string bcc="" 
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CommunicationSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@communication_id", cfsqltype="cf_sql_integer", value=arguments.communication_id, null=( !arguments.communication_id ), variable="communication_id" );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@label", cfsqltype="cf_sql_varchar", value=arguments.label, maxlength=150 );
		sp.addParam( type="in", dbvarname="@subject", cfsqltype="cf_sql_varchar", value=arguments.subject, maxlength=300 );
		sp.addParam( type="in", dbvarname="@body", cfsqltype="cf_sql_longvarchar", value=arguments.body );
		sp.addParam( type="in", dbvarname="@from_email", cfsqltype="cf_sql_varchar", value=arguments.from_email, maxlength=300 );
		sp.addParam( type="in", dbvarname="@header_media_id", cfsqltype="cf_sql_bigint", value=arguments.header_media_id, null=( !arguments.header_media_id ) );
		sp.addParam( type="in", dbvarname="@bcc", cfsqltype="cf_sql_varchar", value=arguments.bcc, maxlength=500, null=( !len( arguments.bcc ) ) );
		result = sp.execute();
		return result.getProcOutVariables().communication_id;
	}
	/*
	* Gets all of the Communications for an Event
	* @event_id The id of the event
	* @start The row to start on
	* @results The number of results to return
	* @sort_column The column to sort by - valid values ('label','subject','from_email_id','from_email')
	* @sort_direction The direction to sort
	* @search a Keyword to filter the results on
	*/
	public struct function CommunicationsList(
		required numeric event_id,
		numeric start=1,
		numeric results=10,
		string sort_column="c.label",
		string sort_direction="ASC",
		string search=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CommunicationsList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", value=arguments.sort_column, maxlength=50, null=( !len( arguments.sort_column ) ) );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", value=arguments.sort_direction, maxlength=4, null=( !len( arguments.sort_direction ) ) );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", value=arguments.search, maxlength=200, null=( !len( arguments.search ) ) );
		sp.addProcResult( name="communications", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}	
}