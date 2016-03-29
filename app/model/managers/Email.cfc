/**
*
* @file  /model/managers/email.cfc
* @author  
* @description
*
*/
 
component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="EmailDao" getter="true" setter="true";
	property name="AutoResponderDao" getter="true" setter="true";
	property name="AttendeeManager" getter="true" setter="true";
	property name="EmailManagementManager" setter="true" getter="true";
	property name="CommunicationDao" getter="true" setter="true";
	property name="InvitationDao" getter="true" setter="true";
	property name="SendingToolDao" setter="true" getter="true";
	property name="AttendeeDao" setter="true" getter="true";
	property name="EventDao" setter="true" getter="true";
	property name="mailer" setter="true" getter="true";
	property name="config" setter="true" getter="true";	
	property name="EventSettingManager" setter="true" getter="true";	
	/**
	* sendReminderEmails 		
	* This method will send reminder emails
	**/	
	public void function sendReminderEmails(
		required numeric event_id,
		required numeric invitation_id,
		required numeric company_id,
		required numeric new_invitation_id
		
	){
		//get invitation email template
		var template_data = getInvitationDao().InvitationGet( invitation_id=arguments.new_invitation_id );
		var invitation_template = getConfig().paths.emails & 'email.invitation.cfm';
		//get all open invites
		var open_invites = getEmailManagementManager().getOpenInvitations( argumentCollection=arguments ).open_invites;		
		var open_invites_cnt = arrayLen( open_invites );
		template_data.settings = deserializeJSON( template_data.settings );
		for( var i=1; i<=open_invites_cnt; i++ ){
			var body = replaceTokens( open_invites[i], template_data.body );
			var footer = replaceTokens( open_invites[i], template_data.footer );
			open_invites[i]['invite_id'] = open_invites[i].invitation_id;
			getMailer().init({
				'env' : getConfig().env,
	            'from' : template_data.from_email,
	            'to' : open_invites[i].email,
	            'bcc' : template_data.bcc,
	            'subject' : template_data.subject,
	            'template' : invitation_template,
	            'data' : {
	            	'body' : body,
	            	'media_path' : getConfig().urls.wysiwyg_media,
	            	'header_image' : template_data.header_filename,
	            	'record' : open_invites[i],
	            	'email_data' : open_invites[i],
	            	'template_data' : template_data,
	            	'footer': footer
	            }
	        }); 
	        getMailer().send();
		}
		return;
	}
	/**
	* setInvitationEmailResponse 		
	* This method will set the email response for invitations
	* @response_type is either declined/accepted
	**/	
	public string function setInvitationEmailResponse(
		required numeric invite_id,
		required string response_type,
		required numeric invitation_schedule_id,
		required numeric event_id,
		required numeric invitation_id
	){
		getInvitationDao().InvitationInviteStatusSet(
			invite_id=arguments.invite_id,
			registered=arguments.response_type eq 'decline' ? 2 : 1,
			viewed=1
		);		
		var event_info = getEventDao().getEvent( event_id=arguments.event_id, company_id=arguments.company_id ).result.event_info;
		var redirect_url = 'http://' & event_info.domain_name & '/' & event_info.slug & '/invite/' & arguments.response_type & '/' & arguments.invite_id & '?invitation_id=' & arguments.invitation_id;
		return redirect_url;
	}
	/**
	* sendScheduledEmails 		
	* This method will queue up the scheduled emails
	**/	
	public void function sendScheduledEmails(
		required string send_date
	) {	
		var timestamp = dateFormat( arguments.send_date, 'YYYY-MM-DD' ) & timeFormat( arguments.send_date, ' HH:MM' );
		var comm_emails = queryToArray( getCommunicationDao().CommunicationsToSend( schedule_date=arguments.send_date ).result.emails );
		var invite_emails = queryToArray( getInvitationDao().InvitationsToSend( schedule_date=arguments.send_date ).result.emails );
		var invites_cnt = arrayLen( invite_emails );
		var comm_cnt = arrayLen( comm_emails );
		var invitation_template = getConfig().paths.emails & 'email.invitation.cfm';
		var communication_template = getConfig().paths.emails & 'email.communication.cfm';
		//send the invites
		for(var i=1;i<=invites_cnt;i++){
			var invitation = getInvitationDao().InvitationInvitesGet( 
					invitation_id=invite_emails[i].invitation_id, 
					invitation_schedule_id=invite_emails[i].invitation_schedule_id
				);
				
			var email_records = queryToArray( invitation.result.email_records );
			var template = invitation.result.template;

			if( isJson( template.settings ) ) {
				template.settings = deserializeJSON( template.settings );
			}else{
				template.settings = {};
			}
			//send the email out
			sendEmail( email_records, template, invitation_template, invite_emails[i] );
			//update the email record
			var params = {
				invitation_schedule_id : invite_emails[i].invitation_schedule_id,
				invitation_id : invite_emails[i].invitation_id,
				send_on : now(),
				sent : 1
			};
			getSendingToolDao().InvitationScheduleSet( argumentCollection = params );			

		}
		//send the comm emails
		for(var i=1;i<=comm_cnt;i++){
			var communication =  getCommunicationDao().CommunicationRecipientsGet(
					communication_id=comm_emails[i].communication_id, 
					communication_schedule_id=comm_emails[i].communication_schedule_id
				);
			
			var email_records = queryToArray( communication.result.email_records );
			var template = communication.result.template;

			//send the email out
			sendEmail( email_records, template, communication_template, comm_emails[i] );
			//update the email record
			var params = {
				communication_schedule_id : comm_emails[i].communication_schedule_id,
				communication_id : comm_emails[i].communication_id,
				send_on : now(),
				sent : 1
			};
			getSendingToolDao().CommunicationScheduleSet( argumentCollection = params );	
		}	
	}
	/**
	* sendEmail 		
	* This method will send the auto task comm/invite emails
	**/	
	private void function sendEmail( 
		required array email_records,
		required query template_data,
		required string body_template,
		required struct email_data
		
	) {
			var email_cnt = arraylen( email_records );
			var str_body = template_data.body;
			var str_footer = "";
			structAppend( template_data, {'footer':""}, false );
			str_footer = template_data.footer;
			for(var k=1;k<=email_cnt;k++) {
				try {
					var body = replaceTokens( email_records[k], str_body );
					var footer = replaceTokens( email_records[k], str_footer );
					getMailer().init({
						'env' : getConfig().env,
			            'from' : trim(template_data.from_email),
			            'to' : trim(email_records[k].email),
			            'subject' : template_data.subject,
			            'bcc' : template_data.bcc,
			            'template' : body_template,
			            'data' : {
			            	'body' : body,
			            	'media_path' : getConfig().urls.wysiwyg_media,
			            	'header_image' : template_data.header_filename,
			            	'record' : email_records[k],
			            	'email_data' : email_data,
			            	'template_data' : arguments.template_data,
			            	'footer':footer
			            }
			        }); 
			        getMailer().send();
			        if( structKeyExists( email_records[k], "invite_id" ) ) {
				    	getInvitationDao().InvitationInviteSentSet( email_records[k].invite_id );
			        }
		        }catch( any e ){
					//send out an error email
					sendErrorEmail(subject="Auto Sender Error", error_data = e, data = email_data );
				}
			}   
			abort;
		
		
	}
	/**
	* sendGeneralEmail 		
	* This will send a general email
	**/
	public void function sendGeneralEmail(
		required string subject,
		required string to_email,
		required string from_email,
		required string body,
		string cc_email="",
		string bcc_email=""		
	){
		//create mail service
		var mail_service = new mail();
		var env = getConfig().env;

		//if we are in dev then change email to dev
		if( listFindNoCase( "dev,local", env ) ){
			to_email = "joshua.g@excelaweb.com";
			cc_email = to_email;
			bcc_email = to_email;			
		}		
		
		//set email params
        mail_service.setTo( to_email ); 
        mail_service.setFrom( from_email ); 
        mail_service.setSubject( subject ); 
        mail_service.setType("html"); 
		
		//if we have cc or bcc then set them
		if( len( bcc_email ) ){
	        mail_service.setBcc( bcc_email ); 			
		}		
		if( len( cc_email ) ){
	        mail_service.setCc( cc_email ); 			
		}		
		
		//send out
		mail_service.send( body=body );

		return;
	}
	/**
	* sendErrorEmail 		
	* This method will replace all of the tokens passed to it
	**/
	public void function sendErrorEmail( required string subject, required error_data, struct data = {} ) {
		//send out an error email
		var mailerService = new mail();
		var mail_body = "";
        mailerService.setTo( 'joshua.g@excelaweb.com' ); 
        mailerService.setFrom( 'errors@meetingplay.com' ); 
        mailerService.setSubject( 'MP ERROR: ' & arguments.subject ); 
        mailerService.setType("html"); 
        savecontent variable="mail_body"{ 
            WriteOutput("There was an error<br><br>" ); 
			writedump( arguments.error_data );
			writedump( arguments.data )
        } 
		mailerService.send( body=mail_body );
		
	}
	/**
	* replaceTokens 		
	* This method will replace all of the tokens passed to it
	**/
	private string function replaceTokens( required struct map, required string template ){
		var str = arguments.template;
		var keys = listToArray( structKeyList( arguments.map ) );
		for( key in keys ){
			if( isSimpleValue( arguments.map[ key ] ) ) {
				str = replaceNoCase( str, '@@' & key & '@@', arguments.map[ key ], 'ALL' );
			}
		}
		return str;
	}
	/**
	* sendAutoResponderTestEmail 		
	* This method will test auto responder emails
	**/	
	public void function sendAutoResponderTestEmail(
		required numeric email_id,
		required string email_address
	) {
		var template = getConfig().paths.emails & 'email.autoResponder.cfm';
		var email = getAutoResponderDao().AutoresponderGet( autoresponder_id=arguments.email_id );
		getMailer().init({
			'env' : getConfig().env,
            'from' : email.from_email,
            'to' : arguments.email_address,
            'bcc' : email.bcc,
            'subject' : email.subject,
            'template' : template,
            'data' : {
            	'before_body' : email.before_body,
            	'after_body' : email.after_body,
            	'footer' : email.footer,
            	'media_path' : getConfig().urls.wysiwyg_media,
            	'header_filename' : email.header_filename
            }
        }); 
        getMailer().send();
		return;
	}
	/**
	* sendAutoResponderByType 		
	* This method will test auto responder emails
	**/	
	public void function sendAutoResponderByType(
		required numeric event_id,
		required string autoresponder_type,
		required string email_address,
		string email_body=""
	) {
		var template = getConfig().paths.emails & "email.autoResponder.cfm";
		var email = getAutoResponderDao().AutoresponderEventTypeGet( event_id=arguments.event_id, autoresponder_type=arguments.autoresponder_type );
		if( ! val( email.autoresponder_id ) ){
			throw( message : "There are currently no auto responder emails setup for " & arguments.event_id & " and " & arguments.autoresponder_type, type : "InvalidData" );
		}
		getMailer().init({
			'env' : getConfig().env,
            'from' : email.from_email,
            'to' : arguments.email_address,
            'bcc' : email.bcc,
            'subject' : email.subject,
            'template' : template,
            'data' : {
            	'before_body' : email.before_body,
            	'after_body' : email.after_body,
            	'footer' : email.footer,
            	'body' : arguments.email_body, 
            	'media_path' : getConfig().urls.wysiwyg_media,
            	'header_filename' : email.header_filename
            }
        }); 
        getMailer().send();
		return;
	}
	/**
	* I check if an email already exists in the system
	*/
	public boolean function emailExists( required string email ){
		return getEmailDao().EmailExists(arguments.email);
	}	
	/**
	* I add an email
	*/	
	public any function emailSet(){
		return getEmailDao().emailSet(argumentCollection:arguments);
	}
	
	/**
	* Basic email of new user
	*/
	public any function emailNewUser(required string email, required string username, required string password){
		
		var emailBody = "";
		savecontent variable="emailBody" { 	"<p>New MeetingPlay Account Created.</p><p>Username: #arguments.username#</p><p>Password: #htmleditformat(arguments.password)#</p>";	}
		
		var mail	=	new mail();        
		        
		mail.setSubject( "Meeting Play: New Administrative User Account Setup" );        
		mail.setTo( arguments.email );        
		mail.setFrom( "noreply@meetingplay.com" );        
		mail.addPart( type="html", charset="utf-8", body=emailBody );        

		mail.send();
		return;
	}
	/*
	* Sends out a cancel email to the attendee
	* @event_id The id of the event
	* @attendee_id The id of the attendee
	* @registration_id The id of the registration
	*/
	public void function sendAttendeeEmail( 
		required numeric event_id, 
		required numeric attendee_id, 
		required numeric registration_id, 
		boolean include_agenda=false, 
		string autoresponder_type="cancel" 
	){
		var attendee = getAttendeeManager().getAttendee( argumentCollection=arguments );
		var params = { 'autoresponder_type':arguments.autoresponder_type,'event_id':arguments.event_id, 'registration_type_id':attendee.registration_type_id };
		//get the email data
		var email_template = getAutoresponderDao().AutoresponderByTypeGet( argumentCollection=params );
		//path to the template
		var template = '/app/layouts/emails/email.default.cfm';
		//create the mail obj
		var mailer = new Mail();
		var data = {
			'from' :  email_template.from_email,
			'to' : attendee.email,
			'bcc' : email_template.bcc,
			'data' : attendee
		};
		 var attendee_totals = getAttendeeDao().AttendeeCostBreakdownGet(
            argumentCollection={
                registration_id : arguments.registration_id,
                attendee_id : arguments.attendee_id
        });
        var show_password = getEventSettingManager().getEventSettingByKey( arguments.event_id, 'register_confirmation_email_show_password' ).b_value;
        if( !isboolean( show_password ) ) {
	        show_password = false;
        }
        //replace the totals
        for( var key in attendee_totals ){
            data['data'][ lCase(key) ] = isSimpleValue( attendee_totals[ key ] ) && isnumeric( attendee_totals[ key ] ) ? lsCurrencyFormat( attendee_totals[ key ] ) : attendee_totals[ key ];
        }        
        
		data['data']['firstname'] = attendee.first_name;
		data['data']['lastname'] = attendee.last_name;
		data['data']['email'] = attendee.email;
		
		//setup params
		if( !isValid("email",data.from) ) {
			data.from = "support@meetingplay.com";
		}
		mailer.setTo( data.to );		
		mailer.setFrom( data.from );
		mailer.setBCC( data.bcc );
		mailer.setType( 'html' );
		mailer.setSubject( email_template.subject );
		mailer.addParam( name="X-Priority", value=3 );

		//this will replace all other tokens used		
		var email_data = getAutoresponderDao().AutoresponderDataGet( argumentCollection=arguments );
		//append this data to the main data struct
		structAppend( data.data, email_data );
		
		//set vars to local scope
		local = email_template;
		if( structKeyExists( data.data, 'custom' ) ) {
			structAppend( data.data, data.data.custom, false );
		}
		if( !show_password ) {
	        structDelete( data.data, "password" );
        }else if( show_password && findNoCase( local.footer, '@@password@@' ) || findNoCase( local.before_body, '@@password@@' ) || findNoCase( local.after_body, '@@password@@' ) ){
	        data['data']['password'] = RandRange(1000, 999999);

	        getAttendeeManager().updatePassword( arguments.attendee_id, data.data.password );
        }
		local.footer = replaceTokens( data.data, local.footer );
		local.before_body = replaceTokens( data.data, local.before_body );
		local.after_body = replaceTokens( data.data, local.after_body );
		
		local['before_body'] = rereplaceNoCase( local.before_body, "(@@)\w+(@@)", "", 'ALL' );
		local['after_body'] = rereplaceNoCase( local.after_body, "(@@)\w+(@@)", "", 'ALL' );
		local['footer'] = rereplaceNoCase( local.footer, "(@@)\w+(@@)", "", 'ALL' );
		
		
		if( arguments.include_agenda) {
			local.review_agenda = attendee.agenda;
			local.agenda = "";
			//replace tokens
			if( local.review_agenda.count ) {
				savecontent variable="local.agenda"{
					include '/app/layouts/emails/email.inc.agenda.cfm';
				}
			}
			local.before_body = replaceNoCase( local.before_body, "@@include_agenda@@", local.agenda, 'ALL' );
			local.after_body = replaceNoCase( local.after_body, "@@include_agenda@@", local.agenda, 'ALL' );
		}
		

		//set the absolute path to the image
		local[ 'media_path' ] = getAppConfig().urls.wysiwyg_media;
		//save the body
		savecontent variable="local.mailBody"{ 
			include template;
		} 
		//send it out
		mailer.send( body=local.mailBody );		
		return;
	}
	
		
}
