/**
* @file  /model/managers/Hotel.cfc
*/
component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="hotelDao" getter="true" setter="true";
	/*
	* Gets all of the event h for a given event
	* @event_id The event id
	*/
	public struct function getHotels( required numeric event_id ) {
		var data = {};
		var recordset = getHotelDao().EventHotelsGet( argumentCollection:arguments ).result;
		data = {
			'data': queryToArray(
			recordset=recordset,
			columns=listAppend( recordset.columnList, "rooms" ),
			data=arguments,
			map=function( row, index, columns, data ){
		    	row['rooms'] = getHotelRooms( data.event_id , row.hotel_id );
		        return row;
			 }),
			'count': recordset.recordCount
		};
	return data;
	}
	/*
	* Gets all of the event hotel rooms for an event
	* @event_id The event id
	* @hotel_id (optional) The hotel id to filter on
	*/
	public struct function getHotelRooms(
		required numeric event_id,
		required numeric hotel_id
	) {
		var data = {};
		var room_data = getHotelDao().HotelRoomTypesByEventGet( argumentCollection:arguments );
		var current_date = "";
		data = {
			'data': queryToArray( recordset:room_data.result, map:function( row, index, columns, data ) {
				var current_date = row.min_date;
				row['dates'] = {'data':[],'count':DateDiff("d", row.min_date, row.max_date )};

				row['max_date'] = dateformat( row.max_date, "mm/dd/yyyy" );
				row['min_date'] = dateformat( row.min_date, "mm/dd/yyyy" );
				
				arrayAppend( row['dates']['data'], {'value': dateformat( current_date, "mm/dd/yyyy" ),'display': dateformat( current_date, "MMMM d" ) } );
				for (var i=1; i LTE row.dates.count; i=i+1) {
					current_date = dateAdd( "d", i, row.min_date);
					arrayAppend( row['dates']['data'], {'value': dateformat( current_date, "mm/dd/yyyy" ),'display': dateformat( current_date, "MMMM d" ) } );
				}

		        return row;
			}),
			'count': room_data.result.recordCount
		};

		return data;
	}
	/*
	* Returns the hotels by company
	* @company_id The id of the company to return for.  NULL returns for all companies
	* @return_null_company Returns all hotels with NULL companies
	*/
	public struct function getCompanyHotels( required numeric company_id ) {
		var recordset = getHotelDao().HotelsByCompanyGet( argumentCollection:arguments ).result;
		var rtn = queryToArray( recordset );
		
		return {
			'data': rtn,
			'count': arrayLen( rtn )
		};
	}
	/*
	* Saves a hotel and rooms to an event
	*/
	public void function saveEventHotel(
		required numeric event_id,
		required numeric hotel_id,
		required struct event_hotel,
		required array event_hotel_rooms
	) {
		var room_count = arrayLen( arguments.event_hotel_rooms );
		var room = {};
		getHotelDao().EventHotelSet( argumentCollection:arguments.event_hotel );
		for( var i=1; i LTE room_count; i=i+1 ) {
			room = arguments.event_hotel_rooms[ i ];
			structAppend( room, {'hotel_room_id':0, 'event_id':arguments.event_id, 'hotel_id':arguments.hotel_id, 'block_date':"", 'room_type_id':0, 'rooms_allocated':0}, false);
			if( isdate( room.block_date ) && room.rooms_allocated > 0 ) {				
				room['hotel_room_id'] = val( room.hotel_room_id );
				getHotelDao().EventHotelRoomSet( argumentCollection:room );
			}
		}
		getCacheManager().purgeEventHotelCache( arguments.event_id );
	}
	/*
	* Gets all of the Hotel Information
	* @hotel_id The id of the hotel
	*/
	public struct function getHotel( required numeric hotel_id ) {	
		var record_sets = getHotelDao().HotelGet( argumentCollection:arguments ).result;
		var data = queryToArray( record_sets.details );
		var count = arrayLen( data );
		var rtn = {};

		if( count ) {
			rtn = data[1];
		}
		structAppend( rtn, {'hotel_id':0, 'name':"", 'url':"", 'address_id':0, 'address_type':"", 'address_1':"", 'address_2':"", 'city':"", 'region_code':"", 'postal_code':"", 'country_code':"", 'latitude':"", 'longitude':"", 'verified':false, 'slug_id':0, 'slug':""}, false );
		
		rtn['phone_numbers'] = queryToArray( record_sets.phone_numbers );
		rtn['photos'] = queryToArray( record_sets.photos );
		rtn['logs'] = queryToArray( record_sets.logs );
		return rtn;
	}
	/*
	* Returns the hotel room types by company
	* @company_id The id of the company to return for
	*/
	public struct function getRoomTypes( required numeric company_id ) {
		var record_set = getHotelDao().HotelRoomTypesByCompanyGet( argumentCollection:arguments ).result;
		var rtn = queryToArray(record_set);
		return {
			'data': rtn,
			'count': arrayLen( rtn )
		};
	}
	/*
	* Gets all of the event hotel rooms for an event
	* @event_id The event id
	* @hotel_id (optional) The hotel id to filter on
	*/
	public struct function getEventHotelRooms(
		required numeric event_id,
		required numeric hotel_id
	) {
		var record_set = getHotelDao().EventHotelRoomsGet( argumentCollection:arguments ).result;
		var rtn = queryToArray( recordset=record_set, map=function( row, index, columns, data ){
			row['block_date'] = dateformat( row.block_date, "mm/dd/yyyy" );
			return row;
		});
		return {
			'data': rtn,
			'count': arrayLen( rtn )
		};
	}
	/*
	* Gets the current max hotel sort value for an event
	* @event_id The id of the Event
	*/
	public numeric function getEventHotelsNextMaxSort( required numeric event_id ) {

		return val( getHotelDao().EventHotelsMaxSortGet( argumentCollection:arguments ).sort ) + 1;
	}
	/*
	* Gets all of the event hotel rooms for an event and the number of rooms booked
	* @event_id The event id
	* @hotel_id (optional) The hotel id to filter on
	*/
	public struct function getBookedHotelRooms(
		required numeric event_id,
		numeric hotel_id=0
	) {
		var record_set = getHotelDao().EventHotelRoomsBookedGet( argumentCollection:arguments ).result;
		var data = {'hotels':[],'count':0, 'hotel_ids':""};
		var map_params = {'recordset':record_set,'data':data};
		map_params['map'] = 
		function( row, index, columns, data ){
			var hotel = {};
			var dates = {};
			var date_key = reReplace( row.block_date, "-", "_", "ALL");
			row['room_available'] = val(row.rooms_allocated) - val(row.rooms_booked);
			if( !listFindNoCase( data.hotel_ids, row.hotel_id) ) {
				data['hotel_ids'] = listAppend( data.hotel_ids, row.hotel_id );
				data['count']++;
				arrayAppend( data['hotels'], 
					{
					'dates':{'data':[],'room_count':0,'count':0,'keys':""}, 
					'total_room_count':0,
					'hotel_id':row.hotel_id,
					'hotel_name':row.hotel_name,
					'address_1':row.address_1, 
					'address_2':row.address_2,
					'phone_number':row.phone_number,
					'city':row.city, 
					'country_code':row.country_code, 
					'region_code':row.region_code,
					'postal_code':row.postal_code } );
			}
			hotel = data['hotels'][data.count];
			dates = hotel.dates;
			if( !listFindNoCase( dates.keys, date_key ) ) {
				dates['keys'] = listAppend( dates.keys, date_key );
				arrayAppend( dates['data'], {'room_types':{'data':[],'count':0},'block_date':dateformat(row.block_date,"mm/dd/yyyy")}  );
				dates['count']++;
			}
			hotel['total_room_count']++;
			dates['room_count']++;
			current_block = dates['data'][ dates.count ];
			current_block['room_types']['count']++;
			
			arrayAppend( current_block['room_types']['data'], {
				'hotel_room_id':row.hotel_room_id,
				'rooms_allocated':row.rooms_allocated,
				'rooms_booked':row.rooms_booked,
				'room_type':row.room_type,
				'room_type_id':row.room_type_id,
				'block_date':row.block_date,
				'room_available':row.room_available
				});
			return row;
		};
		queryToArray( argumentCollection:map_params );

		return data;
	}
	public struct function saveHotel(
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
		var rtn = getHotelDao().HotelSet( argumentCollection:arguments );
		return rtn;
	}
	/*
	* Get the filters for the getHotelFilters
	* @event_id The id of the event to filter for
	*/
	public struct function getHotelFilters( required numeric event_id ) {
		var results = getHotelDao().RegistrationAttendeesHotelFiltersGet( argumentCollection:arguments ).result;

		return {
			'hotels':{
				'data':queryToArray(results.hotels),
				'count':results.hotels.recordCount
			},
			'room_types':{
				'data':queryToArray(results.room_types),
				'count':results.room_types.recordCount
			},
			'dates':{
				'min':dateformat(results.dates.min_block_date,"mm/dd/yyyy"),
				'max':dateformat(results.dates.max_block_date,"mm/dd/yyyy")
			}
		};		
	}
}