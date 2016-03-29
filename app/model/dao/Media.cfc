/**
* I am the DAO for the Media object
* @file  /model/dao/Media.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {
	/*
	* Gets all oof the allowed Mimetypes
	*/
	public struct function MimetypesAllowedGet() {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "MimetypesAllowedGet"
		});
		sp.addProcResult( name="allowed", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Gets all of the allowed Mimetypes as a string
	*/
	public string function MimetypesAllowedList() {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "MimetypesAllowedList"
		});
		sp.addParam( type="out", dbvarname="@allowed", cfsqltype="cf_sql_varchar", variable="allowed" );
		result = sp.execute();
		return result.getProcOutVariables().allowed;
	}
	/**
	* Gets a Mimetype
	* @mimetype The mimetype that you want to get the id for
	*/
	public struct function MimetypeGet( required string mimetype ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "MimetypeGet"
		});
		sp.addParam( type="in", dbvarname="@mimetype", cfsqltype="cf_sql_varchar", maxlength=100, value=trim( arguments.mimetype ) );
		sp.addProcResult( name="mimetypes", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* Gets the Mimetype ID
	* @mimetype The mimetype that you want to get the id for
	*/
	public numeric function MimetypeGetID( required string mimetype ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "MimetypeGetID"
		});
		sp.addParam( type="in", dbvarname="@mimetype", cfsqltype="cf_sql_varchar", maxlength=100, value=trim( arguments.mimetype ) );
		sp.addParam( type="out", dbvarname="@mimetype_id", cfsqltype="cf_sql_integer", variable="mimetype_id" );
		result = sp.execute();
		return result.getProcOutVariables().mimetype_id;
	}
	/**
	* Gets a media element and its logs
	* @media_id The id of the media element
	*/
	public struct function MediaGet( required numeric media_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "MediaGet"
		});
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_integer", value=arguments.media_id );
		sp.addProcResult( name="detail", resultset=1 );
		sp.addProcResult( name="tags", resultset=2 );
		sp.addProcResult( name="logs", resultset=3 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Creates or Updates a Media Item and Returns the Media ID
	* @media_id The media id, if null it is added
	* @mimetype_id The mimetype of the media being added
	* @filename The name of the file
	* @thumbnail The name of the thumbnail
	* @filesize The size of the media in kilobytes
	* @label A friendly label for the media
	* @publish A date to publish the media on
	* @password An SHA-512 hashed password
	* @salt The salt used to generate the password hash
	* @downloadable Whether or not the media can be downloaded
	*/
	public numeric function MediaSet(
		numeric media_id=0,
		required numeric mimetype_id,
		required string filename,
		required string thumbnail,
		required numeric filesize,
		string label,
		date publish,
		date expire,
		string password,
		string salt,
		boolean downloadable
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "MediaSet"
		});

		sp.addParam( type="inout", dbvarname="@media_id", cfsqltype="cf_sql_integer", value=arguments.media_id, null=( !arguments.media_id ), variable="media_id" );
		sp.addParam( type="in", dbvarname="@mimetype_id", cfsqltype="cf_sql_integer", value=arguments.mimetype_id );
		sp.addParam( type="in", dbvarname="@filename", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.filename ) );
		sp.addParam( type="in", dbvarname="@thumbnail", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.thumbnail ) );
		sp.addParam( type="in", dbvarname="@filesize", cfsqltype="cf_sql_integer", value=arguments.filesize );
		if( structKeyExists(arguments, "label" ) ) {
			sp.addParam( type="in", dbvarname="@label", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.label ), null=( !len( trim(arguments.label) ) ) );
		}
		if( structKeyExists(arguments, "publish" ) ) {
			sp.addParam( type="in", dbvarname="@publish", cfsqltype="cf_sql_timestamp", value=arguments.publish, null=( !isDate( arguments.publish ) ) );
		}else{
			sp.addParam( type="in", dbvarname="@publish", cfsqltype="cf_sql_timestamp", value='', null=true );
		}

		if( structKeyExists(arguments, "expire" ) ) {
			sp.addParam( type="in", dbvarname="@expire", cfsqltype="cf_sql_timestamp", value=arguments.expire, null=( !isDate( arguments.expire ) ) );
		}else{
			sp.addParam( type="in", dbvarname="@expire", cfsqltype="cf_sql_timestamp", value='', null=true );
		}

		if( structKeyExists(arguments, "password" ) ) {
			sp.addParam( type="in", dbvarname="@password", cfsqltype="cf_sql_char", maxlength=128, value=arguments.password, null=( len(arguments.password) != 128) );
		}
		if( structKeyExists(arguments, "salt" ) ) {
			sp.addParam( type="in", dbvarname="@salt", cfsqltype="cf_sql_char", maxlength=24, value=arguments.salt, null=( len(arguments.salt) != 128) );
		}
		if( structKeyExists(arguments, "downloadable" ) ) {
			sp.addParam( type="in", dbvarname="@downloadable", cfsqltype="cf_sql_bit", value=int( arguments.downloadable == 1 ) );
		}
		result = sp.execute();
		return result.getProcOutVariables().media_id;
	}
	/**
	* Gets a all of the logs for a given media element
	* @media_id The id of the media element
	*/
	public struct function MediaLogsGet( required numeric media_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "MediaLogsGet"
		});
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_integer", value=arguments.media_id );
		sp.addProcResult( name="logs", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Adds a log entry for a Media
	* @media_id The id of the Media
	* @user_id The id of the user
	* @action The type of action being logged, this is a friendly short name
	* @message (optional) The message to log if any
	* @ip (optional) The IP Address to log
	*/
	public numeric function MediaLogSet(
		required numeric media_id,
		required numeric user_id,
		required string action,
		string message="",
		string ip=""
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "MediaLogSet"
		});
		trim_fields( arguments );
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_integer", value=arguments.media_id );
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		sp.addParam( type="in", dbvarname="@action", cfsqltype="cf_sql_varchar", maxlength=50, value=arguments.action );
		sp.addParam( type="in", dbvarname="@message", cfsqltype="cf_sql_varchar", maxlength=500, value=arguments.message, null=( !len( arguments.message ) ) );
		sp.addParam( type="in", dbvarname="@ip", cfsqltype="cf_sql_varchar", maxlength=40, value=arguments.ip, null=( !len( arguments.ip ) ) );
		sp.addParam( type="out", dbvarname="@log_id", cfsqltype="cf_sql_integer", variable="log_id" );
		result = sp.execute();
		return result.getProcOutVariables().log_id;
	}
	/*
	* Creates or Updates a Media Item and Returns the Media ID
	* Creates or Updates a Company Photo / Media Item and Returns the Media ID
	* @company_id The Company id
	* @media_id The media id, if null it is added
	* @mimetype_id The mimetype of the media being added
	* @filename The name of the file
	* @thumbnail The name of the thumbnail
	* @filesize The size of the media in kilobytes
	* @label A friendly label for the media
	* @publish A date to publish the media on
	* @expire A date to expire the media on
	* @password An SHA-512 hashed password
	* @salt The salt used to generate the password hash
	* @downloadable Whether or not the media can be downloaded
	*/
	public numeric function CompanyMediaSet(
		required numeric company_id,
		numeric media_id = 0,
		required numeric mimetype_id,
		required string filename,
		required string thumbnail,
		required numeric filesize,
		string label,
		date publish,
		string password,
		string salt,
		boolean downloadable
	) {
		var sp = new StoredProc();
		var result = {};
		var identity = 0;
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "CompanyMediaSet"
		});
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addParam( type="inout", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id, null=( !arguments.media_id ), variable="media_id" );
		sp.addParam( type="in", dbvarname="@mimetype_id", cfsqltype="cf_sql_integer", value=arguments.mimetype_id );
		sp.addParam( type="in", dbvarname="@filename", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.filename ) );
		sp.addParam( type="in", dbvarname="@thumbnail", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.thumbnail ) );
		sp.addParam( type="in", dbvarname="@filesize", cfsqltype="cf_sql_integer", value=arguments.filesize);
		if(structKeyExists(arguments, "label")){
			sp.addParam( type="in", dbvarname="@label", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.label ), null=( !len( trim(arguments.label) ) ) );
		}
		if(structKeyExists(arguments, "publish")){
			sp.addParam( type="in", dbvarname="@publish", cfsqltype="cf_sql_timestamp", value=arguments.publish);
		}
		if(structKeyExists(arguments, "expire")){
			sp.addParam( type="in", dbvarname="@expire", cfsqltype="cf_sql_timestamp", value=arguments.expire);
		}
		if(structKeyExists(arguments, "password")){
			sp.addParam( type="in", dbvarname="@password", cfsqltype="cf_sql_char", maxlength=128, value=arguments.password, null=( len(arguments.password) != 128) );
		}
		if(structKeyExists(arguments, "salt")){
			sp.addParam( type="in", dbvarname="@salt", cfsqltype="cf_sql_char", maxlength=24, value=arguments.salt, null=( len(arguments.salt) != 128) );
		}
		if(structKeyExists(arguments, "downloadable")){
			sp.addParam( type="in", dbvarname="@downloadable", cfsqltype="cf_sql_bit", value=int( arguments.downloadable ) );
		}
		result = sp.execute();
		return result.getProcOutVariables().media_id;
	}
	/*
	* Creates an Association Between a Media and an Company
	* @company_id The Company id
	* @media_id The media id
	*/
	public void function CompanyMediaAssociate( required numeric company_id, numeric media_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "CompanyMediaAssociate"
		});
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id );
		sp.execute();
		return;
	}
	/*
	* Removes an Association Between a Media and an Company
	* @company_id The Company id
	* @media_id The media id
	*/
	public void function CompanyMediaDisassociate( required numeric company_id, numeric media_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "CompanyMediaDisassociate"
		});
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id );
		sp.execute();
		return;
	}
	/*
	* Gets all of the media elements associated to a given company
	* @company_id The id of the company
	* @start The row to start on
	* @results The number of results to return
	* @sort_column The column to sort on.  Values can be: filename, label, filesize, uploaded, publish, expire
	* @sort_direction The direction to sort the results
	* @search A keyword to use to filter the results
	*/
	public struct function CompanyMediaList(
		required numeric company_id,
		numeric start=1,
		numeric results=10,
		string sort_column="uploaded",
		string sort_direction="ASC",
		string search=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CompanyMediaList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", value=arguments.sort_column, maxlength=50, null=( !len( arguments.sort_column ) ) );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", value=arguments.sort_direction, maxlength=4, null=( !len( arguments.sort_direction ) ) );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", value=arguments.search, maxlength=200, null=( !len( arguments.search ) ) );
		sp.addProcResult( name="listing", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}	/*
	* Creates or Updates a Media Item and Returns the Media ID
	* Creates or Updates a Event Photo / Media Item and Returns the Media ID
	* @event_id The Event id
	* @media_id The media id, if null it is added
	* @mimetype_id The mimetype of the media being added
	* @filename The name of the file
	* @thumbnail The name of the thumbnail
	* @filesize The size of the media in kilobytes
	* @label A friendly label for the media
	* @publish A date to publish the media on
	* @expire A date to publish the media on
	* @password An SHA-512 hashed password
	* @salt The salt used to generate the password hash
	* @downloadable Whether or not the media can be downloaded
	*/
	public numeric function EventMediaSet(
		required numeric event_id,
		numeric media_id = 0,
		required numeric mimetype_id,
		required string filename,
		required string thumbnail,
		required numeric filesize,
		string label,
		date publish,
		date expire,
		string password,
		string salt,
		boolean downloadable
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventMediaSet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="inout", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id, null=( !arguments.media_id ), variable="media_id" );
		sp.addParam( type="in", dbvarname="@mimetype_id", cfsqltype="cf_sql_integer", value=arguments.mimetype_id );
		sp.addParam( type="in", dbvarname="@filename", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.filename ) );
		sp.addParam( type="in", dbvarname="@thumbnail", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.thumbnail ) );
		sp.addParam( type="in", dbvarname="@filesize", cfsqltype="cf_sql_integer", value=arguments.filesize);
		if(structKeyExists(arguments, "label")){
			sp.addParam( type="in", dbvarname="@label", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.label ), null=( !len( trim(arguments.label) ) ) );
		}
		if(structKeyExists(arguments, "publish")){
			sp.addParam( type="in", dbvarname="@publish", cfsqltype="cf_sql_timestamp", value=arguments.publish);
		}
		if(structKeyExists(arguments, "expire")){
			sp.addParam( type="in", dbvarname="@expire", cfsqltype="cf_sql_timestamp", value=arguments.expire );
		}
		if(structKeyExists(arguments, "password")){
			sp.addParam( type="in", dbvarname="@password", cfsqltype="cf_sql_char", maxlength=128, value=arguments.password, null=( len(arguments.password) != 128) );
		}
		if(structKeyExists(arguments, "salt")){
			sp.addParam( type="in", dbvarname="@salt", cfsqltype="cf_sql_char", maxlength=24, value=arguments.salt, null=( len(arguments.salt) != 128) );
		}
		if(structKeyExists(arguments, "downloadable")){
			sp.addParam( type="in", dbvarname="@downloadable", cfsqltype="cf_sql_bit", value=int( arguments.downloadable ) );
		}
		result = sp.execute();
		return result.getProcOutVariables().media_id;
	}
	/*
	* Creates an Association Between a Media and an Event
	* @event_id The Event id
	* @media_id The media id
	*/
	public void function EventMediaAssociate( required numeric event_id, numeric media_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventMediaAssociate"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id );
		sp.execute();
		return;
	}
	/*
	* Removes an Association Between a Media and an Event
	* @event_id The Event id
	* @media_id The media id
	*/
	public void function EventMediaDisassociate( required numeric event_id, numeric media_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventMediaDisassociate"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id );
		sp.execute();
		return;
	}
	/*
	* Gets all of the Media for a Event
	* @event_id The company id
	*/
	public struct function EventMediaList( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventMediaList"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="listing", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Creates an Association Between a File and a session
	* @session_id The session id
	* @media_id The media id
	*/
	public void function SessionFileAssociate( required numeric session_id, numeric media_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SessionFileAssociate"
		});
		sp.addParam( type="in", dbvarname="@session_id", cfsqltype="cf_sql_integer", value=arguments.session_id );
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id );
		sp.execute();
		return;
	}
	/*
	* Removes an Association Between a File and a session
	* @session_id The Session id
	* @media_id The media id
	*/
	public void function SessionFileDisassociate( required numeric session_id, numeric media_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SessionFileDisassociate"
		});
		sp.addParam( type="in", dbvarname="@session_id", cfsqltype="cf_sql_integer", value=arguments.session_id );
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id );
		sp.execute();
		return;
	}
	/*
	* Creates an Association Between a Photo and a session
	* @session_id The session id
	* @media_id The media id
	*/
	public void function SessionPhotoAssociate( required numeric session_id, numeric media_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SessionPhotoAssociate"
		});
		sp.addParam( type="in", dbvarname="@session_id", cfsqltype="cf_sql_integer", value=arguments.session_id );
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id );
		sp.execute();
		return;
	}
	/*
	* Removes an Association Between a Photo and a session
	* @session_id The Session id
	* @media_id The media id
	*/
	public void function SessionPhotoDisassociate( required numeric session_id, numeric media_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SessionPhotoDisassociate"
		});
		sp.addParam( type="in", dbvarname="@session_id", cfsqltype="cf_sql_integer", value=arguments.session_id );
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id );
		sp.execute();
		return;
	}
	/*
	* Gets all of the Media for a Company
	* @company_id The company id
	*/
	public struct function CompanyAggregateMediaList( required numeric company_id, required numeric event_id, numeric start=1, numeric results=10 ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "CompanyAggregateMediaList"
		});

		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results );
		sp.addProcResult( name="listing", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I set media tags
	* @media_id The ID of the media that you want associated tags.
	* @tags comma-delim list of tags you want associated with the media
	*/
	public void function MediaTagsSet(required numeric media_id, required string tags){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "MediaTagsSet"
		});
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id );
		sp.addParam( type="in", dbvarname="@tags", cfsqltype="cf_sql_varchar", value=arguments.tags );
		result = sp.execute();
	}
	/*
	* Creates an Association Between a Photo and a Venue
	* @venue_id The Venue id
	* @media_id The media id
	*/
	public void function VenuePhotoAssociate( required numeric venue_id, numeric media_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenuePhotoAssociate"
		});
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id );
		sp.execute();
		return;
	}
	/*
	* Removes an Association Between a Photo and a Venue
	* @venue_id The Venue id
	* @media_id The media id
	*/
	public void function VenuePhotoDisassociate( required numeric venue_id, numeric media_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenuePhotoDisassociate"
		});
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id );
		sp.execute();
		return;
	}

	/*
	* Creates an Association Between a Media and an Page
	* @page_id The Page id
	* @media_id The media id
	*/
	public void function PageMediaAssociate( required numeric page_id, required numeric media_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PageMediaAssociate"
		});
		sp.addParam( type="in", dbvarname="@page_id", cfsqltype="cf_sql_integer", value=arguments.page_id );
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id );
		result = sp.execute();
		return;
	}
	/*
	* Removes an Association Between a Media and an Page
	* @page_id The Page id
	* @media_id The media id
	*/
	public void function PageMediaDisassociate( required numeric page_id, required numeric media_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PageMediaDisassociate"
		});
		sp.addParam( type="in", dbvarname="@page_id", cfsqltype="cf_sql_integer", value=arguments.page_id );
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id );
		result = sp.execute();
		return;
	}
}