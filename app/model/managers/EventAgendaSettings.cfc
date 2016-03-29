/**
*
* @file  /model/managers/EventAgendaSettings.cfc
* @author - MG
* @description - This will manage all of Event Agenda Settings.
*
*/

component output="false" displayname="Agenda" accessors="true" extends="app.model.base.Manager" {
	property name="EventAgendaSettingsDao" getter="true" setter="true";
	property name="contentDao" getter="true" setter="true";
	/*
	* Gets agenda settings for an event
	* @event_id The ID of the event
	*/
	public struct function getSettings( required numeric event_id ) {
		var data = getEventAgendaSettingsDao().EventAgendaSettingsGet( arguments.event_id );
		var grouping_data = getAgendaGroupingInfo( arguments.event_id );
		data['agenda_help'] = getContentDAO().ContentByKeyGet( arguments.event_id, "agenda_help" ).content;
		if( isJSON( data.settings ) ) {
			data.settings = deSerializeJSON( data.settings );
		}
		if( !isStruct( data.settings ) ) {
			data['settings'] = {};
			data['settings']['tab_definitions'] = {
				'category':{},
				'date':{}
			};
		}

		structAppend( data['settings'], { 'tab_definitions':{}, 'header_labels': {}, 'sort':{'category':{}} }, false );
		structAppend( data['settings']['header_labels'], {'action':"",'name':"",'scheduled_time':"",'associated_fee':""}, false );
		structAppend( data['settings']['tab_definitions'], { 'category':{}, 'date':{} }, false );
		structAppend( data['settings']['tab_definitions']['category'], grouping_data.categories, false );
		structAppend( data['settings']['tab_definitions']['date'], grouping_data.dates, false );

		structAppend( data['settings']['sort']['category'], grouping_data.category_sort, false );

		data['settings']['tab_definitions']['date_original'] = grouping_data.dates;
		data['settings']['tab_definitions']['category_original'] = grouping_data.categories;

		if( !len( data.layout_type ) ) {
			data['layout_type'] = "tabs";
		}
		if( !len( data.group_by ) ) {
			data['group_by'] = "date";
		}
		if( !len( data.sub_group_by ) ) {
			data['sub_group_by'] = "category";
		}

		data['settings']['tab_counts'] = {
			'category': grouping_data.category_count,
			'date': grouping_data.date_count
		};

		return data;
	}
	/**
	* I get agenda grouping info
	*/
	public struct function getAgendaGroupingInfo( required numeric event_id ) {
		var grouping_info = getEventAgendaSettingsDao().AgendasGroupingInfoGet( arguments.event_id ).result;
		var data = {
			'categories': {},
			'category_sort': {},
			'category_count': grouping_info.categories.recordCount,
			'dates': {},
			'date_count': grouping_info.dates.recordCount
		};
		for( var row = 1; row <= data.category_count; row++ ) {
			var tab_key = grouping_info.categories[ 'tab_key' ][ row ];
			data['categories'][ tab_key ] = grouping_info.categories[ 'tab_display' ][ row ];
			data['category_sort'][ tab_key ] = tab_key;

		}
		for( var row = 1; row <= data.date_count; row++ ) {
			data['dates'][ grouping_info.dates[ 'tab_key' ][ row ] ] = grouping_info.dates[ 'tab_display' ][ row ];
		}
		return data;
	}
	/**
	* I save the event agenda settings
	*/
	public void function saveSettings( required numeric event_id, required struct agenda_setting  ) {
		var params = lowerStruct( arguments.agenda_setting );
		var content_params = {'event_id':arguments.event_id, 'content_id':0,'key':'agenda_help', 'content':params.agenda_help };
		structAppend( params, {'settings':{}}, false );
		getContentDAO().ContentSet( argumentCollection=content_params );
		params.settings = serializeJSON( params.settings );
		params['event_id'] = arguments.event_id;
		getEventAgendaSettingsDao().EventAgendaSettingsSet( argumentCollection=params );
		getCacheManager().purgeAgendaCache( getSessionManageUserFacade().getValue('current_event_id') );
		return;
	}

}