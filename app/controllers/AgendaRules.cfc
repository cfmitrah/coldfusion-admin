/**
*
* @file  /model/managers/AgendaRules.cfc
* @author - MG
* @description - This will control all rules for Agenda's
*
*/
component extends="$base" accessors="true" {
	property name="AgendaRulesManager" getter="true" setter="true";
	property name="AgendasManager" getter="true" setter="true";
	property name="attendeeSettingsManager" setter="true" getter="true";
	/**
	* before
	* This method will be executed before running any agenda controller methods
	*/
	public void function before( rc ) {
		hasEventID();
		rc.sidebar = "sidebar.event.details";
		rc.event_id = getCurrentEventID();
		super.before( rc );
		return;
	}
	/**
	* Default
	* This method will render the event agenda rules list
	**/
	public void function default( rc ) {
		var params =  {
				'event_id': getCurrentEventID(),
				'includeOptions': false,
				'draw': 0
				};
		var cfrequest = {
			'delete_agenda_rule_url': buildURL( "agendarules.remove" ),
			'get_agenda_rule_url': buildURL( "agendarules.rule" ),
			'save_agenda_rule_url': buildURL( "agendarules.save" ),
			'get_agenda_items_url': buildURL( action="agendas.ajaxListing", queryString="event_id=" & getCurrentEventID() & "&start=0&length=1000"  ),
			'rules_table':{
				'table_id':"agenda_rules_listing",
				'ajax_source':buildURL("agendarules.rules"),
				'columns':"Name, Type",
			    'aoColumns':[
		            {
			            'data':"name",
						'sTitle': "Name",
						'bSortable': false
			        },
		            {
			            'data':"type",
						'sTitle': "Type",
						'bSortable': false
					},
					{
						'data':"registration_type",
						'sTitle':"Attendee Type",
						'bSortable': false
					},
		            {
			            'data':"options",
						'sTitle': "Options",
						'bSortable': false
					}
			    ]
		   }
		};
		rc['table_id'] = cfrequest.rules_table.table_id;
		rc['rule_types'] = getAgendaRulesManager().getRuleTypes();
		rc['attendee_types'] = getAttendeeSettingsManager().getRegistrationTypeList( argumentCollection=params );
		cfrequest['required_group_rule_type_id'] = rc['rule_types']['required_group'];
		getCfStatic()
			.includeData( cfrequest )
			.include( "/js/pages/agendaRules/default.js")
			.include("/css/pages/common/listing.css")
			.include( "/css/plugins/multiselect.css");
		return;
	}
	/**
	* I am the ajax listing for agenda rules
	*/
	public void function rules( rc ) {
		var params = rc;
		structAppend( params, {
			'order_index' : ( structKeyExists( rc, 'order[0][column]') ? rc['order[0][column]']:0),
			'order_dir' : ( structKeyExists( rc, 'order[0][dir]') ? rc['order[0][dir]']:"ASC"),
			'search_value' : ( structKeyExists( rc, 'search[value]') ? rc['search[value]']:""),
			'start_row' : ( structKeyExists( rc, 'start') ? rc.start:0),
			'total_rows' : ( structKeyExists( rc, 'length') ? rc.length:0),
			'draw' : ( structKeyExists( rc, 'draw') ? rc.draw:0),
			'event_id': getCurrentEventID()
		}, false );
		getFW().renderData( "json", getAgendaRulesManager().getRules( argumentCollection=params ) );

		return;
	}
	/**
	* I remove a rule
	*/
	public void function remove( rc ) {
		var params = rc;
		structAppend( params, {
			'agenda_rule_id': 0
		}, false );
		getAgendaRulesManager().removeRule( argumentCollection=params );
		getFW().renderData( "json", {'success':true} );
		return;
	}
	/**
	* I get a rule
	*/
	public void function rule( rc ) {
		var params = rc;
		structAppend( params, {
			'agenda_rule_id': 0
		}, false );

		getFW().renderData( "json", getAgendaRulesManager().getRule( argumentCollection=params ) );
		return;
	}
	/**
	* I save a rule
	*/
	public void function save( rc ) {
		var params = rc;
		structAppend( params, {'rule':{}}, false);
		structAppend( params.rule, {
			'agenda_rule_id': 0,
			'event_id':getCurrentEventID(),
			'rule_type_id':0,
			'registration_type_id': 0,
			'name':"",
			'definition': {}
		}, false );

		params['rule']['definition'] = serializeJSON( params.rule.definition );
		getFW().renderData( "json", getAgendaRulesManager().saveRule( argumentCollection=params.rule ) );
		return;
	}
}