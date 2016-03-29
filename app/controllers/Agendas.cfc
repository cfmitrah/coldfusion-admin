/**
*
* @file  /model/managers/Agendas.cfc
* @author - JG
* @description - This will control all things Agendas in reference to an Event.
*
*/

component extends="$base" accessors="true" {
	property name="EventAgendaSettingsManager" setter="true" getter="true";
	property name="eventsManager" setter="true" getter="true";
	property name="agendasManager" setter="true" getter="true";
	property name="sessionsManager" setter="true" getter="true";
	property name="venuesManager" setter="true" getter="true";
	property name="registrationTypesManager" setter="true" getter="true";
	property name="slugManager" setter="true" getter="true";
	/**
	* before
	* This method will be executed before running any agenda controller methods
	*/
	public void function before( rc ) {
		
		//we need to make sure we do in fact have a company ID		
		if( ! getSessionManageUserFacade().getCurrentCompanyID() ){
			redirect('company.select');
		}
		if( !getCurrentEventID() ){
			redirect('event.select');
		}
		rc.sidebar = "sidebar.event.details";
		rc.event_id = getCurrentEventID();	
		super.before( rc );
		return;
	}
	//START PAGE VIEWS
	/**
	* Default 		
	* This method will render the event agenda list
	**/
	public void function default( rc ) {
		var listing_config = {
			"table_id":"agendas_listing"
			,"ajax_source":"agendas.ajaxListing"
			,"columns":"Session Name, Label, Date Scheduled, Start Time, End Time, Visible, Restrictions, Options"
		    ,"aoColumns":[
		             {"data":"title"}
		            ,{"data":"label"} 
		            ,{"data":"date_scheduled"} 		
		            ,{"data":"start_time"} 
		            ,{"data":"end_time"}
		            ,{"data":"visible"} 		
		            ,{"data":"has_restrictions"}
		            ,{"data":"options"}
		    ]
		};
		
		rc['table_id'] = listing_config.table_id;
		rc['columns'] = listing_config.columns;
		listing_config['ajax_source'] = buildURL( ( structKeyExists( listing_config,'ajax_source' ) ? listing_config.ajax_source: '' ) );
		listing_config['delete_agenda_item_url'] = buildURL( "agendas.ajaxRemoveAgenda" );
		getCfStatic().includeData( listing_config )
			.include("/js/pages/common/listing.js")
			.include("/css/pages/common/listing.css")
			.include("/js/pages/agendas/delete_modal.js");
		return;
	}
	/**
	* Calendar
	* This method will create an agenda item
	*/
	public void function calendar( rc ) {
		return;
	}
	/**
	* Create
	* This method will create an agenda item
	*/
	public void function create( rc ) {
		var event_id = getCurrentEventID();
		var sessions = getSessionsManager().getSessionsQuery( event_id );	
		var venues = getAgendasManager().getEventVenues( event_id: event_id );
		var agenda_config = {
			'ajax_get_locations_url' : buildURL( "agendas.ajaxGetLocations" ) 
		};
		rc['session_opts'] = getFormUtilities().buildOptionList(
			values=sessions.session_id,
			display=sessions.title		
		);
		rc['venue_opts'] = getFormUtilities().buildOptionList(
			values=venues.venue_id,
			display=venues.venue_name		
		);		
		getCfStatic().includeData( agenda_config )
		.include("/js/pages/agendas/get_locations.js")
		.include("/js/pages/agendas/date_time.js")
		.include( "/css/plugins/date-timepicker/date-timepicker.css" );
		return;
	}
	/**
	* details
	* This method will handle the managing of agenda items
	*/
	public void function details( rc ) {
		rc['event_id'] = getCurrentEventID();
		rc['agenda'] = {};
		var agenda_id = structKeyExists( rc, "agenda_id" ) ? rc.agenda_id : 0 ;
		var agenda_config = {
			'ajax_get_locations_url' : buildURL( "agendas.ajaxGetLocations" ),
			'ajax_delete_fee_url' : buildURL( "agendas.ajaxDeleteFee" )
		};
		//get the full agenda details: main details, pricing, restrictions, dependencies, agenda_log
		rc.agenda = getAgendasManager().getAgendaDetails( rc.agenda_id, rc.event_id );
		//set the venues options
		var venues = getAgendasManager().getEventVenues( event_id: rc.event_id );
		rc['venue_opts'] = getFormUtilities().buildOptionList(
			values=venues.venue_id,
			display=venues.venue_name,
			selected=rc.agenda.venue_id		
		);		
		//set the sesssion options
		var sessions = getSessionsManager().getSessionsQuery( rc.event_id );
		rc['session_opts'] = getFormUtilities().buildOptionList(
			values=sessions.session_id,
			display=sessions.title,
			selected=rc.agenda.session_id	
		);
		//set the location options
		var locations = getAgendasManager().getEventVenueLocations( rc.agenda.venue_id );
		rc['location_opts'] = getFormUtilities().buildOptionList(
			values=locations.location_id,
			display=locations.location_name,
			selected=rc.agenda.location_id	
		);
		//set checked opts
		rc['checked']['yes'] = "checked=""checked""";
		rc['checked']['no'] = "";
		//show/hide divs
		rc['display_limited_seating'] = rc.agenda.attendance_limit || rc.agenda.waitlist ? "block" : "none";
		rc['display_waitlist'] = rc.agenda.waitlist ? "block" : "none";
		//get registration types
		rc['registration_types'] = getAgendasManager().getAgendaRegistrationTypesOpts( rc.event_id, agenda_id );
		//get registration types
		var registration_types = getAgendasManager().getAgendaRegistrationTypes( rc.event_id, agenda_id );
		rc['registration_opts'] = getFormUtilities().buildOptionList(
			values=registration_types.registration_type_id,
			display=registration_types.registration_type
		);
		rc['wait_list'] = getAgendasManager().getAgendaWaitList( rc.agenda_id );
		getCfStatic().includeData( agenda_config )
			.include("/js/pages/agendas/get_locations.js")
			.include("/js/pages/agendas/date_time.js")
			.include("/js/pages/agendas/details.js")
			.include( "/css/plugins/date-timepicker/date-timepicker.css" );
	}
	//END PAGE VIEWS	
	//START PAGE PROCESSING
	/**
	* DoCreate
	* This method will process the creation of the Agenda Item
	*/
	public void function doCreate( rc ) {
		if( structKeyExists( rc, "agenda") && isStruct( rc.agenda ) ){
			rc['agenda']['event_id'] = getCurrentEventID();
			//save the agenda item	
			if( len( trim( rc['agenda']['new_location'] ) ) ){
				rc.agenda.location_id = getVenuesManager().setVenueLocation( argumentCollection = {
					venue_id: rc.agenda.venue_id,
					location_name: rc.agenda.new_location
				});
			}
			rc['agenda_id'] = getAgendasManager().save( argumentCollection=rc.agenda );
			addSuccessAlert( 'The agenda item was successfully created.' );
			redirect( action="agendas.default" );
		}
		redirect("agendas.create");
		return;		
	}
	/**
	* DoSave
	* This method will process the saving of the Agenda Item
	*/
	public void function doSave( rc ) {
		if( structKeyExists( rc, "agenda" ) && isStruct( rc.agenda ) ){
			if( !getFormUtilities().exists( "agenda_id", rc.agenda ) ) {
				rc['agenda']['agenda_id'] = 0;
			}
			rc['agenda']['event_id'] = getCurrentEventID();
			//save the agenda item	
			if( len( trim( rc['agenda']['new_location'] ) ) ){
				rc.agenda.location_id = getVenuesManager().setVenueLocation( argumentCollection = {
					venue_id: rc.agenda.venue_id,
					location_name: rc.agenda.new_location
				});
			}

			rc['agenda_id'] = getAgendasManager().save( argumentCollection=rc.agenda );
			if( val( rc.agenda_id ) ){
				addSuccessAlert( 'The agenda details were successfully saved.' );
				redirect( action="agendas.details", queryString="agenda_id=" & rc.agenda_id );
			}
		}
		redirect("agendas.default");
		return;
	}
	/**
	* DoCreateFee
	* This method will process the saving of the Agenda Fees
	*/
	public void function doCreateFee( rc ) {
		if( structKeyExists( rc, "agenda" ) && isStruct( rc.agenda ) ){
			if( !getFormUtilities().exists( "agenda_id", rc.agenda ) ) {
				rc['agenda']['agenda_id'] = 0;
			}
			if( !getFormUtilities().exists( "registration_type_ids", rc.agenda ) ){
				rc['agenda']['registration_type_ids'] = 0;
			}
			rc['agenda']['event_id'] = getCurrentEventID();
			getAgendasManager().setAgendaPrices( argumentCollection=rc.agenda );
			addSuccessAlert( 'The agenda associated fees were successfully saved.' );
			redirect( action="agendas.details", queryString="agenda_id=" & rc.agenda.agenda_id );
		}
		redirect("agendas.default");
		return;
	}
	/**
	* doCreateRestrictions
	* This method will process the saving of the Agenda Restrictions
	*/
	public void function doCreateRestrictions ( rc ) {
		if( structKeyExists( rc, "agenda" ) && isStruct( rc.agenda ) ){
			if( !getFormUtilities().exists( "agenda_id", rc.agenda ) ) {
				rc['agenda']['agenda_id'] = 0;
			}
			if( !getFormUtilities().exists( "registration_type_ids", rc.agenda ) ){
				rc['agenda']['registration_type_ids'] = '';
			}
			getAgendasManager().setAgendaRestrictions( argumentCollection=rc.agenda );
			addSuccessAlert( 'The agenda restrictions have been successfully saved.' );
			redirect( action="agendas.details", queryString="agenda_id=" & rc.agenda.agenda_id );
		}
		redirect("agendas.default");
		return;
	}
	/**
	* doCreateCapacity
	* This method will process the saving of the Agenda Capacity
	*/
	public void function doCreateCapacity ( rc ) {
		if( structKeyExists( rc, "agenda" ) && isStruct( rc.agenda ) ){
			if( !getFormUtilities().exists( "agenda_id", rc.agenda ) ) {
				rc['agenda']['agenda_id'] = 0;
			}
			getAgendasManager().setAgendaCapacity( argumentCollection=rc.agenda );
			addSuccessAlert( 'The agenda capacity has been successfully saved.' );
			redirect( action="agendas.details", queryString="agenda_id=" & rc.agenda.agenda_id );
		}
		redirect("agendas.default");
		return;
	}
	//END PAGE PROCESSING
	//START PAGE AJAX
	/**
	* ajaxDeleteFee
	* This method will delete a session fee
	*/
	public void function ajaxDeleteFee( rc ) {
		request.layout = false;
		getAgendasManager().deleteAgendaFee( rc.agenda_price_id, rc.agenda_id );
		getFW().renderData( "json", {
			"success": true
		} );
		return;
	}
	/**
	* ajaxGetLocations
	* This method will get all locations by the venue id
	*/
	public void function ajaxGetLocations( rc ) {
		var venue_locations = getVenuesManager().getVenueLocations( rc.venue_id );
		request.layout = false;
		getFW().renderData( "json", {
			"locations": venue_locations.locations
		} );
		return;
	}	
	/**
	* ajaxRemoveAgenda
	* This method will delete an agenda item
	*/
	public void function ajaxRemoveAgenda( rc ) {
		request.layout = false;
		getAgendasManager().deleteAgendaItem( getCurrentEventID(), rc.agenda_item_id );
		getFW().renderData( "json", {
			"success": true
		} );
		return;
	}
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
			, "event_id" : getCurrentEventID()
		};
		var data = {};
		data = getAgendasManager().getListing( argumentCollection = params );
		data['cnt'] = arrayLen(data.data);
		//create the options links
		for( var i = 1; i <= data.cnt; i++ ) {
			data['data'][i]['date_scheduled'] = dateFormat( data['data'][i]['start_time'], "m/d/yyyy" );
			data['data'][i]['start_time'] = timeFormat( data['data'][i]['start_time'], "h:mm tt" );
			data['data'][i]['end_time'] = timeFormat( data['data'][i]['end_time'], "h:mm tt" );
			data['data'][i]['visible'] = "<span class=""glyphicon glyphicon-" & ( data['data'][i]['visible'] ? "ok" : "remove" ) & """></span>";
			data['data'][i]['has_restrictions'] = "<span class=""glyphicon glyphicon-" & ( data['data'][i]['has_restrictions'] ? "ok" : "remove" ) & """></span>";
			data['data'][i]['options'] = "<a href=""" & buildURL("agendas.details?agenda_id=" & data.data[i].agenda_id ) & """ class=""btn btn-sm btn-primary""> Manage</a>";
			data['data'][i]['options'] &= " <a data-agenda-item-id=""" & data.data[i].agenda_id & """ class=""btn btn-sm btn-danger trigger_delete"" href=""##"">Delete</a>";
			data['data'][i]['agendarules_display'] = data['data'][i]['date_scheduled'] & " - " & data['data'][i]['start_time'] & " " & data['data'][i]['label'];
		}
		getFW().renderData( "json", data );
		request.layout = false;
	}
	//END PAGE AJAX
	/**
	* I get all of the Event Agenda settings
	*/
	public void function settings( rc ) {
		rc['agenda_settings'] = getEventAgendaSettingsManager().getSettings( rc.event_id );
		getCfStatic()
			.include("/js/pages/agendas/settings.js");
		return;
	}
	/**
	* I save the Event Agenda settings
	*/
	public void function saveSettings( rc ) {
		getEventAgendaSettingsManager().saveSettings( rc.event_id, rc.agenda_settings );
		redirect( "agendas.settings" );
		return;
	}
			
}