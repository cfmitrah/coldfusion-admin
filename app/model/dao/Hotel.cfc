/**
* I am the DAO for the Hotel object
* @file  /model/dao/Hotel.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/**
	* I check to see if an hotel slug exists
	* @hotel_id The ID of the hotel that you are checking the slug for
	* @slug The slug that you are checking
	*/
	public boolean function hotelSlugExists( required numeric hotel_id, required string slug ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "HotelSlugExists"
		});
		sp.addParam( type="in", dbvarname="@hotel_id", cfsqltype="cf_sql_integer", value=arguments.hotel_id );
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", maxlength=300, value=trim( arguments.slug ) );
		sp.addParam( type="out", dbvarname="@in_use", cfsqltype="cf_sql_bit", variable="exists" );
		result = sp.execute();
		return result.getProcOutVariables().exists;
	}

	/*
	* Gets all of the hotels associated with a company
	* @company_id The company id
	*/
	public struct function CompanyHotelsGet( required numeric company_id ){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "CompanyHotelsList"
		});
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addProcResult( name="hotels", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().hotels
		};
	}
	/*
	* Remove a User to a Event Association
	* @event_id The id of the event
	* @hotel_id The id of the hotel
	*/
	public void function EventHotelRemove(
		required numeric event_id,
		required numeric hotel_id
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventHotelRemove"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@hotel_id", cfsqltype="cf_sql_integer", value=arguments.hotel_id );
		result = sp.execute();
		return;
	}
	/*
	* Assign room allocation to an event hotel
	* @hotel_room_id The id of the event hotel room to update.  
	*	If NULL and no record exists for the Event/Hotel/Date/Room Type, then a new record will be created
	* @event_id The id of the event
	* @hotel_id The id of the hotel
	* @block_date The date to block rooms for
	* @room_type_id The id for the type of room to block
	* @rooms_allocated The number of rooms allocated at the hotel for this room type and date
	*/
	public numeric function EventHotelRoomSet(
		required numeric hotel_room_id=0,
		required numeric event_id,
		required numeric hotel_id,
		required date block_date,
		required numeric room_type_id,
		numeric rooms_allocated=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventHotelRoomSet"
		});
		sp.addParam( type="inout", dbvarname="@hotel_room_id", cfsqltype="cf_sql_integer", value=arguments.hotel_room_id, null=( !arguments.hotel_room_id ), variable="hotel_room_id" );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@hotel_id", cfsqltype="cf_sql_integer", value=arguments.hotel_id );
		sp.addParam( type="in", dbvarname="@block_date", cfsqltype="cf_sql_date", value=arguments.block_date );
		sp.addParam( type="in", dbvarname="@room_type_id", cfsqltype="cf_sql_integer", value=arguments.room_type_id );
		sp.addParam( type="in", dbvarname="@rooms_allocated", cfsqltype="cf_sql_smallint", value=arguments.rooms_allocated, null=( !arguments.rooms_allocated ) );

		result = sp.execute();
		return result.getProcOutVariables().hotel_room_id;
	}
	/*
	* Gets all of the event hotel rooms for an event
	* @event_id The event id
	* @hotel_id (optional) The hotel id to filter on
	*/
	public struct function EventHotelRoomsGet(
		required numeric event_id,
		required numeric hotel_id
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventHotelRoomsGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@hotel_id", cfsqltype="cf_sql_integer", value=arguments.hotel_id, null=( !arguments.hotel_id ) );
		sp.addProcResult( name="result", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result
		};
	}
	/*
	* Associates a Staff User to a Event
	* @event_id The id of the event
	* @hotel_id The id of the hotel
	* @sort The order in which to sort the event hotel
	* @description A description about the event hotel that is specific to the event
	* @url A special URL for linking or booking
	* @promo_code A promo_code for registrants to use when booking the hotel
	* @rooms_allocated The number of rooms allocated at the hotel
	*/
	public struct function EventHotelSet(
		required numeric event_id,
		numeric hotel_id=0,
		numeric sort=0,
		string description="",
		string url="",
		string promo_code=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventHotelSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@hotel_id", cfsqltype="cf_sql_integer", value=arguments.hotel_id );
		sp.addParam( type="in", dbvarname="@sort", cfsqltype="cf_sql_integer", value=arguments.sort, null=( !arguments.sort ) );
		sp.addParam( type="in", dbvarname="@description", cfsqltype="cf_sql_varchar", value=arguments.description, maxlength=1000, null=( !len( arguments.description ) ) );
		sp.addParam( type="in", dbvarname="@url", cfsqltype="cf_sql_varchar", value=arguments.url, maxlength=300, null=( !len( arguments.url ) ) );
		sp.addParam( type="in", dbvarname="@promo_code", cfsqltype="cf_sql_varchar", value=arguments.promo_code, maxlength=50, null=( !len( arguments.promo_code ) ) );

		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Gets all of the event h for a given event
	* @event_id The event id
	*/
	public struct function EventHotelsGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventHotelsGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="result", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result
		};
	}
	/*
	* Gets the current max hotel sort value for an event
	* @event_id The id of the Event
	*/
	public struct function EventHotelsMaxSortGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventHotelsMaxSortGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="out", dbvarname="@sort", cfsqltype="cf_sql_tinyint", variable="sort" );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
	/*
	* Returns the hotels by company
	* @company_id The id of the company to return for.  NULL returns for all companies
	* @return_null_company Returns all hotels with NULL companies
	*/
	public struct function HotelsByCompanyGet( required numeric company_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "HotelsByCompanyGet"
		});
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id, null=( !arguments.company_id ) );
		sp.addProcResult( name="result", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result
		};
	}
		/*
	* Creates or Updates a Hotel and Returns the Hotel ID
	* @hotel_id The id of the Hotel
	* @name The name of the hotel
	* @slug_id The slug id of the hotel
	* @url (optional) The url to the website of the hotel
	* @hotel_brand_id (optional) The brand of the hotel
	* @address_id (optional) The address id of the hotel
	* @rooms (optional) The number of rooms in the hotel
	* @company_id (optional) A company to associate the Venue too
	*/
	public struct function HotelSet(
		numeric hotel_id=0,
		required string name,
		required numeric slug_id,
		string url="",
		numeric hotel_brand_id=0,
		numeric address_id=0,
		numeric rooms=0,
		required numeric company_id,
		string address_type="Default",
		required string address_1,
		string address_2="",
		required string city,
		required string region_code,
		required string postal_code,
		required string country_code,
		numeric latitude=0,
		numeric longitude=0,
		boolean verified=0,
		numeric phone_id=0,
		string phone_type="Default",
		required string phone_number,
		string extension=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "HotelSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@hotel_id", cfsqltype="cf_sql_integer", value=arguments.hotel_id, null=( !arguments.hotel_id ), variable="hotel_id" );
		sp.addParam( type="in", dbvarname="@name", cfsqltype="cf_sql_varchar", value=arguments.name, maxlength=200 );
		sp.addParam( type="in", dbvarname="@slug_id", cfsqltype="cf_sql_bigint", value=arguments.slug_id );
		sp.addParam( type="in", dbvarname="@url", cfsqltype="cf_sql_varchar", value=arguments.url, maxlength=300, null=( !len( arguments.url ) ) );
		sp.addParam( type="in", dbvarname="@hotel_brand_id", cfsqltype="cf_sql_integer", value=arguments.hotel_brand_id, null=( !arguments.hotel_brand_id ) );
		sp.addParam( type="inout", dbvarname="@address_id", cfsqltype="cf_sql_bigint", value=arguments.address_id, null=( !arguments.address_id ), variable="address_id" );
		sp.addParam( type="in", dbvarname="@rooms", cfsqltype="cf_sql_integer", value=arguments.rooms, null=( !arguments.rooms ) );
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id, null=( !arguments.company_id ) );
		sp.addParam( type="in", dbvarname="@address_type", cfsqltype="cf_sql_varchar", value=arguments.address_type, maxlength=50, null=( !len( arguments.address_type ) ) );
		sp.addParam( type="in", dbvarname="@address_1", cfsqltype="cf_sql_varchar", value=arguments.address_1, maxlength=200 );
		sp.addParam( type="in", dbvarname="@address_2", cfsqltype="cf_sql_varchar", value=arguments.address_2, maxlength=200, null=( !len( arguments.address_2 ) ) );
		sp.addParam( type="in", dbvarname="@city", cfsqltype="cf_sql_varchar", value=arguments.city, maxlength=150 );
		sp.addParam( type="in", dbvarname="@region_code", cfsqltype="cf_sql_varchar", value=arguments.region_code, maxlength=6 );
		sp.addParam( type="in", dbvarname="@postal_code", cfsqltype="cf_sql_varchar", value=arguments.postal_code, maxlength=15 );
		sp.addParam( type="in", dbvarname="@country_code", cfsqltype="cf_sql_char", value=arguments.country_code, maxlength=2 );
		sp.addParam( type="in", dbvarname="@latitude", cfsqltype="cf_sql_real", value=arguments.latitude, null=( !arguments.latitude ) );
		sp.addParam( type="in", dbvarname="@longitude", cfsqltype="cf_sql_real", value=arguments.longitude, null=( !arguments.longitude ) );
		sp.addParam( type="in", dbvarname="@verified", cfsqltype="cf_sql_bit", value=arguments.verified, null=( !len( arguments.verified ) ) );
		sp.addParam( type="inout", dbvarname="@phone_id", cfsqltype="cf_sql_bigint", value=arguments.phone_id, null=( !arguments.phone_id ), variable="phone_id" );
		sp.addParam( type="in", dbvarname="@phone_type", cfsqltype="cf_sql_varchar", value=arguments.phone_type, maxlength=50, null=( !len( arguments.phone_type ) ) );
		sp.addParam( type="in", dbvarname="@phone_number", cfsqltype="cf_sql_varchar", value=arguments.phone_number, maxlength=15 );
		sp.addParam( type="in", dbvarname="@extension", cfsqltype="cf_sql_varchar", value=arguments.extension, maxlength=10, null=( !len( arguments.extension ) ) );

		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
	/*
	* Returns the hotel room types by company
	* @company_id The id of the company to return for
	*/
	public struct function HotelRoomTypesByCompanyGet( required numeric company_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "HotelRoomTypesByCompanyGet"
		});
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addProcResult( name="result", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result
		};
	}
	/*
	* Gets all of the event hotel rooms for an event and the number of rooms booked
	* @event_id The event id
	* @hotel_id (optional) The hotel id to filter on
	*/
	public struct function EventHotelRoomsBookedGet(
		required numeric event_id,
		numeric hotel_id=0
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventHotelRoomsBookedGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@hotel_id", cfsqltype="cf_sql_integer", value=arguments.hotel_id, null=( !arguments.hotel_id ) );
		sp.addProcResult( name="result", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result
		};
	}
	/*
	* Gets all of the Hotel Information
	* @hotel_id The id of the hotel
	*/
	public struct function HotelGet( required numeric hotel_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "HotelGet"
		});
		sp.addParam( type="in", dbvarname="@hotel_id", cfsqltype="cf_sql_integer", value=arguments.hotel_id );
		sp.addProcResult( name="details", resultset=1 );
		sp.addProcResult( name="phone_numbers", resultset=2 );
		sp.addProcResult( name="photos", resultset=3 );
		sp.addProcResult( name="logs", resultset=4 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Returns the hotel room types and checkin/out date range by event
	* @event_id The id of the company to return for
	* @hotel_id (optional) The hotel id
	*/
	public struct function HotelRoomTypesByEventGet(
		required numeric event_id,
		required numeric hotel_id
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "HotelRoomTypesByEventGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@hotel_id", cfsqltype="cf_sql_integer", value=arguments.hotel_id, null=( !arguments.hotel_id ) );
		sp.addProcResult( name="result", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result
		};
	}
	/*
	* Get the filters for the RegistrationAttendeesHotelReport
	* @event_id The id of the event to filter for
	*/
	public struct function RegistrationAttendeesHotelFiltersGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationAttendeesHotelFiltersGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="hotels", resultset=1 );
		sp.addProcResult( name="room_types", resultset=2 );
		sp.addProcResult( name="dates", resultset=3 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
}