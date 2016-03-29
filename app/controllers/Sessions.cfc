
component extends="$base" accessors="true"
{
	property name="venuesManager" setter="true" getter="true";
	property name="sessionsManager" setter="true" getter="true";
	property name="sessionAgendaManager" setter="true" getter="true";
	property name="mediaManager" setter="true" getter="true";
	property name="eventsManager" setter="true" getter="true";
	property name="SpeakersManager" setter="true" getter="true";

	public void function before( rc ) {
		if( !getCurrentEventID() ){
			redirect('event.select');
		}
		rc.event_id = getCurrentEventID();
		rc.sidebar = "sidebar.event.details";
		super.before( rc );
		return;
	}

	/**
	* I am the event session listing
	*/
	public void function default( rc ) {
		var listing_config = {
		    "table_id":"event_listing"
		    ,"ajax_source":"sessions.ajaxListing"
		    ,"columns":"ID,Title,Category,Summary,Options"
		    ,"aoColumns":[
		            {"data":"session_id"}
		            ,{"data":"title"}
		            ,{"data":"category"}
		            ,{"data":"summary"}
		            ,{"data":"options"}
		    ]
		};
		rc['table_id'] = listing_config.table_id;
		listing_config['ajax_source'] = buildURL( (structKeyExists(listing_config,'ajax_source') ? listing_config.ajax_source: '') );
		rc['columns'] = listing_config.columns;

		getCfStatic().includeData( listing_config ).include("/js/pages/common/listing.js").include("/css/pages/common/listing.css");

		return;
	}
	/**
	* I am the session details for a given session
	*/
	public void function details( rc ) {
		var event_id = getSessionManageUserFacade().getValue( "current_event_id" );
		var session_id = ( structKeyExists( rc, "session_id" ) ? rc.session_id : 0 );
		var photos_listing_config = {
		    "table_id":"photos_listing"
		    ,"ajax_source":"sessions.ajaxPhotoListing"
		    ,"columns":"Label,File Name,File Size,Tags,Options"
		    ,"aoColumns":[
		            {"data":"label","bSortable":false}
		            ,{"data":"filename","bSortable":false}
		            ,{"data":"filesize","bSortable":false}
		            ,{"data":"tags","bSortable":false}
		            ,{"data":"options","bSortable":false}
		    ]
		};
		var files_listing_config = {
		    "table_id":"files_listing"
		    ,"ajax_source":"sessions.ajaxFilesListing"
		    ,"columns":"Preview,Label,File Type,Date Uploaded,Options"
		    ,"aoColumns":[
		            {"data":"filename","bSortable":false}
		            ,{"data":"label","bSortable":false}
		            ,{"data":"mimetype","bSortable":false}
		            ,{"data":"uploaded","bSortable":false}
		            ,{"data":"options","bSortable":false}
		    ]
		};
		var data = {
			"files_listing_config":files_listing_config,
			"photos_listing_config":photos_listing_config,
			"mediaListUrl":buildURL('media.ajaxCompanyListing'),
			"mediaSaveUrl":buildURL('media.ajaxsave'),
			"mediaGetUrl":buildURL('media.ajaxget'),
			"categories": getEventsManager().getEventCategories( argumentCollection=rc )
		};

		var speakers_params = getSpeakersManager().getSessionSpeakersParams( argumentCollection = {session_id : session_id, event_id : event_id});

		rc['event_speakers'] = speakers_params.missing;
		rc['event_speakers_cnt'] = arrayLen( rc.event_speakers );
		rc["venues"] = getVenuesManager().getVenueList( start=1, results=100, sort_column="venue_name", sort_direction="ASC", company_id=getCurrentCompanyID() );
		rc["session_details"] = getsessionsManager().getSessionDetails( session_id ).result;
		rc["agenda"] = getSessionAgendaManager().getAgenda( session_id );
		/* photos */
		rc['photos_table_id'] = photos_listing_config.table_id;
		photos_listing_config['ajax_source'] = buildURL( action=(structKeyExists(photos_listing_config,'ajax_source') ? photos_listing_config.ajax_source: ''),querystring="session_id="&rc.session_id );
		rc['photos_columns'] = photos_listing_config.columns;
		/* End photos */

		/* Files */
		rc['files_table_id'] = files_listing_config.table_id;
		files_listing_config['ajax_source'] = buildURL( action=(structKeyExists(files_listing_config,'ajax_source') ? files_listing_config.ajax_source: ''),querystring="session_id="&rc.session_id );
		rc['files_columns'] = files_listing_config.columns;
		/* End Files */

		getCfStatic()
			.includeData( data )
			.include("/js/pages/sessions/details.js")
			.include( "/css/pages/common/listing.css" )
			.include( "/css/plugins/date-timepicker/date-timepicker.css" )
			.include( "/css/pages/common/media.css" );
		return;
	}
	/**
	* I render the new session form
	*/
	public void function create( rc ) {
		getCfStatic()
			.include("/js/pages/sessions/create.js");
		return;
	}
	/**
	* I save a session
	*/
	public void function doSave( rc ) {

		if( structKeyExists( rc, "event_session") && isStruct( rc.event_session ) && structKeyExists( rc.event_session, "session_id")){
			rc["event_session"]["event_id"] = getCurrentEventID();
			rc.session_id = getSessionsManager().save( argumentCollection=rc.event_session );
			if( val( rc.session_id ) gt 0 ){
				addSuccessAlert( 'The session was successfully saved.' );
				redirect( action="sessions.details", queryString="session_id=" & rc.session_id );
			}
		}
		return;
	}
	/**
	* I create a new session
	*/
	public void function doCreate( rc ) {
		if( structKeyExists( rc, "event_session") && isStruct( rc.event_session ) ){
			rc["event_session"]["event_id"] = getCurrentEventID();
			rc.session_id = getSessionsManager().save( argumentCollection=rc.event_session );
			if( val( rc.session_id ) gt 0 ){
				addSuccessAlert( 'The session was successfully created.' );
				redirect( action="sessions.details", queryString="session_id=" & rc.session_id );
			}
		}
		redirect("event.sessions");
		return;
	}
	/**
	* I am the ajax call to get the session listings for an event
	*/
	public void function ajaxListing( rc ) {
		var params = {
			"order_index"=( structKeyExists( rc, 'order[0][column]') ? rc['order[0][column]']:0)
			, "order_dir"=( structKeyExists( rc, 'order[0][dir]') ? rc['order[0][dir]']:"ASC")
			, "search_value"=( structKeyExists( rc, 'search[value]') ? rc['search[value]']:"")
			, "start_row"=( structKeyExists( rc, 'start') ? rc.start:0)
			, "total_rows"=( structKeyExists( rc, 'length') ? rc.length:0)
			, "draw"=( structKeyExists( rc, 'draw') ? rc.draw:0)
			, "event_id"=getCurrentEventID()
		};
		var event_list = getSessionsManager().getListing( argumentCollection=params );

		getFW().renderData( 'json', event_list);
		request.layout = false;
		return;

	}
	/**
	* I am the ajax call to get the session photo listings for a session
	*/
	public void function ajaxPhotoListing( rc ) {
		var session_id = ( structKeyExists( rc, "session_id" ) ? rc.session_id : 0 );
		var params = {
			"draw"=( structKeyExists( rc, 'draw') ? rc.draw:0)
			, "session_id"=session_id
		};
		var session_photo_list = getsessionsManager().getPhotosListing( argumentCollection:params );

		getFW().renderData( 'json', session_photo_list);
		request.layout = false;
		return;

	}
	/**
	* I am the ajax call to get the session file listings for a session
	*/
	public void function ajaxFilesListing( rc ) {
		var session_id = ( structKeyExists( rc, "session_id" ) ? rc.session_id : 0 );
		var params = {
			"draw"=( structKeyExists( rc, 'draw') ? rc.draw:0)
			, "session_id"=session_id
		};
		var session_file_list = getsessionsManager().getFilesListing( argumentCollection:params );

		getFW().renderData( 'json', session_file_list);
		request.layout = false;
		return;

	}



}