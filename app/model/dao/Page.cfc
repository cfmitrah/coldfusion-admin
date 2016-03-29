/**
* I am the DAO for the Speaker object
* @file  /model/dao/Speaker.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {
	/*
	* Creates a Page and Returns the Page ID
	* @title The title of the Page
	* @slug The slug for the Page
	*/
	public numeric function PageCreate( required numeric event_id, required string title, required string slug ) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PageCreate"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@title", cfsqltype="cf_sql_varchar", value=arguments.title, maxlength=150 );
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", value=arguments.slug, maxlength=300 );
		sp.addParam( type="out", dbvarname="@page_id", cfsqltype="cf_sql_integer", variable="page_id" );
		result = sp.execute();
		return result.getProcOutVariables().page_id;
	}
	/*
	* Gets all of the pages for an event
	* @page_id The page_id
	*/
	public struct function PagesGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PagesGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="pages", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().pages
		};
	}
	/*
	* Returns a Page info based on a slug and event id
	* @event_id The Event id
	* @slug The slug for the Page
	*/
	public struct function PageBySlugGet( required numeric event_id, required string slug ) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PageBySlugGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="inout", dbvarname="@slug", cfsqltype="cf_sql_varchar", value=arguments.slug, maxlength=300, variable="slug" );
		sp.addParam( type="out", dbvarname="@page_id", cfsqltype="cf_sql_integer", variable="page_id" );
		sp.addParam( type="out", dbvarname="@title", cfsqltype="cf_sql_varchar", variable="title" );
		sp.addParam( type="out", dbvarname="@description", cfsqltype="cf_sql_varchar", variable="description" );
		sp.addParam( type="out", dbvarname="@summary", cfsqltype="cf_sql_varchar", variable="summary" );
		sp.addParam( type="out", dbvarname="@body", cfsqltype="cf_sql_longvarchar", variable="body" );
		sp.addParam( type="out", dbvarname="@slug_id", cfsqltype="cf_sql_bigint", variable="slug_id" );
		sp.addParam( type="out", dbvarname="@publish_on", cfsqltype="cf_sql_timestamp", variable="publish_on" );
		sp.addParam( type="out", dbvarname="@expire_on", cfsqltype="cf_sql_timestamp", variable="expire_on" );
		sp.addParam( type="out", dbvarname="@active", cfsqltype="cf_sql_bit", variable="active" );
		sp.addParam( type="out", dbvarname="@has_hero", cfsqltype="cf_sql_bit", variable="has_hero" );
		sp.addParam( type="out", dbvarname="@hero_filename", cfsqltype="cf_sql_varchar", variable="hero_filename" );
		sp.addProcResult( name="media", resultset=1 );
		sp.addProcResult( name="tags", resultset=2 );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		structAppend( data, result.getProcResultSets() );
		return data;
	}
	/*
	* Gets a Event Page
	* @page_id The page_id
	*/
	public struct function PageGet( required numeric page_id ) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PageGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@page_id", cfsqltype="cf_sql_integer", value=arguments.page_id, variable="page_id" );
		sp.addParam( type="out", dbvarname="@event_id", cfsqltype="cf_sql_integer", variable="event_id" );
		sp.addParam( type="out", dbvarname="@title", cfsqltype="cf_sql_varchar", variable="title" );
		sp.addParam( type="out", dbvarname="@description", cfsqltype="cf_sql_varchar", variable="description" );
		sp.addParam( type="out", dbvarname="@summary", cfsqltype="cf_sql_varchar", variable="summary" );
		sp.addParam( type="out", dbvarname="@body", cfsqltype="cf_sql_longvarchar", variable="body" );
		sp.addParam( type="out", dbvarname="@slug_id", cfsqltype="cf_sql_bigint", variable="slug_id" );
		sp.addParam( type="out", dbvarname="@slug", cfsqltype="cf_sql_varchar", variable="slug" );
		sp.addParam( type="out", dbvarname="@publish_on", cfsqltype="cf_sql_timestamp", variable="publish_on" );
		sp.addParam( type="out", dbvarname="@expire_on", cfsqltype="cf_sql_timestamp", variable="expire_on" );
		sp.addParam( type="out", dbvarname="@active", cfsqltype="cf_sql_bit", variable="active" );
		sp.addParam( type="out", dbvarname="@has_hero", cfsqltype="cf_sql_bit", variable="has_hero" );
		sp.addParam( type="out", dbvarname="@hero_filename", cfsqltype="cf_sql_varchar", variable="hero_filename" );
		sp.addProcResult( name="media", resultset=1 );
		sp.addProcResult( name="tags", resultset=2 );
		sp.addProcResult( name="logs", resultset=3 );
		sp.addProcResult( name="body_html", resultset=4 );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		structAppend( data, result.getProcResultSets() );
		return data;
	}
	/*
	* Returns a Page id based on a slug and event id
	* @event_id The Event id
	* @slug The slug for the Page
	*/
	public numeric function PageIdBySlugGet( required numeric event_id, required string slug ) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PageIdBySlugGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", value=arguments.slug, maxlength=300 );
		sp.addParam( type="inout", dbvarname="@page_id", cfsqltype="cf_sql_integer", value=arguments.page_id, null=( !arguments.page_id ), variable="page_id" );
		result = sp.execute();
		return result.getProcOutVariables().page_id;
	}
	/*
	* Gets all of the Pages
	* @event_id A event ID to pull specific pages for
	* @start The row to start on
	* @results The number of results to return
	* @sort_column The column to sort by
	* @sort_direction The direction to sort
	* @search a Keyword to filter the results on
	*/
	public struct function PagesList(
		required numeric event_id,
		numeric start=1,
		numeric results=10,
		string sort_column="title",
		string sort_direction="ASC",
		string search=""
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PagesList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", value=arguments.sort_column, maxlength=50, null=( !len( arguments.sort_column ) ) );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", value=arguments.sort_direction, maxlength=4, null=( !len( arguments.sort_direction ) ) );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", value=arguments.search, maxlength=400, null=( !len( arguments.search ) ) );
		sp.addProcResult( name="pages", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().pages
		};
	}
	/*
	* Adds a log entry for a Page
	* @page_id The id of the Page
	* @user_id The id of the user
	* @action The type of action being logged, this is a friendly short name
	* @message (optional) The message to log if any
	* @ip (optional) The IP Address to log
	* @log_id (output) The generated log_id
	*/
	public numeric function PageLogSet(
		required numeric page_id,
		required numeric user_id,
		required string action,
		string message="",
		string ip=""
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PageLogSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@page_id", cfsqltype="cf_sql_integer", value=arguments.page_id );
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		sp.addParam( type="in", dbvarname="@action", cfsqltype="cf_sql_varchar", value=arguments.action, maxlength=50 );
		sp.addParam( type="in", dbvarname="@message", cfsqltype="cf_sql_varchar", value=arguments.message, maxlength=1000, null=( !len( arguments.message ) ) );
		sp.addParam( type="in", dbvarname="@ip", cfsqltype="cf_sql_varchar", value=arguments.ip, maxlength=40, null=( !len( arguments.ip ) ) );
		sp.addParam( type="inout", dbvarname="@log_id", cfsqltype="cf_sql_bigint", value=arguments.log_id, null=( !arguments.log_id ), variable="log_id" );
		result = sp.execute();
		return result.getProcOutVariables().log_id;
	}
	/*
	* Gets all of the logs for a given Page
	* @page_id The Page id
	*/
	public struct function PageLogsGet( required numeric page_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PageLogsGet"
		});
		sp.addParam( type="in", dbvarname="@page_id", cfsqltype="cf_sql_integer", value=arguments.page_id );
		sp.addProcResult( name="logs", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().logs
		};
	}
	/*
	* Gets all of the Media for a given Page
	* @page_id The Page id
	*/
	public struct function PageMediaGet( required numeric page_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PageMediaGet"
		});
		sp.addParam( type="in", dbvarname="@page_id", cfsqltype="cf_sql_integer", value=arguments.page_id );
		sp.addProcResult( name="media", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().media
		};
	}
	/*
	* Gets the current max section page media sort value
	* @page_id The id of the section
	*/
	public numeric function PageMediaMaxSortGet( required numeric page_id ) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PageMediaMaxSortGet"
		});
		sp.addParam( type="in", dbvarname="@page_id", cfsqltype="cf_sql_integer", value=arguments.page_id );
		sp.addParam( type="out", dbvarname="@sort", cfsqltype="cf_sql_smallint", variable="sort" );
		sp.addProcResult( name="result1", resultset=1 );
		result = sp.execute();
		return result.getProcOutVariables().sort;
	}
	/*
	* Creates or Updates a Page Photo / Media Item and Returns the Media ID
	* @page_id The Page id
	* @sort The order to sort the media
	* @media_id The media id, if null it is added
	* @mimetype_id The mimetype of the media being added
	* @filename The name of the file
	* @thumbnail The name of the thumbnail
	* @filesize The size of the media in kilobytes
	* @label (optional) A friendly label for the media
	* @publish (optional) A date to publish the media on
	* @expire (optional) A date to expire the media on
	*/
	public numeric function PageMediaSet(
		required numeric page_id,
		numeric sort=0,
		required numeric media_id=0,
		required numeric mimetype_id,
		required string filename,
		required string thumbnail,
		required numeric filesize,
		string label="",
		date publish="",
		date expire=""
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PageMediaSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@page_id", cfsqltype="cf_sql_integer", value=arguments.page_id );
		sp.addParam( type="in", dbvarname="@sort", cfsqltype="cf_sql_integer", value=arguments.sort, null=( !arguments.sort ) );
		sp.addParam( type="inout", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id, null=( !arguments.media_id ), variable="media_id" );
		sp.addParam( type="in", dbvarname="@mimetype_id", cfsqltype="cf_sql_smallint", value=arguments.mimetype_id );
		sp.addParam( type="in", dbvarname="@filename", cfsqltype="cf_sql_varchar", value=arguments.filename, maxlength=200 );
		sp.addParam( type="in", dbvarname="@thumbnail", cfsqltype="cf_sql_varchar", value=arguments.thumbnail, maxlength=200 );
		sp.addParam( type="in", dbvarname="@filesize", cfsqltype="cf_sql_integer", value=arguments.filesize );
		sp.addParam( type="in", dbvarname="@label", cfsqltype="cf_sql_varchar", value=arguments.label, maxlength=200, null=( !len( arguments.label ) ) );
		sp.addParam( type="in", dbvarname="@publish", cfsqltype="cf_sql_timestamp", value=arguments.publish, null=( !len( arguments.publish ) ) );
		sp.addParam( type="in", dbvarname="@expire", cfsqltype="cf_sql_timestamp", value=arguments.expire, null=( !len( arguments.expire ) ) );
		result = sp.execute();
		return result.getProcOutVariables().media_id;
	}
	/*
	* Removes a page
	* @page_id The id of the page
	*/
	public void function PageRemove( required numeric page_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PageRemove"
		});
		sp.addParam( type="in", dbvarname="@page_id", cfsqltype="cf_sql_bigint", value=arguments.page_id );
		result = sp.execute();
		return;
	}
	/*
	* Creates or Updates an Page and Returns the Page ID
	* @page_id (optional) The id of the page, NULL means add
	* @event_id The id of the event
	* @title The title of the page
	* @slug The slug for the page
	* @description A description for the page
	* @summary A summary / blurb for the page
	* @body The Body of the page
	* @publish_on A date to publish the page
	* @expire_on A date to expire the page
	* @active Whether or not the page is active
	* @tags A comma-delimited list of tags for the page
	*/
	public numeric function PageSet(
		required numeric page_id=0,
		required numeric event_id,
		required string title,
		required string slug,
		string description="",
		string summary="",
		string body="",
		string publish_on="",
		string expire_on="",
		string tags=""
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PageSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@page_id", cfsqltype="cf_sql_integer", value=arguments.page_id, null=( !arguments.page_id ), variable="page_id" );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@title", cfsqltype="cf_sql_varchar", value=arguments.title, maxlength=150 );
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", value=arguments.slug, maxlength=300 );
		sp.addParam( type="in", dbvarname="@description", cfsqltype="cf_sql_varchar", value=arguments.description, maxlength=250, null=( !len( arguments.description ) ) );
		sp.addParam( type="in", dbvarname="@summary", cfsqltype="cf_sql_varchar", value=arguments.summary, maxlength=1000, null=( !len( arguments.summary ) ) );
		sp.addParam( type="in", dbvarname="@body", cfsqltype="cf_sql_longvarchar", value=arguments.body, null=( !len( arguments.body ) ) );
		sp.addParam( type="in", dbvarname="@publish_on", cfsqltype="cf_sql_timestamp", value=arguments.publish_on, null=( !isDate( arguments.publish_on ) ) );
		sp.addParam( type="in", dbvarname="@expire_on", cfsqltype="cf_sql_timestamp", value=arguments.expire_on, null=( !isDate( arguments.expire_on ) ) );
		sp.addParam( type="in", dbvarname="@active", cfsqltype="cf_sql_bit", value=int( arguments.active ) );
		sp.addParam( type="in", dbvarname="@tags", cfsqltype="cf_sql_varchar", value=arguments.tags, maxlength=500, null=( !len( arguments.tags ) ) );
		result = sp.execute();
		return result.getProcOutVariables().page_id;
	}
	/*
	* Checks to see if a slug has already been used by a event for another Page
	* @event_id The event id
	* @slug The slug to check
	*/
	public boolean function PageSlugExists( required numeric event_id, required string slug ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PageSlugExists"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", value=arguments.slug, maxlength=300 );
		sp.addParam( type="out", dbvarname="@in_use", cfsqltype="cf_sql_bit", variable="in_use" );
		result = sp.execute();
		return result.getProcOutVariables().in_use;
	}
	/*
	* Removes a Tag from an Page
	* @page_id The id of the Page
	* @tag_id The id of the tag
	*/
	public void function PageTagRemove( required numeric page_id, required numeric tag_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PageTagRemove"
		});
		sp.addParam( type="in", dbvarname="@page_id", cfsqltype="cf_sql_integer", value=arguments.page_id );
		sp.addParam( type="in", dbvarname="@tag_id", cfsqltype="cf_sql_bigint", value=arguments.tag_id );
		result = sp.execute();
		return;
	}
	/*
	* Gets all of the tags associated to a Page
	* @page_id The Page id
	*/
	public struct function PageTagsGet( required numeric page_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PageTagsGet"
		});
		sp.addParam( type="in", dbvarname="@page_id", cfsqltype="cf_sql_integer", value=arguments.page_id );
		sp.addProcResult( name="tags", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().tags
		};
	}
	/*
	* Associates 1 or more tags to a Page Element
	* @page_id The id of the Page
	* @tags A comma-delimited list of tags
	*/
	public void function PageTagsSet( required numeric page_id, required string tags ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PageTagsSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@page_id", cfsqltype="cf_sql_bigint", value=arguments.page_id );
		sp.addParam( type="in", dbvarname="@tags", cfsqltype="cf_sql_varchar", value=arguments.tags, maxlength=500 );
		sp.addProcResult( name="result1", resultset=1 );
		sp.execute();
		return;
	}
	/*
	* Updates Page with the hero_media_id
	* @event_id The Event id
	* @media_id The media id, if null it is added
	*/
	public void function PageHeroSet(
		required numeric page_id,
		required numeric media_id
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PageHeroSet"
		});
		sp.addParam( type="in", dbvarname="@page_id", cfsqltype="cf_sql_integer", value=arguments.page_id );
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id );
		result = sp.execute();
		return;
	}
}