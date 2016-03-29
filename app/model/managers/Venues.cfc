/**
*
* @file  /model/managers/venues.cfc
* @author
* @description
*
*/

component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="VenueDao" getter="true" setter="true";
	property name="slugManager" getter="true" setter="true";
	property name="mediaManager" getter="true" setter="true";
	 /**
    * Get Venue List
    */
    public struct function getVenueList(numeric company_id, numeric start=1, numeric results=1, string sort_column='venue_name', string sort_direction='ASC', string search="" ){
		var sp = new StoredProc();
        var result = {};
        sp.setAttributes({
            'datasource' = getDSN(),
            'procedure' = "VenuesList"
        });

        sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start );
        sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results );
        sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", maxlength=50, value=arguments.sort_column );
        sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", maxlength=4, value=arguments.sort_direction );
        sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", maxlength=200, value=arguments.search, null=( !len(arguments.search) ) );
        sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id, null=( !arguments.company_id ) );

        sp.addProcResult( name="venues", resultset=1 );

        result = sp.execute();
        return {
            'prefix' = result.getPrefix(),
            'result' = result.getProcResultSets()
            };
    }
	/**
	* Multi line method description
	*
	*/
	public struct function getListing( numeric order_index=0, string order_dir="asc", string search_value="", numeric start_row=0, numeric total_rows=10, numeric draw=1 ) {
		var iTotalDisplayRecords = 0;
		var rtn = {"draw"=arguments.draw, "recordsTotal"=0, "recordsFiltered"=0,"data"=[]};
		var params = {start=(start_row+1),results=arguments.total_rows,sort_column="",sort_direction=arguments.order_dir,search=arguments.search_value};
		var event_sessions = VenuesList( argumentCollection=params );
		var opt = "";
		queryAddColumn( event_sessions, "options", [] );

		for ( var i=1; i <= event_sessions.RecordCount; i++) {
			//opt="";
			//opt &= "<a href='/sessions/details/session_id/"& event_sessions.session_id[ i ] &"'' data-modifytype='true'><span class='glyphicon glyphicon-edit'></span> <strong>Manage</strong> </a>";
			//querySetCell(event_sessions, "options", opt, i);
			arrayappend( rtn['data'], queryRowToStruct( event_sessions, i, true ));
		}

		rtn['recordsTotal'] = event_sessions.total;
		rtn['recordsFiltered'] = event_sessions.total;

		return rtn;
	}
	/*
	* Sets a venue address and creates the venue to address association
	* @venue_id The venue id
	* @address_id (optional) The id of the address if updating, 0 means add
	* @address_type (optional) The address type
	* @address_1 The address line
	* @address_2 (optional) Additional address information
	* @city The city of the address
	* @region_code The region / state / province of the address
	* @postal_code The postal / zip code of the address
	* @country_code The 2 letter iso country code
	* @latitude (optional) The latitude of the address
	* @longitude (optional) The longitude of the address
	* @verified (optional) Whether or not the address has been verified
	*/
	public numeric function setVenueAddress(
		required numeric venue_id,
		numeric address_id=0,
		string address_type="Default",
		required string address_1,
		string address_2="",
		required string city,
		required string region_code,
		required string postal_code,
		required string country_code,
		numeric latitude=0,
		numeric longitude=0,
		boolean verified=false
	) {
		return getVenueDao().VenueAddressSet( argumentCollection=arguments );
	}
	/**
	* I get all of a Venues details, photos, logs
	* @venue_id The Venue ID of the Venue that you want to get details on.
	*/
	public struct function getVenueDetails( numeric venue_id=0, string slug ) {
		var venue = {};
		if( structKeyExists( arguments, "slug" ) ){
			venue = getVenueDao().VenueBySlugGet( slug=arguments.slug );
		}
		else{
			venue = getVenueDao().VenueGet( venue_id=arguments.venue_id );
		}
		// locations
		venue['locations'] = queryToArray( recordset=venue.locations );
		venue['location_cnt'] = arrayLen(venue.locations);
		// photos
		venue['photos'] = queryToArray( recordset=venue.photos );
		venue['photo_cnt'] = arrayLen(venue.photos);
		// logs
		venue['logs'] = queryToArray( recordset=venue.logs );
		venue['log_cnt'] = arrayLen(venue.logs);
		venue['success'] = venue.venue_id ? true : false;
		return venue;
	}
	/*
	* Creates a Venue
	* @venue_name The name of the venue
	* @url A url of the venue
	* @company_id A company to associate the venue to
	* @slug A slug for the venue
	*/
	public numeric function createVenue(
		required string venue_name,
		string url="",
		numeric company_id=0,
		required string slug
	) {
		var params = arguments;
		params['slug'] = getSlugManager().generate( input=arguments.venue_name );
		return getVenueDao().VenueCreate( argumentCollection=params );
	}
	/*
	* Gets a venue's id by the slug
	* @slug The Slug for the Venue
	*/
	public numeric function getVenueID( required string slug ) {
		return getVenueDao().VenueIdBySlugGet( argumentCollection=arguments );
	}
	/*
	* Creates a venue log entry
	* @venue_id The id of the venue
	* @user_id The id of the user
	* @action The type of action performed on the venue
	* @message (optional) A message to store along w/ the log entry
	* @ip (optional) The IP Address where the action was initiated from
	*/
	public numeric function setVenueLog(
		required numeric venue_id,
		required string action,
		string message=""
	) {
		var params = arguments;
		params['user_id'] = getSessionManageUserFacade().getValue( "user_id" );
		params['ip'] = cgi.remote_addr;
		return getVenueDao().VenueCreate( argumentCollection=params );
	}
	/*
	* Gets the Venues logs
	* @venue_id The id of the venue
	*/
	public struct function getVenueLogs( required numeric venue_id ){
		var data = {};
		data['logs'] = queryToArray( recordset=getVenueDao().VenueLogsGet( venue_id=arguments.venue_id ).result );
		data['log_cnt'] = arrayLen( data.logs );
		return data;
	}
	/*
	* Sets a venue phone and creates the venue to phone association
	* @venue_id The venue id
	* @phone_id (optional) The id of the phone if updating, 0 means add
	* @phone_type (optional) The phone type
	* @phone_number The phone number
	* @extension (optional) An extension for the phone
	*/
	public numeric function setVenuePhone(
		required numeric venue_id,
		numeric phone_id=0,
		required string phone_number,
		string extension=""
	) {
		return getVenueDao().VenueAddressSet( argumentCollection=arguments );
	}

	/*
	* Get's all of the phone numbers associated to a venue
	* @venue_id The venue id
	*/
	public struct function getVenuePhones( required numeric venue_id ){
		var data = {};
		data['phones'] = queryToArray( recordset=getVenueDao().VenuePhonesGet( venue_id=arguments.venue_id ).result );
		data['phone_cnt'] = arrayLen( data.phones );
		return data;
	}
	/*
	* Creates or Updates a Venue Photo / Media Item and Returns the Media ID
	* @venue_id The venue id
	* @media_id The media id, if null it is added
	* @mimetype_id The mimetype of the media being added
	* @filename The name of the file
	* @thumbnail The name of the thumbnail
	* @filesize The size of the media in kilobytes
	* @label A friendly label for the media
	* @publish A date to publish the media on
	* @expire A date to expire the media
	*/
	public numeric function setVenuePhoto(
		required numeric venue_id,
		numeric media_id = 0,
		required numeric mimetype_id,
		required string filename,
		required string thumbnail,
		required numeric filesize,
		string label,
		date publish,
		date expire
	) {
		return getVenueDao().VenuePhotoSet( argumentCollection=arguments );
	}
	/*
	* Gets all of the Venues Photos
	* @venue_id The venue id
	*/
	public struct function getVenuePhotos( required numeric venue_id ){
		var data = {};
		data['photos'] = queryToArray( recordset=getVenueDao().VenuePhonesGet( venue_id=arguments.venue_id ).result );
		data['photo_cnt'] = arrayLen( data.photos );
		return data;
	}
	/*
	* Gets all of the photos for a venue, with searching / paging / sorting
	* @venue_id The venue id
	* @start The row to start at
	* @results The number of results to get
	* @sort_column The column to sort on
	* @sort_direction The direction to sort the results
	* @search A string to filter the results
	*/
	public struct function getVenuePhotosList(
		required numeric venue_id,
		numeric start=1,
		numeric results=10,
		string sort_column="uploaded",
		string sort_direction="DESC",
		string search="",
		numeric draw=1
	) {
		var venues = getVenueDao().VenuePhotosList( argumentCollection=arguments ).result;
		return {
			"draw": arguments.draw,
			"recordsTotal": isDefined("venues.total") ? venues.total : venues.recordCount,
			"recordsFiltered": isDefined("venues.total") ? venues.total : venues.recordCount,
			"data": queryToArray( venues )
		};
	}
	/*
	* Gets the current max sort value for the photos
	* @venue_id The venue id
	*/
	public numeric function getVenuePhotosMaxSort( required numeric venue_id ){
		return getVenueDao().VenuePhotosMaxSortGet( argumentCollection=arguments );
	}
	/*
	* Sets a Venues Information
	* @venue_id The id of the venue
	* @venue_name The name of the venue
	* @url A url of the venue
	* @company_id A company to associate the venue to
	* @address_id (optional) The id of the address if updating, 0 means add
	* @address_type (optional) The address type
	* @address_1 The address line
	* @address_2 (optional) Additional address information
	* @city The city of the address
	* @region_code The region / state / province of the address
	* @postal_code The postal / zip code of the address
	* @country_code The 2 letter iso country code
	* @latitude (optional) The latitude of the address
	* @longitude (optional) The longitude of the address
	* @verified (optional) Whether or not the address has been verified
	* @phone_id (optional) The id of the phone if updating, 0 means add
	* @phone_type (optional) The phone type
	* @phone_number The phone number
	* @extension (optional) An extension for the phone
	*/
	public struct function save(
		// venue details
		required numeric venue_id,
		required string venue_name,
		string url="",
		numeric company_id=0,
		// address details
		numeric address_id=0,
		string address_type="Default",
		required string address_1,
		string address_2="",
		required string city,
		required string region_code,
		required string postal_code,
		required string country_code,
		numeric latitude=0,
		numeric longitude=0,
		boolean verified=false,
		// phone details
		string phone_type="Default",
		numeric phone_id=0,
		required string phone_number,
		string extension=""
	) {
		var params = arguments;
		params['slug'] = getSlugManager().generate( input=arguments.venue_name );
		return getVenueDao().VenueSet( argumentCollection=params );
	}
	/**
	* I get all of the Venues
	*/
	public struct function getVenues(
		numeric start=1
		numeric results=10,
		string sort_column="venue_name",
		string sort_direction="ASC",
		string search="",
		numeric company_id=0,
		numeric draw=1
	 ) {
		var venues = getVenueDao().VenuesList( argumentCollection=arguments ).result;
		return {
			"draw": arguments.draw,
			"recordsTotal": isDefined("venues.total") ? venues.total : venues.recordCount,
			"recordsFiltered":  isDefined("venues.total") ? venues.total : venues.recordCount,
			"data": queryToArray( recordset=venues )
		};
	}
	/**
	* I check to see if an venue slug exists for an event
	* @event_id The ID of the event that you are checking the venue slug for
	* @slug The slug that you are checking
	*/
	public boolean function venueSlugExists( required numeric venue_id, required string slug ) {
		return getVenueDao().VenueSlugExists( argumentCollection=arguments );
	}
	/*
	* Gets the current max sort value for the venue location
	* @venue_id The venue id
	*/
	public numeric function getVenueLocationsMaxSort( required numeric venue_id ){
		return getVenueDao().VenueLocationsMaxSortGet( argumentCollection=arguments );
	}
	/*
	* Gets all of the Venues Locations
	* @venue_id The venue id
	*/
	public struct function getVenueLocations( required numeric venue_id ){
		var data = {};
		data['locations'] = queryToArray( recordset=getVenueDao().VenueLocationsGet( venue_id=arguments.venue_id ).result );
		data['location_cnt'] = arrayLen( data.locations );
		return data;
	}
	/*
	* Gets all of the Venues Locations and returns the query object
	* @venue_id The venue id
	*/
	public query function getVenueLocationsQuery( required numeric venue_id ){
		return getVenueDao().VenueLocationsGet( venue_id=arguments.venue_id ).result;
	}
	/**
	* I get all of the Venue Locations w/ paging, sorting, searching
	*/
	public struct function getVenueLocationsListing(
		required numeric venue_id,
		numeric start=1
		numeric results=10,
		string sort_column="sort",
		string sort_direction="ASC",
		string search="",
		numeric draw=1
	 ) {
		var venues = getVenueDao().VenueLocationsList( argumentCollection=arguments ).result;
		return {
			"draw": arguments.draw,
			"recordsTotal": isDefined("venues.total") ? venues.total : venues.recordCount,
			"recordsFiltered":  isDefined("venues.total") ? venues.total : venues.recordCount,
			"data": queryToArray( recordset=venues )
		};
	}
	/*
	* Adds a Location to an Venue
	* @location_id The location id, 0 means add
	* @venue_id The venue id
	* @location_name The name of the location
	* @slug A slug for the location
	* @sort The order in which to sort the venue for the event
	*/
	public numeric function setVenueLocation(
		numeric location_id=0,
		required numeric venue_id,
		required string location_name,
		numeric sort=0
	){
		var params = arguments;
		params['slug'] = getSlugManager().generate( input=arguments.location_name );
		if( !params.sort ) {
			params['sort'] = getVenueLocationsMaxSort( venue_id=params.venue_id ) + 1;
		}
		return getVenueDao().VenueLocationSet( argumentCollection=params );
	}
	/*
	* Removes a Venue to an Event
	* @location_id The location_ id
	* @venue_id The venue id
	*/
	public void function removeVenueLocation( required numeric location_id, required numeric venue_id ){
		getVenueDao().VenueLocationRemove( argumentCollection=arguments );
		return;
	}
	/**
	* I get all of the Company Venues
	*/
	public struct function getCompanyVenues(
		required numeric company_id,
		numeric start=1
		numeric results=10,
		string sort_column="venue_name",
		string sort_direction="ASC",
		string search="",
		numeric draw=1
	 ) {
		var venues = getVenueDao().CompanyVenuesList( argumentCollection=arguments ).result;
		return {
			"draw": arguments.draw,
			"recordsTotal": isDefined("venues.total") ? venues.total : venues.recordCount,
			"recordsFiltered": isDefined("venues.total") ? venues.total : venues.recordCount,
			"data": queryToArray( venues )
		};
	}
	/*
	* Adds a Venue to an Event
	* @event_id The event id
	* @venue_id The venue id
	* @sort The order in which to sort the venue for the event
	*/
	public void function addEventVenue( required numeric event_id, required numeric venue_id, numeric sort=0 ){
		getVenueDao().EventVenueAdd( argumentCollection=arguments );
		return;
	}
	/*
	* Removes a Venue to an Event
	* @event_id The event id
	* @venue_id The venue id
	*/
	public void function removeEventVenue( required numeric event_id, required numeric venue_id ){
		getVenueDao().EventVenueRemove( argumentCollection=arguments );
		return;
	}
	/*
	* Gets all of the venues associated to an event
	* @event_id The event id
	*/
	public struct function getEventVenues( required numeric event_id ){
		var data = {};
		data['venues'] = queryToArray( recordset=getVenueDao().EventVenuesGet( event_id=arguments.event_id ).result );
		data['venue_cnt'] = arrayLen( data.venues );
		return data;
	}
	/*
	* Gets the current max sort value for the event venues
	* @event_id The event id
	*/
	public numeric function getEventVenuesMaxSort( required numeric event_id ){
		return getVenueDao().EventVenuesMaxSortGet( argumentCollection=arguments );
	}
	/*
	* Gets all of the Event Venue Locations
	* @venue_id The venue id
	*/
	public struct function getEventVenueLocations( required numeric event_id ){
		var data = getVenueDao().EventVenueLocationsGet( venue_id=arguments.event_id ).result;
		var result = queryToStruct( recordset=getVenueDao().EventVenueLocationsGet( venue_id=arguments.event_id ).result );
		result['count'] = data.recordCount;
		return result;
	}
	/*
	* Gets all of the Event Venue Locations and returns the query object
	* @venue_id The venue id
	*/
	public query function getEventVenueLocationsQuery( required numeric event_id ){
		return getVenueDao().EventVenueLocationsGet( venue_id=arguments.event_id ).result;
	}
	/**
	* I get all of the Event Venue Locations w/ paging, sorting, searching
	*/
	public struct function getEventVenueLocationsListing(
		required numeric event_id,
		numeric start=1
		numeric results=10,
		string sort_column="venue_name",
		string sort_direction="ASC",
		string search="",
		numeric draw=1
	 ) {
		var venues = getVenueDao().EventVenueLocationsList( argumentCollection=arguments ).result;
		return {
			"draw": arguments.draw,
			"recordsTotal": isDefined("venues.total") ? venues.total : venues.recordCount,
			"recordsFiltered": isDefined("venues.total") ? venues.total : venues.recordCount,
			"data": queryToArray( recordset=venues )
		};
	}
}