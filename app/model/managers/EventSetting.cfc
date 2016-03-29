/**
*
* @file  /model/managers/EventSetting.cfc
* @author
* @description
*
*/

component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="EventSettingsDao" getter="true" setter="true";
	/*
	* Gets a Event Setting
	* @event_id The event id
	* @key The identifying key
	*/
	public struct function getEventSettingByKey(
		required numeric event_id,
		required string key
	) {
		return getEventSettingsDao().EventSettingByKeyGet( argumentCollection=arguments );
	}
	/*
	* Creates or Updates an Event Setting and Returns the Event Setting ID
	* @event_setting_id (optional) The id of the Setting, NULL means add
	* @event_id The id of the event
	* @key The key used to identify the setting in the event
	*
	*/
	public numeric function saveEventSetting(
		numeric event_setting_id=0,
		required numeric event_id,
		required string key,
		string s_value="",
		string d_value="",
		numeric n_value=0,
		boolean b_value
	) {
		var rtn = getEventSettingsDao().EventSettingSet( argumentCollection=arguments );
		getCacheManager().purgeEventConfigCache( getSessionManageUserFacade().getValue('current_event_id') );
		return rtn;
	}
	/**
	* I save a string setting for a given event
	*/
	public void function saveStringSetting(
		required numeric event_id,
		required string setting_name,
		required string setting_value
	) {
		var data = getEventSettingByKey( arguments.event_id, setting_name );
		data['s_value'] = arguments.setting_value;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save a boolean setting for a given event
	*/
	public void function saveBooleanSetting(
		required numeric event_id,
		required string setting_name,
		required string setting_value
	) {
		var data = getEventSettingByKey( arguments.event_id, setting_name );
		data['b_value'] = arguments.setting_value;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	*
	*/
	public void function saveEnableCapacity( required numeric event_id, required boolean enable_capacity ) {
		var data = getEventSettingByKey( arguments.event_id, 'enable_capacity' );
		data['b_value'] = arguments.enable_capacity;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
//		writedump( data );abort;
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	*
	*/
	public void function saveCapacity( required numeric event_id, required numeric capacity ) {
		var data = getEventSettingByKey( arguments.event_id, 'capacity' );
		data['n_value'] = arguments.capacity;
		data['event_id'] = arguments.event_id;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	*
	*/
	public void function saveDatetimeformat( required numeric event_id, required string datetimeformat ) {
		var data = getEventSettingByKey( arguments.event_id, 'datetimeformat' );
		data['s_value'] = arguments.datetimeformat;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	*
	*/
	public void function saveBillingPromoCodeText( required numeric event_id, required string billing_promo_code_text ) {
		var data = getEventSettingByKey( arguments.event_id, 'billing_promo_code_text' );
		data['s_value'] = arguments.billing_promo_code_text;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}

	/**
	* I save the begin registration label
	*/
	public void function saveRegisterBeginRegistrationLabel( required numeric event_id, required string register_begin_registration_label ) {
		var data = getEventSettingByKey( arguments.event_id, 'register_begin_registration_label' );
		data['s_value'] = arguments.register_begin_registration_label;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save the begin registration menu link label
	*/
	public void function saveRegisterRegistrationMenuLinkLabel( required numeric event_id, required string register_registration_menu_link_label ) {
		var data = getEventSettingByKey( arguments.event_id, 'register_registration_menu_link_label' );
		data['s_value'] = arguments.register_registration_menu_link_label;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save the next button label
	*/
	public void function saveRegisterNextButtonLabel( required numeric event_id, required string register_next_button_label ) {
		var data = getEventSettingByKey( arguments.event_id, 'register_next_button_label' );
		data['s_value'] = arguments.register_next_button_label;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}

	/**
	* I save the begin registration button label
	*/
	public void function saveRegisterBeginRegistrationButtonLabel( required numeric event_id, required string register_begin_registration_button_label ) {
		var data = getEventSettingByKey( arguments.event_id, 'register_begin_registration_button_label' );
		data['s_value'] = arguments.register_begin_registration_button_label;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}

	/**
	* I save the login button label
	*/
	public void function saveRegisterLoginButtonLabel( required numeric event_id, required string register_login_button_label ) {
		var data = getEventSettingByKey( arguments.event_id, 'register_login_button_label' );
		data['s_value'] = arguments.register_login_button_label;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}

	/**
	* I save the review label on billing column
	*/
	public void function saveBillingReviewLabel( required numeric event_id, required string billing_review_label ) {
		var data = getEventSettingByKey( arguments.event_id, 'billing_review_label' );
		data['s_value'] = arguments.billing_review_label;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save the review billing label on billing column
	*/
	public void function saveBillingReviewBillingLabel( required numeric event_id, required string billing_review_billing_label ) {
		var data = getEventSettingByKey( arguments.event_id, 'billing_review_billing_label' );
		data['s_value'] = arguments.billing_review_billing_label;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save the billing information label on billing column
	*/
	public void function saveBillingBillingInformationLabel( required numeric event_id, required string billing_billing_information_label ) {
		var data = getEventSettingByKey( arguments.event_id, 'billing_billing_information_label' );
		data['s_value'] = arguments.billing_billing_information_label;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save the information overview label on billing column
	*/
	public void function saveBillingInformationOverviewLabel( required numeric event_id, required string billing_information_overview_label ) {
		var data = getEventSettingByKey( arguments.event_id, 'billing_information_overview_label' );
		data['s_value'] = arguments.billing_information_overview_label;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save the information overview subtext label on billing column
	*/
	public void function saveBillingInformationOverviewSubText( required numeric event_id, required string billing_information_overview_sub_text ) {
		var data = getEventSettingByKey( arguments.event_id, 'billing_information_overview_sub_text' );
		data['s_value'] = arguments.billing_information_overview_sub_text;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save the payment type label on billing column
	*/
	public void function saveBillingPaymentTypeLabel( required numeric event_id, required string billing_payment_type_label ) {
		var data = getEventSettingByKey( arguments.event_id, 'billing_payment_type_label' );
		data['s_value'] = arguments.billing_payment_type_label;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save the registration review label on billing column
	*/
	public void function saveBillingRegistrationReviewLabel( required numeric event_id, required string billing_registration_review_label ) {
		var data = getEventSettingByKey( arguments.event_id, 'billing_registration_review_label' );
		data['s_value'] = arguments.billing_registration_review_label;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save the registration subtotal label on billing column
	*/
	public void function saveBillingRegistrationSubTotalLabel( required numeric event_id, required string billing_registration_sub_total_label ) {
		var data = getEventSettingByKey( arguments.event_id, 'billing_registration_sub_total_label' );
		data['s_value'] = arguments.billing_registration_sub_total_label;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save the registration subtotal label on billing column
	*/
	public void function saveBillingRegistrationTotalLabel( required numeric event_id, required string billing_registration_total_label ) {
		var data = getEventSettingByKey( arguments.event_id, 'billing_registration_total_label' );
		data['s_value'] = arguments.billing_registration_total_label;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}


	public void function saveInviteOnly( required numeric event_id, required boolean invite_only ) {
		var data = getEventSettingByKey( arguments.event_id, 'invite_only' );
		data['s_value'] = arguments.invite_only;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	*
	*/
	public void function saveBillingAgreeText( required numeric event_id, required string billing_agree_text ) {
		var data = getEventSettingByKey( arguments.event_id, 'billing_agree_text' );
		data['s_value'] = arguments.billing_agree_text;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save the setting to allow an attendee to view Reg Details
	*/
	public void function saveAttendeeDashboardShowDetail( required numeric event_id, required boolean attendee_dashboard_show_detail ) {
		var data = getEventSettingByKey( arguments.event_id, 'attendee_dashboard_show_detail' );
		data['b_value'] = arguments.attendee_dashboard_show_detail;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;

		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save the setting to allow an attendee to edit their reg
	*/
	public void function saveAttendeeDashboardAgendaEdit( required numeric event_id, required boolean attendee_dashboard_agenda_edit ) {
		var data = getEventSettingByKey( arguments.event_id, 'attendee_dashboard_agenda_edit' );
		data['b_value'] = arguments.attendee_dashboard_agenda_edit;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;

		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save the setting to show registration review information
	*/
	public void function saveRegisterConfirmationShowReview( required numeric event_id, required boolean register_confirmation_show_review ) {
		var data = getEventSettingByKey( arguments.event_id, 'register_confirmation_show_review' );
		data['b_value'] = arguments.register_confirmation_show_review;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;

		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save the seting to allow an attendee to edit their reg
	*/
	public void function saveAttendeeDashboardRegEdit( required numeric event_id, required boolean attendee_dashboard_reg_edit ) {
		var data = getEventSettingByKey( arguments.event_id, 'attendee_dashboard_reg_edit' );
		data['b_value'] = arguments.attendee_dashboard_reg_edit;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save the seting to omit the cancel email
	*/
	public void function saveOmitCancelEmail( required numeric event_id, required boolean omit_cancel_email ) {
		var data = getEventSettingByKey( arguments.event_id, 'omit_cancel_email' );
		data['b_value'] = arguments.omit_cancel_email;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	*
	*/
	public void function saveInviteDeclineMessageText( required numeric event_id, required string invite_decline_message_text ) {
		var data = getEventSettingByKey( arguments.event_id, 'invite_decline_message_text' );
		data['s_value'] = arguments.invite_decline_message_text;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save the seting to omit the event invite not found message
	*/
	public void function saveInviteNotFoundText( required numeric event_id, required string invite_not_found_text ) {
		var data = getEventSettingByKey( arguments.event_id, 'invite_not_found_text' );
		data['s_value'] = arguments.invite_not_found_text;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		structdelete( data,"b_value",true);
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save the seting to hide attendee cost breakdown
	*/
	public void function savehideattendeecostbreakdown( required numeric event_id, required boolean hide_attendee_cost_breakdown ) {
		var data = getEventSettingByKey( arguments.event_id, 'hide_attendee_cost_breakdown' );
		data['b_value'] = arguments.hide_attendee_cost_breakdown;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save the seting to hide or show the verify password field
	*/
	public void function saveRegisterVerifyPassword( required numeric event_id, required boolean register_verify_password ) {
		var data = getEventSettingByKey( arguments.event_id, 'register_verify_password' );
		data['b_value'] = arguments.register_verify_password;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		saveEventSetting( argumentCollection=data );
		return;
	}
	/**
	* I save the seting to hide or show the verify email field
	*/
	public void function saveRegisterVerifyEmail( required numeric event_id, required boolean register_verify_email ) {
		var data = getEventSettingByKey( arguments.event_id, 'register_verify_email' );
		data['b_value'] = arguments.register_verify_email;
		data['event_id'] = arguments.event_id;
		data['n_value'] = 0;
		saveEventSetting( argumentCollection=data );
		return;
	}
	/*
	* Gets all Event settings for an event
	* @event_id The event id
	*/
	public struct function getEventSettings( required numeric event_id ) {
		var data = queryToArray( getEventSettingsDao().EventSettingAllGet( arguments.event_id ).result );

		return {
			'count' = arrayLen( data ),
			'data' = data
		};
	}
	/**
	* I save the seting for pay type labels
	*/
	public void function savePayTypeLabel( required numeric event_id, required struct pay_type_labels ) {
		var data = {};
		for( var label_key in pay_type_labels ) {
			data = getEventSettingByKey( arguments.event_id, label_key );
			data['s_value'] = arguments.pay_type_labels[ label_key ];
			data['event_id'] = arguments.event_id;
			data['n_value'] = 0;
			structdelete( data,"b_value",true);
			saveEventSetting( argumentCollection=data );
		}

		return;
	}
	/**
	* I get the default settings
	*/
	public struct function getFormattedStruct( required numeric event_id ) {
		var settings = getEventSettings( arguments.event_id );
		var data = {'settings':{}};
		for ( var i=1; i LTE settings.count; i=i+1){
			var row = settings.data[ i ];
			var key = row.key;
			data['settings'][ key ] = "";
			if( isBoolean( row.b_value ) ) {
				data['settings'][ key ] = row.b_value;
			}else if( isDate( row.d_value ) ) {
				data['settings'][ key ] = row.d_value;
			}else if( isNumeric( row.n_value ) ) {
				data['settings'][ key ] = row.n_value;
			}else if( len( row.s_value ) ) {
				data['settings'][ key ] = row.s_value;
			}
		}

		structAppend( data['settings'], {
			'enable_capacity':false,
			'invite_only': false,
			'invite_not_found_text': "",
			'invite_decline_message_text':"",
			'attendee_dashboard_agenda_edit':true,
			'attendee_dashboard_reg_edit':true,
			'attendee_dashboard_show_detail':true,
			'omit_cancel_email':false,
			'hide_attendee_cost_breakdown':false,
			'register_verify_email':false,
			'register_verify_password':false,
			'billing_promo_code_text': "",
			'billing_agree_text': "",
			'pay_type_po_label': "PO",
			'pay_type_check_label': "Check",
			'pay_type_credit_card_label': "Credit Card",
			'pay_type_invoice_label': "Invoice",
			'pay_type_po_label': "PO",
			'pay_type_on_site_label': "On Site",
			'register_login_button_label': "Login",
			'register_begin_registration_label': "Begin Registration",
			'register_begin_registration_button_label': "Begin Registration",
			'register_registration_menu_link_label': "Registration",
			'register_next_button_label': "Next",
			'register_step_one_label': "1",
			'register_step_begin_label': "Begin",
			'register_step_agenda_label': "Agenda",
			'register_step_confirmation_label': "Confirmation",
			'register_agenda_title_label': "Agenda",
			'register_agenda_help_text': "For some sessions, extended details are available. To view extended details on a session, click the session name.",
			'register_confirmation_name_label': "Name",
			'register_confirmation_email_label': "Email",
			'register_confirmation_company_label': "Company",
			'register_confirmation_expand_button_label': "Expand Detailed Summary",
			'register_complete_registration_button_label': "Complete Registration",
			'billing_review_label': "Review",
			'billing_review_billing_label': "Review/Billing",
			'billing_billing_information_label': "Billing Information",
			'billing_information_overview_label': "Information Overview",
			'billing_information_overview_sub_text': "To review your entries please click on the Expand Detail button",
			'billing_payment_type_label': "Payment Type",
			'billing_registration_review_label': "Review",
			'billing_registration_sub_total_label': "Registration Subtotal",
			'billing_registration_total_label': "Total",
			'js_script': "",

			'attendee_login_title': 'Attendee Log In',
			'attendee_login_email': 'Email Address',
			'attendee_login_password': 'Password',
			'attendee_login_reset_password_button': 'Reset Password',
			'attendee_login_wrong_login_message': 'Wrong username and password combination',

			'reg_info_description': 'Registration information for {attendee_name} for {event_name}.',
			'reg_info_total_fee': 'Total Fee',
			'reg_info_total_paid': 'Total Paid',
			'reg_info_total_discounts': 'Total Discounts',
			'reg_info_total_due': 'Total Due',
			'reg_info_tab_choose_form': 'Change Form Section to Manage',
			'reg_info_tab_agenda': 'Agenda',
			'reg_info_tab_detail': 'Detail',
			'reg_info_reg_form_title': '',
			'reg_info_save_button': 'Save',
			'reg_info_agenda_title': 'Agenda for {attendee_name}',
			'reg_info_tab_agenda_view': 'View',
			'reg_info_tab_agenda_manage': 'Manage',
			'reg_info_tab_choose_form_reg_form': '',
			'reg_info_detail_title': 'Details',
			'reg_info_detail_table_amount': 'Amount',
			'reg_info_detail_table_detail': 'Detail',
			'reg_info_detail_table_description': 'Description',
			'reg_info_detail_table_date': 'Date',

			'register_confirmation_address_one_label': "Address Line One",
			'register_confirmation_address_two_label': "Address Line Two",
			'register_confirmation_city_label': "City/Town",
			'register_confirmation_country_label': "Country",
			'register_confirmation_zip_label': "Zip/Postal Code",
			'register_confirmation_phone_label': "Phone Number",
			'register_confirmation_additional_label': "Additional Session Fees",
			'register_confirmation_show_review': false,
			'register_group_title_label': "Group",
			'register_group_list_label': "Current Attendees in your Group",
			'register_group_add_attendee': "Add Attendee",
			'register_group_description': "You can add another group member here.",
			'register_contact_first_name_label':"First Name",
			'register_contact_subject_label':"Subject",
			'register_contact_subject_options':"",
			'register_contact_message_label':"Message",
			'register_contact_email_label':"Email Address",
			'register_contact_page_header':"Contact",
			'register_contact_button_label':"Send Message!",
			'register_contact_realperson_help':"Please verify you're a real person by entering the letters displayed below:",
			'register_contact_page_sub_header':"Need to get in touch? Use the form below!",
			'register_begin_hide_password': false,
			'register_confirmation_email_show_password': false,
            'invite_decline_reason_message_text':"Thank You!",
            'register_html_title': "MeetingPlay Registration",
            'invite_send_decline_email':true,
            'invite_collect_decline_reason':false
		}, false );

		return data.settings;
	}

	/**
	* I get the default settings
	*/
	public struct function getRegSiteSettingsFields( ) {
		var data = [];

		data[arrayLen(data)+1] = {
			'fieldname': 'register_step_one_label',
			'label': 'Step One Label',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_begin_registration_label',
			'label': 'Begin Registration Label',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_begin_registration_button_label',
			'label': 'Begin Registration Button Label',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_registration_menu_link_label',
			'label': 'Registration Menu Link Label',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_next_button_label',
			'label': 'Registration Next Button Label',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_login_button_label',
			'label': 'Login Button Label',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_step_begin_label',
			'label': 'Step Begin Label',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_step_agenda_label',
			'label': 'Step Agenda Label',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_step_confirmation_label',
			'label': 'Step Confirmation Label',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_agenda_title_label',
			'label': 'Agenda Title Label',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_agenda_help_text',
			'label': 'Agenda Help Text',
			'type': 'textarea'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_confirmation_name_label',
			'label': 'Name Label on Confirmation',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_confirmation_email_label',
			'label': 'Email Label on Confirmation',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_confirmation_company_label',
			'label': 'Company Label on Confirmation',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_confirmation_address_one_label',
			'label': 'Address Line One Label on Confirmation',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_confirmation_address_two_label',
			'label': 'Address Line Two Label on Confirmation',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_confirmation_city_label',
			'label': 'City Label on Confirmation',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_confirmation_country_label',
			'label': 'Country Label on Confirmation',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_confirmation_zip_label',
			'label': 'Zip Label on Confirmation',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_confirmation_phone_label',
			'label': 'Phone Label on Confirmation',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_confirmation_expand_button_label',
			'label': 'Expand Button Label on Confirmation',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_confirmation_additional_label',
			'label': 'Additional Session Fee Label on Confirmation',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_complete_registration_button_label',
			'label': 'Complete Registration Button Label on Confirmation',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'js_script',
			'label': 'JS Script (Used Primarily for Google Analytics)',
			'type': 'textarea'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'attendee_login_title',
			'label': 'Attendee Login Title',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'attendee_login_email',
			'label': 'Email Label on Attendee Login',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'attendee_login_password',
			'label': 'Password Label on Attendee Login',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'attendee_login_reset_password_button',
			'label': 'Reset Password Button Label on Attendee Login',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'attendee_login_wrong_login_message',
			'label': 'Wrong Username/Password Message on Attendee Login',
			'type': 'textarea'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'reg_info_description',
			'label': 'Registration description text (Use the tags {attendee_name} and {event_name} to include the name of the Atendee and the Event)',
			'type': 'textarea'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'reg_info_total_fee',
			'label': 'Total Fee Label on Registration',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'reg_info_total_paid',
			'label': 'Total Paid Label on Registration',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'reg_info_total_discounts',
			'label': 'Total Discounts Label on Registration',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'reg_info_total_due',
			'label': 'Total Due Label on Registration',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'reg_info_tab_choose_form',
			'label': 'Choose Form Section Tab Label on Registration',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'reg_info_tab_agenda',
			'label': 'Agenda Tab Label on Registration',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'reg_info_tab_detail',
			'label': 'Detail Tab Label on Registration',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'reg_info_reg_form_title',
			'label': 'Title inside of Choose Form Section Tab on Registration',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'reg_info_save_button',
			'label': 'Reg. Form Save Button Label on Registration',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'reg_info_agenda_title',
			'label': 'Title inside Agenda Tab on Registration (Use tag {attendee_name} to include the name of the attendee)',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'reg_info_tab_agenda_view',
			'label': 'Label for Submenu View of Agenda Tab on Registration',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'reg_info_tab_agenda_manage',
			'label': 'Label for Submenu Manage of Agenda Tab on Registration',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'reg_info_tab_choose_form_reg_form',
			'label': 'Prefix Label for Submenues of Choose Form Section Tab on Registration',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'reg_info_detail_title',
			'label': 'Title inside Detail Tab on Registration',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'reg_info_detail_table_amount',
			'label': 'Label for Amount column for the table inside Detail Tab on Registration',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'reg_info_detail_table_detail',
			'label': 'Label for Detail column for the table inside Detail Tab on Registration',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'reg_info_detail_table_description',
			'label': 'Label for Description column for the table inside Detail Tab on Registration',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'reg_info_detail_table_date',
			'label': 'Label for Date column for the table inside Detail Tab on Registration',
			'type': 'input'
		};


		data[arrayLen(data)+1] = {
			'fieldname': 'register_group_title_label',
			'label': 'Header for the Group page',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_group_list_label',
			'label': 'Header for the current attendees in a group',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_group_add_attendee',
			'label': 'Label for the add attendee to group button',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_group_description',
			'label': 'Group section description',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_contact_page_header',
			'label': 'Contact page header label',
			'type': 'input'
		};
		data[arrayLen(data)+1] = {
			'fieldname': 'register_contact_page_sub_header',
			'label': 'Contact page sub-header label',
			'type': 'input'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_contact_first_name_label',
			'label': 'Contact page first name label',
			'type': 'input'
		};
		data[arrayLen(data)+1] = {
			'fieldname': 'register_contact_email_label',
			'label': 'Contact page email label',
			'type': 'input'
		};
		data[arrayLen(data)+1] = {
			'fieldname': 'register_contact_subject_label',
			'label': 'Contact page subject label',
			'type': 'input'
		};
		data[arrayLen(data)+1] = {
			'fieldname': 'register_contact_subject_options',
			'label': 'Contact page subject drop down options. Separate options using a ;.',
			'type': 'textarea'
		};
		data[arrayLen(data)+1] = {
			'fieldname': 'register_contact_message_label',
			'label': 'Contact page message label',
			'type': 'input'
		};
		data[arrayLen(data)+1] = {
			'fieldname': 'register_contact_button_label',
			'label': 'Contact page button label',
			'type': 'input'
		};
		data[arrayLen(data)+1] = {
			'fieldname': 'register_contact_realperson_help',
			'label': 'Contact page real person help text.',
			'type': 'textarea'
		};

		data[arrayLen(data)+1] = {
			'fieldname': 'register_begin_hide_password',
			'label': '',
			'type': 'none',
			'data_type': 'boolean'
		};
		data[arrayLen(data)+1] = {
			'fieldname': 'register_confirmation_email_show_password',
			'label': '',
			'type': 'none',
			'data_type': 'boolean'
		};

        data[arrayLen(data)+1] = {
            'fieldname': 'invite_decline_reason_message_text',
            'label': 'Decline Reason Confimration Message',
            'type': 'textarea'
        };
        data[arrayLen(data)+1] = {
            'fieldname': 'register_html_title',
            'label': 'HTML Title',
            'type': 'input'
        };
        data[arrayLen(data)+1] = {
			'fieldname': 'invite_send_decline_email',
			'label': 'Send Decline Response Email',
			'type': 'none',
			'data_type': 'boolean'
		};
        data[arrayLen(data)+1] = {
			'fieldname': 'invite_collect_decline_reason',
			'label': 'Collect Decline Reason',
			'type': 'none',
			'data_type': 'boolean'
		};




		return {'data': data};
	}

}