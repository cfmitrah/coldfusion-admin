component extends="$base" accessors="true"
{
	property name="companyManager" setter="true" getter="true";
	property name="eventsManager" setter="true" getter="true";
	property name="slugManager" setter="true" getter="true";
	property name="venuesManager" setter="true" getter="true";
	property name="ssosManager" setter="true" getter="true";
	property name="eventSettingManager" setter="true" getter="true";
	property name="ContentEventManager" setter="true" getter="true";
	property name="EventPaymentTypesManager" setter="true" getter="true";
	/**
	* before
	* This method will be executed before running any event controller methods
	*/
	public void function before( rc ) {
		rc.sidebar = "sidebar.event.details";
		if( !getSessionManageUserFacade().getCurrentCompanyID() ){
			redirect('company.select');
		}
		if( structKeyExists( rc, "event_id") && isNumeric( rc.event_id ) && rc.event_id gt 0 ){
			getSessionManageUserFacade().setValue( 'current_event_id', rc.event_id );
		}
		super.before( rc );
		return;
	}
	//START PAGE VIEWS
	/**
	* Default
	* This method will render the event event list
	**/
	public void function default( rc ) {
		rc.has_sidebar = false;
		var listing_config = {
		    "table_id":"event_listing"
		    ,"ajax_source":"event.ajaxListing"
		    ,"columns":"Name,Published,Status,Start Date,End Date,Tags,Options"
		    ,"aoColumns":[
		            {"data":"name"}
		            ,{"data":"published"}
		            ,{"data":"event_status"}
		            ,{"data":"start_date"}
		            ,{"data":"end_date"}
		            ,{"data":"tags"}
		            ,{"data":"options"}
		    ]
		};
		rc['table_id'] = listing_config.table_id;
		listing_config['ajax_source'] = buildURL( (structKeyExists(listing_config,'ajax_source') ? listing_config.ajax_source: '') );
		rc['columns'] = listing_config.columns;
		getCfStatic().includeData( listing_config ).include("/js/pages/common/listing.js").include("/css/pages/common/listing.css");
		return;
	}
	/**
	* select
	* This method will render the events dropdown list TODO POSSIBLE REFACTOR??
	**/
	public void function select( rc ) {
		var events = getEventsManager().getCompanyEventList( getCurrentCompanyID(), 1, 100 );
		rc['event_opts'] = getFormUtilities().buildOptionList(
			values = events.event_id,
			display = events.name
		);
		return;
	}
	/**
	* Default
	* This method set the create frm for an event
	* @securityroles System Administrator, Administrator, Company Administrator
	**/
	public void function create( rc ) {
		var company_id = getCurrentCompanyID();
		var domains = getEventsManager().getCompanyDomains( company_id:company_id );
		rc['domain_opts'] = getFormUtilities().buildOptionList(
			values = domains.domain_id,
			display = domains.domain_name
		);
		rc['company_id'] = company_id;
		getCfStatic()
			.include( "/css/main.css" )
			.include( "/js/plugins/slugify/slugify.min.js" )
			.include( "/js/pages/event/create.js" );
		return;
	}
	/**
	* Details
	* This method set the details for the event
	**/
	public void function details( rc ) {
		var domains = getEventsManager().getCompanyDomains( company_id=rc.company_id );
		var event_statuses = getEventsManager().getEventStatuses();
		var venue_list = getEventsManager().getVenueList( company_id=rc.company_id );
		var ssos = getSSOsManager().getCompanySSOs( company_id=rc.company_id );
		var processors = getEventsManager().getProcessorList( company_id=rc.company_id );
		var datetimeformatinfo = {};  // Used to grab the datetime format info.
		var event_config = {
			'ajax_delete_venue_url' = buildURL( "event.ajaxRemoveVenue" ),
			'ajax_delete_day_url' = buildURL( "event.ajaxRemoveEventDay" )
		};
		//get main details
		rc['event'] = getEventsManager().getEventDetails( event_id=rc.event_id, company_id=rc.company_id );

		//get settings fields
		rc['settings_fields'] = getEventSettingManager().getRegSiteSettingsFields();

		//get event tags
		rc['event_tags'] = getEventsManager().getEventTags( event_id=rc.event_id );
		//get datetime format options
		rc['datetimeformat_opts'] = getEventsManager().getDateTimeFormats();
		//get domain options
		rc['domain_opts'] = getFormUtilities().buildOptionList(
			values = domains.domain_id,
			display = domains.domain_name,
			selected = rc.event.details.domain_id
		);
		rc['status_opts'] = getFormUtilities().buildOptionList(
			values = event_statuses.event_status,
			display = event_statuses.event_status,
			selected = rc.event.details.event_status
		);
		// Find the current datetime format information
		if ( isDefined( "rc.event.details.settings.datetimeformat" ) ) {
			datetimeformatinfo = structFindValue( rc.datetimeformat_opts, rc.event.details.settings.datetimeformat );
			if (structKeyExists( datetimeformatinfo[1], "owner" ) ) {
				datetimeformatinfo = datetimeformatinfo[1].owner;
			}
		}
		rc['datetimeformat_current'] = datetimeformatinfo;

		rc['venues_opts'] = getFormUtilities().buildOptionList(
			values = venue_list.venue_id,
			display = venue_list.venue_name
		);
		rc['has_ssos'] = arrayLen( ssos.sso_id ) > 0;
		rc['sso_opts'] = getFormUtilities().buildOptionList(
			values = ssos.sso_id,
			display = ssos.label
		);
		rc['has_processors'] = arrayLen( processors.processor_id ) > 0;
		rc['processor_list'] = getFormUtilities().buildOptionList(
			values = processors.processor_id,
			display = processors.label,
			selected = rc.event.details.processor_id
		);
		//get event vunes data
		rc['event_venues'] = getEventsManager().getEventVenues( event_id=rc.event_id );
		//set checked opts
		rc['checked']['yes'] = "checked=""checked""";
		rc['checked']['no'] = "";



		getCfStatic().includeData( event_config )
			.include( "/css/pages/common/listing.css" )
			.include( "/css/plugins/date-timepicker/date-timepicker.css" )
			.include( "/css/pages/common/media.css" )
			.include( "/js/plugins/slugify/slugify.min.js" )
			.include( "/js/pages/event/create.js" )
			.include( "/js/pages/event/delete_venue_modal.js" )
			.include( "/js/pages/event/delete_day_modal.js" )
			.include( "/js/pages/event/details.js" );
	}
	//END PAGE VIEWS
	//START PAGE PROCESSING
	/**
	* doSelect
	* This method process the event choice selections
	**/
	public void function doSelect( rc ) {
		if( structKeyExists( rc, "event_select") && isNumeric( rc.event_select ) ){
			getSessionManageUserFacade().setValue( 'current_event_id', rc.event_select );
			redirect( action="event.details", queryString="event_id=" & getCurrentEventID() );
		}
		redirect( "event.select");
		return;
	}
	/**
	* DoCreate
	* This method will process the creation of the event details
	* @securityroles System Administrator, Administrator, Company Administrator
	*/
	public void function doCreate( rc ) {
		if( structKeyExists( rc, "event") && isStruct( rc.event ) ){
			rc.event['slug_id'] = getSlugManager().save( rc.event.name ).slug_id;
			rc['event_id'] = getEventsManager().save( argumentCollection=rc.event );
			getSessionManageUserFacade().setValue( 'current_event_id', rc.event_id );
			addSuccessAlert( 'The event was successfully created.' );
			redirect( action="event.details", queryString="event_id=" & getCurrentEventID() );
		}
		redirect("event.create");
		return;
	}
	/**
	* DoSave
	* This method will process the saving of the event details
	*/
	public void function doSave( rc ) {
		if( structKeyExists( rc, "event") && isStruct( rc.event ) ) {
			structAppend( rc['event'], {'capacity':0,'payment_types':""},false);
            if( !isNumeric( rc.event.capacity ) ) {
                rc['event']['capacity'] = 0;
            }
			rc.event['slug_id'] = getSlugManager().save( rc.event.slug ).slug_id;
			rc['event_id'] = getEventsManager().save( argumentCollection=rc.event );
			if( structKeyExists( rc.event, 'enable_capacity' ) ) {
				getEventSettingManager().saveEnableCapacity( rc.event_id, rc.event.enable_capacity );
			}
			if( structKeyExists( rc.event, 'capacity' ) ) {
				getEventSettingManager().savecapacity( rc.event_id, rc.event.capacity );
			}
			if( structKeyExists( rc.event, 'datetimeformat' ) ) {
				getEventSettingManager().saveDatetimeformat( rc.event_id, rc.event.datetimeformat );
			}
			if( structKeyExists( rc.event, 'omit_cancel_email' ) ) {
				getEventSettingManager().saveOmitCancelEmail( rc.event_id, rc.event.omit_cancel_email );
			}
			if( structKeyExists( rc.event, 'attendee_dashboard_agenda_edit' ) ) {
				getEventSettingManager().saveAttendeeDashboardAgendaEdit( rc.event_id, rc.event.attendee_dashboard_agenda_edit );
			}
			if( structKeyExists( rc.event, 'attendee_dashboard_reg_edit' ) ) {
				getEventSettingManager().saveAttendeeDashboardRegEdit( rc.event_id, rc.event.attendee_dashboard_reg_edit );
			}
			if( structKeyExists( rc.event, 'register_verify_email' ) ) {
				getEventSettingManager().saveRegisterVerifyEmail( rc.event_id, rc.event.register_verify_email );
			}
			if( structKeyExists( rc.event, 'register_verify_password' ) ) {
				getEventSettingManager().saveRegisterVerifyPassword( rc.event_id, rc.event.register_verify_password );
			}
			if( structKeyExists( rc.event, 'billing_promo_code_text' ) ) {
				getEventSettingManager().saveBillingPromoCodeText( rc.event_id, rc.event.billing_promo_code_text );
			}
			if( structKeyExists( rc.event, 'billing_agree_text' ) ) {
				getEventSettingManager().saveBillingAgreeText( rc.event_id, rc.event.billing_agree_text );
			}
			if( structKeyExists( rc.event, 'attendee_dashboard_show_detail' ) ) {
				getEventSettingManager().saveAttendeeDashboardShowDetail( rc.event_id, rc.event.attendee_dashboard_show_detail );
			}
			if( structKeyExists( rc.event, 'pay_type_labels' ) && isStruct( rc.event.pay_type_labels ) ) {
				getEventSettingManager().savePayTypeLabel( rc.event_id, rc.event.pay_type_labels );
			}
			if( structKeyExists( rc.event, 'hide_attendee_cost_breakdown' ) && isboolean( rc.event.hide_attendee_cost_breakdown ) ) {
				getEventSettingManager().savehideattendeecostbreakdown( rc.event_id, rc.event.hide_attendee_cost_breakdown );
			}
			if( structKeyExists( rc.event, 'invite_only' ) && isboolean( rc.event.invite_only ) ) {
				getEventSettingManager().saveinviteonly( rc.event_id, rc.event.invite_only );
			}
			if( structKeyExists( rc.event, 'invite_not_found_text' ) ) {
				getEventSettingManager().saveInviteNotFoundText( rc.event_id, rc.event.invite_not_found_text );
			}
			if( structKeyExists( rc.event, 'invite_decline_message_text' ) ) {
				getEventSettingManager().saveInviteDeclineMessageText( rc.event_id, rc.event.invite_decline_message_text );
			}
			

			// Saving the registration customizations
			var settings_fields = getEventSettingManager().getRegSiteSettingsFields();

			for (var i=1; i <= arrayLen(settings_fields.data); i++ ) {
				var current_field = settings_fields.data[i];
				if( structKeyExists( rc.event, current_field['fieldname'] ) ) {
					var params = { event_id:rc.event_id, setting_name:current_field['fieldname'], setting_value:rc.event[current_field['fieldname']] };
					if( structKeyExists( current_field, "data_type" ) && current_field.data_type == "boolean") {
						getEventSettingManager().saveBooleanSetting( argumentCollection:params );	
					}else{
						getEventSettingManager().saveStringSetting( argumentCollection:params );	
					}
				}
			}
			//////

			if( structKeyExists( rc.event, 'billing_review_label' ) ) {
				getEventSettingManager().saveBillingReviewLabel( rc.event_id, rc.event.billing_review_label );
			}
			if( structKeyExists( rc.event, 'billing_review_billing_label' ) ) {
				getEventSettingManager().saveBillingReviewBillingLabel( rc.event_id, rc.event.billing_review_billing_label );
			}
			if( structKeyExists( rc.event, 'billing_billing_information_label' ) ) {
				getEventSettingManager().saveBillingBillingInformationLabel( rc.event_id, rc.event.billing_billing_information_label );
			}
			if( structKeyExists( rc.event, 'billing_information_overview_label' ) ) {
				getEventSettingManager().saveBillingInformationOverviewLabel( rc.event_id, rc.event.billing_information_overview_label );
			}
			if( structKeyExists( rc.event, 'billing_information_overview_sub_text' ) ) {
				getEventSettingManager().saveBillingInformationOverviewSubText( rc.event_id, rc.event.billing_information_overview_sub_text );
			}
			if( structKeyExists( rc.event, 'billing_payment_type_label' ) ) {
				getEventSettingManager().saveBillingPaymentTypeLabel( rc.event_id, rc.event.billing_payment_type_label );
			}
			if( structKeyExists( rc.event, 'billing_registration_review_label' ) ) {
				getEventSettingManager().saveBillingRegistrationReviewLabel( rc.event_id, rc.event.billing_registration_review_label );
			}
			if( structKeyExists( rc.event, 'billing_registration_sub_total_label' ) ) {
				getEventSettingManager().saveBillingRegistrationSubTotalLabel( rc.event_id, rc.event.billing_registration_sub_total_label );
			}
			if( structKeyExists( rc.event, 'billing_registration_total_label' ) ) {
				getEventSettingManager().saveBillingRegistrationTotalLabel( rc.event_id, rc.event.billing_registration_total_label );
			}
			if( structKeyExists( rc.event, 'register_confirmation_show_review' ) ) {
				getEventSettingManager().saveRegisterConfirmationShowReview( rc.event_id, rc.event.register_confirmation_show_review );
			}
			

			getEventPaymentTypesManager().saveEventPaymentTypes( rc.event_id, rc.event.payment_types );
			addSuccessAlert( 'The event was successfully saved.' );
			redirect( action="event.details", queryString="event_id=" & getCurrentEventID() );
		}
		redirect("event.default");
		return;
	}
	/**
	* doSaveEventContactContent
	* This method will process the saving of event Contact Content
	*/
	public void function doSaveEventContactContent( rc ) {
		structAppend( rc, {'event_contact_content':{} }, false);
		if( isStruct( rc.event_contact_content ) ) {
			rc['event_contact_content']['event_id'] = getCurrentEventID();
			getContentEventManager().saveEventContactContent( argumentCollection=rc.event_contact_content );
			addSuccessAlert( 'The event contact content was successfully saved.' );
		}
		redirect( action="event.details", queryString="event_id=" & getCurrentEventID() );
		return;
	}
	/**
	* doSaveEventDate
	* This method will process the saving of event dates
	*/
	public void function doSaveEventDate( rc ) {
		if( structKeyExists( rc, "event") && isStruct( rc.event ) ){
			getEventsManager().setEventDay( argumentCollection=rc.event );
			addSuccessAlert( 'The event tag was successfully saved.' );
			redirect( action="event.details", queryString="event_id=" & getCurrentEventID() );
		}
		redirect("event.default");
		return;
	}
	/**
	* doSaveHeroGraphic
	* This method will process the saving of event hero graphic
	*/
	public void function doSaveLandingPageContent( rc ) {
		structAppend( rc, {'landing_page_content':{} }, false);
		if( isStruct( rc.landing_page_content ) ) {
			rc['landing_page_content']['event_id'] = getCurrentEventID();
			getContentEventManager().saveLandingPageContent( argumentCollection=rc.landing_page_content );
			addSuccessAlert( 'The event landing page content was successfully saved.' );
		}
		redirect( action="event.details", queryString="event_id=" & getCurrentEventID() );
		return;
	}
	/**
	* doSaveBillingPageContent
	* This method will process the saving of billing page text
	*/
	public void function doSaveBillingPageContent( rc ) {
		structAppend( rc, {'billing_page_content':{} }, false);
		if( isStruct( rc.billing_page_content ) ) {
			rc['billing_page_content']['event_id'] = getCurrentEventID();
			getContentEventManager().saveBillingPageContent( argumentCollection=rc.billing_page_content );
			addSuccessAlert( 'The event Billing page content was successfully saved.' );
		}
		redirect( action="event.details", queryString="event_id=" & getCurrentEventID() );
		return;
	}

	/**
	* doSaveTag
	* This method will process the saving of event tags
	*/
	public void function doSaveTag( rc ) {
		if( structKeyExists( rc, "event") && isStruct( rc.event ) ){
			getEventsManager().setEventTags( argumentCollection=rc.event );
			addSuccessAlert( 'The event date was successfully saved.' );
			redirect( action="event.details", queryString="event_id=" & getCurrentEventID() );
		}
		redirect("event.default");
		return;
	}
	/**
	* doSaveVenue
	* This method will process saving of event details
	*/
	public void function doSaveVenue( rc ) {
		if( structKeyExists( rc, "event") && isStruct( rc.event ) ){
			getEventsManager().setEventVenue( argumentCollection=rc.event );
			addSuccessAlert( 'The event venue was successfully created.' );
			redirect( action="event.details", queryString="event_id=" & getCurrentEventID() );
		}
		redirect("event.default");
		return;
	}
	//END PAGE PROCESSING
	//START PAGE AJAX
	/**
	* AjaxListing
	* - This method will return the ajax JSON for event agenda list
	*/
	public void function ajaxListing( rc ) {
		var params = {
			"order_index" : ( structKeyExists( rc, 'order[0][column]') ? rc['order[0][column]']:0)
			, "order_dir" : ( structKeyExists( rc, 'order[0][dir]') ? rc['order[0][dir]']:"ASC")
			, "search_value" : ( structKeyExists( rc, 'search[value]') ? rc['search[value]']:"")
			, "start_row" : ( structKeyExists( rc, 'start') ? rc.start:0)
			, "total_rows" : ( structKeyExists( rc, 'length') ? rc.length:0)
			, "draw" : ( structKeyExists( rc, 'draw') ? rc.draw:0)
			, "company_id" : getCurrentCompanyID()
		};
		var data = {};
		data = getEventsManager().getListing( argumentCollection=params );
		data['cnt'] = arrayLen(data.data);
		//create the options links
		for( var i = 1; i <= data.cnt; i++ ) {
			data['data'][i]['options'] = "<div class=""btn-group""><a class=""btn btn-sm btn-primary"" href=""#buildURL('event.details?event_id=' & data.data[i].event_id )#"">Manage</a></div>";
			data['data'][i]['start_date'] = "" & dateFormat(data.data[i].start_date, 'mm/dd/yyyy');
			data['data'][i]['end_date'] = "" & dateFormat(data.data[i].end_date, 'mm/dd/yyyy');
		}
		getFW().renderData( "json", data );
		request.layout = false;
	}
	/**
	* AjaxRemoveVenue
	* - This method will remove an event venue
	*/
	public void function ajaxRemoveVenue( rc ) {
		request.layout = false;
		getEventsManager().eventRemoveVenue( rc.event_id, rc.venue_id );
		getFW().renderData( "json", {
			"success": true
		} );
		return;
	}
	/**
	* ajaxRemoveEventDay
	* - This method will remove an event day
	*/
	public void function ajaxRemoveEventDay( rc ) {
		request.layout = false;
		getEventsManager().eventRemoveDay( rc.event_id, rc.day_id );
		getFW().renderData( "json", {
			"success": true
		} );
		return;
	}
	//END PAGE AJAX
	/**
	* Ajax Categories
	* - This method will return the ajax JSON for event categories
	*/
	public void function categoriesListing( rc ) {
		request['layout'] = false;
		getFW().renderData( 'json', getEventsManager().getEventCategories( argumentCollection=rc ) );
		return;
	}
	/**
	* I am the view to copy and event
	*/
	public void function copy( rc ) {
		var events_to_copy = getEventsManager().getCompanyEventList( getCurrentCompanyID(), 1, 100, "name" );
		rc['event_opts'] = getFormUtilities().buildOptionList(
			values = events_to_copy.event_id,
			display = events_to_copy.name
		);
		getCfStatic().includeData( {} ).include("/js/pages/event/copy.js");
		return;
	}
	/**
	* Copy's an Event
	*/
	public void function doCopy( rc ) {
		var params = {};
		var new_event_id = 0;
		structAppend( rc, {'event':{'slug':"", 'event_name':"", 'copy_event_id':0}}, false);
		params = rc.event;
		structAppend( params, {'slug':"", 'event_name':"", 'copy_event_id':0}, false);
		new_event_id = getEventsManager().copyEvent( argumentCollection=params );
		if( new_event_id ) {
			addSuccessAlert("Event copied!");
			redirect( action="event.details", queryString="event_id=" & new_event_id );
		}else{
			addSuccessAlert("There was an issue copying the requested event.");
			redirect( action="event.copy" );
		}
		return;
	}
}