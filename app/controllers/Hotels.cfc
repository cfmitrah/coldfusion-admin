
component extends="$base" accessors="true"
{
	property name="HotelManager" getter="true" setter="true";
	property name="GeographyManager" getter="true" setter="true";
	property name="slugManager" setter="true" getter="true";
	
	public void function before( rc ) {
		rc.sidebar = "sidebar.event.details";
		if( !getSessionManageUserFacade().getCurrentCompanyID() ){
			redirect('company.select');
		}
		if( structKeyExists( rc, "event_id") && isNumeric( rc.event_id ) && rc.event_id gt 0 ){
			getSessionManageUserFacade().setValue( 'current_event_id', rc.event_id );
		}
		super.before( rc );
		return;
	}
	//START PAGE VIEWS
	/**
	* Default
	* This method will render the hotel list
	**/
	public void function default( rc ) {
		rc['booked_rooms'] = getHotelManager().getBookedHotelRooms( event_id:getCurrentEventID() );
		return;
	}
	/**
	* Edit
	* This method is for editing another hotel / room / date
	**/
	public void function edit( rc ) {
		var cf_js = {
			'urls':{
				'hotel_list':buildURL("hotels.list")
				,'hotel_get':buildURL("hotels.hotelInfo")
				,'room_room_list':buildURL("hotels.eventHotelRooms")
				,'save_hotel':buildURL("hotels.saveHotel")
			}
		};
		structAppend( rc, {'hotel_id':0}, false );
		cf_js['hotel_id'] = rc.hotel_id;

		if( !rc.hotel_id ) {
			rc['regions'] = getGeographyManager().getRegions("US");
			rc['regions_opts'] = getFormUtilities().buildOptionList( rc.regions.region_code, rc.regions.region_name );
		}
		rc['room_types'] = gethotelManager().getRoomTypes( getCurrentCompanyID() );
		rc['next_sort'] = gethotelManager().getEventHotelsNextMaxSort( getCurrentEventID() );
		getCfStatic()
			.includeData( cf_js )
			.include( "/js/pages/hotels/create.js" )
			.include( "/css/plugins/date-timepicker/date-timepicker.css" );
		return;
	}
	/**
	* 
	*/
	public void function save( rc ) {
		var params = {};
		structAppend( rc, {'eventhotel':{}, 'eventhotelroom':[]}, false );
		structAppend( rc['eventhotel'], {'hotel_id':0,'event_id':getCurrentEventID(),'url':"",'sort':gethotelManager().getEventHotelsNextMaxSort( getCurrentEventID() ),'description':"" }, false );
		rc['eventhotelroom'] = getFormUtilities().arrayRemoveEmpty( rc.eventhotelroom );
		params['event_hotel_rooms'] = rc.eventhotelroom;
		params['event_hotel'] = rc.eventhotel;
		params['event_id'] = rc.eventhotel.event_id;
		params['hotel_id'] = rc.eventhotel.hotel_id;
		
		gethotelManager().saveEventHotel( argumentCollection:params );
		redirect("hotels");	
		return;
	}
	/**
	* get a list of company hotels
	*/
	public void function list( rc ) {

		getFW().renderData( "json", gethotelManager().getCompanyHotels( getCurrentCompanyID() ) );
		return;
	}
	/**
	* get a hotel
	*/
	public void function hotelInfo( rc ) {
		structAppend( rc, {'hotel_id':0}, false );
		getFW().renderData( "json", gethotelManager().getHotel( rc.hotel_id ) );
		return;
	}
	/**
	* save a hotel
	*/
	public void function saveEventHotel( rc ) {
		structAppend( rc, {'hotel_id':0, 'sort':0, 'description':"", 'url':"" }, false);
		getFW().renderData( "json", gethotelManager().saveEventHotel( argumentCollection:rc ) );
		return;
	}
	/**
	* get the event hotel room
	*/
	public void function eventHotelRooms( rc ) {
		structAppend( rc, {'hotel_id':0}, false );
		getFW().renderData( "json", gethotelManager().getEventHotelRooms( argumentCollection:rc ) );
		return;
	}
	/**
	* Multi line method description
	* @argument_name Argument description
	*/
	public void function saveHotel( rc ) {
		var hotel_params = {};
		structAppend( rc, {'hotel':{} }, false );
		hotel_params = rc.hotel;
		structAppend( hotel_params, {'hotel_id':0, 'state':"", 'name':"", 'slug_id':0, 'url':"", 'company_id':getCurrentCompanyID(), 'address_1':"", 'city':"",
				'region_code':"", 'postal_code':"", 'country_code':"", 'verified': true, 'phone_number':""}, false );
		
		hotel_params['country_code'] = listFirst( hotel_params.state, "-");
		hotel_params['region_code'] = hotel_params.state;
		hotel_params['slug_id'] = getSlugManager().save( hotel_params.name ).slug_id;
		getFW().renderData( "json", gethotelManager().saveHotel( argumentCollection:hotel_params ) );
		return;
	}
}