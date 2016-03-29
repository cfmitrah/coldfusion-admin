/**
*
* @file  /model/managers/Agendas.cfc
* @author - JG
* @description - This will manage all things Agenda in reference to an event.
*
*/

component output="false" displayname="Agenda" accessors="true" extends="app.model.base.Manager" {
	property name="AgendaDao" getter="true" setter="true";
	property name="EventDao" getter="true" setter="true";
	property name="VenueDao" getter="true" setter="true";
	property name="RegistrationTypesDao" getter="true" setter="true";
	property name="EventAgendaSettingsManager" getter="true" setter="true";
	/**
	* GetListing
	* This method will return an agenda for the given event
	*/
	public struct function getListing(
		required numeric event_id, 
		numeric order_index=0, 
		string order_dir="asc", 
		string search_value="", 
		numeric start_row=0, 
		numeric total_rows=10, 
		numeric draw=1
	 ) {
		var columns = [ "title", "date_scheduled", "start_time", "end_time", "is_visible", "has_restrictions" ];
		var params = {
			event_id : arguments.event_id,
			start : ( start_row + 1 ),
			results : arguments.total_rows,
			sort_column : columns[ order_index + 1 ],
			sort_direction : arguments.order_dir,
			search : arguments.search_value
		};
		var agenda = getAgendaDao().AgendasList( argumentCollection = params ).result.agenda;
		return {
			"draw" : arguments.draw,
			"recordsTotal" : len( agenda.total ) ? agenda.total : 0,
			"recordsFiltered" : len( agenda.total ) ? agenda.total : 0,
			"data": queryToArray( agenda )
		};
	}
	/**
	* getAgendaItem
	* This method will get an agenda item
	*/
	public struct function getAgendaDetails( required numeric agenda_id, required numeric event_id ){
		var agenda = getAgendaDao().AgendaGet( argumentCollection = arguments );
		//set dependencies
		agenda['dependencies'] = queryToArray( recordset=agenda.dependencies );
		agenda['dependencies_cnt'] = arrayLen( agenda.dependencies );
		//setpricing
		agenda['pricing'] = queryToArray( recordset=agenda.pricing );
		agenda['pricing_cnt'] = arrayLen( agenda.pricing );
		//set restrictions
		agenda['restrictions'] = queryToStruct( recordset=agenda.restrictions );
		//set log
		agenda['agenda_log'] = queryToArray(  recordset=agenda.agenda_log );
		agenda['agenda_log_cnt'] = arrayLen( agenda.agenda_log );
		agenda['next_sort'] = getAgendaDao().AgendaMaxSortGet( arguments.event_id ) + 1;
		if( !agenda.sort ) {
			agenda['sort'] = agenda.next_sort;
		}
		return agenda;
	}
	/**
	* deleteAgendaItem
	* This method will delete an agenda for the given event
	*/
	public void function deleteAgendaItem( required numeric event_id, required numeric agenda_id ) {
		getAgendaDao().AgendaRemove( argumentCollection = arguments );
		getCacheManager().purgeAgendaCache( getSessionManageUserFacade().getValue('current_event_id') );
		return;
	}
	/**
	* save
	* This method will save an agenda for the given event
	*/
	public any function save(
		numeric agenda_id=0,
		required string label,
		required numeric event_id,
		required string session_id,
		required string start_time,
		required string end_time,
		boolean visible="",
		numeric location_id=0,
		numeric sort=0
	) {
		//format the start/end date
		var params = arguments;
		params['start_time'] = parseDateTime( params.date & ' ' & params.start_time );
		params['end_time'] = parseDateTime( params.date & ' ' & params.end_time );
		structDelete( params, 'new_location' );
		// save the agenda item
		getCacheManager().purgeAgendaCache( getSessionManageUserFacade().getValue('current_event_id') );
		return getAgendaDao().AgendaSet( argumentCollection=arguments );
	}

	/**
	* setAgendaPrice
	* This method will save an agenda price for the agenda
	*/
	public void function setAgendaPrices(
		numeric agenda_price_id=0,
		required numeric agenda_id,
		required string registration_type_ids,
		required numeric price,
		string valid_from="",
		string valid_to=""
	) {
		var params = arguments;
		getAgendaDao().AgendaPricesSet( argumentCollection = arguments );
		getCacheManager().purgeAgendaCache( getSessionManageUserFacade().getValue('current_event_id') );
		return;
	}
	/**
	* setAgendaRestrictions
	* This method will save an agenda restrictions for the agenda
	*/
	public void function setAgendaRestrictions(
		required numeric agenda_id,
		required string registration_type_ids
	) {
		getAgendaDao().AgendaRestrictionsAdd( argumentCollection = arguments );
		getCacheManager().purgeAgendaCache( getSessionManageUserFacade().getValue('current_event_id') );
		return;
	}
	/**
	* setAgendaCapacity
	* This method will save an agenda capacity for the agenda
	*/
	public void function setAgendaCapacity(
		required numeric agenda_id,
		required string attendance_limit,
		boolean waitlist = 0
	) {
		arguments.attendance_limit = val( arguments.attendance_limit.replaceAll('[^0-9\.]+','') );
		getAgendaDao().AgendaCapacitySet( argumentCollection = arguments );
		getCacheManager().purgeAgendaCache( getSessionManageUserFacade().getValue('current_event_id') );
		return;
	}
	/*
	* Gets attendee waitlist
	* @agenda_id The agenda id
	*/
	public struct function getAgendaWaitList( required numeric agenda_id ) {
		var data = {};
		data['wait_list'] = queryToArray( recordset=getAgendaDao().AgendaItemWaitListGet( agenda_id=arguments.agenda_id ).result );
		data['wait_list_cnt'] = arrayLen( data.wait_list );
		return data;
	}
	/*
	* Gets all of the venues associated to an event
	* @event_id The event id
	*/
	public struct function getEventVenues( required numeric event_id ){
		var data = getVenueDao().EventVenuesGet( event_id=arguments.event_id );
		return queryToStruct( recordset=data.result );
	}
	/*
	* Gets all of the venues associated to an event
	* @venue_id The venue id
	*/
	public struct function getEventVenueLocations( required numeric venue_id ) {
		var data = getVenueDao().VenueLocationsGet( venue_id=arguments.venue_id );
		return queryToStruct( recordset=data.result );
	}
	/*
	* Gets all of the registration types associated to an event
	* @event_id The event id
	*/
	public struct function getRegistrationTypes( required numeric event_id ){
		var data = getRegistrationTypesDao().registrationTypesGet( argumentCollection = arguments );
		return queryToStruct( recordset=data.result.registration_types );
	}
	/*
	* deletes an agenda fee
	* @agenda_price_id The agenda price id
	* @agenda_id The agenda id
	*/
	public void function deleteAgendaFee( required numeric agenda_price_id, required numeric agenda_id ) {
		getAgendaDao().AgendaPriceRemove( argumentCollection = arguments );
		getCacheManager().purgeAgendaCache( getSessionManageUserFacade().getValue('current_event_id') );
		return;
	}
	/*
	* gets the agenda restrictions as an array
	* @event_id The event id
	*/
	public struct function getAgendaRegistrationTypesOpts( required numeric event_id, numeric agenda_id ) {
		var data = {};
		data['opts'] = queryToArray( recordset=getAgendaDao().AgendaRegistrationTypesGet( argumentCollection = arguments ).result );
		data['cnt'] = arrayLen( data.opts );
		return data;
	}
	/*
	* gets the agenda restrictions
	* @agenda_price_id The agenda price id
	* @event_id The event id
	*/
	public struct function getAgendaRegistrationTypes( required numeric event_id, numeric agenda_id ) {
		var data = getAgendaDao().AgendaRegistrationTypesGet( argumentCollection = arguments );
		return queryToStruct( recordset=data.result );
	}
	/*
    * I get an agenda by event ID and registration type
    * @event_id
    * @registration_type_id
    */
   public struct function getAgendaByRegistrationType( 
   	required string event_id, 
   	required string registration_type_id,
   	string current_agenda_items=""
   ) {
		var cache_key = "event_" & arguments.event_id & "_agenda_" & arguments.registration_type_id & "_config";
		var agenda = getAgendaDao().AgendasByRegistrationTypeGet( argumentCollection:arguments ).result;
		var agenda_settings = getEventAgendaSettingsManager().getSettings( arguments.event_id );
		var data = { 'count': 0, 'fees': arraySum( listToArray( valueList( agenda.price ) ) ), 'layout_type': agenda_settings.layout_type, 'agenda_settings': agenda_settings };
		var data_agenda = { 'keys':"", 'agenda': [], 'current':0 };
		var data_params = {
				'data_agenda': data_agenda, 
				'current_items': arguments.current_agenda_items,
				'agenda_settings': data.agenda_settings
			};
		queryToArray( 
			recordset=agenda,
			columns= listAppend( agenda.columnList, "scheduled_time,associated_fee,include_option,session_display" ),
			map=function( row, index, columns, data ){
				var date_key =  dateFormat( row.start_date, 'mmddyyyy' );
				var category_key = rereplaceNoCase( row.category,"[[:punct:][:cntrl:][:space:]]", "", "all" );
				var tab_definitions = data.agenda_settings.settings.tab_definitions;
				//var date_label = ( structKeyExists( tab_definitions.date, date_key ) ? tab_definitions.date[date_key]: dateFormat( row.start_date, getDateFormat() ));
				var date_label = ( structKeyExists( tab_definitions.date, date_key ) ? tab_definitions.date[date_key]: dateFormat( row.start_date, "dd/mm/yyyy" ));
				var category_label = ( structKeyExists( tab_definitions.category, category_key ) ? tab_definitions.category[category_key]: row.category );
				var group_key = "";
				var group_label = "";
				var sub_group_key = "";
				var sub_group_label = "";
				var item = {};
				var key_info = {
						'date':{'key':date_key,'label':date_label },
						'category':{'key':( !len( category_key ) ? "==blank==" : category_key ),'label':( !len( category_label ) ? "No Label" : category_label )}
				};
				var checked = {'Yes':"checked",'No':""};
				var associated_fee = { 'Yes': "", 'No': "+" & dollarFormat( row.price ) };
				var session_display = { 'Yes': row.title, 'No': row.label };
				var data_agenda = data.data_agenda;
				var include = { 
					'Yes': "Included <input type=""hidden""  name=""attendee_agenda.agenda_item"" data-agenda_id=""" & row.agenda_id & """  value=""" & row.agenda_id & """ >", 
					'No': "<input type=""checkbox""  name=""attendee_agenda.agenda_item"" data-agenda_id=""" & 
							row.agenda_id & """  value=""" & row.agenda_id & """ " & checked[ yesnoformat(listFindnocase(data.current_items,row.agenda_id)) ] &" >" };
				
				group_key = key_info[ data.agenda_settings.group_by ].key;
				group_label = key_info[ data.agenda_settings.group_by ].label;
				
				sub_group_key = key_info[ data.agenda_settings.sub_group_by ].key;
				sub_group_label = key_info[ data.agenda_settings.sub_group_by ].label;					
				if( !listfindNocase( data_agenda.keys, group_key )  ) {
					arrayAppend( data_agenda.agenda, { 'data': {}, 'key_count': 0, 'count': 0, 'sub_group_keys':"", 'total_fees':0, 'display': group_label } );
					data_agenda.keys = listAppend( data_agenda.keys, group_key );
					data_agenda.current++; 
				}
				
				item = data_agenda.agenda[ data_agenda.current ];
				if( !structKeyExists( item.data, sub_group_key ) ) {
					item['data'][sub_group_key]={'header':sub_group_label,'data':[]}; 
					item['key_count']++;
					item['sub_group_keys'] = listAppend( item.sub_group_keys, sub_group_key );
				}
				
				item['count']++;
				item['total_fees'] = item.total_fees + val( row.price );					
				arrayAppend( item['data'][sub_group_key]['data'], row );
				item['data'][sub_group_key]['count'] = arrayLen( item['data'][sub_group_key]['data'] );
				
				//row[ 'scheduled_time' ] = timeFormat( row.start_time, getTimeFormat() ) & " - " & timeFormat( row.end_time, getTimeFormat() );
				row[ 'scheduled_time' ] = timeFormat( row.start_time, "hh:mm tt" ) & " - " & timeFormat( row.end_time, "hh:mm tt" );
				row[ 'associated_fee' ] = associated_fee[ row.price eq "" ];
				row[ 'include_option' ] = include[ row.included eq 1 ];
				row[ 'session_display' ] = session_display[ row.label eq "" ];
		        return row;
			},
			data=data_params
		);
		data[ 'data' ] = data_agenda.agenda;
		data[ 'count' ] = arrayLen( data_agenda.agenda );

		data['Availability'] = getAgendaAvailability( argumentCollection=arguments );
        return data;
    }
    /**
    * I check get the Availability of an agenda
    */
    public struct function getAgendaAvailability( required string event_id, required string registration_type_id ) {
    	var agenda_counts = getAgendaDao().AgendaRegistrationsCountByType( argumentCollection=arguments ).result;
    	var data = {};
    	var key = "";
    	for( var row=1; row <= agenda_counts.recordCount; row=row+1) {
	    	key = "agenda_id_" & agenda_counts['agenda_id'][row];
	    	data[ key ] = {
	    		'attendance_limit': val( agenda_counts['attendance_limit'][row] ),
	    		'has_limit': agenda_counts['has_limit'][row],
	    		'seats_remaining': val( agenda_counts['seats_remaining'][row] ),
	    		'total_registered': val( agenda_counts['total_registered'][row] )
	    	};
	    	data[ key ]['show_checkbox'] = true;
	    	if( data[ key ].has_limit && data[ key ].seats_remaining lte 0 ) {
		    	data[ key ]['show_checkbox'] = false;
	    	}
		}
    	return data;
    }
    /*
	* Checks a list of agenda_ids against a single agenda id to see if there is a conflict
	* @agenda_id The single agenda id to check against
	* @agenda_ids A comma-delimited list of agenda ids to see if a agenda id conflicts with
	*/
	public boolean function AgendaConflictCheck( required numeric agenda_id, required string agenda_ids ) {
		var params = arguments;

		return getAgendaDao().AgendaConflictCheck( argumentCollection=params );
	}

}