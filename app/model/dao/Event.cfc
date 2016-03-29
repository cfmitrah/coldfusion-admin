/**
* I am the DAO for the Event object
* @file  /model/dao/Event.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {
	/*
	* Creates or Updates a Event and Returns the Event ID
	* @event_id The id of the Event
	* @company_id The id of the company the event is for
	* @domain_id The id of the domain
	* @name The name of the event
	* @slug_id The slug id of the Event
	* @processor_id The payment processor for the event
	* @start_date The start date of the event
	* @end_date The end date of the event
	* @publish_on The date and time to publish the event
	* @event_status The status of the event
	* @access_code (optional) an access code to allow access to registration
	* @virtual (optional) Whether or not the event is a virtual event
	* @capacity (optional) an access code to allow access to registration
	*/
	public numeric function EventSet(
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
		string settings="",
		boolean published=false
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, null=( !arguments.event_id ), variable="event_id" );
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addParam( type="in", dbvarname="@domain_id", cfsqltype="cf_sql_integer", value=arguments.domain_id );
		sp.addParam( type="in", dbvarname="@name", cfsqltype="cf_sql_varchar", value=arguments.name, maxlength=510 );
		sp.addParam( type="in", dbvarname="@slug_id", cfsqltype="cf_sql_bigint", value=arguments.slug_id );
		sp.addParam( type="in", dbvarname="@processor_id", cfsqltype="cf_sql_tinyint", value=arguments.processor_id, null=( !arguments.processor_id ) );
		sp.addParam( type="in", dbvarname="@start_date", cfsqltype="cf_sql_date", value=arguments.start_date, null=( !len( arguments.start_date ) ) );
		sp.addParam( type="in", dbvarname="@end_date", cfsqltype="cf_sql_date", value=arguments.end_date, null=( !len( arguments.end_date ) ) );
		sp.addParam( type="in", dbvarname="@publish_on", cfsqltype="cf_sql_timestamp", value=arguments.publish_on, null=( !len( arguments.publish_on ) ) );
		sp.addParam( type="in", dbvarname="@event_status", cfsqltype="cf_sql_varchar", value=arguments.event_status, maxlength=100, null=( !len( arguments.event_status ) ) );
		sp.addParam( type="in", dbvarname="@access_code", cfsqltype="cf_sql_varchar", value=arguments.access_code, maxlength=50, null=( !len( arguments.access_code ) ) );
		sp.addParam( type="in", dbvarname="@virtual", cfsqltype="cf_sql_bit", value=arguments.virtual, null=( !len( arguments.virtual ) ) );
		sp.addParam( type="in", dbvarname="@capacity", cfsqltype="cf_sql_integer", value=arguments.capacity, null=( !arguments.capacity ) );
		sp.addParam( type="in", dbvarname="@sso_id", cfsqltype="cf_sql_integer", value=arguments.sso_id, null=( !arguments.sso_id ) );
		sp.addParam( type="in", dbvarname="@settings", cfsqltype="cf_sql_varchar", value=arguments.settings);
		sp.addParam( type="in", dbvarname="@published", cfsqltype="cf_sql_bit", value=arguments.published);
		result = sp.execute();
		return result.getProcOutVariables().event_id;
	}
	/**
	* I add a user to the event admin group.
	* @event_id The ID of the event that you want to add the user to.
	* @user_id The ID of the user that you want to add to the event admin group.
	*/
	public void function EventAdminAdd( required numeric event_id, required string user_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventAdminAdd"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		result = sp.execute();
		return;
	}
	/**
	* I remove a user from the event admin group.
	* @event_id The ID of the event that you want to remove the user from.
	* @user_id The ID of the user that you want to remove from the event admin group.
	*/
	public void function EventAdminRemove( required numeric event_id, required numeric user_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventAdminRemove"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		result = sp.execute();
		return;
	}
	/**
	* I get all of the event admins for an event
	* @event_id The ID of the event that you want the event admins for.
	*/
	public struct function EventAdminsGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventAdminsGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="event_admins", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I check to see if a slug exists for an event.
	* @company_id The ID of the company that to check to see if the event slug exists for,
	* @slug The slug to check
	*/
	public boolean function EventSlugExists( required numeric company_id, required string slug ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventSlugExists"
		});
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", maxlength=300, value=trim( arguments.slug ) );
		sp.addParam( type="out", dbvarname="@in_use", cfsqltype="cf_sql_bit", variable="exists" );
		result = sp.execute();
		return result.getProcOutVariables().exists;
	}
	/**
	* I add a user to the event staff group.
	* @event_id The ID of the event that you want to add the user to.
	* @user_id The ID of the user that you want to add to the event staff group.
	*/
	public void function EventStaffAdd( required numeric event_id, required numeric user_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventStaffAdd"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		result = sp.execute();
		return;
	}
	/**
	* I get all of the event staff for an event
	* @event_id The ID of the event that you want the event staff for.
	*/
	public struct function EventStaffGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventStaffGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_varchar", value=arguments.event_id );
		sp.addProcResult( name="event_staff", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I remove a user from the event staff group.
	* @event_id The ID of the event that you want to remove the user from.
	* @user_id The ID of the user that you want to remove from the event staff group.
	*/
	public void function EventStaffRemove( required numeric event_id, required numeric user_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventStaffRemove"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		result = sp.execute();
		return;
	}
	/**
	* I get event details.
	* @event_id The ID of the event that you want details.
	* @company_id The ID of the company associated with the event.
	*/
	public struct function getEvent(required numeric event_id, required numeric company_id){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addProcResult( name="event_info", resultset=1 );
		sp.addProcResult( name="event_days", resultset=2 );
		sp.addProcResult( name="event_admins", resultset=3 );
		sp.addProcResult( name="event_staff", resultset=4 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I get event venues
	* @event_id The ID of the event that you want associated venues.
	*/
	public struct function getEventVenues(required numeric event_id){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventVenuesGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_varchar", value=arguments.event_id );
		sp.addProcResult( name="event_venues", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I get event tags
	* @event_id The ID of the event that you want associated tags.
	*/
	public struct function getEventTags(required numeric event_id){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventTagsGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="event_tags", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I set event tags
	* @event_id The ID of the event that you want associated tags.
	* @tags comma-delim list of tags you want associated with the event
	*/
	public void function setEventTags(required numeric event_id, required string tags){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventTagsSet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@tags", cfsqltype="cf_sql_varchar", value=arguments.tags );
		//sp.addProcResult( name="event_tags", resultset=1 );
		result = sp.execute();
	}

	/**
	* I get event statuses	*
	*/
	public struct function EventStatusesGet(){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventStatusesGet"
		});
		sp.addProcResult( name="event_statuses", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I set venues to events
	*/
	public void function EventVenueSet(required numeric event_id, required numeric venue_id){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventVenueAdd"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		result = sp.execute();
		return;
	}
	/**
	* I remove a day from the event.
	* @day_id The ID of the day that you want to remove from the event.
	* @event_id The ID of the event that you want to remove a day from.
	*/
	public void function eventRemoveDay( required numeric event_id, required numeric day_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventDayRemove"
		});
		sp.addParam( type="in", dbvarname="@day_id", cfsqltype="cf_sql_integer", value=arguments.day_id );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		result = sp.execute();
		return;
	}
	/*
	* Gets all of the details for a Event
	* @event_id The Event ID
	* @company_id The Company id
	*/
	public struct function EventDetailsGet( required numeric event_id, required numeric company_id ) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventDetailsGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, variable="event_id" );
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addParam( type="out", dbvarname="@name", cfsqltype="cf_sql_varchar", variable="name" );
		sp.addParam( type="out", dbvarname="@start_date", cfsqltype="cf_sql_varchar", variable="start_date" );
		sp.addParam( type="out", dbvarname="@end_date", cfsqltype="cf_sql_varchar", variable="end_date" );
		sp.addParam( type="out", dbvarname="@publish_on", cfsqltype="cf_sql_timestamp", variable="publish_on" );
		sp.addParam( type="out", dbvarname="@published", cfsqltype="cf_sql_bit", variable="published" );
		sp.addParam( type="out", dbvarname="@event_status", cfsqltype="cf_sql_varchar", variable="event_status" );
		sp.addParam( type="out", dbvarname="@access_code", cfsqltype="cf_sql_varchar", variable="access_code" );
		sp.addParam( type="out", dbvarname="@virtual", cfsqltype="cf_sql_integer", variable="capacity" );
		sp.addParam( type="out", dbvarname="@capacity", cfsqltype="cf_sql_integer", variable="capacity" );
		sp.addParam( type="out", dbvarname="@total_registered", cfsqltype="cf_sql_integer", variable="total_registered" );
		sp.addParam( type="out", dbvarname="@domain_id", cfsqltype="cf_sql_integer", variable="domain_id" );
		sp.addParam( type="out", dbvarname="@domain_name", cfsqltype="cf_sql_varchar", variable="domain_name" );
		sp.addParam( type="out", dbvarname="@slug_id", cfsqltype="cf_sql_int", variable="slug_id" );
		sp.addParam( type="out", dbvarname="@slug", cfsqltype="cf_sql_varchar", variable="slug" );
		sp.addParam( type="out", dbvarname="@processor_id", cfsqltype="cf_sql_int", variable="processor_id" );
		sp.addParam( type="out", dbvarname="@processor_name", cfsqltype="cf_sql_varchar", variable="processor_name" );
		sp.addParam( type="out", dbvarname="@has_logo", cfsqltype="cf_sql_bit", variable="has_logo" );
		sp.addParam( type="out", dbvarname="@logo_media_id", cfsqltype="cf_sql_bigint", variable="logo_media_id" );
		sp.addParam( type="out", dbvarname="@logo_filename", cfsqltype="cf_sql_varchar", variable="logo_filename" );
		sp.addParam( type="out", dbvarname="@logo_thumbnail", cfsqltype="cf_sql_varchar", variable="logo_thumbnail" );
		sp.addParam( type="out", dbvarname="@logo_label", cfsqltype="cf_sql_varchar", variable="logo_label" );
		sp.addParam( type="out", dbvarname="@logo_filesize", cfsqltype="cf_sql_varchar", variable="logo_filesize" );
		sp.addParam( type="out", dbvarname="@logo_uploaded", cfsqltype="cf_sql_timestamp", variable="logo_uploaded" );
		sp.addParam( type="out", dbvarname="@has_hero", cfsqltype="cf_sql_varchar", variable="has_hero" );
		sp.addParam( type="out", dbvarname="@hero_media_id", cfsqltype="cf_sql_bigint", variable="hero_media_id" );
		sp.addParam( type="out", dbvarname="@hero_filename", cfsqltype="cf_sql_varchar", variable="hero_filename" );
		sp.addParam( type="out", dbvarname="@hero_thumbnail", cfsqltype="cf_sql_varchar", variable="hero_thumbnail" );
		sp.addParam( type="out", dbvarname="@hero_label", cfsqltype="cf_sql_varchar", variable="hero_label" );
		sp.addParam( type="out", dbvarname="@hero_filesize", cfsqltype="cf_sql_varchar", variable="hero_filesize" );
		sp.addParam( type="out", dbvarname="@hero_uploaded", cfsqltype="cf_sql_timestamp", variable="hero_uploaded" );
		sp.addParam( type="out", dbvarname="@sso_id", cfsqltype="cf_sql_int", variable="sso_id" );
		sp.addParam( type="out", dbvarname="@settings", cfsqltype="cf_sql_int", variable="settings" );
		sp.addProcResult( name="days", resultset=1 );
		sp.addProcResult( name="admins", resultset=2 );
		sp.addProcResult( name="staff", resultset=3 );
		sp.addProcResult( name="content", resultset=4 );
		sp.addProcResult( name="logs", resultset=5 );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		structAppend( data, result.getProcResultSets() );
		if ( isJson( data.settings ) ) {
			data['settings'] = deserializeJSON( data.settings );
		}
		return data;
	}
	/*
	* Remove a User to a Event Association
	* @event_id The id of the event
	* @venue_id The id of the venue
	*/
	public void function EventVenueRemove(
		required numeric event_id,
		required numeric venue_id
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventVenueRemove"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		result = sp.execute();
		return;
	}
	/*
	* Creates or Updates an Event Day and Returns the Day ID
	* @day_id (optional) The id of the day, NULL means add
	* @event_id The id of the event
	* @start_time The date and time to start the day on
	* @end_time The date and time to end the day on
	*/
	public numeric function EventDaySet(
		numeric day_id=0,
		required numeric event_id,
		required date start_time,
		required date end_time
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventDaySet"
		});
		sp.addParam( type="inout", dbvarname="@day_id", cfsqltype="cf_sql_integer", value=arguments.day_id, null=( !arguments.day_id ), variable="day_id" );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@start_time", cfsqltype="cf_sql_timestamp", value=arguments.start_time );
		sp.addParam( type="in", dbvarname="@end_time", cfsqltype="cf_sql_timestamp", value=arguments.end_time );
		result = sp.execute();
		return result.getProcOutVariables().day_id;
	}
	/*
	* Creates or Updates a Event Photo / Media Item and Returns the Media ID
	* @event_id The Event id
	* @media_id The media id, if null it is added
	*/
	public void function EventHeroSet(
		required numeric event_id,
		required numeric media_id
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventHeroSet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id );
		result = sp.execute();
		return;
	}
	/*
	* Creates or Updates all of the content values
	* @content_id (optional) The id of the Content, NULL means add
	* @event_id The id of the event
	* @key The key used to identify the content in the event
	* @body The Content
	*/
	public void function ContentAllSet(
		required numeric event_id,
		string hero_text="",
		string location="",
		string dates="",
		string overview="",
		string contact_page_overview="",
		string event_contact_email="",
		string event_agenda_help=""
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "ContentAllSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@hero_text", cfsqltype="cf_sql_longvarchar", value=arguments.hero_text, null=( !len( arguments.hero_text ) ) );
		sp.addParam( type="in", dbvarname="@location", cfsqltype="cf_sql_longvarchar", value=arguments.location, null=( !len( arguments.location ) ) );
		sp.addParam( type="in", dbvarname="@dates", cfsqltype="cf_sql_longvarchar", value=arguments.dates, null=( !len( arguments.dates ) ) );
		sp.addParam( type="in", dbvarname="@overview", cfsqltype="cf_sql_longvarchar", value=arguments.overview, null=( !len( arguments.overview ) ) );
		sp.addParam( type="in", dbvarname="@contact_page_overview", cfsqltype="cf_sql_longvarchar", value=arguments.contact_page_overview, null=( !len( arguments.contact_page_overview ) ) );
		sp.addParam( type="in", dbvarname="@event_contact_email", cfsqltype="cf_sql_longvarchar", value=arguments.event_contact_email, null=( !len( arguments.event_contact_email ) ) );
		sp.addParam( type="in", dbvarname="@event_agenda_help", cfsqltype="cf_sql_longvarchar", value=arguments.event_agenda_help, null=( !len( arguments.event_agenda_help ) ) );
		sp.addParam( type="in", dbvarname="@registration_closed_message", cfsqltype="cf_sql_longvarchar", value=arguments.registration_closed_message, null=( !len( arguments.registration_closed_message ) ) );

		result = sp.execute();
		return;
	}
	/*
	* Gets the name of an event
	* @event_id The Event ID
	*/
	public string function EventNameGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventNameGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="out", dbvarname="@name", cfsqltype="cf_sql_varchar", variable="name" );
		result = sp.execute();
		return result.getProcOutVariables().name;
	}
	/*
	* Creates or Updates a Event Photo / Media Item and Returns the Media ID
	* @event_id The Event id
	* @media_id The media id, if null it is added
	*/
	public void function EventLogoSet(
		required numeric event_id,
		required numeric media_id
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventLogoSet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id );
		result = sp.execute();
		return;
	}
	/*
	* Gets all of the Categorys associated to a Event
	* @event_id The event id
	*/
	public struct function EventCategoriesGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventCategoriesGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="categories", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().categories
		};
	}
	/*
	* Gets the Events By the Domain and Slug
	* @event_domains Comma delimited list of domains (without periods)
	* @event_slugs Comma-delimited list of event slugs
	*/
	public struct function EventsByDomainCacheGet(
		required string event_domains,
		required string event_slugs
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventsByDomainCacheGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_domains", cfsqltype="cf_sql_longvarchar", value=arguments.event_domains );
		sp.addParam( type="in", dbvarname="@event_slugs", cfsqltype="cf_sql_longvarchar", value=arguments.event_slugs );
		sp.addProcResult( name="events", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().events
		};
	}
	/*
	* Gets the Event Domain
	* @event_id The Event ID
	*/
	public string function EventDomainGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventDomainGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="out", dbvarname="@domain_name", cfsqltype="cf_sql_varchar", variable="domain_name" );
		result = sp.execute();
		return result.getProcOutVariables().domain_name;
	}
	/*
	* Gets the Event Domain + Slug for the event
	* @event_id The Event ID
	*/
	public string function EventURIGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventURIGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="out", dbvarname="@uri", cfsqltype="cf_sql_varchar", variable="uri" );
		result = sp.execute();
		return result.getProcOutVariables().uri;
	}

	/**
	* I get the datetime formats.
	*/
	public struct function EventDateTimeFormatsGet() {
		// Declare local variables
			var sp = new StoredProc();
			var result = {};
			var data = {};
		// Trim all of the inputs
			trim_fields( arguments );
		// Build and execute the stored procedure to get the datetime formats
			sp.setAttributes({
				'datasource': getDSN(),
				'procedure': "DateTimeFormatsGet"
			});
			sp.addProcResult( name="PaymentTypes", resultset=1 );
			result = sp.execute();
		// Return results
			return {
				'prefix' = result.getPrefix(),
				'result' = result.getProcResultSets().PaymentTypes
			};
	}

	/**
	* I get the payment typs avaialable for an event
	* @event_id the id of the event that you want payment types for
	*/
	public struct function EventPaymentTypesGet(
		required numeric event_id
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventPaymentTypesGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="PaymentTypes", resultset=1 );

		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().PaymentTypes
		};
	}
	/*
	* Gets the processor of an event
	* @event_id The Event ID
	*/
	public struct function EventProcessorGet(
		required numeric event_id
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventProcessorGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="out", dbvarname="@processor_id", cfsqltype="cf_sql_integer", variable="processor_id" );
		sp.addParam( type="out", dbvarname="@processor_name", cfsqltype="cf_sql_varchar", variable="processor_name" );

		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );

		return data;
	}
	/*
	* Gets the event hero graphic
	* @event_id The Event id
	*/
	public struct function EventHeroGet( required numeric event_id	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventHeroGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, variable="event_id" );
		sp.addParam( type="out", dbvarname="@hero_filename", cfsqltype="cf_sql_varchar", variable="hero_filename" );
		sp.addParam( type="out", dbvarname="@hero_thumbnail", cfsqltype="cf_sql_varchar", variable="hero_thumbnail" );
		sp.addParam( type="out", dbvarname="@hero_filesize", cfsqltype="cf_sql_varchar", variable="hero_filesize" );
		sp.addParam( type="out", dbvarname="@hero_uploaded", cfsqltype="cf_sql_timestamp", variable="hero_uploaded" );
		sp.addParam( type="out", dbvarname="@hero_media_id", cfsqltype="cf_sql_integer", variable="hero_media_id" );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
	/*
	* Copies the contents of an old event to a new event and returns the new event_id
	* @copy_event_id The id of the existing event to copy
	* @event_name The name of the new event
	* @identifier The slug identifier for the new event
	* @event_id (output) The id of the new event
	*/
	public numeric function EventCopy(
		required numeric copy_event_id,
		required string event_name,
		required string slug
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventCopy"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@copy_event_id", cfsqltype="cf_sql_integer", value=arguments.copy_event_id );
		sp.addParam( type="in", dbvarname="@event_name", cfsqltype="cf_sql_varchar", value=arguments.event_name, maxlength=255 );
		sp.addParam( type="in", dbvarname="@identifier", cfsqltype="cf_sql_varchar", value=arguments.slug, maxlength=300 );
		sp.addParam( type="out", dbvarname="@event_id", cfsqltype="cf_sql_integer", variable="event_id" );

		result = sp.execute();
		return result.getProcOutVariables().event_id;
	}
	/*
	* Gets an company payment processor
	* @event_id The id of the event
	*/
	public struct function EventCompanyPaymentProcessorGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventCompanyPaymentProcessorGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="out", dbvarname="@company_processor_id", cfsqltype="cf_sql_integer", variable="company_processor_id" );
		sp.addParam( type="out", dbvarname="@company_id", cfsqltype="cf_sql_integer", variable="company_id" );
		sp.addParam( type="out", dbvarname="@label", cfsqltype="cf_sql_varchar", variable="label" );
		sp.addParam( type="out", dbvarname="@config", cfsqltype="cf_sql_longvarchar", variable="config" );
		sp.addParam( type="out", dbvarname="@processor_id", cfsqltype="cf_sql_tinyint", variable="processor_id" );
		sp.addParam( type="out", dbvarname="@processor_name", cfsqltype="cf_sql_varchar", variable="processor_name" );
		sp.addParam( type="out", dbvarname="@api_url", cfsqltype="cf_sql_varchar", variable="api_url" );
		sp.addParam( type="out", dbvarname="@docs_url", cfsqltype="cf_sql_varchar", variable="docs_url" );

		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
	/*
	* Calculates the costs and credits for an event
	* @event_id INT The id for the event
	* @total_invites_sent The total number of invites sent for the event
	* @total_invites_viewed The total number of invitations viewed for the event
	* @total_invites_accepted The total number of invites accepted for the event
	* @total_invites_declined The total number of invites declined for the event
	* @total_invites_noresponse The total number of no responses for invites for the event
	* @total_event_registered The total number of attendees registered for the event
	* @total_event_cancelled The total number of attendees cancelled for the event
	*/
	public struct function EventAttendeeCountBreakdownGet( required numeric event_id=0 ) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventAttendeeCountBreakdownGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, null=( !arguments.event_id ) );
		sp.addParam( type="out", dbvarname="@total_invites_imported", cfsqltype="cf_sql_integer", variable="total_invites_imported" );
		sp.addParam( type="out", dbvarname="@total_invites_sent", cfsqltype="cf_sql_integer", variable="total_invites_sent" );
		sp.addParam( type="out", dbvarname="@total_invites_viewed", cfsqltype="cf_sql_integer", variable="total_invites_viewed" );
		sp.addParam( type="out", dbvarname="@total_invites_accepted", cfsqltype="cf_sql_integer", variable="total_invites_accepted" );
		sp.addParam( type="out", dbvarname="@total_invites_declined", cfsqltype="cf_sql_integer", variable="total_invites_declined" );
		sp.addParam( type="out", dbvarname="@total_invites_noresponse", cfsqltype="cf_sql_integer", variable="total_invites_noresponse" );
		sp.addParam( type="out", dbvarname="@total_event_registered", cfsqltype="cf_sql_integer", variable="total_event_registered" );
		sp.addParam( type="out", dbvarname="@total_event_cancelled", cfsqltype="cf_sql_integer", variable="total_event_cancelled" );

		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
	/*
	* Calculates the costs and credits for an event
	* @event_id INT The id for the event
	* @total_cost The sum of all Fees, Cancels and Discounts/Coupons
	* @total_credits The sum of all Payments, Refunds and Voids
	* @total_due The total amount outstanding
	* @total_payments The total of payments collected
	* @total_refunds The total of refunds given
	* @total_voids The total of voids done
	* @total_fees The sum of all Fees and Cancels
	* @total_discounts The sum of all Discounts and Coupons
	* @total_agenda_fees The sum of all Agenda Fees and Cancels
	* @total_event_fees The sum of all Event Fees and Cancels
	*/
	public struct function EventCostBreakdownGet( required numeric event_id=0 ) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventCostBreakdownGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, null=( !arguments.event_id ) );
		sp.addParam( type="out", dbvarname="@total_cost", cfsqltype="cf_sql_money", variable="total_cost" );
		sp.addParam( type="out", dbvarname="@total_credits", cfsqltype="cf_sql_money", variable="total_credits" );
		sp.addParam( type="out", dbvarname="@total_due", cfsqltype="cf_sql_money", variable="total_due" );
		sp.addParam( type="out", dbvarname="@total_payments", cfsqltype="cf_sql_money", variable="total_payments" );
		sp.addParam( type="out", dbvarname="@total_refunds", cfsqltype="cf_sql_money", variable="total_refunds" );
		sp.addParam( type="out", dbvarname="@total_voids", cfsqltype="cf_sql_money", variable="total_voids" );
		sp.addParam( type="out", dbvarname="@total_fees", cfsqltype="cf_sql_money", variable="total_fees" );
		sp.addParam( type="out", dbvarname="@total_discounts", cfsqltype="cf_sql_money", variable="total_discounts" );
		sp.addParam( type="out", dbvarname="@total_agenda_fees", cfsqltype="cf_sql_money", variable="total_agenda_fees" );
		sp.addParam( type="out", dbvarname="@total_event_fees", cfsqltype="cf_sql_money", variable="total_event_fees" );

		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
}