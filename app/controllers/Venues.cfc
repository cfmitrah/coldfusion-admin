component extends="$base" accessors="true" {
	property name="venuesManager" setter="true" getter="true";
	property name="geographyManager" setter="true" getter="true";
	property name="mediaManager" setter="true" getter="true";
	property name="formatter" setter="true" getter="true";
	property name="eventsManager" setter="true" getter="true";

	public void function before( rc ) {
		rc.sidebar = 'sidebar.company';
		if( !getCurrentCompanyID() ){
			redirect("company.select");
		}
		super.before( rc );
		return;
	}
	/**
	* I am the event speakers listing
	*/
	public void function default( rc ) {
		var listing_config = {
			"table_id": "venues_listing",
			"ajax_source": "venues.listing",
			"columns": "venue_name,website,address,phone_number,locations,photos,options",
			"aoColumns": [
				{
					"data": "venue_name",
					"sTitle": "Venue Name"
				},
				{
					"data": "website",
					"sTitle": "Website",
					"bSortable": false
				},
				{
					"data": "address",
					"sTitle": "Address",
					"bSortable": false
				},
				{
					"data": "phone_number",
					"sTitle": "Contact Number",
					"bSortable": false
				},
				{
					"data": "locations",
					"sTitle": "## Locations"
				},
				{
					"data": "photos",
					"sTitle": "Photos",
					"bSortable": false
				},
				{
					"data": "options",
					"sTitle": "Options",
					"bSortable": false
				}
			]
		};
		rc['table_id'] = listing_config.table_id;
		listing_config['ajax_source'] = buildURL( (structKeyExists(listing_config,'ajax_source') ? listing_config.ajax_source: '') );
		rc['columns'] = listing_config.columns;
		getCfStatic()
			.includeData( listing_config )
			.include( "/css/pages/common/listing.css" )
			.include( "/js/pages/common/listing.js" );

		return;
	}
	/**
	* Returns a listing based on a given id
	*/
	public any function listing( rc ) {
		var params = {
			'start' = 1,
			'length' = 10,
			'SEARCH[VALUE]' = "",
			'ORDER[0][COLUMN]' = "0",
			'ORDER[0][DIR]' = "ASC"
		};
		var result = {};
		var columns = [ "venue_name", "locations", "website", "address", "options" ];
		structAppend(params, rc);
		params['results'] = params.length;
		params['sort_column'] = columns[ params['ORDER[0][COLUMN]'] + 1 ];
		params['sort_direction'] = params['ORDER[0][DIR]'];
		params['search'] = params['SEARCH[VALUE]'];
		params['company_id'] = getCurrentCompanyID();
		result = getVenuesManager().getVenues( argumentCollection = params );
		result['cnt'] = arrayLen(result.data);
		for( var i = 1; i <= result.cnt; i++ ) {
			result['data'][i]['address'] = result.data[i].address_1 & " " & result.data[i].address_2 & "<br />" & result.data[i].city & ", " & result.data[i].region_code.replaceAll( result.data[i].country_code & "-", "" ) & " " &result.data[i].postal_code;
			result['data'][i]['website'] = len(result.data[i].url) ? "<a href=""" & result.data[i].url & """>View</a>" : "";
			result['data'][i]['phone_number'] = len(result.data[i].phone_number) ? getFormatter().formatPhone( result.data[i].phone_number ) : "N/A";
			result['data'][i]['photos'] = result.data[i].has_photos ? "<span class=""glyphicon glyphicon-ok""></span>" : "<span class=""glyphicon glyphicon-remove""></span>";
			result['data'][i]['options'] = "<a class=""btn btn-primary btn-sm"" href=""" & buildURL("venues.details?venue_id=" & result.data[i].venue_id ) & """>View Venue</a>";
		}
		getFW().renderData( "json", result );
		return;
	}
	/**
	* I render the new Speaker form
	*/
	public void function create( rc ) {
		requestType = GetHttpRequestData();
		if (requestType.headers.referer == 'http://manage.meetingplay.local/venues/create') {
			getCfStatic()
			.include ("/js/pages/venues/unique_venue_name.js");
		}
		/**/
		var venue_config = {
			'ajax_get_region_url' : buildURL( "venues.ajaxGetVenues" )
		};
		rc['countries'] = getGeographyManager().getCountries( has_regions=1);
		rc['countries']['opts' ] = getFormUtilities().buildOptionList( values=rc.countries.country_code, display=rc.countries.country_name, selected="US" );
		rc['regions'] = getGeographyManager().getRegions( country_code="US" );
		rc['regions']['opts'] = getFormUtilities().buildOptionList( values=rc.regions.region_code, display=rc.regions.region_name );
		getCfStatic().includeData( venue_config )
			.include("/js/pages/speakers/create.js")
			.include("/js/pages/venues/set_region.js");
		return;
	}

	/**
	* I create a new Speaker
	*/
	public void function doCreate( rc ) {
		if( structKeyExists( rc, "venue") && isStruct( rc.venue ) ){
			if( !structKeyExists( rc.venue, "venue_id" ) ) {
				rc['venue']['venue_id'] = 0;
			}

			var newVenueName = rc['VENUE.VENUE_NAME'];
			completeVenueslist = getVenuesManager().getVenues(company_id=rc['company_id']);

			for (venue in completeVenueslist['data']) {
				if (!ArrayIsEmpty(StructFindValue(venue, newVenueName, 'one'))) {
					redirect( action="venues.create" );
					break;
				}
			}

			var eventsList = getEventsManager().getCompanyEventList(company_id=rc['company_id']);
			var vennuesList = ArrayNew(1);
			var exists = false;

			for (eventId in eventsList['event_id'] ) {
				if (!exists) {
					vennuesList = getEventsManager().getEventVenues(eventId);
					for (event in vennuesList['venues']) {
						if (!ArrayIsEmpty(StructFindValue(event, newVenueName, 'one'))) {
							exists = true;
							redirect( action="venues.create" );
							break;
						}
					}
				} else {
					break;
				}
			}

			// save the venue
			structAppend( rc, getVenuesManager().save( argumentCollection=rc.venue ) );

			// associate the venue to an event if we have a valid event id.
			if ( getCurrentEventID() ) {
				rc['event_id'] = getCurrentEventID();
				getVenuesManager().addEventVenue( event_id=rc.event_id, venue_id=rc.venue_id );
			}

			if( val( rc.venue_id ) ){
				redirect( action="venues.details", queryString="venue_id=" & rc.venue_id );
			}
		}
		redirect("venues.default");
		return;
	}
	/**
	* I am the Speaker details for a given Speaker
	*/
	public void function details( rc ) {
		rc['company_id'] = getCurrentCompanyID();
		rc['event_id'] = getCurrentEventID();
		var venue_id = structKeyExists( rc, "venue_id" ) ? rc.venue_id : 0 ;
		if( !structKeyExists( rc, "venue" ) ) {
			rc['venue'] = {};
		}
		structAppend(rc.venue, getVenuesManager().getVenueDetails( venue_id = venue_id ), false );
		// make sure records were found
		if( !rc.venue.success ) {
			redirect( "venues.default" );
		}
		rc['venue']['phone_number'] = getFormatter().formatPhone( rc.venue.phone_number );
		var venue_config = {
			'ajax_get_region_url' : buildURL( "venues.ajaxGetVenues" )
		};
		rc['countries'] = getGeographyManager().getCountries( has_regions=1);
		rc['countries']['opts' ] = getFormUtilities().buildOptionList( values=rc.countries.country_code, display=rc.countries.country_name, selected=rc.venue.country_code );
		rc['regions'] = getGeographyManager().getRegions( country_code="US" );
		rc['regions']['opts'] = getFormUtilities().buildOptionList( values=rc.regions.region_code, display=rc.regions.region_name, selected=rc.venue.region_code );
		getCfStatic().includeData( venue_config )
			.include( "/css/pages/common/media.css" )
			.include( "/js/pages/common/media.js" )
			.include("/js/pages/venues/set_region.js")
			.include( "/js/pages/venues/details.js" );
		return;
	}
	/**
	* I save a Speaker
	*/
	public void function doSave( rc ) {
		if( structKeyExists( rc, "venue") && isStruct( rc.venue ) ){
			if( !structKeyExists( rc.venue, "venue_id" ) ) {
				rc['venue']['venue_id'] = 0;
			}
			// save the venue
			structAppend( rc, getVenuesManager().save( argumentCollection=rc.venue ) );
			// associate the venue to an event
			rc['event_id'] = getCurrentEventID();
			if( val( rc.venue_id ) ){
				redirect( action="venues.details", queryString="venue_id=" & rc.venue_id );
			}
		}
		redirect("venues.default");
		return;
	}
	/**
	* Adds a Location to a Venue
	*/
	public void function addLocation( rc ) {
		var result = {
			'success': false
		};
		if( structKeyExists( rc, "location_name") && structKeyExists(rc, "venue_id") ){
			if( !structKeyExists( rc, "location_id" ) ) {
				rc['location_id'] = 0;
			}
			if( !structKeyExists( rc, "sort" ) ) {
				rc['sort'] = 0;
			}
			result['location_id'] = getVenuesManager().setVenueLocation(
				location_id=rc.location_id,
				venue_id=rc.venue_id,
				location_name=rc.location_name,
				sort=rc.sort
			);
			result['location_name'] = rc.location_name;
			result['success'] = true;
		}
		getFW().renderData( "json", result );
		return;
	}
	/**
	* Removes a location from a venue
	*/
	public void function removeLocation( rc ) {
		if( structKeyExists( rc, "location_id") && structKeyExists(rc, "venue_id") ){
			getVenuesManager().removeVenueLocation(
				location_id = rc.location_id,
				venue_id = rc.venue_id
			);
		}
		getFW().renderData( "json", {
			'success': true
		} );
		return;
	}
	/**
	* ajaxGetVenues
	* - This method will return the ajax JSON for event agenda list
	*/
	public void function ajaxGetVenues( rc ) {
		request.layout = false;

		rc['regions'] = getGeographyManager().getRegionsArray( country_code=rc.region_code );
		getFW().renderData( "json", {
			"regions": rc.regions
		} );
		return;
	}

}