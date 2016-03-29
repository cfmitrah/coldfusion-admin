component extends="$base" accessors="true"
{
	property name="AttendeeManager" setter="true" getter="true";
	property name="AttendeeSettingsManager" setter="true" getter="true";
	property name="AgendasManager" setter="true" getter="true";
	property name="RegistrationManager" setter="true" getter="true";
	property name="RegistrationSectionManager" setter="true" getter="true";
	property name="GeographyManager" setter="true" getter="true";
	property name="EventsManager" setter="true" getter="true";
	property name="CompanyManager" setter="true" getter="true";
	property name="PaymentManager" setter="true" getter="true";
	property name="RegistrationTypesManager" setter="true" getter="true";
	property name="EventPaymentTypesManager" setter="true" getter="true";
	property name="PaymentTypesManager" setter="true" getter="true";
	property name="RegistrationTypesDao" getter="true" setter="true";
	property name="hotelManager" getter="true" setter="true";

	public void function after( rc ) {
		rc.sidebar = "sidebar.event.details";
		super.after( rc );
	}
	/**
	* I am the default event for attendees
	*/
	public any function default( rc ) {
		var listing_config = getAttendeeManager().getListingConfig();
		var counter = getEventsManager().getEventAttendeesCounter( rc.event_id );

		rc['table_id'] = listing_config.table_id;
		rc['counter'] = counter;
		listing_config['ajax_source'] = buildURL( listing_config.ajax_source );

		getCfStatic()
			.includeData( listing_config )
			.include("/js/pages/attendees/event-attendees.js")
			.include("/css/pages/common/listing.css");

		return;
	}
	/**
	* I am the user entry screen to create a new attendee
	*/
	public void function create( rc ) {
		structAppend( rc, {'parent_id':0,'registration_type_id':0,'registration_id':0}, false );
		rc.registration_type = getRegistrationTypesManager().getRegistrationTypes( rc.event_id );
		getCfStatic()
			.includeData( {} )
			.include("/js/pages/attendees/create.js");
		return;
	}
	/**
	* I create an attendee
	*/
	public void function doCreate( rc ) {
		var params = rc.register_field;
		var data = {};
		structAppend( params, { 'event_id':rc.event_id, 'company_id':rc.company_id, 'parent_attendee_id':0, 'registration_id':0 }, false );
		data = getAttendeeManager().processCreate( argumentCollection=params );
		if( !data.has_error ) {
			redirect( action='attendee.manage', queryString="attendee_id=" & data.attendee_id );
		}else {
			redirect( "attendee.create" );
		}
	}
	/**
	* Attendee Profile / Management
	*/
	public void function manage( rc ) {//re-factor
		var params = rc;
		var company = getCompanyManager().getCompany( getCurrentCompanyID(), true ).company;
		var cfrequest = {
			'payment_url':buildURL("attendee.processPayment"),
			'refund_url':buildURL("attendee.processRefund"),
			'void_url':buildURL("attendee.processVoid"),
			'get_attendee_url':buildURL("attendee.getAttendee"),
			'get_registration_payments_url':buildURL("attendee.registrationPayments"),
			'do_refund_url':buildURL("attendee.processRefund"),
			'do_void_url':buildURL("attendee.processVoid"),
			'attendee_id':rc.attendee_id,
			'agenda_conflict_check_url': buildURL( "attendee.agendaConflictCheck" ),
			'apply_promo_code_url': buildURL( "attendee.applyCoupon" )
			};
		var regions = getGeographyManager().getRegions( company.data[1].country_code );

		cfrequest['details_list_columns'] =  [
				{'data': "amount",'sTitle': "Amount",'bSortable': false},
				{'data': "detail_name",'sTitle': "Detail",'bSortable': false},
				{'data': "attendee_name",'sTitle': "Attendee",'bSortable': false},
				{'data': "description",'sTitle': "Description",'bSortable': false},
				{'data': "detail_timestamp",'sTitle': "Date",'bSortable': false},
				{'data': "payment_description",'sTitle': "Payment Type",'bSortable': false},
				{'data': "ip",'sTitle': "IP",'bSortable': false}
		    ];

		rc['country_code'] = company.data[1].country_code;
		structAppend( params, {'attendee_id':0}, false );
		rc['active_class'] = {'Yes':'active','No':''};
		rc['attendee'] = getAttendeeManager().getAttendee( params.attendee_id, getCurrentEventID() );

		rc['sections'] = getAttendeeManager().getRegistrationSections( rc.attendee.registration_type_id, rc.attendee.custom, rc.attendee, getCurrentEventID() );
		rc['expiration_month_opts'] = getFormUtilities().buildOptionList(
			values=getConfig().expiration_month_options.value,
			display=getConfig().expiration_month_options.display );
		rc['expiration_year_opts'] = getFormUtilities().buildOptionList(
			values=getConfig().expiration_year_options.value,
			display=getConfig().expiration_year_options.display );

		rc['region_options'] = getFormUtilities().buildOptionList( regions.region_code, regions.region_name, rc.attendee.region_code );
		rc['payment_types'] = getEventPaymentTypesManager().getEventPaymentTypes( getCurrentEventID() );

		rc['processor_credit_cards'] = getCompanyManager().getCompanyProcessorCreditCards( getCurrentCompanyID(), getCurrentEventID() );
		cfrequest['group_allowed'] = rc.attendee.group_allowed;


		if( rc.attendee.group_allowed && val(rc.attendee.parent_attendee_id ) == rc.attendee.attendee_id ) {
			cfrequest['registration_details_url'] = buildURL( action="attendee.registrationDetails", queryString="registration_id=" & rc.attendee.registration_id   );
		}else {
			cfrequest['registration_details_url'] = buildURL( action="attendee.registrationDetails", queryString="registration_id=" & rc.attendee.registration_id & "&attendee_id=" & params.attendee_id  );
		}
		rc['action_urls']['cancel'] = buildURL( action="attendee.cancelAttendee", queryString="attendee_id=" & rc.attendee_id & "&registration_id=" & rc.attendee.registration_id);
		rc['action_urls']['cancel_with_email'] = buildURL( action="attendee.cancelAttendee", queryString="send_cancel_email=true&attendee_id=" & rc.attendee_id & "&registration_id=" & rc.attendee.registration_id);
		rc['action_urls']['activate'] = buildURL( action="attendee.activateAttendee", queryString="attendee_id=" & rc.attendee_id & "&registration_id=" & rc.attendee.registration_id & "&registration_type_id=" & rc.attendee.registration_type_id );
		rc['agenda_manage'] = getAgendasManager().getAgendaByRegistrationType( rc.event_id, rc.attendee.registration_type_id, rc.attendee.agenda.agenda_ids );
		cfrequest['fields'] = rc['sections']['all_fields'];
		rc['attendee_types'] = getAttendeeSettingsManager().getRegistrationTypesSelect( getCurrentEventID(), rc.attendee.registration_type_id );

		cfrequest['registration_id'] = rc.attendee.registration_id;

		if( rc.sections.has_hotel ) {
			rc['hotels'] = gethotelManager().getHotels( getCurrentEventID() );
			cfrequest['hotels'] = rc.hotels;
			rc['hotel_rooms'] = gethotelManager().getHotelRooms( getCurrentEventID(), rc.hotels.data[1].hotel_id );
			cfrequest['hotel_rooms'] = rc.hotel_rooms;
			cfrequest['field_prefix'] = "register_field";
			cfrequest['reg_hotel_id'] = val( rc.attendee.hotel_id );
			cfrequest['reg_hotel_checkin_date'] = dateformat( rc.attendee.hotel_checkin_date, "mm/dd/yyyy" );
			cfrequest['reg_hotel_checkout_date'] =  dateformat( rc.attendee.hotel_checkout_date, "mm/dd/yyyy" );
			cfrequest['reg_hotel_room_type_id'] = val( rc.attendee.hotel_room_type_id );
			getCfStatic().include('/js/pages/attendees/hotel.js');
		}
		rc['can_pay'] = true;
		if( rc.attendee.parent_attendee_id gt 0 && rc.attendee.parent_attendee_id NEQ rc.attendee.attendee_id ) {
			rc['can_pay'] = false;
		}
		getCfStatic( )
			.includeData( cfrequest )
			.include("/js/pages/attendees/manage.js")
			.include( "/css/plugins/date-timepicker/date-timepicker.css" )
			.include("/css/pages/attendee/manage.css")
			.include("/css/plugins/chosen/chosen.css");
		return;
	}
	/**
	* I am the ajax listing for attendees
	*/
	public void function getAttendees( rc ) {
		var params = getGenericListingParams();
		params['event_id'] = getCurrentEventID();
		structAppend( params, rc );
		structAppend( params, {
			'order_index'=( structKeyExists( rc, 'order[0][column]') ? rc['order[0][column]']:0),
			'order_dir'=( structKeyExists( rc, 'order[0][dir]') ? rc['order[0][dir]']:"ASC"),
			'search_value'=( structKeyExists( rc, 'search[value]') ? rc['search[value]']:""),
			'start_row'=( structKeyExists( rc, 'start') ? rc.start:1),
			'total_rows'= ( structKeyExists( rc, 'length') ? rc.length:10),
			'draw'=( structKeyExists( rc, 'draw') ? rc.draw:0),
			'event_id'=getCurrentEventID()
			});

		getFW().renderData( 'json', getAttendeeManager().getAttendees( argumentCollection=params ));
		request.layout = false;
		return;
	}
	/**
	* Attendee Profile / Management
	*/
	public void function save( rc ) {//fixme: move logic to manager
		var params = { 'registration':{}, 'custom':{}, 'event_id': rc.event_id, 'registration_id':0, 'attendee_note':"" };
		var agenda_edit_params = { 'event_id':rc.event_id, 'ip':cgi.remote_addr };
		var note_params = { 'note_id': 0, 'attendee_id':0, 'note':rc.attendee_note, 'event_id':rc.event_id };
		structAppend( rc, { 'attendee_id':0, 'current_registration_type_id':0, 'register_field':[], 'upload_prefix':"", 'fieldnames':"" },false );
		params['attendee_id'] = rc.attendee_id;
		params['upload_prefix'] = rc.upload_prefix;
		params['fieldnames'] = rc.fieldnames;
		params['registration']['current_registration_type_id'] = rc.current_registration_type_id;
		params['registration']['attendee_status'] = rc.attendee_status;
		if( isArray( rc.register_field ) && arrayLen( rc.register_field ) ) {
			agenda_edit_params['registration_id'] = rc.register_field[1].standard.registration_id;
			params['registration_id'] = rc.register_field[1].standard.registration_id;
			for( var section in rc.register_field ) {
				try{
					if( isStruct( section ) ) {
						if( structKeyExists( section, "standard" ) ) {
							structAppend( params['registration'], section.standard, false );
						}
						if( structKeyExists( section, "custom" ) ) {
							structAppend( params['custom'], section.custom, false );
						}
						if( structKeyExists( section, "hotel" ) ) {
							structAppend( params['registration'], section.hotel, false );
						}
					}
				}
				catch (coldfusion.runtime.UndefinedElementException e){}
			 	catch( coldfusion.runtime.CfJspPage$ArrayBoundException e){}
				catch (expression e){}
			}

		}

		rc['new_attendee_id'] = getAttendeeManager().processSave( argumentCollection=params );
		agenda_edit_params['attendee_id'] = rc['new_attendee_id'];
		structAppend( rc, { 'attendee_agenda':{} }, false );
		structAppend( rc.attendee_agenda, { 'agenda_item':"" }, false );
		structAppend( agenda_edit_params, rc.attendee_agenda );
		getAttendeeManager().saveAttendeeAgenda( argumentCollection:agenda_edit_params );

		if( rc.new_attendee_id && len(rc.attendee_note) ) {
			note_params['attendee_id'] = rc.new_attendee_id;
			getAttendeeManager().addNote( argumentCollection=note_params );
		}

		if( !rc.new_attendee_id ) {
			addErrorAlert( "We were unable to save the attendee record." );
		}else{
			addSuccessAlert( "Attendee record saved." );
			rc['attendee_id'] = rc.new_attendee_id;
		}
		redirect( action='attendee.manage', preserve="attendee_id");
		return;
	}
	/**
	* I process a payment
	*/
	public void function processPayment( rc ) {//fixme: move logic to manager
		var params = {
			'event_id':getCurrentEventID()
			,'company_processor_id':0
		};
		var rtn = {'success':"No",'message':"","processor_response":{}};
		var detail_param = {};
		var detail_types = getConfig().detail_types;
		var processor_response = "";
		var payment_types = getPaymentTypesManager().getPaymentTypes();
		var payment_type_id = 0;

		if( structKeyExists( payment_types, rc.account_info.payment_type ) ) {
			payment_type_id = payment_types[ rc.account_info.payment_type ];
		}
		structAppend( rc, { 'account_info': {}, 'attendee_id': 0 ,'registration_id': 0 }, false );
		rc['attendee'] = getAttendeeManager().getAttendee( rc.attendee_id, getCurrentEventID() );
		structAppend( rc['account_info'], {
			'account_number':"",
			'month':"",
			'year':"",
			'first_name':"",
			'last_name':"",
			'address':"",
			'postal_code':"",
			'cvv':"",
			'country':"",
			'region':"",
			'city':""
		}, false );

		params['total'] = rc.account_info.amount;
		params['account_info'] = rc.account_info;
		switch ( rc.account_info.payment_type ){
			case "credit_card":
				params['company_processor_id'] = getCompanyManager().getCompanyProcessorCreditCards( getCurrentCompanyID(), getCurrentEventID() ).processor_id;
				processor_response = getPaymentManager().makeCCPayment( argumentCollection:params );

				rtn['success'] = processor_response.getsuccess();
				rtn['message'] = processor_response.getmessage();
				rtn['processor_response'] = processor_response.getparsedresult();
				structAppend( rtn.processor_response, {
					'tx_x_date':left( rc.account_info.month, 2 ) & right( rc.account_info.year, 2 ),
					'tx_last_4':right( rc.account_info.account_number, 4 ),
					'processor_tx_id':processor_response.getTransactionID()
				});
				addErrorAlert( processor_response.getmessage() );
			break;
			default:
				rtn.processor_response = {'processor_tx_id':0};
				rtn.success = "Yes";
				addErrorAlert( "Your payment has been entered." );
		}


		detail_param = {
			'registration_id':rc.registration_id,
			'attendee_id':rc.attendee_id,
			'detail_type_id':detail_types[ 'payment'],
			'payment_type_id':payment_type_id,
			'ip':cgi.REMOTE_ADDR,
			'item_id': getCurrentEventID(),
			'processor_id': params.company_processor_id,
			'processor_tx_id':rtn.processor_response.processor_tx_id,
			'receipt': serializeJSON( rtn.processor_response )
		};
		rc['transaction_status'] = {
			'YES':{ 'amount':params.total*-1,
				 	'description':"Payment Notes: " &  rc.account_info.notes
				 },
			'NO':{ 'amount':0,
				 	'description':"Payment (#dollarFormat( params.total )#) Error: " &  rtn.message & " "
				 }
		};
		structAppend( detail_param, rc.transaction_status[ rtn.success ], true );

		rc['detail_id'] = getRegistrationManager().saveRegistrationDetail( argumentCollection=detail_param );
		rc['group_detail'] = {
			'registration_id':rc.registration_id,
			'payment_amount':rc.account_info.amount*-1,
			'payment_registration_detail_id':rc.detail_id
		};
		getRegistrationManager().GroupPaymentWaterfall( argumentCollection=group_detail );

		rtn['formatted_message'] = getAlertBox().render();
		getFW().renderData( "json", rtn );
		return;
	}
	/**
	* I am an ajxk call to get an attendee
	*/
	public void function getAttendee( rc ) {
		structAppend( rc, {'attendee_id':0}, false );
		getFW().renderData( "json", getAttendeeManager().getAttendee( rc.attendee_id, getCurrentEventID() ) );
		return;
	}
	/**
	* I get all of the payments in the reg details to refund
	*
	*/
	public any function registrationPayments(rc) {
		var params = rc;
		structAppend( params, {
			'registration_id':0,
			'attendee_id':0
			}, false );

		getFW().renderData( "json", getRegistrationManager().getRegistrationDetailPayments( argumentCollection=params ) );
		return;
	}
	/**
	* I process a Refund
	*/
	public void function processRefund( rc ) {//fixme: move logic to manager
		var rtn = {'success':"No",'message':"","processor_response":{}};
		var detail_param = {};
		var detail_types = getConfig().detail_types;
		var processor_response = "";
		var params = {
			'amount':0,
			'attendee_id':0,
			'notes':"",
			'processor_tx_id':"",
			'registration_id':0,
			'tx_x_date':"",
			'tx_last_4':"",
			'item_id':0,
			'event_id':getCurrentEventID()
			};
		var payment_types = getPaymentTypesManager().getPaymentTypes();
		var payment_type_id = 0;

		structAppend( rc, {'refund_info':{}},false);
		structAppend( params, rc.refund_info );
		if( structKeyExists( payment_types, params.payment_type ) ) {
			payment_type_id = payment_types[ params.payment_type ];
		}
		switch ( params.payment_type ){
			case "credit_card":
				params['company_processor_id'] = getCompanyManager().getCompanyProcessorCreditCards( getCurrentCompanyID(), getCurrentEventID() ).processor_id;
				processor_response = getPaymentManager().doCCRefund( argumentCollection=params );
				rtn['success'] = processor_response.getsuccess();
				rtn['message'] = processor_response.getmessage();
				rtn['processor_response'] = processor_response.getparsedresult();
				rtn['processor_response']['processor_tx_id'] = processor_response.getTransactionID();
			break;
			default:
				params['company_processor_id'] = 0;
				processor_response = "Your refund has been entered.";
				rtn['success'] = "Yes";
				rtn['message'] = processor_response;
				rtn['processor_response'] = {};
				rtn['processor_response']['processor_tx_id'] = 0;
		}



		detail_param = {
			'registration_id':params.registration_id,
			'attendee_id':params.attendee_id,
			'detail_type_id':detail_types[ 'refund'],
			'payment_type_id': payment_type_id,
			'ip':cgi.REMOTE_ADDR,
			'item_id': params.item_id,
			'processor_id': params.company_processor_id,
			'processor_tx_id':rtn.processor_response.processor_tx_id,
			'receipt': serializeJSON( rtn.processor_response ),
			'item_id': params.item_id
		};

		rc['transaction_status'] = {
			'YES':{ 'amount':params.amount,
				 	'description':"Refund Notes: " &  params.notes
				 },
			'NO':{ 'amount':0,
				 	'description':"Refund Error: " &  rtn.message & " "
				 }
		};
		structAppend( detail_param, rc.transaction_status[ rtn.success ], true );
		if( rtn.success ) {
			getRegistrationManager().saveRegistrationDetail( argumentCollection=detail_param );
		}
		addErrorAlert( rtn.message );
		rtn['formatted_message'] = getAlertBox().render();


		getFW().renderData( "json", rtn );
		return;
	}
	/**
	* I process a void
	*/
	public void function processVoid( rc ) {//fixme: move logic to manager
		var rtn = {'success':"No",'message':"","processor_response":{}};
		var detail_param = {};
		var detail_types = getConfig().detail_types;
		var processor_response = "";
		var params = {
			'attendee_id':0,
			'notes':"",
			'processor_tx_id':"",
			'registration_id':0,
			'item_id':0,
			'event_id':getCurrentEventID()
			};
		var payment_types = getPaymentTypesManager().getPaymentTypes();
		var payment_type_id = 0;

		structAppend( rc, {'refund_info':{}},false);
		structAppend( params, rc.refund_info );
		if( structKeyExists( payment_types, params.payment_type ) ) {
			payment_type_id = payment_types[ params.payment_type ];
		}
		switch ( params.payment_type ){
			case "credit_card":
				params['company_processor_id'] = getCompanyManager().getCompanyProcessorCreditCards( getCurrentCompanyID(), getCurrentEventID() ).processor_id;
				processor_response = getPaymentManager().doCCVoid( argumentCollection=params );
				rtn['success'] = processor_response.getsuccess();
				rtn['message'] = processor_response.getmessage();
				rtn['processor_response'] = processor_response.getparsedresult();
				rtn['processor_response']['processor_tx_id'] = processor_response.getTransactionID();
			break;
			default:
				params['company_processor_id'] = 0;
				processor_response = "Your void has been entered.";
				rtn['success'] = "Yes";
				rtn['message'] = processor_response;
				rtn['processor_response'] = {};
				rtn['processor_response']['processor_tx_id'] = 0;
		}


		detail_param = {
			'registration_id':params.registration_id,
			'attendee_id':params.attendee_id,
			'detail_type_id':detail_types[ 'void' ],
			'payment_type_id': payment_type_id,
			'ip':cgi.REMOTE_ADDR,
			'item_id': params.item_id,
			'processor_id': params.company_processor_id,
			'processor_tx_id':rtn.processor_response.processor_tx_id,
			'receipt': serializeJSON( rtn.processor_response )
		};

		rc['transaction_status'] = {
			'YES':{ 'amount':params.amount,
				 	'description':"Void Notes: " &  params.notes
				 },
			'NO':{ 'amount':0,
				 	'description':"Void Error: " &  rtn.message & " "
				 }
		};
		structAppend( detail_param, rc.transaction_status[ rtn.success ], true );
		if( rtn.success ) {
			getRegistrationManager().saveRegistrationDetail( argumentCollection=detail_param );
		}
		addErrorAlert( rtn.message );
		rtn['formatted_message'] = getAlertBox().render();

		getFW().renderData( "json", rtn );
		return;
	}
	/**
	* Multi line method description
	* @argument_name Argument description
	*/
	public any function registrationDetails( rc ) {
		var rtn = {};
		var params = {
			'attendee_id':0,
			'registration_id':0,
			'draw':0
			};
		structAppend( params, rc );
		rtn = getRegistrationManager().getRegistrationDetails( argumentCollection=params );

		getFW().renderData( "json", rtn );
		return;
	}
	/**
	* I update an Attendee Registration status
	*/
	public void function updateAttendeeStatus(rc) {
		var rtn = {'success':true};
		var params = {
			'attendee_id':0,
			'registration_id':0,
			'attendee_status':"Registered"
			};
		structAppend( params, rc );

		getAttendeeManager().uodateAttendeeStatus( argumentCollection=params );
		getFW().renderData( "json", rtn );
		return;
	}
	/**
	* I cancel an Attendee Registration
	*/
	public void function cancelAttendee(rc) {
		var params = {
			'attendee_id':0,
			'registration_id':0,
			'event_id':getCurrentEventID(),
			'send_cancel_email':false
			};
		structAppend( params, rc );
		getAttendeeManager().cancelAttendee( argumentCollection=params );
		redirect( action="attendee.manage", preserve="attendee_id");
		return;
	}
	/**
	* I cancel an Attendee Registration
	*/
	public void function activateAttendee(rc) {
		var params = {
			'attendee_id':0,
			'registration_id':0,
			'event_id':getCurrentEventID()
			};
		structAppend( params, rc );
		getAttendeeManager().activateAttendee( argumentCollection=params );
		redirect( action="attendee.manage", preserve="attendee_id");
		return;
	}
	/**
	* I cancel an agnda item for an attendee
	*/
	public void function cancelAgendaItem(rc) {
		var params = {
			'attendee_id':0,
			'registration_id':0,
			'agenda_id':0,
			'event_id':getCurrentEventID()
			};
		structAppend( params, rc );

		getAttendeeManager().cancelAttendeeAgenda( argumentCollection=params );
		redirect( action="attendee.manage", preserve="attendee_id");
		return;
	}
	/*
	* Sends out a confirmation email to the attendee
	*/
	public void function sendConfirmation( rc ){
		var params = {
			'attendee_id':0,
			'registration_id':0,
			'event_id':getCurrentEventID()
			};
		structAppend( params, rc );
		getAttendeeManager().sendConfirmation( argumentCollection=params );
		redirect( action="attendee.manage", preserve="attendee_id");
	}
	/**
	* I check to see if a selected agenda item conflicts with any of the other agenda items selected
	*/
	public void function agendaConflictCheck( rc ) {
		var params = { 'agenda_ids':"", 'agenda_id':0 };
		structAppend( params, rc );
		getFW().renderData( "json", { 'has_conflict': getAgendasManager().AgendaConflictCheck( argumentCollection=params ) } );
		return;
	}
	/**
	* Multi line method description
	* @argument_name Argument description
	*/
	public void function doSaveAgenda( rc ) {
		var params = rc;
		structAppend( params,{
			'attendee_id':0,
			'agenda_ids':""
		},false );
		getAttendeeManager().saveAttendeeAgenda( argumentCollection=params );
		redirect( action="attendee.manage", preserve="attendee_id");
		return;
	}
	/*
	* Purges all records of an attendee for an Event
	*  NOTE:  This is a descructive purge and does not log any actions
	*		  Should only be used for system clean up
	* @attendee_id The id of the attendee
	* @event_id The id of the event
	*/
	public void function purgeAttendeeFromEvent( rc ) {
		var params = rc;
		structAppend( params,{
			'attendee_id': 0,
			'event_id': getCurrentEventID()
		},false );
		if( getSessionManageUserFacade().isAdmin() && params.attendee_id && params.attendee_id ) {
			getAttendeeManager().purgeAttendeeFromEvent( argumentCollection=params );
		}
		redirect( action="attendee" );
		return;
	}
	/**
	* I check to see if a coupon code is valid, if so I apply it to an attendee's record
	*/
	public void function applyCoupon( rc ) {
		var params = rc;
		structAppend( params, {
			'attendee_id':0,
			'registration_id':0,
			'event_id':getCurrentEventID(),
			'registration_type_id':0,
			'code':""
		},false );
		getAttendeeManager().applyCoupon( argumentCollection:params );

		getFW().renderData( "json", { 'success': true, 'notification': getAlertBox().render() } );
		return;
	}
}

