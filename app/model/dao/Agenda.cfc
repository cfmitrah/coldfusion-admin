/**
*
* @file  /model/dao/Agenda.cfc
* @author - JG
* @description
*
*/

component accessors="true" extends="app.model.base.Dao" {
	/*
    * I get the agenda by registration type
    * @event_id
    * @registration_type_id
    */
    public struct function AgendasByRegistrationTypeGet( required string event_id, required string registration_type_id ) {
        var sp = new StoredProc();
        var result = {}; 
        var data = {}; 
        sp.setAttributes({
            'datasource': getDSN(),
            'procedure': "AgendasByRegistrationTypeGet"
        });
        
        sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
        sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );
        sp.addProcResult( name="agenda", resultset=1 );

        result = sp.execute();
        data['prefix'] = result.getPrefix();
        data['result'] = result.getProcResultSets().agenda;
        return data;
    }
	/*
	* Gets all of the agendas for an event without paging / filtering / sorting
	* @event_id The id of the event
	*/
	public struct function AgendasGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendasGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="agendas", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Gets all of the agendas for an event with paging / filtering / sorting / searching
	* @event_id The event id
	* @start The row to start on
	* @results The number of results to return
	* @sort_column The column to sort by
	* @sort_direction The direction to sort
	* @search a Keyword to filter the results on
	*/
	public struct function AgendasList(
		required numeric event_id,
		numeric start=1,
		numeric results=10,
		string sort_column="title",
		string sort_direction="ASC",
		string search=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendasList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", value=arguments.sort_column, maxlength=50, null=( !len( arguments.sort_column ) ) );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", value=arguments.sort_direction, maxlength=4, null=( !len( arguments.sort_direction ) ) );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", value=arguments.search, maxlength=200, null=( !len( arguments.search ) ) );
		sp.addProcResult( name="agenda", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* AgendaSet
	* This will save an agenda item
	* @agenda_id The agenda id
	* @event_id The event id of the agenda
	* @session_id The session id of the agenda
	* @start_time The start time of the agenda
	* @end_time The end time of the agenda
	* @visible (optional) Make the item visible or not
	* @location_id (optional) The location of the agenda item
	*/
	public numeric function AgendaSet(
		numeric agenda_id=0,
		required numeric event_id,
		required string session_id,
		required string start_time,
		required string end_time,
		boolean included=0,
		boolean visible=1,
		numeric location_id=0,
		string label="",
		string note="",
		numeric attendance_limit=0,
		numeric waitlist=0
		numeric sort=0
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "AgendaSet"
		});
		trim_fields( arguments );
		sp.addParam( type="inout", dbvarname="@agenda_id", cfsqltype="cf_sql_integer", value=arguments.agenda_id, null=( !arguments.agenda_id ), variable="agenda_id" );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@session_id", cfsqltype="cf_sql_integer", value=arguments.session_id );
		sp.addParam( type="in", dbvarname="@start_time", cfsqltype="cf_sql_timestamp", value=createODBCDateTime( arguments.start_time ) );
		sp.addParam( type="in", dbvarname="@end_time", cfsqltype="cf_sql_timestamp", value=createODBCDateTime( arguments.end_time ) );
		sp.addParam( type="in", dbvarname="@included", cfsqltype="cf_sql_bit", value=arguments.included );
		sp.addParam( type="in", dbvarname="@visible", cfsqltype="cf_sql_bit", value=arguments.visible );
		sp.addParam( type="in", dbvarname="@location_id", cfsqltype="cf_sql_integer", value=int( arguments.location_id ), null=( !arguments.location_id ) );
		sp.addParam( type="in", dbvarname="@label", cfsqltype="cf_sql_varchar", maxlength=150, value=arguments.label, null=( !len(arguments.label) ) );
		sp.addParam( type="in", dbvarname="@note", cfsqltype="cf_sql_varchar", maxlength=500, value=arguments.note, null=( !len(arguments.note) ) );
		sp.addParam( type="in", dbvarname="@attendance_limit", cfsqltype="cf_sql_integer", value=int( arguments.attendance_limit ), null=( !arguments.attendance_limit ) );
		sp.addParam( type="in", dbvarname="@waitlist", cfsqltype="cf_sql_integer", value=int( arguments.waitlist ), null=( !arguments.waitlist ) );
		sp.addParam( type="in", dbvarname="@sort", cfsqltype="cf_sql_integer", value=int( arguments.sort ), null=( !arguments.sort ) );
		result = sp.execute();
		return result.getProcOutVariables().agenda_id;
	}
	/*
	* AgendaRemove
	* This will remove an agenda item
	* @event_id The event id
	* @agenda_id The agenda id
	*/
	public void function AgendaRemove( required numeric event_id, required numeric agenda_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "AgendaRemove"
		});
		sp.addParam( type="in", dbvarname="@agenda_id", cfsqltype="cf_sql_integer", value=arguments.agenda_id );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.execute();
		return;
	}
	/*
	* Gets an agenda item
	* @agenda_id The agenda_id
	*/
	public struct function AgendaGet(
		required numeric agenda_id
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendaGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@agenda_id", cfsqltype="cf_sql_integer", value=arguments.agenda_id, variable="agenda_id" );
		sp.addParam( type="out", dbvarname="@event_id", cfsqltype="cf_sql_integer", variable="event_id" );
		sp.addParam( type="out", dbvarname="@session_id", cfsqltype="cf_sql_integer", variable="session_id" );
		sp.addParam( type="out", dbvarname="@start_time", cfsqltype="cf_sql_timestamp", variable="start_time" );
		sp.addParam( type="out", dbvarname="@end_time", cfsqltype="cf_sql_timestamp", variable="end_time" );
		sp.addParam( type="out", dbvarname="@included", cfsqltype="cf_sql_bit", variable="included" );
		sp.addParam( type="out", dbvarname="@visible", cfsqltype="cf_sql_bit", variable="visible" );
		sp.addParam( type="out", dbvarname="@label", cfsqltype="cf_sql_varchar", variable="label" );
		sp.addParam( type="out", dbvarname="@note", cfsqltype="cf_sql_varchar", variable="note" );
		sp.addParam( type="out", dbvarname="@attendance_limit", cfsqltype="cf_sql_smallint", variable="attendance_limit" );
		sp.addParam( type="out", dbvarname="@waitlist", cfsqltype="cf_sql_bit", variable="waitlist" );
		sp.addParam( type="out", dbvarname="@open_seats", cfsqltype="cf_sql_smallint", variable="open_seats" );
		sp.addParam( type="out", dbvarname="@location_id", cfsqltype="cf_sql_integer", variable="location_id" );
		sp.addParam( type="out", dbvarname="@location_name", cfsqltype="cf_sql_varchar", variable="location_name" );
		sp.addParam( type="out", dbvarname="@venue_id", cfsqltype="cf_sql_integer", variable="venue_id" );
		sp.addParam( type="out", dbvarname="@venue_name", cfsqltype="cf_sql_varchar",variable="venue_name" );
		sp.addParam( type="out", dbvarname="@sort", cfsqltype="cf_sql_integer",variable="sort" );
		sp.addProcResult( name="dependencies", resultset=1 );
		sp.addProcResult( name="pricing", resultset=2 );
		sp.addProcResult( name="restrictions", resultset=3 );
		sp.addProcResult( name="waitList", resultset=4 );
		sp.addProcResult( name="agenda_log", resultset=5 );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		structAppend( data, result.getProcResultSets() );
		return data;
	}
	/*
	* Gets the waiting list for an agenda item
	* @agenda_id The id of the agenda item
	* @assigned Whether or not to pull back assigned / unassigned waitlist entries
	*/
	public struct function AgendaItemWaitListGet(
		required numeric agenda_id,
		boolean assigned=0
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendaItemWaitListGet"
		});
		sp.addParam( type="in", dbvarname="@agenda_id", cfsqltype="cf_sql_integer", value=arguments.agenda_id );
		sp.addParam( type="in", dbvarname="@assigned", cfsqltype="cf_sql_bit", value=arguments.assigned, null=( !len( arguments.assigned ) ) );
		sp.addProcResult( name="result", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result
		};
	}
    /*
    * Creates Agenda Prices for Multiple Registration types
    * @agenda_id The agenda_id
    * @registration_type_ids A comma delimited list of registration type ids
    * @price The cost of the agenda item for a given registration type
    * @valid_from (optional) A date and time the price is valid from
    * @valid_to (optional) A date and time the price is valid to
    */
    public void function AgendaPricesSet(
        required numeric agenda_id,
        required string registration_type_ids,
        required numeric price,
        string valid_from="",
        string valid_to="",
        required string label
    ) {
        var sp = new StoredProc();
        var result = {}; 
        sp.setAttributes({
            'datasource': getDSN(),
            'procedure': "AgendaPricesSet"
        });
        trim_fields( arguments );  // trim all of the inputs
        sp.addParam( type="in", dbvarname="@agenda_id", cfsqltype="cf_sql_integer", value=arguments.agenda_id );
        sp.addParam( type="in", dbvarname="@registration_type_ids", cfsqltype="cf_sql_varchar", value=arguments.registration_type_ids, maxlength=500 );
        sp.addParam( type="in", dbvarname="@price", cfsqltype="cf_sql_money", value=arguments.price );
        sp.addParam( type="in", dbvarname="@valid_from", cfsqltype="cf_sql_timestamp", value=arguments.valid_from, null=( !isDate( arguments.valid_from ) ) );
        sp.addParam( type="in", dbvarname="@valid_to", cfsqltype="cf_sql_timestamp", value=arguments.valid_to, null=( !isDate( arguments.valid_to ) ) );
        sp.addParam( type="in", dbvarname="@label", cfsqltype="cf_sql_varchar", value=arguments.label, maxlength=150, null=( !len( arguments.label ) ) );
        result = sp.execute();
        return;
    }
	/*
	* Sets the capacity settings for an agenda item
	* @agenda_id (optional) The agenda ID, if NULL it means to add
	* @attendance_limit (optional) The maximum number of allowed attendees
	* @waitlist (optional) Whether or not the wait list should be enabled
	*/
	public numeric function AgendaCapacitySet(
		required numeric agenda_id=0,
		numeric attendance_limit=0,
		boolean waitlist=0
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendaCapacitySet"
		});
		sp.addParam( type="inout", dbvarname="@agenda_id", cfsqltype="cf_sql_integer", value=arguments.agenda_id, null=( !arguments.agenda_id ), variable="agenda_id" );
		sp.addParam( type="in", dbvarname="@attendance_limit", cfsqltype="cf_sql_smallint", value=arguments.attendance_limit, null=( !arguments.attendance_limit ) );
		sp.addParam( type="in", dbvarname="@waitlist", cfsqltype="cf_sql_bit", value=arguments.waitlist, null=( !len( arguments.waitlist ) ) );
		result = sp.execute();
		return result.getProcOutVariables().agenda_id;
	}
	/**
	* AgendaRestrictionSet
	* This will save an agenda restriction
	* @agenda_id The agenda id of the event
	* @registration_type_id The registration types ids?
	*/
	public void function AgendaRestrictionSet(
		required numeric agenda_id,
		required string registration_type_id
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "AgendaRestrictionAdd"
		});
		trim_fields( arguments );
		sp.addParam( type="in", dbvarname="@agenda_id", cfsqltype="cf_sql_integer", value=arguments.agenda_id );
		sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );
		result = sp.execute();
		return;
	}
	/*
	* Removes a Restricted Registration Type from a Agenda
	* @agenda_price_id The id of the Agenda Price
	* @agenda_id The id of the Agenda
	*/
	public void function AgendaPriceRemove(
		required numeric agenda_price_id,
		required numeric agenda_id
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendaPriceRemove"
		});
		sp.addParam( type="in", dbvarname="@agenda_price_id", cfsqltype="cf_sql_integer", value=arguments.agenda_price_id );
		sp.addParam( type="in", dbvarname="@agenda_id", cfsqltype="cf_sql_integer", value=arguments.agenda_id );
		result = sp.execute();
		return;
	}
	/*
	* Gets all of the registration types for an event, and determines if they are restricted or not
	* @event_id The id of the event
	*/
	public struct function AgendaRegistrationTypesGet( required numeric event_id, numeric agenda_id=0 ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendaRegistrationTypesGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@agenda_id", cfsqltype="cf_sql_integer", value=int(arguments.agenda_id), null=( !arguments.agenda_id ) );
		sp.addProcResult( name="result", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result
		};
	}
	/*
	* Adds Multiple restrictions to an agenda item
	* @agenda_id The agenda id
	* @registration_type_ids Comma-delimited list of registration_type_ids
	*/
	public void function AgendaRestrictionsAdd(
		required numeric agenda_id,
		required string registration_type_ids
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendaRestrictionsAdd"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@agenda_id", cfsqltype="cf_sql_integer", value=arguments.agenda_id );
		sp.addParam( type="in", dbvarname="@registration_type_ids", cfsqltype="cf_sql_varchar", value=arguments.registration_type_ids, maxlength=500 );
		result = sp.execute();
		return;
	}
	/*
	* Gets the current max section sort value
	* @event_id The event id
	*/
	public numeric function AgendaMaxSortGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendaMaxSortGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="out", dbvarname="@sort", cfsqltype="cf_sql_smallint", variable="sort" );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return val( data.sort );
	}
	/*
	* Gets count of the registrations for an agenda
	* @agenda_id The agenda id
	* @registration_type_id the Reg Type ID
	*/
	public struct function AgendaRegistrationsCountByType(
		required numeric event_id,
		required numeric registration_type_id
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendaRegistrationsCountByType"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );
		sp.addProcResult( name="Counts", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().Counts
		};
	}
	/*
	* Checks a list of agenda_ids against a single agenda id to see if there is a conflict
	* @agenda_id The single agenda id to check against
	* @agenda_ids A comma-delimited list of agenda ids to see if a agenda id conflicts with
	*/
	public boolean function AgendaConflictCheck( required numeric agenda_id, required string agenda_ids ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendaConflictCheck"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@agenda_id", cfsqltype="cf_sql_integer", value=arguments.agenda_id );
		sp.addParam( type="in", dbvarname="@agenda_ids", cfsqltype="cf_sql_varchar", value=arguments.agenda_ids, maxlength=500 );
		sp.addParam( type="out", dbvarname="@conflict", cfsqltype="cf_sql_bit", variable="conflict" );
		result = sp.execute();

		return result.getProcOutVariables().conflict;
	}
}