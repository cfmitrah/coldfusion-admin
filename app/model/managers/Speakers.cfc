/**
*
* @file  /model/managers/Speakers.cfc
* @author
* @description
*
*/
component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="speakerDao" getter="true" setter="true";
	property name="slugManager" getter="true" setter="true";
	property name="mediaManager" getter="true" setter="true";
	property name="sessionsManager" getter="true" setter="true";
	/**
	* I get all of the Speakers for an event
	*/
	public struct function getEventSpeakers(
		required numeric event_id=0,
		start = 0
		results = 10,
		sort_column = "display_name",
		sort_direction = "ASC",
		numeric draw = 1
	 ) {
		var event_speakers = getSpeakerDao().SpeakersList( argumentCollection=arguments ).result.speakers;
		return {
			"draw": arguments.draw,
			"recordsTotal": isDefined("event_speakers.total") ? event_speakers.total : event_speakers.recordCount,
			"iTotalRecords": isDefined("event_speakers.total") ? event_speakers.total : event_speakers.recordCount,
			"iTotalDisplayRecords": event_speakers.recordCount,
			"recordsFiltered": 0,
			"data": queryToArray(event_speakers)
		};
	}

	/**
	* Get a list of an event's speakers that are not related to the entered session.
	*/
	public struct function getSessionSpeakersParams (
		required numeric session_id,
		required numeric event_id
	) {
		var event_speakers = getSpeakerDao().SpeakersList( argumentCollection={event_id:event_id, results: 100} ).result.speakers;
		event_speakers = queryToArray(event_speakers);

		var session_speakers = getSessionsManager().getSessionDetails(session_id).result.speakers;
		session_speakers = queryToArray(session_speakers);

		var missing_speakers = [];

		for (idx = 1; idx lte arrayLen(event_speakers); idx = idx +1) {
			var event_speaker = event_speakers[idx];
			var in_session = false;
			for (idx2 = 1; idx2 lte arrayLen(session_speakers); idx2 = idx2 +1) {
				var session_speaker = session_speakers[idx2];
				if (event_speaker.speaker_id == session_speaker.speaker_id) {
					in_session = true;
				}
			}

			if (!in_session) {
				missing_speakers[arrayLen(missing_speakers) + 1] = event_speaker;
			}
		}

		return {
			"available" : event_speakers,
			"related" : session_speakers,
			"missing" : missing_speakers
		};
	}

	/**
	* I save a Speaker
	* @speaker_id The Speaker id
	* @event_id The event id of the Speaker
	* @first_name The first name of the speaker
	* @last_name The last name of the speaker
	* @display_name The display name of the speaker
	* @slug A slug for the speaker (should be firstname + '-' + lastname
	* @title (optional) The job title of the speaker
	* @company (optional) The company that the speaker works for
	* @summary (optional) A summary description for the speaker
	* @bio (optional) A biography of the speaker
	* @email (optional) An email address for the speaker
	* @photo (optional) A media_id of a photo of the speaker
	*/
	public any function save(
		numeric speaker_id=0,
		required numeric event_id,
		required string first_name,
		required string last_name,
		required string display_name,
		string title="",
		string company="",
		string summary="",
		string bio="",
		string email=""
	) {
		// generate a slug based on the display name
		arguments['slug'] = getSlugManager().generate( arguments.display_name );
		// check to see if the slug already exists, if it does it should be an error
		if( !getSpeakerDao().SpeakerSlugExists( arguments.event_id, arguments.slug ) ){
			getSlugManager().save( arguments.slug );
		}
		// save the speaker
		return getSpeakerDao().SpeakerSet( argumentCollection=arguments );
	}
	/**
	* I save a Speaker
	* @speaker_id The Speaker id
	*/
	public struct function addPhoto( required numeric speaker_id ) {
		var photo = {};
		// upload the file
		photo = getMediaManager().upload( field_name="speaker.photo" );
		// save the media
		photo['media_id'] = getMediaManager().save( argumentCollection=photo );
		// associate the photo to the speaker
		getSpeakerDao().SpeakerPhotoSet( speaker_id=arguments.speaker_id, media_id=photo.media_id );
		// save the speaker
		return photo;
	}
	/**
	* I add remove a photo from a speaker
	* @speaker_id The Speaker ID of the Speaker to remove the photo from
	*/
	public void function removePhoto( required numeric speaker_id ) {
		getSpeakerDao().SpeakerPhotoRemove( argumentCollection=arguments );
		return;
	}
	/**
	* I get all of a Speaker's details, speakers, tags, files, photos and logs
	* @speaker_id The Speaker ID of the Speaker that you want to get detals on.
	*/
	public struct function getSpeakerDetails( required numeric speaker_id ) {
		var speaker = getSpeakerDao().SpeakerGet( arguments.speaker_id );
		var buffer = "";
		// tags
		speaker['tags'] = queryToArray( recordset=speaker.tags );
		speaker['tag_cnt'] = arrayLen(speaker.tags);
		speaker['tag_list'] = "";
		if( speaker.tag_cnt ) {
			buffer = createObject( "java", "java.lang.StringBuffer" );
			// loop over all the tags and create a list
			for( var i = 1; i <= speaker.tag_cnt; i++ ) {
				buffer.append(speaker.tags[i].tag).append(", ");
			}
			if( buffer.length() ) {
				buffer.setLength( javaCast( "int", buffer.length() - 2 ) );
				speaker['tag_list'] = buffer.toString();
				buffer.setLength( javaCast( "int", 0 ) );
			}
		}
		// sessions
		speaker['sessions'] = queryToArray( recordset=speaker.sessions );
		speaker['session_cnt'] = arrayLen(speaker.sessions);
		// logs
		speaker['logs'] = queryToArray( recordset=speaker.logs );
		speaker['log_cnt'] = arrayLen(speaker.logs);
		speaker['success'] = speaker.speaker_id ? true : false;
		return speaker;
	}
	/**
	* I add a tags to a speaker
	* @speaker_id The Speaker ID of the Speaker to add
	* @tags A list of tags
	*/
	public void function setSpeakerTags( required numeric speaker_id, string tags="" ) {
		getSpeakerDao().SpeakerTagsSet( argumentCollection = arguments );
		return;
	}
	/**
	* Get all Speakers for an event
	* @event_id The Event ID of the to get the Sessions for
	*/
	public array function getSpeakers( required numeric event_id ) {
		var data = getSpeakerDao().EventSpeakersGet( event_id = arguments.event_id );
		return queryToArray( recordset = data.result.sessions );
	}
	/**
	* I add a speaker to a session
	* @session_id The Session ID to add the Speaker to
	* @speaker_id The Speaker ID of the Speaker to add
	*/
	public void function addSessionSpeaker( required numeric session_id, required numeric speaker_id ) {
		getSpeakerDao().SessionSpeakerAdd( argumentCollection = arguments );
		return;
	}
	/**
	* I add remove a speaker from a session
	* @session_id The Session ID to remove the Speaker to
	* @speaker_id The Speaker ID of the Speaker to remove
	*/
	public void function removeSessionSpeaker( required numeric session_id, required numeric speaker_id ) {
		getSpeakerDao().SessionSpeakerRemove( argumentCollection = arguments );
		return;
	}
}