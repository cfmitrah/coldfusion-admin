/**
*
* @file  /model/managers/Attendee.cfc
* @author
* @description
*
*/

component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="AttendeeDao" getter="true" setter="true";
	property name="Crypto" getter="true" setter="true";
	property name="RegistrationDao" getter="true" setter="true";
	property name="EventDao" getter="true" setter="true";
	property name="AutoresponderDao" getter="true" setter="true";
	property name="EmailManager" getter="true" setter="true";
	property name="RegistrationTypeDao" getter="true" setter="true";
	property name="RegistrationManager" getter="true" setter="true";
	property name="RegistrationSectionManager" getter="true" setter="true";
	property name="Dformd" setter="true" getter="true";
	property name="geographyManager" setter="true" getter="true";
	property name="FormUtilities" setter="true" getter="true";
	property name="EventSettingManager" setter="true" getter="true";
	property name="CouponsManager" setter="true" getter="true";
	property name="SlugManager" setter="true" getter="true";
	/*
	* Gets all of the attendees for an event
	* @event_id The id of the event to get the attendees for
	* @start (optional) The row to start on
	* @results (optional) The number of results to return
	* @sort_column (optional) The column to sort by
	* @sort_direction (optional) The direction to sort
	* @search (optional) A Keyword to filter the results on
	*/
	public struct function getAttendees(
		required numeric event_id,
		numeric order_index=0,
		string order_dir="asc",
		string search_value="",
		numeric start_row=0,
		numeric total_rows=100,
		numeric draw=1
	) {
		var params = arguments;
		var columns = [ "attendee_id","first_name","last_name","email","registration_type","attendee_status"];
		var attendees = "";
		var rtn = {"draw"=arguments.draw, "recordsTotal"=0, "recordsFiltered"=0,"data"=[]};
	 	structAppend( params, {
		 	'start'=(start_row+1),
		 	'results'=arguments.total_rows,
		 	'sort_column'=columns[ order_index + 1 ],
		 	'sort_direction'=arguments.order_dir,
		 	'search'=arguments.search_value
		 	}, true );

		attendees = getAttendeeDao().AttendeesList( argumentCollection:params ).result;
		rtn.data = queryToArray(
			recordSet=attendees,
			columns= listAppend( attendees.columnList, "options" ),
			data={'event_id':arguments.event_id},
			map=function( row, index, columns, data ){
					var options = "<a href=""/attendee/manage/attendee_id/" & row.attendee_id & "/"" class=""btn btn-sm btn-primary"">Manage Account</a>";
			    	row['options'] = options;
			    	if( getSessionManageUserFacade().isAdmin() ) {
				    	row['options'] &= "<a href=""/attendee/purgeAttendeeFromEvent/event_id/" & data.event_id & "/attendee_id/" & row.attendee_id & "/"" class=""btn btn-sm btn-danger"">Purge Attendee from Event</a>";
			    	}
			        return row;
			});

		rtn['recordsTotal'] = val(attendees.total);
		rtn['recordsFiltered'] = val(attendees.total);

		return rtn;
	}
	/**
	* Multi line method description
	* @argument_name Argument description
	*/
	public struct function getListingConfig() {
		var listing_config = {
			'table_id':"attendee_listing"
			,'ajax_source':"attendee.getAttendees"
			,'aoColumns':[
				{
					'data':"attendee_id",
					"sTitle": "ID",
					'bSortable': true
				},
				{
					'data':"first_name",
					"sTitle": "First Name",
					'bSortable': true
				},
				{
					'data':"last_name",
					"sTitle": "Last name",
					'bSortable': true
				},
				{
					'data':"email",
					"sTitle": "Email Address",
					'bSortable': true
				},
				{
					'data':"registration_type",
					"sTitle": "Attendee Type",
					'bSortable': true
				},
				{
					'data':"attendee_status",
					"sTitle": "Status",
					'bSortable': true
				},
				{
					'data':"options",
					"sTitle": "Options"
				}

		    ]
		};
		return listing_config;
	}
	/*
	* Gets an attendee
	* @attendee_id The attendee_id
	*/
	public struct function getAttendee( required numeric attendee_id, required numeric event_id ) {
		var attendee = getAttendeeDao().AttendeeGet( argumentCollection=arguments );
		var agenda = getAttendeeDao().AttendeeAgendaGet( argumentCollection=arguments ).result;
		var group_cost = {};
		attendee['cost_breakdown'] = {'total_cost':0, 'total_credits':0, 'total_due':0};
		if( isJSON( attendee.custom ) ) {
			attendee['custom'] = deserializeJSON( attendee.custom );
		}else{
			attendee['custom'] = {};
		}
		attendee['details'] = {
			'data':queryToArray(
				recordSet=attendee.details,
				columns=listAppend( attendee.details.columnList, "options,receipt_data" ),
				map=function( row, index, columns, data ){
					row['detail_timestamp'] = "" & dateformat( row.detail_timestamp, "m/dd/yyyy" ) & " " & timeformat( row.detail_timestamp, "h:mm tt" );
					if( isJson( row.receipt ) ) {
						row['receipt_data'] = deserializeJSON( row.receipt );
					}else{
						row['receipt_data'] = {};
					}
					row['options'] = "";

					row['amount'] = dollarFormat( val( row.amount ) );
					return row;
				},data={'attendee':attendee}),
			'count':attendee.details.recordCount };
		attendee['notes'] = { 'data':queryToArray( attendee.notes ), 'count':attendee.notes.recordCount };
		attendee['logs'] = { 'data':queryToArray( attendee.logs ), 'count':attendee.logs.recordCount };
		attendee['detailPayments'] = { 'data':queryToArray( attendee.detailPayments ), 'count':attendee.detailPayments.recordCount };
		attendee['Agenda'] = {
			'count': agenda.recordcount,
			'data':queryToArray( recordset=agenda,
				map=function( row, index, columns, data ){
			    	row[ 'start_time' ] = "" & timeformat( row.start_time, 'h:mm tt');
			    	row[ 'end_time' ] = "" & timeformat( row.end_time, 'h:mm tt');
			        return row;
					}
			)};
		attendee['group'] = {'count': attendee.group.recordcount,'data':queryToArray( 
				recordset=attendee.group,
				map=function( row, index, columns, data ){
					row['total_due'] = row.total_fees_cancels + row.total_discounts;
					return row;
				}	
			)};
		attendee['Agenda']['agenda_ids'] = valuelist( agenda.agenda_id );
		
		attendee['parent_attendee_id'] = val( attendee.parent_attendee_id );
		
		attendee['formatted_name'] = attendee.first_name & " " & attendee.last_name;

		if( attendee.group_allowed && attendee.attendee_id == attendee.parent_attendee_id ) {
			group_cost = getAttendeeDao().GroupCostBreakdownGet( attendee.registration_id );
			structDelete( group_cost, "prefix" );
			structAppend( attendee, group_cost, true);
		}
		attendee['cost_breakdown']['total_cost'] = attendee.total_cost;
		attendee['cost_breakdown']['total_fees_cancels'] = attendee.total_fees_cancels;
		attendee['cost_breakdown']['total_due'] = attendee.total_due;
		attendee['cost_breakdown']['total_credits'] = attendee.total_credits*-1;
		attendee['cost_breakdown']['total_discounts'] = attendee.total_discounts*-1;		
		
		structAppend( attendee['cost_breakdown'],
			{'total_cost_display':dollarFormat(attendee.cost_breakdown.total_cost)
			,'total_credits_display':dollarFormat(attendee.cost_breakdown.total_credits)
			,'total_due_display':dollarFormat(attendee.cost_breakdown.total_due)
			,'total_discounts_display':dollarFormat(attendee.cost_breakdown.total_discounts)
			,'total_fees_cancels_display':dollarFormat(attendee.cost_breakdown.total_fees_cancels)

		});
		return attendee;
	}
	public numeric function processSave(
		numeric attendee_id=0,
		required numeric event_id,
		required struct registration,
		struct custom={},
		required string upload_prefix,
		required string fieldnames
	) {
		var params = arguments;
		var fees = 0;
		var detail_param = {};
		var coupons = {};
		var attendee = {};
		var form_field_prefix = "";
		structAppend( params, arguments.registration, false );
		if( structKeyExists( params, "custom" ) ) {
			for( var custom_field_name in params.custom ) {
				if( structKeyExists( params.custom, custom_field_name )
					&& listLast( params.custom[ custom_field_name ], "." ) == "tmp" ) {
					for( var field_name in arguments.fieldnames ) {
						if( listLast( field_name, "." ) == custom_field_name ) {
							form_field_prefix = left( field_name, len(field_name) - len(custom_field_name ) );
							break;
						}
					}
					uploadFile( custom_field_name, params.event_id, params.custom, params.email, form_field_prefix );
				}else if( structKeyExists( params.custom, custom_field_name & "_current" ) ) {
					params.custom[ custom_field_name ] = params.custom[ custom_field_name & "_current" ];
					StructDelete( params.custom, custom_field_name & "_current" );
				}
			}
		}
		params['custom'] = serializeJSON( arguments.custom );
		structAppend( params, {'registration_type_id':0, 'upload_prefix':"", 
			'hotel_id':0, 'hotel_room_type_id':0, 'hotel_number_rooms':0, 'registration_id':0 }, false );
		
		if( params.registration_type_id && params.registration_id ) {
			if( !isnumeric( params.hotel_room_type_id ) ) {
				params['hotel_room_type_id'] = 0;
			}
			if( !isnumeric( params.hotel_number_rooms ) ) {
				params['hotel_number_rooms'] = 0;
			}
			if( !isnumeric( params.hotel_id ) ) {
				params['hotel_id'] = 0;
			}
			attendee_id = save( argumentCollection=params );
		}

		if( arguments.registration.registration_type_id != arguments.registration.current_registration_type_id) {
			//Cancel the event for the attendee
			getAttendeeDao().AttendeeEventCancel(
				event_id=arguments.event_id,
				attendee_id=arguments.attendee_id,
				registration_id=params.registration_id,
				ip=cgi.remote_addr,
				cancel_description="Changed Attendee Type",
				ignore_rules=1
			);
			//Add new event record to detail

			fees = getRegistrationFee( arguments.registration.registration_type_id ).price;
			detail_param = {
				'registration_id':params.registration_id,
				'attendee_id':arguments.attendee_id,
				'detail_type_id':getAppConfig().detail_types[ 'event_fee'],
				'amount':val( fees ),
				'payment_type_id':0,
				'description': getEventDao().EventNameGet( arguments.event_id ),
				'ip':cgi.REMOTE_ADDR,
				'item_id':arguments.event_id,
				'processor_id':0,
				'processor_tx_id':"",
				'receipt': ""
			};
			getRegistrationManager().saveRegistrationDetail( argumentCollection=detail_param );
			coupons = removeCoupons( arguments.attendee_id, params.registration_id );
			coupon_params ={
				'registration_type_id':arguments.registration.registration_type_id
				,'attendee_id':arguments.attendee_id
				,'registration_id':params.registration_id
				,'event_id':arguments.event_id
			};
			for(var i=1; i LTE coupons.count; i=i+1) {
				coupon_params['code'] = coupons.data[i].code;
				applyCoupon( argumentCollection=coupon_params );
			}
		}
		
		attendee = getAttendeeDao().AttendeeGet( argumentCollection=arguments );
		return attendee_id;
	}
	/**
	* I save an attendee
	*/
	public numeric function save(
		numeric attendee_id=0,
		required numeric event_id,
		required numeric registration_type_id,
		required string email,
		string password="",
		string salt="",
		required numeric registration_id=0,
		required numeric coupon_id=0,
		string prefix="",
		string first_name="",
		string middle_name="",
		string last_name="",
		string suffix="",
		string job_title="",
		string name_on_badge="",
		string company="",
		string country_code="",
		string address_1="",
		string address_2="",
		string city="",
		string region_code="",
		string postal_code="",
		string home_phone="",
		string work_phone="",
		string extension="",
		string fax_phone="",
		string cell_phone="",
		string dob="",
		string gender="",
		string emergency_contact_name="",
		string emergency_contact_phone="",
		string secondary_email="",
		string cc_email="",
		string custom="",
		required numeric company_id=0,
		string attendee_status="",
		numeric hotel_id=0,
		numeric hotel_room_type_id=0,
		string hotel_checkin_date="",
		string hotel_checkout_date="",
		numeric hotel_number_rooms=0,
		string hotel_reservation_name="",
		string hotel_reservation_phone="",
		string hotel_reservation_email="",
		boolean hotel_requested=false,
		numeric parent_attendee_id=0,
		string cc_email_2="",
		string cc_email_3="",
		string cc_email_4=""
	) {

		return getAttendeeDAO().AttendeeSet( argumentCollection:arguments );
	}
	/**
    * I get a list of section for a registration type
    * @registration_type_id ID of the registration type that you want a list of sections for
    */
	public struct function getRegistrationSections( required numeric registration_type_id, required struct custom_fields, required struct standard_fields, required numeric event_id ) {
		var data = getRegistrationSectionManager().getRegistrationSections( arguments.registration_type_id, true, true );
		data['all_fields'] = [];
		data[ 'tabs' ] = [];
		data['has_hotel'] = false;
		for (var i=1; i lte data.count; i=i+1 ) {
			var section = data.data[ i ];
			var tab =  {
				'name': section.title,
				'active': (i eq 1),
				'content': doRenderSection( section, i, arguments.custom_fields, arguments.standard_fields, arguments.event_id ),
				'id': "tab-" & section.section_id
			};
			if( section.section_type_name == "hotel" ) {
				data['has_hotel'] = true;
			}
			arrayAppend( data[ 'tabs' ], tab  );
			data['all_fields'].addAll( section.fields );
		}
		return data;
	}
	/**
    * I render a section's fields
    * @section_config The config of the section that you want to render
    */
	public string function doRenderSection(
		required struct section_config,
		section_index,
		required struct custom_fields,
		required struct standard_fields,
		required numeric event_id,
		struct hotel_fields={}
		) {
		var Dformd = getDformd().getDform();
		var field_context = "";
		var element = "";
		var prefix = { '1': "standard", '2': "standard", '0': "custom", '3':"hotel" };
		var settings = {
			'wrappers': { '2-columns': 'two_col_wrapper', '1-column': 'one_col_wrapper' },
			'field_prefix': "register_field"
		};
		var custom_field_values = arguments.custom_fields;
		var standard_field_values = arguments.standard_fields;

      	Dformd.setAutoWrapper( true );
		Dformd.setWrapperElementType( settings.wrappers[ section_config.layout ] );

      	for (var i=1; i lte section_config.field_count; i=i+1){
      		field_context = duplicate( section_config.fields[ i ] );
      		field_context['not_has_narrative'] = true;
      		field_context[ 'id' ] = field_context.field_name;
      		field_context[ 'field_name' ] = settings.field_prefix & "[" & arguments.section_index &"]." & prefix[ field_context.standard_field ] & "." & field_context.field_name;
      		field_context[ 'value' ] = "";
      		 if( structKeyExists( standard_field_values, field_context.id ) ) {
	      		field_context[ 'value' ] = standard_field_values[ field_context.id ];
      		}else if( structKeyExists( custom_field_values, field_context.id ) ){
	      		field_context[ 'value' ] = custom_field_values[ field_context.id ];
      		}else if( structKeyExists( hotel_fields, field_context.id ) ){
	      		field_context[ 'value' ] = hotel_fields[ field_context.id ];
      		}
      		if( isStruct( field_context.attributes ) ) {
      			structAppend( field_context, field_context.attributes, false );
      		}
      		if( field_context.standard_field == 2) {
	      		field_context[ 'field_name' ] = settings.field_prefix & "[" & arguments.section_index &"].standard." & field_context.id;
	      		if( field_context.field_type == "password") {
		      		field_context['value'] = "*****";
		      	}
		      	if( listFindNoCase("email,password", field_context.id ) ) {
		      		field_context['field_type'] = "display";
		      		field_context['required'] = false;
	      		}
      		}

	      	if( field_context.choices.count ) {
	      	field_context['field_choices'] = field_context.choices.data;

		      	for( var j=1; j lte field_context.choices.count; j=j+1 ) {
		      		var choice = field_context.choices.data[ j ];
		      		if( listFindNoCase( field_context.value, trim(choice.value) ) ) {
			      		field_context['field_choices'][ j ][ 'is_selected' ] = true;
		      		}else if( findNoCase( ",", trim(choice.value) ) && findNoCase( field_context.value, trim(choice.value) ) ){
			      		field_context['field_choices'][ j ][ 'is_selected' ] = true;
		      		}
		      	}
		      	//if(section_index==2) writedump(field_context);
		      	if( structKeyExists( field_context, "has_other_input" ) && listFindNoCase( field_context.value, "other" ) ) {
			      	field_context[ 'other_selected' ] = true;
			      	field_context[ 'other_value' ] = listLast( field_context.value );
		      	}
	      	}

	      	if( field_context.id == "region_code" && structKeyExists( field_context, "region_code" ) ) {
		      	field_context['regions'] = getGeographyManager().getRegions( field_context.region_code );
		      	field_context['options'] = getFormUtilities().buildOptionList( field_context.regions.region_code, field_context.regions.region_name, field_context.value );
	      	}else if( field_context.id == "country_code" ) {
	      		if( structKeyExists( standard_field_values,"country_code" ) ) {
		      		field_context['value'] = standard_field_values.country_code;
	      		}

		      	field_context['countries'] = getGeographyManager().getCountries();
		      	field_context['options'] = getFormUtilities().buildOptionList( field_context.countries.country_code, field_context.countries.country_name, field_context.value );
	      	}

      		switch ( field_context.field_type ) {
      			case "date":
      				if( isdate( field_context.value ) ) {
      					field_context[ 'value' ] = dateformat( field_context.value, "m/dd/yyyy" );
      				}
	  				break;
      			case "image":
	      			field_context[ 'has_image' ] = false;
      				if( len( field_context.value ) ) {
	      				field_context[ 'image_url' ] = getAppConfig().urls.mp_cdn;
		      			field_context[ 'image_url' ] = field_context.image_url & "images/events/" & arguments.event_id & "/";
	      				field_context[ 'image_url' ] = field_context.image_url & field_context.value;
		  				field_context[ 'has_image' ] = true;
		  				field_context['required'] = false;
      				}
      				break;
      			case "yes_no":
      				if( val(field_context.value) ) {
      					field_context['yes_is_selected'] = true;
      				}else if( field_context.value == 0 ){
      					field_context['no_is_selected'] = true;
      				}

      				break;
      			case "narrative":
      				field_context['not_has_narrative'] = false;
      				break;
      				
      		}
		  	field_context[ 'is_required' ] = field_context.required;
		  	field_context['has_placeholder'] = ( structKeyExists( field_context, "placeholder" ) and len(field_context.placeholder) gt 0);
		  	field_context['has_narrative'] = ( structKeyExists( field_context, "narrative" ) and len(field_context.narrative) gt 0);
      		element = getDformd().getElement( type=field_context.field_type, context=field_context );
      		Dformd.addElement( element );
	    }

		return Dformd.render( true );
	}
	/*
	* Updates an Attendee's Status for a Registration
	* @registration_id The ID the of the registration
	* @attendee_id The Attendee ID
	* @attendee_status The attendee status
	*/
	public void function uodateAttendeeStatus(
		required numeric registration_id,
		required numeric attendee_id,
		required string attendee_status
	) {
		getAttendeeDAO().RegistrationAttendeeStatusSet( argumentCollection=arguments );
		return;
	}
	/*
	* Cancels a Agenda for an Attendee and puts appropriate credits in RegistrationDetails
	* @event_id The id of the event
	* @attendee_id The id of the attendee
	* @registration_id The id of the registration
	* @agenda_id The id of the agenda to cancel
	*/
	public struct function cancelAttendeeAgenda(
		required numeric event_id,
		required numeric attendee_id,
		required numeric registration_id,
		required numeric agenda_id
	) {
		var params = arguments;
		params['ip'] = cgi.REMOTE_ADDR;

		return getAttendeeDAO().AttendeeAgendaCancel( argumentCollection=params );
	}
	/*
	* Cancels an Attendee
	* @event_id The id of the event
	* @attendee_id The id of the attendee
	* @registration_id The id of the registration
	*/
	public struct function cancelAttendee(
		required numeric event_id,
		required numeric attendee_id,
		required numeric registration_id,
		boolean send_cancel_email=false
	) {
		var params = arguments;
		var rtn = {};
		params['ip'] = cgi.REMOTE_ADDR;
		rtn = getAttendeeDAO().AttendeeRegistrationCancel( argumentCollection=params );
		sendCancelEmail( argumentCollection=params );
		return rtn;
	}
	/*
	* Activate's an Attendee
	* @event_id The id of the event
	* @attendee_id The id of the attendee
	* @registration_id The id of the registration
	*/
	public void function activateAttendee(
		required numeric event_id,
		required numeric attendee_id,
		required numeric registration_id,
		required numeric registration_type_id
	) {
		var pricing = getRegistrationFee( arguments.registration_type_id );
		var detail_param = {
			'registration_id':arguments.registration_id,
			'attendee_id':arguments.attendee_id,
			'detail_type_id':getConfig().detail_types[ 'event_fee'],
			'amount':val( pricing.price ),
			'payment_type_id':0,
			'description': getEventDao().EventNameGet( arguments.event_id ),
			'ip':cgi.REMOTE_ADDR,
			'item_id':arguments.event_id,
			'processor_id':0,
			'processor_tx_id':"",
			'receipt': ""
		};

		uodateAttendeeStatus( arguments.registration_id, arguments.attendee_id, "Registered" );
		getRegistrationManager().saveRegistrationDetail( argumentCollection=detail_param );
		sendActivationEmail( argumentCollection=arguments );
	}
	/**
	* I get the fee for a registration type
	* @registration_type_id
	*/
	public struct function getRegistrationFee( required numeric registration_type_id ) {
		var data = getRegistrationTypeDao().RegistrationPriceByTypeGet( argumentCollection=arguments );
		return data;
	}
	/*
	* Sends out a confirmation email to the attendee
	* @event_id The id of the event
	* @attendee_id The id of the attendee
	* @registration_id The id of the registration
	*/
	public void function sendConfirmation( required numeric event_id, required numeric attendee_id, required numeric registration_id ) {
		var params = arguments;
		structAppend( params, { 'autoresponder_type':"confirmation", 'include_agenda':true } );
		getEmailManager().sendAttendeeEmail( argumentCollection:params );
		return;
	}
	/*
	* Sends out a activation email to the attendee
	* @event_id The id of the event
	* @attendee_id The id of the attendee
	* @registration_id The id of the registration
	*/
	public void function sendActivationEmail( required numeric event_id, required numeric attendee_id, required numeric registration_id ) {
		var params = arguments;
		var omit_cancel_email = getEventSettingManager().getEventSettingByKey( arguments.event_id, "omit_cancel_email" ).b_value;
		structAppend( params, { 'autoresponder_type':"activation", 'include_agenda':true } );
		if( isBoolean( omit_cancel_email ) && !omit_cancel_email ) {
			getEmailManager().sendAttendeeEmail( argumentCollection:params );
		}

		return;
	}
	/*
	* Sends out a cancel email to the attendee
	* @event_id The id of the event
	* @attendee_id The id of the attendee
	* @registration_id The id of the registration
	*/
	public void function sendCancelEmail( required numeric event_id, required numeric attendee_id, required numeric registration_id, boolean send_cancel_email=false ) {
		var params = arguments;
		//var omit_cancel_email = getEventSettingManager().getEventSettingByKey( arguments.event_id, "omit_cancel_email" ).b_value;
		structAppend( params, { 'autoresponder_type':"cancellation", 'include_agenda':false } );
		if( send_cancel_email ) {
			getEmailManager().sendAttendeeEmail( argumentCollection:params );
		}

		return;
	}
	/*
	* Updates the sort order for fields in a section in a given reg type
	* @agenda_ids Comma-delimited list of field_ids
	*/
	public void function saveAttendeeAgenda(
		required numeric event_id,
		required numeric attendee_id,
		required numeric registration_id,
		required string agenda_item,
		string ip=cgi.remote_addr )
	{
		var params = arguments;
		var remove_list = "";
		var cancel_agenda_params = {'attendee_id':arguments.attendee_id, 'registration_id':arguments.registration_id, 'event_id':arguments.event_id };
		var current_agenda = getAttendeeDao().AttendeeAgendaGet( arguments.attendee_id, arguments.event_id ).result;
		var current_agenda_items = valuelist( current_agenda.agenda_id );
		
		if( arguments.registration_id && len( current_agenda_items ) ) {
			for( var position = 1; position LTE ListLen( current_agenda_items ); position = position + 1) {
				var value = ListGetAt( current_agenda_items, position );
				if( !ListFindNoCase( arguments.agenda_item, value ) ) {
					cancel_agenda_params['agenda_id'] = value;
					cancelAttendeeAgenda( argumentCollection=cancel_agenda_params );
				}
			}
		}
		params['agenda_ids'] = arguments.agenda_item;
		return getAttendeeDAO().AttendeeAgendasAdd( argumentCollection=arguments );
	}
	
	/*
	* Determines if an attendee email exists already or not in the database
	* @event_id The id of the event
	* @email The users name
	* @in_use (output) Whether or not the email exists
	*/
	public struct function emailExists(
		required numeric event_id,
		required numeric company_id,
		required string email
	) {
		var data = getAttendeeDAO().AttendeeEventEmailExists( argumentCollection=arguments );
		return data;
	}
	/**
	* I process the create request for an attendee
	*/
	public struct function processCreate(
		required numeric event_id,
		required numeric company_id,
		required string email,
		required string last_name,
		required string first_name,
		required string password,
		required string registration_type,
		string access_code="",
		boolean check_code=false,
		numeric parent_attendee_id=0,
		numeric registration_id=0
	 ) {
		var rtn = {'has_error':false, 'attendee_id':0 };
		var valid_access_code = false;
		var detail_params = {'registration_detail_id':0};
		var Registration = { 'registration_id':arguments.registration_id, event_id:arguments.event_id, email:arguments.email };
		var attendee = {};
		var detail_types = getAppConfig().detail_types;
		var email_exists = "";
		if(  arguments.check_code ) {
			valid_access_code = getEventManager().verifyRegistrationTypeAccessCode( arguments.registration_type, arguments.access_code );
			if( !valid_access_code ) {
				getAlertBox().addErrorAlert( "The access code that you used is not valid." );
				rtn['has_error'] = true;
			}
		}

		if( !rtn.has_error ) {
			email_exists = emailExists( arguments.event_id, arguments.company_id, arguments.email );
			if( !email_exists.registered ) {//s@mp.com
				if( !val( registration.registration_id ) ) {
					structAppend( Registration, getRegistrationDao().RegistrationSet( argumentCollection:Registration ) );
				}
				attendee = getAttendeeDao().AttendeeOnlyGet( email_exists.attendee_id );
				attendee['registration_id'] = registration.registration_id;
				attendee['event_id'] = arguments.event_id;
				attendee['email'] = arguments.email;
				attendee['last_name'] = arguments.last_name;
				attendee['first_name'] = arguments.first_name;
				attendee['registration_type_id'] = arguments.registration_type;
				attendee['salt'] = getCrypto().salt();
				attendee['password'] = getCrypto().compute( arguments.password, attendee.salt );
				attendee['parent_attendee_id'] = arguments.parent_attendee_id;
				rtn.attendee_id = save( argumentCollection=attendee );
				structAppend( detail_params, {
					'registration_id':registration.registration_id,
					'attendee_id':rtn.attendee_id,
					'detail_type_id':detail_types[ 'event_fee'],
					'amount':val( getRegistrationTypeDao().RegistrationPriceByTypeGet( arguments.registration_type ).price ),
					'description':getEventDao().EventNameGet( arguments.event_id ),
					'ip':cgi.remote_addr
				} );
				getRegistrationManager().saveRegistrationDetail( argumentCollection=detail_params );
				if( arguments.parent_attendee_id ) {
					getAttendeeDao().RegistrationAttendeesParentSet( arguments.registration_id, arguments.parent_attendee_id );
				}
				
			}else{
				getAlertBox().addErrorAlert( "Please use another email address, that email is already in use for this event." );
				rtn['has_error'] = true;
			}
		}
		return rtn;
	}
	/*
	* Purges all records of an attendee for an Event
	*  NOTE:  This is a descructive purge and does not log any actions
	*		  Should only be used for system clean up
	* @attendee_id The id of the attendee
	* @event_id The id of the event
	*/
	public void function purgeAttendeeFromEvent(
		required numeric attendee_id,
		required numeric event_id
	) {

		return getAttendeeDao().AttendeeEventPurge( argumentCollection=arguments );
	}
	/**
	* I check to see if a coupon code is valid, if so I apply it to an attendee's record
	* @code The coupon code
	* @event_id The id of the event
	* @registration_type_id The id of the registration type
	*/
	public boolean function applyCoupon(
		required numeric attendee_id,
		required numeric registration_id,
		required numeric event_id,
		required string code,
		required numeric registration_type_id
		) {
		var detail_types = getAppConfig().detail_types;
		var coupon = getCouponsManager().validate( argumentCollection:arguments );
		var coupon_valid = coupon.valid;
		var rtn = false;
		var cost_breakdown = {};
		var details = {
			'registration_id': arguments.registration_id,
			'attendee_id': arguments.attendee_id,
			'detail_type_id': detail_types['coupon'],
			'amount': 0,
			'payment_type_id': 0,
			'description': "Coupon - " & arguments.code & " - " & coupon.description,
			'ip': cgi.REMOTE_ADDR,
			'item_id': coupon.coupon_id,
			'processor_id': 0,
			'processor_tx_id': "",
			'receipt': ""
		};

		if ( coupon_valid && val(coupon.value) ) {
			cost_breakdown = getAttendeeDao().AttendeeCostBreakdownGet( arguments.registration_id, arguments.attendee_id );
			if( val( cost_breakdown.total_discounts ) == 0 ) {
				switch ( coupon.coupon_type ){
					case "discount":
						if( val(coupon.value) gt cost_breakdown.total_fees_cancels ) {
							coupon.value = cost_breakdown.total_fees_cancels;
						}
						details['amount'] = coupon.value;
					break;
					case "flat":
						if( val(coupon.value) gt cost_breakdown.total_event_fees ) {
							coupon.value = cost_breakdown.total_event_fees;
						}
						details['amount'] = coupon.value;
					break;
					case "percent":
						if( val(coupon.value) gt 100 ) {
							coupon.value = 100;
						}
						if( val(coupon.value) ) {
							details['amount'] = cost_breakdown.total_fees_cancels * (val(coupon.value)/100);
						}

					break;
				}

				if( val(details.amount) ) {
					details['amount'] = details.amount*-1;
					getRegistrationManager().saveRegistrationDetail( argumentCollection=details );
					getAlertBox().addSuccessAlert( "Your promo code has been applied." );
					cost_breakdown = getAttendeeDao().AttendeeCostBreakdownGet( arguments.registration_id, arguments.attendee_id );
					if( !cost_breakdown.total_due ) {
						uodateAttendeeStatus( arguments.registration_id, arguments.attendee_id, "Registered" );
					}
					rtn = true;
				}else {
					getAlertBox().addErrorAlert( "Sorry! But we were not able to apply this {" & arguments.code & "} promo code." );
				}
			}else {
				getAlertBox().addErrorAlert( "Sorry! But we were not able to apply this {" & arguments.code & "} promo code.  It appears that you have already applied a promo code in the amount of " & dollarformat( cost_breakdown.total_discounts * -1 ) & "." );
			}
		}

		return rtn;
	}
	/**
	* I upload images and files for an attendee
	*/
	public void function uploadFile( required string field_name, required numeric event_id, required struct custom_fields, required string upload_prefix, string form_field_prefix="" ) {
		var file_separator = createObject("java", "java.lang.System").getProperty("file.separator");
		var info = fileUpload( getTempDirectory(), arguments.form_field_prefix & arguments.field_name, "*", "makeunique" );
		var file_name_path = info.serverdirectory & file_separator & info.serverfile;
		var mime_type = FilegetMimeType( file_name_path );
		var new_file_name = arguments.upload_prefix & "_"& getSlugManager().generate( info.serverfilename ) & "." & info.serverfileext;
		var rtn_info = { 'name':new_file_name, 'file_type':"none", 'path': "", 'uploaded': false, 'field_name': lcase( arguments.field_name ) };
		var file_upload_path = getAppConfig().paths.cdn_file_upload_dir & "events/" & arguments.event_id & "/";
		var image_upload_path = getAppConfig().paths.cdn_image_upload_dir & "events/" & arguments.event_id & "/";
		var old_upload = "";

		if( listFindNoCase( getAppConfig().allowed_mime_types.image, mime_type ) ) {
			rtn_info['path'] = image_upload_path;
			rtn_info['uploaded'] = true;
			rtn_info['file_type'] = "image";
			fileMove( file_name_path, rtn_info.path & new_file_name );
			custom_fields[ lcase( arguments.field_name ) ] = new_file_name;
			if( structKeyExists( arguments.custom_fields, arguments.field_name & "_current" ) ) {
				old_upload = image_upload_path & arguments.custom_fields[ arguments.field_name & "_current" ];
				if( len( arguments.custom_fields[ arguments.field_name & "_current" ] )
					&& fileExists( old_upload ) ) {
					FileDelete( old_upload );
				}
				StructDelete( custom_fields, arguments.field_name & "_current" );
			}
		}else if( listFindNoCase(getAppConfig().allowed_mime_types.file, mime_type ) ) {
			rtn_info['path'] = file_upload_path;
			rtn_info['uploaded'] = true;
			rtn_info['file_type'] = "file";
			fileMove( file_name_path, rtn_info.path & new_file_name);
			custom_fields[ lcase( arguments.field_name ) ] = new_file_name;
			if( structKeyExists( arguments.custom_fields, arguments.field_name & "_current" ) ) {
				old_upload = file_upload_path & arguments.custom_fields[ arguments.field_name & "_current" ];
				if( len( arguments.custom_fields[ arguments.field_name & "_current" ] )
					&& fileExists( old_upload ) ) {
					FileDelete( old_upload );
				}
				StructDelete( custom_fields, arguments.field_name & "_current" );
			}
		}else{
			FileDelete( file_name_path );
		}
	}
	/*
	* Remove a coupon from an attendee's record
	* @event_id The id of the event
	* @attendee_id The id of the attendee
	* @registration_id The id of the registration
	*/
	public struct function removeCoupons(
		required numeric attendee_id,
		required numeric registration_id
	) {
		var data = getAttendeeDAO().AttendeeCouponsRemove( argumentCollection=arguments ).result.coupons;

		return {
			'data':queryToArray(data)
			,'count':data.recordCount
		};
	}
	/**
	* I add a note to an attendee for an event
	*/
	public numeric function addNote(
		numeric note_id=0,
		required numeric attendee_id,
		required string note,
		required numeric event_id
	) {

		return getAttendeeDAO().AttendeeNoteSet( argumentCollection:arguments );
	}
	/*
	* Updates an Attendee's password
	* @attendee_id The Attendee ID, if NULL it means to add
	* @password The password hash
	* @salt The salt used to generate the password hash
	*/
	public void function updatePassword(
		required numeric attendee_id,
		required string password
	) {
		var params = {'salt':getCrypto().salt()};
		params['password'] = getCrypto().compute( arguments.password, params.salt );
		params['attendee_id'] = arguments.attendee_id;
		
		getAttendeeDAO().AttendeePasswordSet( argumentCollection:params );
		return;
	}
}