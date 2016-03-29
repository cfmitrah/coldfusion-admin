/**
*
* @file  /model/managers/EmailManagement.cfc
* @author - JG
* @description - This will control all things Email Management.
*
*/

component extends="$base" accessors="true"
{
	property name="eventsManager" setter="true" getter="true";
	property name="emailManager" setter="true" getter="true";
	property name="EmailManagementManager" setter="true" getter="true";
	property name="registrationTypesManager" setter="true" getter="true";
	property name="mailer" setter="true" getter="true";
	/**
	* before
	* This method will be executed before running any agenda controller methods
	*/
	public void function before( rc ) {
		//we need to make sure we do in fact have a company ID		
		if( ! getCurrentCompanyID() ){
			redirect('company.select');
		}
		if( !getCurrentEventID() ){
			redirect('event.select');
		}
		rc['sidebar'] = "sidebar.event.details";
		super.before( rc );
		return;
	}
	//START PAGE VIEWS
	/**
	* emailReminders 		
	* This method will render the email reminders listing
	**/
	public void function emailReminders( rc ){
		var email_labels = getEmailManagementManager().getInviationEmailLabelsAsStruct( event_id=rc.event_id );		
		rc['email_label_opts'] = getFormUtilities().buildOptionList(
			values=email_labels.invitation_id,
			display=email_labels.label
		);
		return;
	}
	/**
	* listOpenInvitations 		
	* This method will list all open invites
	**/
	public void function listOpenInvitations( rc ){
		if( structKeyExists( rc, "invitation_id") && isStruct( rc.invitation_id ) ){
			redirect( action="emailManagement.default" );
		}
		//get all open invites
		var params = {
			'company_id' : rc.company_id,
			'event_id' : rc.event_id,
			'invitation_id' : rc.invitation_id
		};
		var email_labels = getEmailManagementManager().getInviationEmailLabelsAsStruct( event_id=rc.event_id );		
		rc['email_label_opts'] = getFormUtilities().buildOptionList(
			values=email_labels.invitation_id,
			display=email_labels.label,
			selected=rc.invitation_id
		);
		rc['invites'] = getEmailManagementManager().getOpenInvitations( argumentCollection=params );
		if( rc.invites.open_invites_cnt == 0 ){
			addInfoAlert( "There are currently no open invitations for this invitation" );			
			redirect( "emailManagement.emailReminders" );
		}
		getCfStatic()
			.include("/js/pages/emailManagement/reminders.js");
		return;
	}
	/**
	* Default 		
	* This method will render the event agenda list
	**/
	public void function default( rc ) {
		var listing_config = {};
		//set up the listing configs for the data tables		
		//write the sub configs to the main config for the data tables (see private struct methods)
		listing_config['invitation_listing_config'] = getInvitationListingConfig();
		listing_config['communication_listing_config'] = getCommunicationListingConfig();
		listing_config['auto_responder_listing_config'] = getAutoResponderListingConfig();
		//set specific listing config data for the sub sections
		rc['invitation_listing_config'] = {};
		rc['communication_listing_config'] = {};
		rc['system_listing_config'] = {};
		//invitations
		rc.invitation_listing_config['table_id'] = listing_config.invitation_listing_config.table_id;
		rc.invitation_listing_config['columns'] = listing_config.invitation_listing_config.columns;
		//communications
		rc.communication_listing_config['table_id'] = listing_config.communication_listing_config.table_id;
		rc.communication_listing_config['columns'] = listing_config.communication_listing_config.columns;
		//Auto Responders
		rc.auto_responder_listing_config['table_id'] = listing_config.auto_responder_listing_config.table_id;
		rc.auto_responder_listing_config['columns'] = listing_config.auto_responder_listing_config.columns;

		listing_config['send_test_email_url'] = buildURL( "emailManagement.ajaxSendTestAutoResponder" );
		getCfStatic().includeData( listing_config )
			.include("/js/pages/emailManagement/mainListing.js")
			.include("/js/pages/emailManagement/general.js")
			.include("/css/pages/common/listing.css");
		return;
	}
	/**
	* selectAutoResponderTypes 		
	* This method will render the select auto responder type
	**/
	public void function selectAutoResponderTypes( rc ) {
		var auto_responder_types = getEmailManagementManager().getAutoResponderTypesAsStruct();;	
		rc['auto_responder_types_opts'] = getFormUtilities().buildOptionList(
			values=auto_responder_types.autoresponder_type,
			display=auto_responder_types.description
		);

		return;
	}
	/**
	* createAutoResponderEmail 		
	* This method will render the create auto responder email
	**/
	public void function createAutoResponderEmail( rc ) {
		if( structKeyExists( rc, "email") && isStruct( rc.email ) ){
			rc.email['event_id'] = rc.event_id;
			rc['email_details'] = getEmailManagementManager().AutoresponderByTypeGet( argumentCollection=rc.email );
			//get registration types
			var registration_types = getEmailManagementManager().getRegistrationTypesByAutoresponderAsStruct( rc.event_id, rc.email.autoresponder_type );
			if( !arrayLen( registration_types.registration_type ) ){
				addErrorAlert( 'All attendee types have been set for the system email.');
				redirect( "emailManagement.selectAutoResponderTypes" );
			}
			rc['registration_opts'] = getFormUtilities().buildOptionList(
				values=registration_types.registration_type_id,
				display=registration_types.registration_type,
				selected=val( rc.email_details.registration_type_id )
			);
			//set checked opts
			rc['checked']['yes'] = "checked=""checked""";
			rc['checked']['no'] = "";
			getCfStatic()
				.include( "/css/pages/common/media.css" )
				.include("/js/pages/emailManagement/validate.js")
				.include( "/js/pages/emailManagement/tinyMCE.js" );
			return;
		}
		redirect( "emailManagement.default" );
	}
	
	
	/**
	* createInvitationEmail 		
	* This method will render the create invitation form
	**/
	public void function createInvitationEmail( rc ) {
		rc['event_id'] = getCurrentEventID();
		//get registration types
		var registration_types = getRegistrationTypesManager().getRegistrationTypesStruct( rc.event_id );
		rc['registration_opts'] = getFormUtilities().buildOptionList(
			values=registration_types.registration_type_id,
			display=registration_types.registration_type
		);
		//create defaults - frm reuse
		rc['email_details'] = {
			'page_title' : "Create a New Invitation Email",
			'label' : "", 'from_email' : '', 'subject' : "", 'header_filename' : "", 'body' : '', 'footer' : '', 'invitation_id' : "", 'bcc' : "",
			'settings' : getEmailManagementManager().getDefaultInviteSettings()
				
		};
		rc['has_response'] = "yes";
		//set checked opts
		rc['checked']['yes'] = "checked=""checked""";
		rc['checked']['no'] = "";
		
		getCfStatic()
			.include( "/css/plugins/colorpicker/colorpicker.css" )
			.include( "/js/plugins/colorpicker/colorpicker.js" )
			.include( "/css/pages/common/media.css" )
			.include("/js/pages/emailManagement/validate.js")
			.include("/js/pages/emailManagement/color.js")
			.include( "/js/pages/emailManagement/tinyMCE.js" );
		return;
	}
	/**
	* editInvitationEmail 		
	* This method will render the edit invitation form
	**/
	public void function editInvitationEmail( rc ){
		if( !getFormUtilities().exists( "invitation_id", rc ) ) {
			redirect( action="emailManagement.default" );
		}
		rc['event_id'] = getCurrentEventID();
		rc['email_details'] = getEmailManagementManager().getInvitationDetails( invitation_id=rc.invitation_id );
		//frm required fields to output
		rc['email_details']['page_title'] = 'Edit "' & rc.email_details.label & '" Invitation Email';
		//get registration types
		var registration_types = getRegistrationTypesManager().getRegistrationTypesStruct( rc.event_id );
		rc['registration_opts'] = getFormUtilities().buildOptionList(
			values=registration_types.registration_type_id,
			display=registration_types.registration_type,
			selected=rc.email_details.registration_type_id
		);
		rc['has_response'] = yesNoFormat( rc.email_details.response );
		//set checked opts
		rc['checked']['yes'] = "checked=""checked""";
		rc['checked']['no'] = "";
		getCfStatic()
			.include( "/css/plugins/colorpicker/colorpicker.css" )
			.include( "/js/plugins/colorpicker/colorpicker.js" )
			.include( "/css/pages/common/media.css" )
			.include("/js/pages/emailManagement/validate.js")
			.include("/js/pages/emailManagement/color.js")
			.include( "/js/pages/emailManagement/tinyMCE.js" );
		return;
	}
	/**
	* createCommunicationEmail 		
	* This method will render the edit auto responder form
	**/
	public void function createCommunicationEmail( rc ) {
		rc['event_id'] = getCurrentEventID();
		//create defaults - frm reuse
		rc['email_details'] = {
			'page_title' : 'Create a New Communication Email',
			'label' : "", 'from_email' : "", 'subject' : "", 'header_filename' : "", 'body' : "", 'communication_id' : "", 'bcc' : ""				
		};
		getCfStatic()
			.include( "/css/pages/common/media.css" )
			.include("/js/pages/emailManagement/validate.js")
			.include( "/js/pages/emailManagement/tinyMCE.js" );
		return;
	}
	/**
	* editCommunicationEmail 		
	* This method will render the edit auto responder form
	**/
	public void function editCommunicationEmail( rc ) {
		if( !getFormUtilities().exists( "communication_id", rc ) ) {
			redirect( action="emailManagement.default" );
		}
		rc['event_id'] = getCurrentEventID();
		rc['email_details'] = getEmailManagementManager().getCommunicationDetails( communication_id=rc.communication_id );
		//frm required fields to output
		rc['email_details']['page_title'] = 'Edit "' & rc.email_details.label & '" Communication Email';
		getCfStatic()
			.include( "/css/pages/common/media.css" )
			.include("/js/pages/emailManagement/validate.js")
			.include( "/js/pages/emailManagement/tinyMCE.js" );
		return;
	}
	/**
	* editAutoResponderEmail 		
	* This method will render the edit auto responder form
	**/
	public void function editAutoResponderEmail( rc ) {
		if( !getFormUtilities().exists( "autoresponder_id", rc ) ) {
			redirect( action="emailManagement.default" );
		}
		rc['email_details'] = getEmailManagementManager().getAutoResponderDetails( autoresponder_id=rc.autoresponder_id );
		//get registration types
		var registration_types = getRegistrationTypesManager().getRegistrationTypesStruct( rc.event_id );
		rc['registration_opts'] = getFormUtilities().buildOptionList(
			values=registration_types.registration_type_id,
			display=registration_types.registration_type,
			selected=val( rc.email_details.registration_type_id )
		);
		//set checked opts
		rc['checked']['yes'] = "checked=""checked""";
		rc['checked']['no'] = "";
		//set checked opts
		rc['disabled']['yes'] = "disabled=""disabled""";
		rc['disabled']['no'] = "";
		getCfStatic()
			.include( "/css/pages/common/media.css" )
			.include("/js/pages/emailManagement/validate.js")
			.include( "/js/pages/emailManagement/tinyMCE.js" );
		return;
	}
	/**
	* emailTool 		
	* This method will 
	**/
	public void function emailTool( rc ) {
		var listing_config = {};
		//set up the listing configs for the data tables		
		//write the sub configs to the main config for the data tables (see private struct methods)
		listing_config['attendee_listing_config'] = getAttendeeListingConfig();
		listing_config['email_history_listing_config'] = getEmailHistoryListingConfig();
		//set specific listing config data for the sub sections
		rc['attendee_listing'] = {};
		rc['email_history_listing'] = {};
		//invitations
		rc.attendee_listing['table_id'] = listing_config.attendee_listing_config.table_id;
		rc.attendee_listing['columns'] = listing_config.attendee_listing_config.columns;
		//communications
		rc.email_history_listing['table_id'] = listing_config.email_history_listing_config.table_id;
		rc.email_history_listing['columns'] = listing_config.email_history_listing_config.columns;		
		rc['event_id'] = getCurrentEventID();
		rc['email_labels'] = getEmailManagementManager().getEmailLabels( event_id=rc.event_id );		
		rc['registration_types'] = getEmailManagementManager().getRegistrationTypes( rc.event_id );
		listing_config['cancel_email_url'] =  buildURL( 'emailManagement.ajaxCancelEmail' );
		getCfStatic().includeData( listing_config )
			.include( "/js/pages/emailManagement/sendingTool.js" )
			.include("/js/pages/emailManagement/mainListing.js")
			.include("/js/pages/emailManagement/validate.js")
			.include("/css/pages/common/listing.css");
		return;
	}
	/**
	* emailDefaults 		
	* This method will 
	**/
	public void function emailDefaults( rc ) {
		rc['event_id'] = getCurrentEventID();
		rc['email_defaults'] = getEmailManagementManager().getEmailDefaults( event_id=rc.event_id );
		getCfStatic()
			.include("/js/pages/emailManagement/validate.js");
		return;
	}
	//END PAGE VIEWS
	//START PAGE PROCESSING
	/**
	* doGetInvitation 		
	* This method will process getting all open invites 
	**/
	public void function doGetInvitation( rc ){
		if( structKeyExists( rc, "email") && isStruct( rc.email ) ){
			redirect( action="emailManagement.listOpenInvitations?invitation_id=" & rc.email.invitation_id );
		}
		redirect( "emailManagement.default" );
		return;
	}
	/**
	* doSendReminders 		
	* This method will process sending the reminder emails
	**/
	public void function doSendReminders( rc ){
		if( structKeyExists( rc, "email") && isStruct( rc.email ) ){
			getEmailManager().sendReminderEmails( argumentCollection=rc.email );			
			addSuccessAlert( 'Your reminder email has been successfully sent.' );
			redirect( "emailManagement.emailReminders" );
		}
		redirect( "emailManagement.default" );
		return;
	}
	/**
	* doScheduleCommunicationEmail 		
	* This method will communication template data
	**/
	public void function doScheduleCommunicationEmail( rc ){
		if( structKeyExists( rc, "email") && isStruct( rc.email ) ){
			getEmailManagementManager().scheduleCommunicationEmail( argumentCollection=rc.email );
			addSuccessAlert( 'Your communication email has been successfully scheduled.' );
		}
		redirect( "emailManagement.default" );
	}
	/**
	* doScheduleInvitationEmail 		
	* This method will process invitation template data
	**/
	public void function doScheduleInvitationEmail( rc ) {
		if( structKeyExists( rc, "email") && isStruct( rc.email ) ){
			try{
				getEmailManagementManager().scheduleInvitationEmail( argumentCollection=rc.email );
				addSuccessAlert( 'Your invitation email has been successfully scheduled.' );				
			}catch( Any e ){
				writedump(e);abort;
				addErrorAlert( 'There was an issue while sending this invitation email.');
			}
		}
		redirect( "emailManagement.default" );
	}
	/**
	* doSendTestEmail 		
	* This method will send the test email
	**/
	public void function doSendTestEmail( rc ){
		if( structKeyExists( rc, "email") && isStruct( rc.email ) ){
			getEmailManagementManager().sendTestEmail( argumentCollection=rc.email );
			addSuccessAlert( "Your test email has been sent." );
		}
		redirect( "emailManagement.default" );
	}
	/**
	* doSaveAutoResponder 		
	* This method will save the auto responder form
	**/
	public void function doSaveAutoResponder( rc ){
		if( structKeyExists( rc, "email") && isStruct( rc.email ) ){
			getEmailManagementManager().setAutoResponderContent( argumentCollection=rc.email );
			addSuccessAlert( 'The auto responder email "' & email.label & '" has been saved.' );
			redirect( action="emailManagement.default" );
		}
		redirect( "emailManagement.default" );
	}
	/**
	* doSaveCommunicationEmail 		
	* This method will save the communication form
	**/
	public void function doSaveCommunicationEmail( rc ) {
		if( structKeyExists( rc, "email") && isStruct( rc.email ) ){
			getEmailManagementManager().setCommunicationContent( argumentCollection=rc.email );
			addSuccessAlert( 'The communication email "' & email.label & '" has been saved.' );
			redirect( action="emailManagement.default" );
		}
		redirect( "emailManagement.default" );
	}
	/**
	* doSaveInvitationEmail 		
	* This method will save the invitation form
	**/
	public void function doSaveInvitationEmail( rc ){
		if( structKeyExists( rc, "email") && isStruct( rc.email ) ){
			getEmailManagementManager().setInvitationContent( argumentCollection=rc.email );
			addSuccessAlert( 'The invitation email "' & email.label & '" has been saved.' );
			redirect( action="emailManagement.default" );
		}
		redirect( "emailManagement.default" );
	}
	/**
	* doSaveInvitationEmail 		
	* This method will save the invitation form
	**/
	public void function doSaveEmailDefaults( rc ) {
		if( structKeyExists( rc, "email") && isStruct( rc.email ) ){
			getEmailManagementManager().setEmailDefaultsContent( argumentCollection=rc.email );
			addSuccessAlert( 'The email defaults have been saved' );
			redirect( action="emailManagement.default" );
		}
		redirect( "emailManagement.default" );
	}
	//END PAGE PROCESSING	
	//START AJAX VIEWS
	/**
	* ajaxSendTestAutoResponder
	* - This method will send a test email for auto responders
	*/
	public void function ajaxSendTestAutoResponder( rc ) {
		request.layout = false;
		getEmailManager().sendAutoResponderTestEmail( argumentCollection = rc );
		getFW().renderData( "json", {
			"success": true
		} );
		return;
	}
	/**
	* ajaxAttendeeListing
	* - This method will return the ajax JSON for event attendee list
	*/
	public void function ajaxAttendeeListing( rc ) {
		var params = {
			"order_index" : ( structKeyExists( rc, 'order[0][column]') ? rc['order[0][column]']:0)
			, "order_dir" : ( structKeyExists( rc, 'order[0][dir]') ? rc['order[0][dir]']:"ASC")
			, "search_value" : ( structKeyExists( rc, 'search[value]') ? rc['search[value]']:"")
			, "start_row" : ( structKeyExists( rc, 'start') ? rc.start:0)
			, "total_rows" : ( structKeyExists( rc, 'length') ? rc.length:0)
			, "draw" : ( structKeyExists( rc, 'draw') ? rc.draw:0)
			, "event_id" : getCurrentEventID()
		};
		var data = {};
		data = getEmailManagementManager().getAttendeesListing( argumentCollection = params );
		data['cnt'] = arrayLen(data.data);
		//create the options links
		for( var i = 1; i <= data.cnt; i++ ) {
			data['data'][i]['tag'] = "<div><input type=""checkbox"" name=""email.value_list"" value=""#data.data[i].attendee_id#""  /></div>";
		}
		getFW().renderData( "json", data );
		request.layout = false;
	}

	/**
	* ajaxInvitationListing
	* - This method will return the ajax JSON for event invitations list
	*/
	public void function ajaxInvitationListing( rc ) {
		var params = {
			"order_index" : ( structKeyExists( rc, 'order[0][column]') ? rc['order[0][column]']:0)
			, "order_dir" : ( structKeyExists( rc, 'order[0][dir]') ? rc['order[0][dir]']:"ASC")
			, "search_value" : ( structKeyExists( rc, 'search[value]') ? rc['search[value]']:"")
			, "start_row" : ( structKeyExists( rc, 'start') ? rc.start:0)
			, "total_rows" : ( structKeyExists( rc, 'length') ? rc.length:0)
			, "draw" : ( structKeyExists( rc, 'draw') ? rc.draw:0)
			, "event_id" : getCurrentEventID()
		};
		var data = {};
		data = getEmailManagementManager().getInvitationsListing( argumentCollection = params );
		data['cnt'] = arrayLen(data.data);
		//create the options links
		for( var i = 1; i <= data.cnt; i++ ) {
			data['data'][i]['options'] = "<div class=""btn-group""><a class=""btn btn-sm btn-primary"" href=""#buildURL('emailManagement.editInvitationEmail?invitation_id=' & data.data[i].invitation_id )#"">Set Content</a></div>";
		}
		getFW().renderData( "json", data );
		request.layout = false;
	}
	/**
	* ajaxCommunicationListing
	* - This method will return the ajax JSON for event communication list
	*/
	public void function ajaxCommunicationListing( rc ) {
		var params = {
			"order_index" : ( structKeyExists( rc, 'order[0][column]') ? rc['order[0][column]']:0)
			, "order_dir" : ( structKeyExists( rc, 'order[0][dir]') ? rc['order[0][dir]']:"ASC")
			, "search_value" : ( structKeyExists( rc, 'search[value]') ? rc['search[value]']:"")
			, "start_row" : ( structKeyExists( rc, 'start') ? rc.start:0)
			, "total_rows" : ( structKeyExists( rc, 'length') ? rc.length:0)
			, "draw" : ( structKeyExists( rc, 'draw') ? rc.draw:0)
			, "event_id" : getCurrentEventID()
		};
		var data = {};
		data = getEmailManagementManager().getCommunicationsListing( argumentCollection = params );
		data['cnt'] = arrayLen(data.data);
		//create the options links
		for( var i = 1; i <= data.cnt; i++ ) {
			data['data'][i]['options'] = "<div class=""btn-group""><a class=""btn btn-sm btn-primary"" href=""#buildURL('emailManagement.editCommunicationEmail?communication_id=' & data.data[i].communication_id )#"">Set Content</a></div>";
		}
		getFW().renderData( "json", data );
		request.layout = false;
	}
	/**
	* ajaxAutoResponderListing
	* - This method will return the ajax JSON for event auto responder list
	*/
	public void function ajaxAutoResponderListing( rc ) {
		var params = {
			"order_index" : ( structKeyExists( rc, 'order[0][column]') ? rc['order[0][column]']:0)
			, "order_dir" : ( structKeyExists( rc, 'order[0][dir]') ? rc['order[0][dir]']:"ASC")
			, "search_value" : ( structKeyExists( rc, 'search[value]') ? rc['search[value]']:"")
			, "start_row" : ( structKeyExists( rc, 'start') ? rc.start:0)
			, "total_rows" : ( structKeyExists( rc, 'length') ? rc.length:0)
			, "draw" : ( structKeyExists( rc, 'draw') ? rc.draw:0)
			, "event_id" : getCurrentEventID()
		};
		var data = {};
		data = getEmailManagementManager().getAutoResponderListing( argumentCollection = params );
		data['cnt'] = arrayLen(data.data);
		//create the options links		
		for( var i = 1; i <= data.cnt; i++ ) {
			data['data'][i]['registration_type'] = len( data.data[i].registration_type ) ? data.data[i].registration_type : 'Default'; 
			data['data'][i]['active'] = data.data[i].active  ? "<span>Yes</span>" : "<span>No</span>"; 
			data['data'][i]['options'] = "<div class=""btn-group""><a class=""btn btn-sm btn-primary"" href=""#buildURL('emailManagement.editAutoResponderEmail?autoresponder_id=' & data.data[i].autoresponder_id )#"">Set Content</a></div>";
			data['data'][i]['options'] &= "<div class=""btn-group""><a class=""btn btn-sm btn-success send_test_email"" href=""##"" data-email_id=""#data.data[i].autoresponder_id#"" >Send Test Email</a></div>";
		}
		getFW().renderData( "json", data );
		request.layout = false;
	}
	/**
	* ajaxEmailHistoryListing
	* - This method will return the ajax JSON for event email history 
	*/
	public void function ajaxEmailHistoryListing( rc ) {
		var params = {
			"order_index" : ( structKeyExists( rc, 'order[0][column]') ? rc['order[0][column]']:0)
			, "order_dir" : ( structKeyExists( rc, 'order[0][dir]') ? rc['order[0][dir]']:"ASC")
			, "search_value" : ( structKeyExists( rc, 'search[value]') ? rc['search[value]']:"")
			, "start_row" : ( structKeyExists( rc, 'start') ? rc.start:0)
			, "total_rows" : ( structKeyExists( rc, 'length') ? rc.length:0)
			, "draw" : ( structKeyExists( rc, 'draw') ? rc.draw:0)
			, "event_id" : getCurrentEventID()
		};
		var data = {};
		data = getEmailManagementManager().getEmailHistoryListing( argumentCollection = params );
		data['cnt'] = arrayLen(data.data);
		//create the options links	
		var statuses = [ 'Pending','Sent', 'Cancelled' ];
		//set show or not
		rc['show']['yes'] = "";
		rc['show']['no'] = "display:none";
		for( var i = 1; i <= data.cnt; i++ ) {
			var status_id = data.data[i].sent + 1;
			data['data'][i]['send_on'] = dateFormat( data.data[i].send_on, 'MM/DD/YYYY' ) & ' ' & timeFormat( data.data[i].send_on, 'hh:mm tt' );
			data['data'][i]['sent'] = statuses[ status_id == 256 ? 2 : status_id ];
			data['data'][i]['recipients'] = data.data[i].recipients & ' Recipients';
			data['data'][i]['options'] = "<div class=""btn-group""><a data-type=""#data.data[i].comm_type#"" data-schedule_id=""#data.data[i].schedule_id#"" data-email_id=""#data.data[i].id#"" href=""javascript:void(0)"" class=""btn btn-sm btn-danger cancel-email"" style=""#rc.show[ data.data[i].sent eq 'pending' ]#"">Cancel</a>";
		}
		getFW().renderData( "json", data );
		request.layout = false;
	}
	/**
	* ajaxRemoveAgenda
	* This method will delete an agenda item
	*/
	public void function ajaxCancelEmail( rc ) {
		request.layout = false;
		getEmailManagementManager().cancelEmail( argumentCollection = rc );
		getFW().renderData( "json", {
			"success": true
		} );
		return;
	}
	//END AJAX VIEWS	
	//START PRIVATE METHODS
	private struct function getEmailHistoryListingConfig() {
		//Attendees listing
		var email_history_config = {
			"table_id":"email_history_listing"
			,"ajax_source":"emailManagement.ajaxEmailHistoryListing"
			,"columns":"Type, Name, Sent To, Send Date, Status, Options"
		    ,"aoColumns":[
		    		 {"data":"comm_type"}
		            ,{"data":"label"}
		            ,{"data":"recipients"} 		
		            ,{"data":"send_on"}
		            ,{"data":"sent"}
		            ,{"data":"options"}
		    ]
		};
		email_history_config['ajax_source'] = buildURL( ( structKeyExists( email_history_config,'ajax_source' ) ? email_history_config.ajax_source: '' ) );
		return email_history_config;		
	}
	private struct function getAttendeeListingConfig() {
		//Attendees listing
		var attendees_listing_config = {
			"table_id":"inivation_listing"
			,"ajax_source":"emailManagement.ajaxAttendeeListing"
			,"columns":"Tag, First Name, Last Name, Email, Attendee Type, Active"
		    ,"aoColumns":[
		    		 {"data":"tag"}
		            ,{"data":"first_name"}
		            ,{"data":"last_name"} 		
		            ,{"data":"email"}
		            ,{"data":"registration_type"}
		            ,{"data":"active"}
		    ]
		};
		attendees_listing_config['ajax_source'] = buildURL( ( structKeyExists( attendees_listing_config,'ajax_source' ) ? attendees_listing_config.ajax_source: '' ) );
		return attendees_listing_config;		
	}
	private struct function getInvitationListingConfig() {
		//invitation listing
		var invitation_listing_config = {
			"table_id":"invitation_listing"
			,"ajax_source":"emailManagement.ajaxInvitationListing"
			,"columns":"Email Name, Subject, Options"
		    ,"aoColumns":[
		             {"data":"label"}
		            ,{"data":"subject"} 		
		            ,{"data":"options"}
		    ]
		};
		invitation_listing_config['ajax_source'] = buildURL( ( structKeyExists( invitation_listing_config,'ajax_source' ) ? invitation_listing_config.ajax_source: '' ) );
		return invitation_listing_config;
	}
	private struct function getCommunicationListingConfig() {
		//communications listing
		var communication_listing_config = {
			"table_id":"communication_listing"
			,"ajax_source":"emailManagement.ajaxCommunicationListing"
			,"columns":"Email Name, Subject, Options"
		    ,"aoColumns":[
		             {"data":"label"}
		            ,{"data":"subject"} 		
		            ,{"data":"options"}
		    ]
		};
		communication_listing_config['ajax_source'] = buildURL( ( structKeyExists( communication_listing_config,'ajax_source' ) ? communication_listing_config.ajax_source: '' ) );
		return communication_listing_config;
	}
	private struct function getAutoResponderListingConfig() {
		//auto responder listing
		var auto_responder_listing_config = {
			"table_id":"system_listing"
			,"ajax_source":"emailManagement.ajaxAutoResponderListing"
			,"columns":"Email Name, Subject, Registration Type, Active, Options"
		    ,"aoColumns":[
		             {"data":"label"}
		            ,{"data":"subject"}
		            ,{"data":"registration_type"} 		
		            ,{"data":"active"}
		            ,{"data":"options"}
		    ]
		};
		auto_responder_listing_config['ajax_source'] = buildURL( ( structKeyExists( auto_responder_listing_config,'ajax_source' ) ? auto_responder_listing_config.ajax_source: '' ) );
		return auto_responder_listing_config;		
	}
	//END PRIVATE METHODS
}
