/**
*
* @file  /model/managers/events.cfc
* @author
* @description
*
*/

component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="CompanyEventDao" getter="true" setter="true";
	property name="CompanyPaymentDao" getter="true" setter="true";
	property name="EventDao" getter="true" setter="true";
	property name="companyDao" getter="true" setter="true";
	property name="venueDao" getter="true" setter="true";
	property name="mediaManager" setter="true" getter="true";
	property name="eventSettingManager" setter="true" getter="true";
	property name="AttendeeManager" setter="true" getter="true";
	property name="EventPaymentTypesManager" setter="true" getter="true";
	property name="FormUtilities" setter="true" getter="true";
	/**
	* Multi line method description
	*
	*/
	public struct function getListing(
		required numeric company_id,
		numeric order_index=0,
		string order_dir="asc",
		string search_value="",
		numeric start_row=0,
		numeric total_rows=10,
		numeric draw=1
	) {
		var columns = [ 'name','published','event_status','start_date','end_date','tags' ];
		var params = {
			company_id : arguments.company_id,
			start : ( start_row + 1 ),
			results : arguments.total_rows,
			sort_column : columns[ order_index + 1 ],
			sort_direction : arguments.order_dir,
			search : arguments.search_value
		};
		var events = "";
		if(  getSessionManageUserFacade().isEventStaff() ) {
			params['user_id'] = getSessionManageUserFacade().getValue("UserID");

		}
		events = getCompanyEventDao().CompanyEventList( argumentCollection=params ).result.events;

		return {
			"draw" : arguments.draw,
			"recordsTotal" : len( events.total ) ? events.total : 0,
			"recordsFiltered" : len( events.total ) ? events.total : 0,
			"data": queryToArray( events )
		};
	}

	/**
	* Get the counters of registered, cancelled and pending attendees for an event.
	* @event_id The id of the event to get the counters for
	*/
	public struct function getEventAttendeesCounter (
				required numeric event_id
	) {
		var stats = getDashboardStats(event_id);

		var params = {'event_id' = event_id};
		structAppend( params, {
			'order_index'=0,
			'order_dir'="ASC",
			'search_value'="",
			'start_row'=1,
			'total_rows'= 1,
			'draw'=0
			});

		var total_registrants = getAttendeeManager().getAttendees( argumentCollection=params );

		var registered = total_registrants.recordsTotal;
		var cancelled = ( stats.attendee_count_breakdown.total_event_cancelled != '' ? stats.attendee_count_breakdown.total_event_cancelled:0);
		var registered_status = ( stats.attendee_count_breakdown.total_event_registered != '' ? stats.attendee_count_breakdown.total_event_registered:0);
		var pending = registered - cancelled - registered_status;

		var counter = {
			'registered' = total_registrants.recordsTotal,
			'cancelled' = cancelled,
			'pending' = pending
		};

		return counter;
	}

	/**
	* Gets all of the events for a given company and creates selectbox options
	*/
	public string function getCompanyEventSelectOptions( required numeric company_id, numeric selected_event_id=0 ) {
		var events = queryToStruct( getCompanyEventSelectList( arguments.company_id, "query" ) );
		var opts = getFormUtilities().buildOptionList( events.event_id, events.name, arguments.selected_event_id );

		return opts;
	}
	/**
	* Gets all of the events for a given company and creates selectbox options
	*/
	public any function getCompanyEventSelectList( required numeric company_id, string data_type="query" ) {
		var events = getCompanyEventDao().CompanyEventSelectList( argumentCollection=arguments ).result;
		var rtn = events;
		var QoQ = {};
		if( !getSessionManageUserFacade().isSystemAdmin() && getSessionManageUserFacade().getValue( 'user_events').count ) {
			QoQ.queryService = new query();
			QoQ.queryService.setName("event_query");
			QoQ.queryService.setDBType("query");
			QoQ.queryService.addParam( name="event_ids", list=true, value=getSessionManageUserFacade().getValue( 'user_events').event_ids, cfsqltype="cf_sql_integer" );
			QoQ.queryService.setAttributes( sourceQuery=rtn );
			QoQ.objQueryResult = QoQ.queryService.execute(sql="SELECT * FROM sourceQuery WHERE event_id IN ( :event_ids ) ");
			rtn = QoQ.objQueryResult.getResult();
		}
		switch ( arguments.data_type ){
			case "struct":
				rtn = queryToStruct( events );
			break;
			case "array":
				rtn = {'data':queryToArray( events ),'count':events.recordCount};
			break;
		}

		return rtn;
	}

	/**
	* Event Create
	*/
	public any function create() {
		return getEventDao().EventSet( argumentCollection= arguments );
	}

	/**
	* I save changes to an event
	*/
	public numeric function save(
		numeric event_id=0,
		required numeric company_id,
		required numeric domain_id,
		required string name,
		required numeric slug_id,
		numeric processor_id=0,
		string start_date="",
		string end_date="",
		string publish_on="",
		string event_status="",
		string access_code="",
		boolean virtual=0,
		numeric capacity=0,
		numeric sso_id=0,
		string settings = "",
		string event_agenda_help=""
		) {
		var rtn = "";
		arguments['settings'] = "{}";//getFormUtilities().buildSettings( arguments );
      	rtn = getEventDao().EventSet( argumentCollection = arguments );
		getCacheManager().purgeEventConfigCache( arguments.event_id );
		return rtn;
	}
	/**
	*  I get the company event lists
	*/
	public struct function getCompanyEventList( required numeric company_id, numeric start=1, numeric results=100 ) {

		return queryToStruct( recordset = getCompanyEventDao().CompanyEventList( arguments.company_id, arguments.start, arguments.results ).result.events );
	}
	/**
	* Get Event Details (Info,Admins,Dates,Staff...)
	*/
	public any function getEvent(required numeric event_id, required numeric company_id){
		return getEventDao().getEvent(event_id:arguments.event_id,company_id:arguments.company_id);
	}
	/**
	* Get Event Venues
	*/
	public any function getEventVenues(required numeric event_id ){
		var data = {};
		data['venues'] = queryToArray( recordset=getEventDao().getEventVenues(event_id:arguments.event_id).result.event_venues  );
		data['venues_cnt'] = arrayLen( data.venues );
		return data;
	}
	/**
	* Get Event venues
	*/
	public struct function getVenueList( required numeric company_id ) {
		var ret = queryToStruct( recordset=getVenueDao().CompanyVenuesGet( argumentCollection = arguments ).result );
		return ret;
	}
	/**
	* Get Event Tags
	*/
	public any function getEventTags(required numeric event_id){
		var data = {};
		var result = getEventDao().getEventTags(event_id:arguments.event_id).result.event_tags;
		data['tags'] = queryToArray( recordset=result );
		data['tags_list'] = arrayToList( queryToStruct( recordset=result ).tag );
		data['tags_cnt'] = arrayLen( data.tags );
		return data;
	}
	/**
	* Set Event Tags
	*/
	public void function setEventTags(required numeric event_id, required string tags, required string tags_list ){
		var params = arguments;
		params.tags &= ',' & params.tags_list;
		structDelete( params, 'tags_list' );
		getEventDao().setEventTags(event_id:arguments.event_id, tags:arguments.tags);
		getCacheManager().purgeEventConfigCache( arguments.event_id );
		return;
	}

	/**
	*	Get Event Statuses
	*/
	public struct function getEventStatuses(){
		var getEventStatuses = getEventDao().EventStatusesGet();
		return queryToStruct( recordset=getEventStatuses.result.event_statuses );
	}
	/**
	*	Set Event Venue
	*/
	public void function setEventVenue( required numeric event_id, required numeric venue_id ){
		getEventDao().EventVenueSet(argumentCollection:arguments);
		getCacheManager().purgeEventConfigCache( arguments.event_id );
		return;
	}
	/**
	*	Event Staff Add
	*/
	public void function eventStaffAdd( required numeric event_id, required numeric user_id ){
		getEventDao().EventStaffAdd(argumentCollection:arguments);
		getCacheManager().purgeEventConfigCache( arguments.event_id );
		return;
	}
	/**
	*	Remove a day from an event
	*/
	public void function eventRemoveDay( required numeric event_id, required numeric day_id ){
		getEventDao().eventRemoveDay(argumentCollection:arguments);
		getCacheManager().purgeEventConfigCache( arguments.event_id );
		return;
	}
	/**
	*	Remove a venue from an event
	*/
	public void function eventRemoveVenue( required numeric event_id, required numeric venue_id ){
		getEventDao().eventVenueRemove(argumentCollection:arguments);
		getCacheManager().purgeEventConfigCache( arguments.event_id );
		return;
	}

	/**
	*
	*/
	public struct function getCompanyDomains( required numeric company_id ) {
		return queryToStruct( recordset=getCompanyDao().companyDomainsGet( argumentCollection=arguments ).result.domains );
	}
	/**
	* setEventDay
	* This method will get all event details by event id
	*/
	public void function setEventDay( required numeric event_id, required string start_time, required string end_time ) {
		var params = arguments;
		params['start_time'] = parseDateTime( params.date & ' ' & params.start_time );
		params['end_time'] = parseDateTime( params.date & ' ' & params.end_time );
		structDelete( params, 'date' );
		getEventDao().EventDaySet( argumentCollection=arguments );
		getCacheManager().purgeEventConfigCache( arguments.event_id );
		return;
	}
	/**
	* getEventDetails
	* This method will get all event details by event id
	*/
	public struct function getEventDetails( required numeric event_id, required numeric company_id ) {
		var data = {};
		data['details'] = getEventDao().EventDetailsGet( argumentCollection=arguments );
		data['date_time'] = queryToArray( recordset=data.details.days );
		data['date_time_cnt'] = arrayLen( data.date_time );
		data['hero_content' ] = queryToArray( data.details.content );
		data['hero_cnt' ] = arrayLen( data.hero_content );

		if( !isstruct( data['details']['settings'] ) ) {
			data['details']['settings'] = {};
		}

		structAppend( data['details']['settings'], {'datetimeformat':"US",'hide_attendee_cost_breakdown':0,'enable_capacity':false}, false );
		structAppend( data['details']['settings'], getEventSettingManager().getFormattedStruct( arguments.event_id ), true );

		if( !isBoolean( data.details.settings.omit_cancel_email ) ) {
			data['details']['settings']['omit_cancel_email'] = false;
		}
		//create a key value pair for easy content output
		data[ 'hero' ] = {};
		for(var i=1; i<=data.hero_cnt; i++ ){ data.hero[ data.hero_content[i].key ] = data.hero_content[i].content; }
		data['payment_types'] = getEventPaymentTypesManager().getEventPaymentTypes( arguments.event_id );

		return data;
	}
	/**
	* getEventName
	* This method will get the name of an event
	* @event_id The id of the event
	*/
	public string function getEventName( required numeric event_id ) {
		return getEventDao().EventNameGet( event_id=arguments.event_id );
	}
	/**
	* getEventCategories
	* This method will get the categories of the event
	* @event_id The id of the event
	*/
	public array function getEventCategories( required numeric event_id ) {
		return getEventDao().EventCategoriesGet( event_id=arguments.event_id ).result.category.toArray();
	}
	/**
	* getEventCategories
	* This method will get the categories of the event
	* @event_id The id of the event
	*/
	public struct function getEventCategoriesStruct( required numeric event_id ) {
		var ret = getEventDao().EventCategoriesGet( event_id=arguments.event_id ).result;
		return queryToStruct( ret );
	}
	/**
	* getEventCategories
	* This method will get the categories of the event
	* @event_id The id of the event
	*/
	public array function getEventCategoriesArray( required numeric event_id ) {
		var ret = getEventDao().EventCategoriesGet( event_id=arguments.event_id ).result;
		return queryToArray( ret );
	}
	/**
	* getProcessorList
	* This method will get the processors for an  event
	* @company_id The id of the company
	*/
	public struct function getProcessorList( required numeric company_id ) {
		var ret = getCompanyPaymentDao().CompanyPaymentProcessorList( argumentCollection = arguments ).result;
		return queryToStruct( recordset=ret );
	}
	/**
	* getEventDomain
	* This method will get the domain name of an event
	* @event_id The id of the event
	*/
	public string function getEventDomain( required numeric event_id ) {
		return getEventDao().EventDomainGet( event_id=arguments.event_id );
	}
	/**
	* getEventURI
	* This method will get the domain name + the slug of an event
	* @event_id The id of the event
	*/
	public string function getEventURI( required numeric event_id ) {
		return getEventDao().EventURIGet( event_id=arguments.event_id );
	}
	/**
	* I get payment types for an event
	* @event_id The id of the event
	*/
	public struct function getPaymentTypes( required numeric event_id ) {
		var types = getEventDAO().EventPaymentTypesGet( argumentCollection:arguments ).result;
		var data = { 'types': queryToArray( types ), 'count': types.recordCount };

		return data;
	}
	/**
	* I get date time formats
	*/
	public struct function getDateTimeFormats() {
		var formats = getEventDAO().EventDateTimeFormatsGet().result;
		var data = { 'formats': queryToArray( formats ), 'count': formats.recordCount };

		return data;
	}
	/**
	* Copy's an Event
	* @copy_event_id The ID of the event that is being copied
	* @event_name The name of the new Event
	* @slug The slug of the new Event
	*/
	public numeric function copyEvent(
		required numeric copy_event_id,
		required string event_name,
		required string slug) {

		return getEventDAO().EventCopy( argumentCollection=arguments );
	}
	/**
	* I get dashboard stats
	* -- Calculates the costs and credits for an event
	* -- Calculates the costs and credits for an event
	*/
	public struct function getDashboardStats( required numeric event_id ) {
		var data = {
			'cost_breakdown': getEventDAO().EventCostBreakdownGet( arguments.event_id )
			,'attendee_count_breakdown': getEventDAO().EventAttendeeCountBreakdownGet( arguments.event_id )
		};

		return data;
	}

}