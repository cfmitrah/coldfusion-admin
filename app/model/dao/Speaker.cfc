/**
* I am the DAO for the Speaker object
* @file  /model/dao/Speaker.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/**
	* Gets a all of the logs for a given Speaker element
	* @speaker_id The id of the Speaker element
	*/
	public struct function SpeakerLogsGet( required numeric speaker_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SpeakerLogsGet"
		});
		sp.addParam( type="in", dbvarname="@speaker_id", cfsqltype="cf_sql_integer", value=arguments.speaker_id );
		sp.addProcResult( name="logs", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Adds a log entry for a Speaker
	* @speaker_id The id of the Speaker
	* @user_id The id of the user
	* @action The type of action being logged, this is a friendly short name
	* @message (optional) The message to log if any
	* @ip (optional) The IP Address to log
	*/
	public numeric function SpeakerLogSet(required numeric speaker_id, required numeric user_id, required string action, required string message, string ip
	) {
		var sp = new StoredProc();
		var result = {};
		var identity = 0;
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SpeakerLogSet"
		});
		sp.addParam( type="in", dbvarname="@speaker_id", cfsqltype="cf_sql_integer", value=arguments.speaker_id );
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		sp.addParam( type="in", dbvarname="@action", cfsqltype="cf_sql_varchar", maxlength=50, value=arguments.action );
		sp.addParam( type="in", dbvarname="@message", cfsqltype="cf_sql_varchar", maxlength=500, value=arguments.message );
		if(structKeyExists(arguments, "ip")){
			sp.addParam( type="in", dbvarname="@ip", cfsqltype="cf_sql_varchar", maxlength=40, value=arguments.ip );
		}
		sp.addParam( type="out", dbvarname="@log_id", cfsqltype="cf_sql_integer", variable="identity" );
		result = sp.execute();
		return identity;
	}
	/**
	* I check to see if an Speaker slug exists for an event
	* @event_id The ID of the event that you are checking the Speaker slug for
	* @slug The slug that you are checking
	*/
	public boolean function SpeakerSlugExists( required numeric event_id, required string slug ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SpeakerSlugExists"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", maxlength=300, value=trim( arguments.slug ) );
		sp.addParam( type="out", dbvarname="@in_use", cfsqltype="cf_sql_bit", variable="exists" );
		result = sp.execute();
		return result.getProcOutVariables().exists;
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
	public boolean function SpeakerSet(
		numeric speaker_id=0,
		required numeric event_id,
		required string first_name,
		required string last_name,
		required string display_name,
		required string slug,
		string title="",
		string company="",
		string summary="",
		string bio="",
		string email=""
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SpeakerSet"
		});
		sp.addParam( type="inout", dbvarname="@speaker_id", cfsqltype="cf_sql_integer", value=arguments.speaker_id, null=( !arguments.speaker_id ), variable="speaker_id" );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@first_name", cfsqltype="cf_sql_varchar", maxlength=100, value=trim( arguments.first_name ) );
		sp.addParam( type="in", dbvarname="@last_name", cfsqltype="cf_sql_varchar", maxlength=100, value=trim( arguments.last_name ) );
		sp.addParam( type="in", dbvarname="@display_name", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.display_name ) );
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", maxlength=300, value=trim( arguments.slug ) );
		sp.addParam( type="in", dbvarname="@title", cfsqltype="cf_sql_varchar", maxlength=150, value=trim( arguments.title ), null=( !len( trim( arguments.title ) ) ) );
		sp.addParam( type="in", dbvarname="@company", cfsqltype="cf_sql_varchar", maxlength=150, value=trim( arguments.company ), null=( !len( trim( arguments.company ) ) ) );
		sp.addParam( type="in", dbvarname="@summary", cfsqltype="cf_sql_varchar", maxlength=1000, value=trim( arguments.summary ), null=( !len( trim( arguments.summary ) ) ) );
		sp.addParam( type="in", dbvarname="@bio", cfsqltype="cf_sql_varchar", value=trim( arguments.bio ), null=( !len( trim( arguments.bio ) ) ) );
		sp.addParam( type="in", dbvarname="@email", cfsqltype="cf_sql_varchar", maxlength=300, value=trim( arguments.email ), null=( !len( trim( arguments.email ) ) ) );
		result = sp.execute();
		return result.getProcOutVariables().speaker_id;
	}
	/**
	* I get all of a Speaker's details, speakers, tags, files, photos and logs
	* @speaker_id The Speaker ID of the Speaker that you want to get details on.
	*/
	public struct function SpeakerGet( required numeric speaker_id ) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SpeakerGet"
		});
		sp.addParam( type="inout", dbvarname="@speaker_id", cfsqltype="cf_sql_integer", value=arguments.speaker_id, variable="speaker_id" );
		sp.addParam( type="out", dbvarname="@event_id", cfsqltype="cf_sql_integer", variable="event_id" );
		sp.addParam( type="out", dbvarname="@first_name", cfsqltype="cf_sql_varchar", variable="first_name" );
		sp.addParam( type="out", dbvarname="@last_name", cfsqltype="cf_sql_varchar", variable="last_name" );
		sp.addParam( type="out", dbvarname="@display_name", cfsqltype="cf_sql_varchar", variable="display_name" );
		sp.addParam( type="out", dbvarname="@title", cfsqltype="cf_sql_varchar", variable="title" );
		sp.addParam( type="out", dbvarname="@company", cfsqltype="cf_sql_varchar", variable="company" );
		sp.addParam( type="out", dbvarname="@summary", cfsqltype="cf_sql_varchar", variable="summary" );
		sp.addParam( type="out", dbvarname="@bio", cfsqltype="cf_sql_varchar", variable="bio" );
		sp.addParam( type="out", dbvarname="@slug_id", cfsqltype="cf_sql_integer", variable="slug_id" );
		sp.addParam( type="out", dbvarname="@slug", cfsqltype="cf_sql_varchar", variable="slug" );
		sp.addParam( type="out", dbvarname="@has_email", cfsqltype="cf_sql_bit", variable="has_email" );
		sp.addParam( type="out", dbvarname="@email_id", cfsqltype="cf_sql_integer", variable="email_id" );
		sp.addParam( type="out", dbvarname="@email", cfsqltype="cf_sql_varchar", variable="email" );
		sp.addParam( type="out", dbvarname="@has_photo", cfsqltype="cf_sql_bit", variable="has_photo" );
		sp.addParam( type="out", dbvarname="@media_id", cfsqltype="cf_sql_bigint", variable="media_id" );
		sp.addParam( type="out", dbvarname="@filename", cfsqltype="cf_sql_varchar", variable="filename" );
		sp.addParam( type="out", dbvarname="@thumbnail", cfsqltype="cf_sql_varchar", variable="thumbnail" );
		sp.addParam( type="out", dbvarname="@label", cfsqltype="cf_sql_varchar", variable="label" );
		sp.addParam( type="out", dbvarname="@filesize", cfsqltype="cf_sql_varchar", variable="filesize" );
		sp.addParam( type="out", dbvarname="@uploaded", cfsqltype="cf_sql_date", variable="uploaded" );
		sp.addProcResult( name="tags", resultset=1 );
		sp.addProcResult( name="sessions", resultset=2 );
		sp.addProcResult( name="logs", resultset=3 );
		result = sp.execute();data['prefix'] = result.getPrefix();
        structAppend( data, result.getProcOutVariables() );
        structAppend( data, result.getProcResultSets() );
		return data;
	}
	/**
	* I get event tags
	* @speaker_id The ID of the speaker that you want associated tags.
	*/
	public struct function SpeakerTagsGet(required numeric speaker_id){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SpeakerTagsGet"
		});
		sp.addParam( type="in", dbvarname="@speaker_id", cfsqltype="cf_sql_integer", value=arguments.speaker_id );
		sp.addProcResult( name="tags", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I set event tags
	* @speaker_id The ID of the speaker that you want associated tags.
	* @tags comma-delim list of tags you want associated with the speaker
	*/
	public void function SpeakerTagsSet(required numeric speaker_id, required string tags){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SpeakerTagsSet"
		});
		sp.addParam( type="in", dbvarname="@speaker_id", cfsqltype="cf_sql_integer", value=arguments.speaker_id );
		sp.addParam( type="in", dbvarname="@tags", cfsqltype="cf_sql_varchar", value=arguments.tags );
		//sp.addProcResult( name="event_tags", resultset=1 );
		result = sp.execute();
	}
	/**
	* I get the the id of a speaker based on a slug
	* @event_id The ID of the event that you are checking the Speaker slug for
	* @slug The slug that you are checking
	*/
	public numeric function SpeakerIdBySlugGet( required numeric event_id, required string slug ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SpeakerIdBySlugGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", maxlength=300, value=trim( arguments.slug ) );
		sp.addParam( type="out", dbvarname="@speaker_id", cfsqltype="cf_sql_bit", variable="speaker_id" );
		result = sp.execute();
		return result.getProcOutVariables().speaker_id;
	}
	/**
	* I get all of a Speaker's details, speakers, tags, files, photos and logs from a slug
	* @speaker_id The Speaker ID of the Speaker that you want to get details on.
	*/
	public struct function SpeakerBySlugGet( required numeric event_id, required string slug ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SpeakerBySlugGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", maxlength=300, value=trim( arguments.slug ) );
		sp.addProcResult( name="details", resultset=1 );
		sp.addProcResult( name="tags", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Creates an Association Between a Speaker and an Event Session
	* @session_id The session id
	* @speaker_id The speaker id
	* @sort The order in which to display the speaker for the session
	*/
	public void function SessionSpeakerAdd( required numeric session_id, required numeric speaker_id, numeric sort=0 ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SessionSpeakerAdd"
		});
		sp.addParam( type="in", dbvarname="@session_id", cfsqltype="cf_sql_integer", value=arguments.session_id );
		sp.addParam( type="in", dbvarname="@speaker_id", cfsqltype="cf_sql_integer", value=arguments.speaker_id );
		sp.execute();
		return;
	}
	/*
	* Removes an Association Between a Media and an Event
	* @session_id The session id
	* @speaker_id The speaker id
	*/
	public void function SessionSpeakerRemove( required numeric session_id, required numeric speaker_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SessionSpeakerRemove"
		});
		sp.addParam( type="in", dbvarname="@session_id", cfsqltype="cf_sql_integer", value=arguments.session_id );
		sp.addParam( type="in", dbvarname="@speaker_id", cfsqltype="cf_sql_integer", value=arguments.speaker_id );
		sp.execute();
		return;
	}
	/**
	* I get all of the speakers for a session
	* @session_id
	*/
	public struct function SessionSpeakersGet( required numeric session_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SessionSpeakersGet"
		});
		sp.addParam( type="in", dbvarname="@session_id", cfsqltype="cf_sql_integer", value=arguments.session_id );
		sp.addProcResult( name="speakers", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I get all of the sessions for a Speaker
	* @speaker_id
	*/
	public struct function SpeakerSessionsGet( required numeric speaker_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SpeakerSessionsGet"
		});
		sp.addParam( type="in", dbvarname="@speaker_id", cfsqltype="cf_sql_integer", value=arguments.speaker_id );
		sp.addProcResult( name="sessions", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I get all of the speakers for an Event
	* @event_id
	*/
	public struct function EventSpeakersGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventSpeakersGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="speakers", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I get all of the speakers for an event, with paging and basic searching / sorting
	* @speaker_id
	* @start
	* @results
	* @sort_column
	* @sort_direction
	* @search
	*/
	public struct function SpeakersList(
		required numeric event_id,
		required numeric start=1,
		required numeric results=1,
		required string sort_column='first_name',
		required string sort_direction='ASC',
		string search="" ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SpeakersList"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", maxlength=50, value=arguments.sort_column );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", maxlength=4, value=arguments.sort_direction );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", maxlength=200, value=arguments.search, null=( !len(arguments.search) ) );
		sp.addProcResult( name="speakers", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Creates an Association Between a Speaker and an Photo Session
	* @speaker_id The speaker id
	* @media_id The id of the media
	*/
	public void function SpeakerPhotoSet( required numeric speaker_id, required numeric media_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SpeakerPhotoSet"
		});
		sp.addParam( type="in", dbvarname="@speaker_id", cfsqltype="cf_sql_integer", value=arguments.speaker_id );
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id );
		sp.execute();
		return;
	}
	/*
	* Removes an Association Between a Media and an Speaker
	* @speaker_id The speaker id
	*/
	public void function SpeakerPhotoRemove( required numeric speaker_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SpeakerPhotoRemove"
		});
		sp.addParam( type="in", dbvarname="@speaker_id", cfsqltype="cf_sql_integer", value=arguments.speaker_id );
		sp.execute();
		return;
	}
}