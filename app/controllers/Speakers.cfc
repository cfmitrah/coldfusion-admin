component extends="$base" accessors="true" {
	property name="speakersManager" setter="true" getter="true";
	property name="mediaManager" setter="true" getter="true";

	public void function before( rc ) {
		if( !getCurrentEventID() ){
			redirect("event.select");
		}
		rc.sidebar = "sidebar.event.details";
		rc.event_id = getCurrentEventID();
		super.before( rc );
		return;
	}
	/**
	* I am the event speakers listing
	*/
	public void function default( rc ) {
		var listing_config = {
			"table_id": "speakers_listing",
			"ajax_source": "speakers.listing?event_id=" & getSessionManageUserFacade().getValue( "current_event_id" ),
			"columns": "first_name,last_name,display_name,title,company,options",
			"aoColumns": [
				{
					"data": "first_name",
					"sTitle": "First Name"
				},
				{
					"data": "last_name",
					"sTitle": "Last Name"
				},
				{
					"data": "display_name",
					"sTitle": "Display Name"
				},
				{
					"data": "title",
					"sTitle": "Title"
				},
				{
					"data": "company",
					"sTitle": "Company"
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
			'start' = 0,
			'length' = 10,
			'SEARCH[VALUE]' = "",
			'ORDER[0][COLUMN]' = "0",
			'ORDER[0][DIR]' = "ASC"
		};
		var data = {};
		var columns = [ "first_name", "last_name", "display_name", "title", "company" ];
		structAppend(params, rc);
		params['results'] = params.length;
		params['sort_column'] = columns[ params['ORDER[0][COLUMN]'] + 1 ];
		params['sort_direction'] = params['ORDER[0][DIR]'];
		params['search'] = params['SEARCH[VALUE]'];
		data = getSpeakersManager().getEventSpeakers( argumentCollection = params );
		data['cnt'] = arrayLen(data.data);
		for( var i = 1; i <= data.cnt; i++ ) {
			data['data'][i]['options'] = "<a href=""" & buildURL("speakers.details?speaker_id=" & data.data[i].speaker_id ) & """ class=""btn btn-sm btn-primary"">Manage</a>";
		}
		getFW().renderData( "json", data );
		return;
	}
	/**
	* I render the new Speaker form
	*/
	public void function create( rc ) {
		getCfStatic()
			.include("/js/pages/speakers/create.js");
		return;
	}
	/**
	* I create a new Speaker
	*/
	public void function doCreate( rc ) {
		if( structKeyExists( rc, "speaker") && isStruct( rc.speaker ) ){
			rc['speaker']['event_id'] = getCurrentEventID();
			rc['speaker_id'] = getSpeakersManager().save( argumentCollection=rc.speaker );
			if( val( rc.speaker_id ) ){
				redirect( action="speakers.details", queryString="speaker_id=" & rc.speaker_id );
			}
		}
		redirect("speakers.default");
		return;
	}
	/**
	* I am the Speaker details for a given Speaker
	*/
	public void function details( rc ) {
		var event_id = getSessionManageUserFacade().getValue( "current_event_id" );
		var speaker_id = ( structKeyExists( rc, "speaker_id" ) ? rc.speaker_id : 0 );
		if( !structKeyExists( rc, "speaker" ) ) {
			rc['speaker'] = {};
		}
		structAppend(rc.speaker, getSpeakersManager().getSpeakerDetails( speaker_id = speaker_id ), false );
		// make sure records were found
		if( !rc.speaker.success ) {
			redirect("speakers.default");
		}
		rc['sessions'] = getFW().getBeanFactory().getBean("SessionsManager").getSessions( event_id = event_id );
		rc['session_cnt'] = arrayLen( rc.sessions );
		getCfStatic()
			.include("/js/pages/speakers/create.js")
			.include("/js/pages/speakers/details.js");
		return;
	}
	/**
	* I save a Speaker
	*/
	public void function doSave( rc ) {
		if( structKeyExists( rc, "speaker") && isStruct( rc.speaker ) && structKeyExists( rc.speaker, "speaker_id") ) {
			// get the current working event id
			rc['speaker']['event_id'] = getCurrentEventID();
			// save the speaker
			rc['speaker_id'] = getSpeakersManager().save( argumentCollection=rc.speaker );
			// save the tags
			getSpeakersManager().setSpeakerTags( speaker_id = rc.speaker_id, tags=rc.speaker.tags );
			// check to see if a photo was uploaded
			if( structKeyExists( rc.speaker, "photo" ) && len( rc.speaker.photo ) ) {
				getSpeakersManager().addPhoto( argumentCollection=rc.speaker );
			}
			if( val( rc.speaker_id ) ) {
				redirect( action="speakers.details", queryString="speaker_id=" & rc.speaker_id );
			}
		}
		return;
	}
	/**
	* I add a speaker to a session
	*/
	public void function addToSession( rc ) {
		var event_id = getSessionManageUserFacade().getValue( "current_event_id" );
		var speaker_params = {};

		if( structKeyExists( rc, "speaker_id" ) && structKeyExists( rc, "session_id" ) ){
			getSpeakersManager().addSessionSpeaker(
				session_id = rc.session_id,
				speaker_id = rc.speaker_id
			);

			speakers_params = getSpeakersManager().getSessionSpeakersParams(
				session_id : rc.session_id,
				event_id : event_id
			);
		}

		getFW().renderData( "json", {
			'success': true,
			'speakers_params': speakers_params
		} );
		return;
	}
	/**
	* I remove a speaker from a session
	*/
	public void function removeFromSession( rc ) {
		var event_id = getSessionManageUserFacade().getValue( "current_event_id" );
		var speaker_params = {};

		if( structKeyExists( rc, "speaker_id") && structKeyExists(rc, "session_id") ){
			getSpeakersManager().removeSessionSpeaker(
				session_id = rc.session_id,
				speaker_id = rc.speaker_id
			);

			speakers_params = getSpeakersManager().getSessionSpeakersParams(
				session_id : rc.session_id,
				event_id : event_id
			);
		}
		getFW().renderData( "json", {
			'success': true,
			'speakers_params': speakers_params
		} );
		return;
	}
	/**
	* I remove a speaker from a session
	*/
	public void function removePhoto( rc ) {
		if( structKeyExists( rc, "speaker_id") ){
			getSpeakersManager().removePhoto(
				speaker_id = rc.speaker_id
			);
		}
		getFW().renderData( "json", {
			'success': true
		} );
		return;
	}
}