/**
*
* @file  /model/dao/Agenda.cfc
* @author - JG
* @description
*
*/
component accessors="true" extends="app.model.base.Dao" {		
	/*
	* Copies the contents of an old invitation id to a new entry
	* @copy_invitation_id The id of the invitation to copy the contents from
	* @event_id The id of the event
	* @invitation_id the id of the new invitation copy
	*/
	public numeric function InvitationCopy(
		numeric event_id,
		numeric copy_invitation_id=0,
		numeric invitation_id=0
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "InvitationCopy"
		});
		sp.addParam( type="in", dbvarname="@copy_invitation_id", cfsqltype="cf_sql_integer", value=arguments.copy_invitation_id, null=( !arguments.copy_invitation_id ) );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="inout", dbvarname="@invitation_id", cfsqltype="cf_sql_integer", value=arguments.invitation_id, null=( !arguments.invitation_id ), variable="invitation_id" );
		sp.addProcResult( name="result1", resultset=1 );
		sp.addProcResult( name="result2", resultset=2 );
		result = sp.execute();
		return result.getProcOutVariables().invitation_id;
	}
	/*
	* Updates an Invitation Invite registered and/or viewed status
	* @invite_id The id of the InvitationInvite
	* @registered The value to update registered to, if NULL will not update:  0=No, 1=Yes, 2=Declined
	* @viewed The value to update viewed to, if NULL will not update
	*/
	public void function InvitationInviteStatusSet( 
		required numeric invite_id,
		numeric registered=0,
		boolean viewed=0
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "InvitationInviteStatusSet"
		});
		sp.addParam( type="in", dbvarname="@invite_id", cfsqltype="cf_sql_bigint", value=arguments.invite_id );
		sp.addParam( type="in", dbvarname="@registered", cfsqltype="cf_sql_tinyint", value=arguments.registered, null=( !arguments.registered ) );
		sp.addParam( type="in", dbvarname="@viewed", cfsqltype="cf_sql_bit", value=arguments.viewed, null=( !len( arguments.viewed ) ) );
		result = sp.execute();
		return;
	}
	/*
	* Updates an Invitation Invite sent datetime
	* @invite_id The id of the InvitationInvite
	* @result Flag indicating number of records updated succesfully
	*/
	public numeric function InvitationInviteSentSet(
		required numeric invite_id
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "InvitationInviteSentSet"
		});
		sp.addParam( type="in", dbvarname="@invite_id", cfsqltype="cf_sql_bigint", value=arguments.invite_id );
		sp.addParam( type="out", dbvarname="@result", cfsqltype="cf_sql_smallint", variable="result" );

		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data.result;
	}
	/*
	* Returns the email template info and list of recipients to recieve emails with placeholder values
	* @event_id The id of the event
	* @invitation_id The id of the invitation
	* @invitation_schedule_id The id of the invitation schedule
	*/
	public struct function InvitationInvitesGet(
		required numeric invitation_id,
		required numeric invitation_schedule_id
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "InvitationInvitesGet"
		});
		sp.addParam( type="in", dbvarname="@invitation_id", cfsqltype="cf_sql_integer", value=arguments.invitation_id );
		sp.addParam( type="in", dbvarname="@invitation_schedule_id", cfsqltype="cf_sql_integer", value=arguments.invitation_schedule_id );
		sp.addProcResult( name="template", resultset=1 );
		sp.addProcResult( name="email_records", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Gets all of the Invitation Scheduless that need to be sent
	* 	use this list of communicaitons to call InvitationInvitesGet for each
	*/
	public struct function InvitationsToSend( string schedule_date ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "InvitationsToSend"
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
	* Gets all of the Invitation Information
	* @invitation_id The id of the invitation
	* @event_id (output) of the event_id for the Invitation
	* @label (output) of the label for the Invitation
	* @subject (output) of the subject for the Invitation
	* @body (output) of the body for the Invitation
	* @from_email_id (output) of the from_email_id for the Invitation
	* @from_email (output) of the from_email for the Invitation
	* @header_media_id (output) of the header_media_id for the Invitation
	* @header_filename (output) of the header_filename for the Invitation
	* @registration_type_id (output) of the registration_type_id for the Invitation
	* @registration_type (output) of the registration_type for the Invitation
	* @respone (output) Boolean on whether to include response for accept/decline on invitation emails
	* @bcc (output) String value for email address(es) to include on invitaiton
	*/
	public struct function InvitationGet(
		required numeric invitation_id,
		numeric event_id=0,
		string label="",
		string subject="",
		string body="",
		numeric from_email_id=0,
		string from_email="",
		numeric header_media_id=0,
		string header_filename="",
		numeric registration_type_id=0,
		string registration_type="",
		boolean response = 0,
		string bcc="",
		string settings=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "InvitationGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@invitation_id", cfsqltype="cf_sql_integer", value=arguments.invitation_id, variable="invitation_id" );
		sp.addParam( type="inout", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, null=( !arguments.event_id ), variable="event_id" );
		sp.addParam( type="inout", dbvarname="@label", cfsqltype="cf_sql_varchar", value=arguments.label, maxlength=150, null=( !len( arguments.label ) ), variable="label" );
		sp.addParam( type="inout", dbvarname="@subject", cfsqltype="cf_sql_varchar", value=arguments.subject, maxlength=150, null=( !len( arguments.subject ) ), variable="subject" );
		sp.addParam( type="inout", dbvarname="@body", cfsqltype="cf_sql_longvarchar", value=arguments.body, null=( !len( arguments.body ) ), variable="body" );
		sp.addParam( type="inout", dbvarname="@from_email_id", cfsqltype="cf_sql_bigint", value=arguments.from_email_id, null=( !arguments.from_email_id ), variable="from_email_id" );
		sp.addParam( type="inout", dbvarname="@from_email", cfsqltype="cf_sql_varchar", value=arguments.from_email, maxlength=300, null=( !len( arguments.from_email ) ), variable="from_email" );
		sp.addParam( type="inout", dbvarname="@header_media_id", cfsqltype="cf_sql_bigint", value=arguments.header_media_id, null=( !arguments.header_media_id ), variable="header_media_id" );
		sp.addParam( type="inout", dbvarname="@header_filename", cfsqltype="cf_sql_varchar", value=arguments.header_filename, maxlength=200, null=( !len( arguments.header_filename ) ), variable="header_filename" );
		sp.addParam( type="inout", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id, null=( !arguments.registration_type_id ), variable="registration_type_id" );
		sp.addParam( type="inout", dbvarname="@registration_type", cfsqltype="cf_sql_varchar", value=arguments.registration_type, maxlength=150, null=( !len( arguments.registration_type ) ), variable="registration_type" );
		sp.addParam( type="inout", dbvarname="@response", cfsqltype="cf_sql_bit", value=arguments.response, null=( !len( arguments.response ) ), variable="response" );
		sp.addParam( type="inout", dbvarname="@bcc", cfsqltype="cf_sql_varchar", value=arguments.bcc, maxlength=500, null=( !len( arguments.bcc ) ), variable="bcc" );
		sp.addParam( type="inout", dbvarname="@settings", cfsqltype="cf_sql_longvarchar", value=arguments.settings, null=( !len( arguments.settings ) ), variable="settings" );
		sp.addParam( type="out", dbvarname="@registration_type_slug", cfsqltype="cf_sql_varchar", variable="registration_type_slug" );
		sp.addParam( type="out", dbvarname="@footer", cfsqltype="cf_sql_longvarchar", variable="footer" );
		sp.addProcResult( name="schedule", resultset=1 );
		sp.addProcResult( name="log", resultset=2 );
		sp.addProcResult( name="body_settings", resultset=3 );
		
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		structAppend( data, result.getProcResultSets() );
		data['body'] = data.body_settings.body;
		data['settings'] = data.body_settings.settings;
		data['footer'] = data.body_settings.footer;
		return data;
	}	
	/*
	* Gets all of the Invitations for an Event
	* @event_id The id of the event
	* @event_id The id of the event
	* @start The row to start on
	* @results The number of results to return
	* @sort_column The column to sort by - valid values ('label', 'subject', 'from_email_id', 'from_email', 'registration_type_id', 'registration_type')
	* @sort_direction The direction to sort
	* @search a Keyword to filter the results on
	*/
	public struct function InvitationsList(
		required numeric event_id,
		numeric start=1,
		numeric results=10,
		string sort_column="label",
		string sort_direction="ASC",
		string search=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "InvitationsList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", value=arguments.sort_column, maxlength=50, null=( !len( arguments.sort_column ) ) );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", value=arguments.sort_direction, maxlength=4, null=( !len( arguments.sort_direction ) ) );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", value=arguments.search, maxlength=200, null=( !len( arguments.search ) ) );
		sp.addProcResult( name="invitations", resultset=1 );
		result = sp.execute();
		
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Creates or Updates a Invitation and Returns the Invitation ID
	* @invitation_id The id of the Invitation
	* @event_id The id of the event
	* @label A friendly label for the invitation
	* @subject The subject of the email
	* @body The body of the email
	* @registration_type_id (optional) Tie the email to a given registration type, when viewed that registration type would be selected
	* @from_email the email for the invitation
	* @header_media_id the header media id for the invitation
	*/
	public numeric function InvitationSet(
		numeric invitation_id=0,
		required numeric event_id,
		required string label,
		required string subject,
		required string body,
		numeric registration_type_id=0,
		required string from_email,
		numeric header_media_id=0,
		boolean response = 0,
		string bcc="",
		string settings="",
		string footer=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "InvitationSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@invitation_id", cfsqltype="cf_sql_integer", value=arguments.invitation_id, null=( !arguments.invitation_id ), variable="invitation_id" );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@label", cfsqltype="cf_sql_varchar", value=arguments.label, maxlength=150 );
		sp.addParam( type="in", dbvarname="@subject", cfsqltype="cf_sql_varchar", value=arguments.subject, maxlength=300 );
		sp.addParam( type="in", dbvarname="@body", cfsqltype="cf_sql_longvarchar", value=arguments.body );
		sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id, null=( !arguments.registration_type_id ) );
		sp.addParam( type="in", dbvarname="@from_email", cfsqltype="cf_sql_varchar", value=arguments.from_email, maxlength=300 );
		sp.addParam( type="in", dbvarname="@header_media_id", cfsqltype="cf_sql_bigint", value=arguments.header_media_id, null=( !arguments.header_media_id ) );
		sp.addParam( type="in", dbvarname="@response", cfsqltype="cf_sql_bit", value=arguments.response, null=( !arguments.response ) );
		sp.addParam( type="in", dbvarname="@bcc", cfsqltype="cf_sql_varchar", value=arguments.bcc, maxlength=500, null=( !len( arguments.bcc ) ) );
		sp.addParam( type="in", dbvarname="@settiings", cfsqltype="cf_sql_varchar", value=arguments.settings, maxlength=500, null=( !len( arguments.settings ) ) );
		sp.addParam( type="in", dbvarname="@footer", cfsqltype="cf_sql_longvarchar", value=arguments.footer, null=( !len( arguments.footer ) ) );
		result = sp.execute();
		return result.getProcOutVariables().invitation_id;
	}
	/*
	* Gets all of the Invitations for an Event
	* @event_id The id of the event
	*/
	public struct function InvitationsGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "InvitationsGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="result1", resultset=1 );
		sp.addProcResult( name="result2", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
}