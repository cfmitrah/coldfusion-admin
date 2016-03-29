/**
* I am the DAO for the Email object
* @file  /model/dao/SendingTool.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {
	/*
	* Replaces Communication Filter for the communication_id
	* @communication_id The id of the Communication
	* @field_name The id of the field
	* @value_list A comma seperated list of values to create filter entries for
	* @equals Whether or not the record should be evaluated as a true or false
	*/
	public struct function CommunicationFiltersSet(
		required numeric communication_id,
		required string field_name,
		required string value_list
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CommunicationFiltersSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@communication_id", cfsqltype="cf_sql_integer", value=arguments.communication_id );
		sp.addParam( type="in", dbvarname="@field_name", cfsqltype="cf_sql_varchar", value=arguments.field_name, maxlength=128 );
		sp.addParam( type="in", dbvarname="@value_list", cfsqltype="cf_sql_longvarchar", value=arguments.value_list );
		sp.addParam( type="in", dbvarname="@equals", cfsqltype="cf_sql_bit", value=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Imports a flist of attendees and creates CommunicationRecipients for the schedule
	* @event_id The id of the event
	* @invitation_schedule_id The id of the invitation schedule
	* @attendee_id_list - comma seperated list of attendee_id's to import
	* @import_count (output) Total number of attendees imported
	*/
	public struct function CommunicationScheduleEmailImport(
		required numeric event_id,
		required numeric communication_id,
		required numeric communication_schedule_id,
		numeric import_count=0

	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CommunicationScheduleEmailImport"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@communication_id", cfsqltype="cf_sql_integer", value=arguments.communication_id );
		sp.addParam( type="in", dbvarname="@communication_schedule_id", cfsqltype="cf_sql_integer", value=arguments.communication_schedule_id );
		sp.addParam( type="inout", dbvarname="@import_count", cfsqltype="cf_sql_integer", value=arguments.import_count, null=( !arguments.import_count ), variable="import_count" );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		data['result'] = result.getProcResultSets();
		return data;
	}	
	/*
	* Creates or Updates a Communication Schedule and Returns the Communication Schedule ID
	* @communication_schedule_id The id of the Communication
	* @communication_id The id of the Communication
	* @send_on When to send the email communication
	* @sent (optional) Whether or not the scheduled item has been sent
	*/
	public numeric function CommunicationScheduleSet(
		numeric communication_schedule_id=0,
		required numeric communication_id,
		required date send_on,
		numeric sent=0
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CommunicationScheduleSet"
		});
		sp.addParam( type="inout", dbvarname="@communication_schedule_id", cfsqltype="cf_sql_integer", value=arguments.communication_schedule_id, null=( !arguments.communication_schedule_id ), variable="communication_schedule_id" );
		sp.addParam( type="in", dbvarname="@communication_id", cfsqltype="cf_sql_integer", value=arguments.communication_id );
		sp.addParam( type="in", dbvarname="@send_on", cfsqltype="cf_sql_timestamp", value=arguments.send_on );
		sp.addParam( type="in", dbvarname="@sent", cfsqltype="cf_sql_integer", value=arguments.sent, null=( !len( arguments.sent ) ) );
		result = sp.execute();
		return result.getProcOutVariables().communication_schedule_id;
	}
	/*
	* Imports a file or passed in list of email addresses and creates InvitationInvites for the schedule
	* @event_id The id of the event
	* @invitation_schedule_id The id of the invitation schedule
	* -- At least one of the following params must be supplied with the emails to import
	* @path_to_file The full path to the file including filename and extension e.g. 'C:\Import\emails.csv'
	*	- supported file types: .csv, .xls, .xlsx
	*	- .csv must have single column containing the emails to import and no column header
	*	- .xls and .xlsx files must have data in column A with no headers on a worksheet named Sheet1
	* @emails_list - comma seperated list of email addresses to import
	* --
	* @import_count (output) Total number of emails imported
	*/
	public struct function InvitationScheduleEmailImport(
		required numeric event_id,
		required numeric invitation_schedule_id,
		string path_to_file="",
		string emails_list="",
		numeric import_count=0
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "InvitationScheduleEmailImport"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@invitation_schedule_id", cfsqltype="cf_sql_integer", value=arguments.invitation_schedule_id );
		sp.addParam( type="in", dbvarname="@path_to_file", cfsqltype="cf_sql_varchar", value=arguments.path_to_file, maxlength=260, null=( !len( arguments.path_to_file ) ) );
		sp.addParam( type="in", dbvarname="@emails_list", cfsqltype="cf_sql_longvarchar", value=arguments.emails_list, null=( !len( arguments.emails_list ) ) );
		sp.addParam( type="inout", dbvarname="@import_count", cfsqltype="cf_sql_integer", value=arguments.import_count, null=( !arguments.import_count ), variable="import_count" );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		structAppend( data, result.getProcResultSets() );
		return data;
	}	
	/*
	* Creates or Updates a Invitation Schedule and Returns the Invitation Schedule ID
	* @invitation_schedule_id The id of the Invitation
	* @invitation_id The id of the invitation
	* @send_on When to send the invitation
	* @sent (optional) Whether or not the scheduled item has been sent
	*/
	public numeric function InvitationScheduleSet(
		numeric invitation_schedule_id=0,
		required numeric invitation_id,
		required date send_on,
		numeric sent=0
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "InvitationScheduleSet"
		});
		sp.addParam( type="inout", dbvarname="@invitation_schedule_id", cfsqltype="cf_sql_integer", value=arguments.invitation_schedule_id, null=( !arguments.invitation_schedule_id ), variable="invitation_schedule_id" );
		sp.addParam( type="in", dbvarname="@invitation_id", cfsqltype="cf_sql_integer", value=arguments.invitation_id );
		sp.addParam( type="in", dbvarname="@send_on", cfsqltype="cf_sql_timestamp", value=arguments.send_on );
		sp.addParam( type="in", dbvarname="@sent", cfsqltype="cf_sql_integer", value=arguments.sent, null=( !len( arguments.sent ) ) );
		result = sp.execute();
		return result.getProcOutVariables().invitation_schedule_id;
	}	/*
	* Gets all of the Invitations and Communicaitons for an Event
	* @event_id The id of the event
	*/
	public struct function EmailCommsGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EmailCommsGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="invitation", resultset=1 );
		sp.addProcResult( name="communication", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
}