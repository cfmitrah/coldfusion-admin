/**
*
* @file  /model/managers/Agendas.cfc
* @author - JG
* @description - This will manage all things email management in reference to an event.
*
*/ 
component output="false" displayname="Email Management" accessors="true" extends="app.model.base.Manager" {
	property name="StandardReportManager" setter="true" getter="true";
	property name="CommunicationDao" getter="true" setter="true";
	property name="InvitationDao" getter="true" setter="true";
	property name="emailDefaultsDao" setter="true" getter="true";
	property name="SendingToolDao" setter="true" getter="true";
	property name="AutoResponderDao" getter="true" setter="true";
	property name="EmailDao" getter="true" setter="true";
	property name="AttendeeDao" getter="true" setter="true";
	property name="mediaManager" setter="true" getter="true";
	property name="mailer" setter="true" getter="true";
	property name="config" setter="true" getter="true";	
	property name="RegistrationTypesDao" getter="true" setter="true";
	/**
	* getRegistrationTypesByAutoresponderAsStruct
	* This method will all available auto responders registration types for creation
	*/
	public struct function getRegistrationTypesByAutoresponderAsStruct(
		required numeric event_id,
		required string autoresponder_type		
	){
		return queryToStruct( getRegistrationTypesDao().RegistrationTypesByAutoresponderGet( argumentCollection=arguments ).result.types );
	}
	/**
	* getAutoResponderTypes
	* This method will get all auto repsonder types
	*/
	public query function getAutoResponderTypes(){
		return getAutoResponderDao().AutoresponderTypesGet().result.types;
	}	
	/**
	* getAutoResponderTypesAsStruct
	* This method will get all auto repsonder types
	*/
	public struct function getAutoResponderTypesAsStruct(){
		return queryToStruct( getAutoResponderTypes() );
	}		
	/**
	* getAutoResponderTypesAsArray
	* This method will get all auto repsonder types
	*/
	public array function getAutoResponderTypesAsArray(){
		return queryToArray( getAutoResponderTypes() );
	}			
	/**
	* getOpenInvitations
	* This method will get all open emails
	*/
	public struct function getOpenInvitations(
		required numeric event_id,
		required numeric company_id,
		required numeric invitation_id
	) {		
		var open_invites = [];
		var invitations = queryToArray( getStandardReportManager().getInvitationStatusReportResults( argumentCollection=arguments )	);
		var invitations_cnt = arrayLen( invitations );

		for( var i=1; i <= invitations_cnt; i++ ){
			if( invitations[ i ].registered == 0 ){
				arrayAppend( open_invites, invitations[ i ] );
			}
		}
		return {
			'open_invites' : open_invites,
			'open_invites_cnt' : arrayLen( open_invites ),
			'invite_label' : invitations_cnt > 0 ? invitations[ 1 ].invitation_label : ""
		};
	}
	/**
	* scheduleCommunicationEmail
	* This method will schedule a communication email
	*/
	public void function scheduleCommunicationEmail(
		required numeric email_id,
		required string email_type,
		required string send_time
	) {
	 	var params = {
		 	'event_id' : arguments.event_id,
		 	'communication_id' : arguments.email_id,
		 	'send_on' : arguments.send_time
	 	};
	 	//create the filters if the user chooses registration types or individual attendees
	 	//we pass in the field name, email id, and the value list
	 	if( arguments.recipient_settings == 'registration_type_id' || arguments.recipient_settings == 'attendee_id' ){
		 	var filters = {
			 	'communication_id' : arguments.email_id,
			 	'field_name' : arguments.recipient_settings,
			 	'value_list' : arguments.value_list
		 	};		 	
		 	getSendingToolDao().CommunicationFiltersSet( argumentCollection=filters );
	 	}
	 	//create the communication schedule record
	 	//get the communication schedule id
	 	params['communication_schedule_id'] = getSendingToolDao().CommunicationScheduleSet( argumentCollection=params );		
		structDelete( params, 'send_on' );		
		//create a record in the communication schedule import
		//we pass in teh event id, communication id and communincation schedule id
		getSendingToolDao().CommunicationScheduleEmailImport( argumentCollection=params );
	}

	/**
	* scheduleInvitationEmail
	* This method will schedule an invitation email
	*/
	public void function scheduleInvitationEmail(
		required numeric email_id,
		required string email_type,
		required string send_time,
		string import_file = "",
		string send_to = ""
		
	) {
		var tmp_dir = getConfig().paths.tmp;
	 	var params = {
		 	'event_id' : arguments.event_id,
		 	'invitation_id' : arguments.email_id,
		 	'send_on' : arguments.send_time
	 	};
	 	var ftpService = "";
	 	var result = "";
	 	//get the invitation schedule id
	 	params['invitation_schedule_id'] = getSendingToolDao().InvitationScheduleSet( argumentCollection=params );
	 	//if we have an import file upload it
	 	if( len( arguments.import_file )){
			if( directoryExists( tmp_dir ) ){				

				var mime_types = "text/plain,text/csv,application/msexcel,application/x-msexcel,application/excel,application/vnd.ms-excel,application/x-tika-ooxml,application/msword";
				var upload = fileUpload( tmp_dir, 'email.import_file', mime_types, 'makeunique' );
				var file_separator = createObject("java", "java.lang.System").getProperty("file.separator");
				
				params['path_to_file'] = getConfig().paths.sql_import_tmp & file_separator & upload.serverFile;
				
			 	ftpService = new ftp(); 
			    /* Set attributes using implicit setters */ 
			    ftpService.setUsername("file_import_ftp"); 
			    ftpService.setPassword("v8FK##(oR7]2n"); 
			    ftpService.setServer("76.12.157.187"); 
			    ftpService.setStopOnError("true"); 
			    ftpService.setConnection("conn"); 
			    result = ftpService.open(); 
				
				ftpService.putFile(transferMode="binary", localfile=upload.serverDirectory & file_separator & upload.serverFile, remoteFile=getConfig().paths.ftp & upload.serverFile );
				ftpService.close(connection="conn");
			}else{
				Throw(type="InvalidData", message="The upload directory does not exist.");
			}
	 	}
	 	//if we have a list of emails use it
		if( len( arguments.send_to )){
			params['emails_list'] = arguments.send_to;
		}
		//schedule it!
		getSendingToolDao().InvitationScheduleEmailImport( argumentCollection=params );
		return;
	}
	/**
	* sendTestEmail
	* This method will send a test email
	*/
	public void function sendTestEmail(
		required string send_to,
		required numeric email_id,
		required string email_type
	) {
		var target = '../../app/layouts/emails/';
		var template =  target & 'email.' & arguments.email_type & '.cfm';
		if( arguments.email_type == 'invitation' ){
			var email = getInvitationDao().InvitationGet( invitation_id = arguments.email_id );
			email.settings = deSerializeJSON( email.settings );
		}
		if( arguments.email_type == 'communication' )
			var email = getCommunicationDao().CommunicationGet( communication_id = arguments.email_id );
			
		getMailer().init({
			'env' : getConfig().env,
            'from' : email.from_email,
            'to' : arguments.send_to,
            'bcc' : email.bcc,
            'subject' : email.subject,
            'template' : template,
            'data' : {
            	'body' : email.body,
            	'header_image' : email.header_filename,
            	'data' : email,
            	'footer':email.footer
            }
        }); 
        getMailer().send();
	}
	/**
	* getEmailLabels
	* This method will get and merge email labels
	*/
	public array function getEmailLabels( required numeric event_id ) {
		var labels = getSendingToolDao().EmailCommsGet( argumentCollection=arguments );
		var invitations = queryToArray( labels.result.invitation );
		var communications = queryToArray( labels.result.communication );
		var invitation_cnt = arrayLen( invitations );
		var communication_cnt = arrayLen( communications );
		var data = [];
		for(var i=1; i<=invitation_cnt; i++ ){ 
			var tmp = {};
			tmp[ 'label' ] = invitations[i].label;
			tmp[ 'email_id' ] = invitations[i].invitation_id;
			tmp[ 'type' ] = 'invitation';
			arrayAppend( data, tmp );
		}
		for(var i=1; i<=communication_cnt; i++ ){ 
			var tmp = {};
			tmp[ 'label' ] = communications[i].label;
			tmp[ 'email_id' ] = communications[i].communication_id;
			tmp[ 'type' ] = 'communication';
			arrayAppend( data, tmp );
		}
		return data;
	}
	/**
	* getEmailLabels
	* This method will get and merge email labels
	*/
	public struct function getInviationEmailLabelsAsStruct( required numeric event_id ) {
		return queryToStruct( getSendingToolDao().EmailCommsGet( argumentCollection=arguments ).result.invitation );
	}
	/**
	* getEmailLabels
	* This method will get and merge email labels
	*/
	public array function getInviationEmailLabelsAsArray( required numeric event_id ) {
		return queryToArray( getSendingToolDao().EmailCommsGet( argumentCollection=arguments ).result.invitation );
	}
	/**
	* setAutoResponderContent
	* This method will set the auto responders content
	*/
	public void function setAutoResponderContent(
		required numeric event_id,
		numeric autoresponder_id=0,
		required string autoresponder_type,
		required string label,
		required string from_email,
		required string subject,
		required string header_image,
		required string before_body,
		required string after_body,
		numeric header_media_id=0,
		numeric remove_image = 0,
		string footer=""
	) {
		var params = arguments;
		if( len( arguments.header_image )){
		 	var email_image = getMediaManager().upload( field_name="email.header_image" );
		 	var email_media_id = getMediaManager().save( argumentCollection=email_image );	 	
		 	params['header_media_id'] = email_media_id;			
		}
		structDelete( params, 'header_image' );
		if( params.remove_image ){
			structDelete( params, 'header_media_id' );			
		}
	 	getAutoResponderDao().AutoResponderSet( argumentCollection=params );
	 	return;
	}	
	/**
	* getAutoResponderDetails
	* This method will get the auto responders content
	*/
	public struct function getAutoResponderDetails( required numeric autoresponder_id ) {
		return getAutoResponderDao().AutoresponderGet( argumentCollection=arguments );
	}
	/**
	* AutoresponderByTypeGet
	* This method will get the auto responders content by type
	*/
	public struct function AutoresponderByTypeGet(
		required numeric event_id,
		required string autoresponder_type
	){
		return getAutoResponderDao().AutoresponderByTypeGet( argumentCollection=arguments );
	}
	/**
	* setEmailDefaultsContent
	* This method will set the default email content
	*/
	public void function setEmailDefaultsContent(
		required numeric event_id,
		required string from_email,
		required string subject,
		string header_image
	) {
		var params = arguments;
		if( len( arguments.header_image )){
		 	var email_image = getMediaManager().upload( field_name="email.header_image" );
		 	var email_media_id = getMediaManager().save( argumentCollection=email_image );	 	
		 	params['header_media_id'] = email_media_id;			
		}
		structDelete( params, 'header_image' );
	 	getemailDefaultsDao().EmailDefaultsSet( argumentCollection=params );
	 	return;
		
	}
	/**
	* getCommunicationDetails
	* This method will return Communication content
	*/
	public struct function getEmailDefaults( required numeric event_id ) {
		return getemailDefaultsDao().EmailDefaultsGet( argumentCollection=arguments );
	}
	/**
	* getCommunicationDetails
	* This method will return Communication content
	*/
	public struct function getCommunicationDetails( required numeric communication_id ) {
		return getCommunicationDao().CommunicationGet( argumentCollection=arguments );
	}
	/**
	* getInvitationDetails
	* This method will return Invitation content
	*/
	public struct function getInvitationDetails( required numeric invitation_id ) {
		var email_details = getInvitationDao().InvitationGet( argumentCollection=arguments );
		var settings_default = getDefaultInviteSettings();
		//if the settings string has never been set.
		if( ! len( email_details.settings ) ){
			email_details.settings = settings_default;
			return email_details;
		}
		//if not lets merge in the defaults		
		email_details.settings = deserializeJSON( email_details.settings );
		structAppend( email_details.settings, settings_default, false );
		return email_details;
	}
	/**
	* setCommunicationContent
	* This method willset Communication content
	*/
	public void function setCommunicationContent(
		required numeric event_id,
		required string label,
		required string from_email,
		required string body,
		required string header_image,
		numeric communication_id,
		numeric header_media_id=0,
		numeric remove_image=0
	) {
		var params = arguments;
		if( len( arguments.header_image )){
		 	var email_image = getMediaManager().upload( field_name="email.header_image" );
		 	var email_media_id = getMediaManager().save( argumentCollection=email_image );	 	
		 	params['header_media_id'] = email_media_id;			
		}
		structDelete( params, 'header_image' );
		if( params.remove_image ){
			structDelete( params, 'header_media_id' );			
		}
	 	getCommunicationDao().CommunicationSet( argumentCollection=params );
	 	return;
	 }	
	/**
	* setInvitationContent
	* This method willset Invitation content
	*/
	public void function setInvitationContent(
		required numeric event_id,
		required string label,
		required string from_email,
		required string body,
		required string header_image,
		numeric registration_type_id=0,
		numeric invitation_id,
		numeric header_media_id=0,
		numeric remove_image = 0,
		boolean response = 0,
		struct settings = {},
		string footer = ""
	) {
		var params = arguments;
		if( len( arguments.header_image )){
		 	var email_image = getMediaManager().upload( field_name="email.header_image" );
		 	var email_media_id = getMediaManager().save( argumentCollection=email_image );	 	
		 	params['header_media_id'] = email_media_id;			
		}
		structDelete( params, 'header_image' );
		if( params.remove_image ){
			structDelete( params, 'header_media_id' );			
		}
		params.settings = serializeJSON( arguments.settings );
	 	getInvitationDao().InvitationSet( argumentCollection=params );
	 	return;
	 }	
	/**
	* getInvitationsListing
	* This method will return a list of invitations per event
	*/
	public struct function getInvitationsListing(
		required numeric event_id, 
		numeric order_index=0, 
		string order_dir="asc", 
		string search_value="", 
		numeric start_row=0, 
		numeric total_rows=10, 
		numeric draw=1
	 ) {
		var columns = [ "label", "subject" ];
		var params = {
			event_id : arguments.event_id,
			start : ( start_row + 1 ),
			results : arguments.total_rows,
			sort_column : columns[ order_index + 1 ],
			sort_direction : arguments.order_dir,
			search : arguments.search_value
		};
		var invitations = getInvitationDao().InvitationsList( argumentCollection = params ).result.invitations;
		return {
			"draw" : arguments.draw,
			"recordsTotal" : val( invitations.total ) ? invitations.total : 0,
			"recordsFiltered" : val( invitations.total ) ? invitations.total : 0,
			"data": queryToArray( invitations )
		};
	}
	/**
	* getCommunicationsListing
	* This method will return a list of communications per event
	*/
	public struct function getCommunicationsListing(
		required numeric event_id, 
		numeric order_index=0, 
		string order_dir="asc", 
		string search_value="", 
		numeric start_row=0, 
		numeric total_rows=10, 
		numeric draw=1
	 ) {
		var columns = [ "label", "subject" ];
		var params = {
			event_id : arguments.event_id,
			start : ( start_row + 1 ),
			results : arguments.total_rows,
			sort_column : columns[ order_index + 1 ],
			sort_direction : arguments.order_dir,
			search : arguments.search_value
		};
		var communications = getCommunicationDao().CommunicationsList( argumentCollection = params ).result.communications;
		return {
			"draw" : arguments.draw,
			"recordsTotal" : val( communications.total ) ? communications.total : 0,
			"recordsFiltered" : val( communications.total ) ? communications.total : 0,
			"data": queryToArray( communications )
		};
	}
	/**
	* getAttendeesListing
	* This method will return a list of Attendees per event
	*/
	public struct function getAttendeesListing(
		required numeric event_id, 
		numeric order_index=0, 
		string order_dir="asc", 
		string search_value="", 
		numeric start_row=0, 
		numeric total_rows=10, 
		numeric draw=1
	 ) {
		var columns = [ "first_name", "last_name", "email", "registration_type", "active" ];
		var params = {
			event_id : arguments.event_id,
			start : ( start_row + 1 ),
			results : arguments.total_rows,
			sort_column : columns[ order_index + 1 ],
			sort_direction : arguments.order_dir,
			search : arguments.search_value
		};
		var attendees = getAttendeeDao().AttendeesList( argumentCollection = params ).result;
		return {
			"draw" : arguments.draw,
			"recordsTotal" : val( attendees.total ) ? attendees.total : 0,
			"recordsFiltered" :val( attendees.total ) ? attendees.total : 0,
			"data": queryToArray( attendees )
		};
	}
	/**
	* getAutoResponderListing
	* This method will return a list of invitations per event
	*/
	public struct function getAutoResponderListing(
		required numeric event_id, 
		numeric order_index=0, 
		string order_dir="asc", 
		string search_value="", 
		numeric start_row=0, 
		numeric total_rows=10, 
		numeric draw=1
	 ) {
		var columns = [ "label", "subject", "registration_type", "active" ];
		var params = {
			event_id : arguments.event_id,
			start : ( start_row + 1 ),
			results : arguments.total_rows,
			sort_column : columns[ order_index + 1 ],
			sort_direction : arguments.order_dir,
			search : arguments.search_value
		};
		var autoResponder = getAutoResponderDao().AutoRespondersList( argumentCollection = params ).result.autoResponder;
//		setabort( autoResponder );
		return {
			"draw" : arguments.draw,
			"recordsTotal" :  val( autoResponder.total ) ? autoResponder.total : 0,
			"recordsFiltered" : val( autoResponder.total ) ? autoResponder.total : 0,
			"data": queryToArray( autoResponder )
		};
	}
	/**
	* getAutoResponderListing
	* This method will return a list of invitations per event
	*/
	public struct function getEmailHistoryListing(
		required numeric event_id, 
		numeric order_index=5, 
		string order_dir="asc", 
		string search_value="", 
		numeric start_row=0, 
		numeric total_rows=10, 
		numeric draw=1
	 ) {
		var columns = [ "comm_type", "label", "subject", "from_email", "send_on", "sent", "recipients" ];
		var params = {
			event_id : arguments.event_id,
			start : ( start_row + 1 ),
			results : arguments.total_rows,
			sort_column : columns[ order_index + 1 ],
			sort_direction : arguments.order_dir,
			search : arguments.search_value
		};
		var history = getEmailDao().EmailCommSchedulesList( argumentCollection = params ).result.history;
		return {
			"draw" : arguments.draw,
			"recordsTotal" : val( history.total ) ? history.total : 0,
			"recordsFiltered" : val( history.total ) ? history.total : 0,
			"data": queryToArray( history )
		};
	}
	/**
	* getEmailHistory
	* This method will return a list of invitations per event
	*/
	public array function getEmailHistory( required numeric event_id ) {
		//status key array
		var statuses = [ 'Pending', 'Sent', 'Cancelled' ];
		//get history
		var ret = getEmailDao().EmailCommSchedulesGet( argumentCollection = arguments );
		//set up the 2 types of returns
		var invitations = queryToArray( recordset=ret.result.invitations );
		var communications = queryToArray( recordset=ret.result.communications );		
		var email_history = [];
		//create a merged array of structs
		for( var i=1; i <= arrayLen( invitations ); i++ ){
			var tmp = {
				'id' : invitations[i].invitation_id,
				'schedule_id' : invitations[i].invitation_schedule_id,
				'type' : "Invitations",
				'label' : invitations[i].label,
				'sent_to' : invitations[i].recipients,
				'send_date' : dateFormat( invitations[i].send_on, 'MM/DD/YYYY' ) & ' ' & timeFormat( invitations[i].send_on, 'hh:mm tt' ),
				'status' : statuses[ invitations[i].sent + 1 ],
				'status_id' : invitations[i].sent				
			};
			arrayAppend( email_history, tmp );
		}
		for( var i=1; i <= arrayLen( communications ); i++ ){
			var tmp = {
				'id' : communications[i].communication_id,
				'schedule_id' : communications[i].communication_schedule_id,
				'type' : "Communications",
				'label' : communications[i].label,
				'sent_to' : communications[i].recipients,
				'send_date' : dateFormat( communications[i].send_on, 'MM/DD/YYYY' ) & ' ' & timeFormat( communications[i].send_on, 'hh:mm tt' ),
				'status' : statuses[ communications[i].sent + 1 ],
				'status_id' : communications[i].sent				
			};
			arrayAppend( email_history, tmp );
		}
		return email_history;
	}
	/**
	* getEmailHistory
	* This method will return a list of invitations per event
	*/
	public array function getRegistrationTypes( required numeric event_id ) {
		return queryToArray( recordset=getRegistrationTypesDao().registrationTypesGet( argumentCollection = arguments ).result.registration_types );
	}	
	
	public void function cancelEmail(
		required numeric schedule_id,
		required string type,
		required numeric email_id		
	){
		if( arguments.type == 'Invitation' ){
			var params = {
				invitation_schedule_id : arguments.schedule_id,
				invitation_id : arguments.email_id,
				send_on : now(),
				sent : 2
			};
			getSendingToolDao().InvitationScheduleSet( argumentCollection = params );	
		}else{
			var params = {
				communication_schedule_id : arguments.schedule_id,
				communication_id : arguments.email_id,
				send_on : now(),
				sent : 2
			};
			getSendingToolDao().CommunicationScheduleSet( argumentCollection = params );	
		} 	
		return;
	}
	
	public struct function getDefaultInviteSettings(){
		return {
			'accept' : {
				'btn_text' : "Accept Invitation",
				'btn_color' : "##2370ab"
			},
			'decline' : {
				'btn_text' : "Decline Invitation",
				'btn_color' : "##2370ab"
			}
		};
	}
}
