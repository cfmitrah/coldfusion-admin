/**
*
* @file  /model/managers/Sessions.cfc
* @author
* @description
*
*/

component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="SessionDao" getter="true" setter="true";
	property name="slugManager" getter="true" setter="true";
	/**
	* I get all of the session for an event
	*
	*/
	public struct function getListing( required numeric event_id, numeric order_index=0, string order_dir="asc", string search_value="", numeric start_row=0, numeric total_rows=10, numeric draw=1 ) {
		var iTotalDisplayRecords = 0;
		var columns = [ "session_id", "title", "category", "summary", "options" ];
		var rtn = {"draw"=arguments.draw, "recordsTotal"=0, "recordsFiltered"=0,"data"=[]};
		var params = {event_id=arguments.event_id,start=(start_row+1),results=arguments.total_rows,sort_column=columns[ order_index + 1 ],sort_direction=arguments.order_dir,search=arguments.search_value};
		var event_sessions = getSessionDao().EventSessionsList( argumentCollection=params ).result.event_sessions;
		var opt = "";
		queryAddColumn( event_sessions, "options", [] );

		for ( var i=1; i <= event_sessions.RecordCount; i++) {
			opt="";
			opt &= "<a href='/sessions/details/session_id/"& event_sessions.session_id[ i ] &"'' data-modifytype='true' class='btn btn-primary btn-sm'>Manage</a>";

			querySetCell(event_sessions, "options", opt, i);
			arrayappend( rtn['data'], queryRowToStruct( event_sessions, i, true ));
		}

		rtn['recordsTotal'] = event_sessions.total;
		rtn['recordsFiltered'] = event_sessions.total;

		return rtn;
	}
	/**
	* I get all of the photos for a session
	*
	*/
	public struct function getPhotosListing( required numeric session_id, numeric order_index=0, string order_dir="asc", string search_value="", numeric start_row=0, numeric total_rows=10, numeric draw=1 ) {
		var iTotalDisplayRecords = 0;
		var columns = [ "label", "filename", "filesize", "tags", "options" ];
		var params = {session_id=arguments.session_id,start=(start_row+1),results=arguments.total_rows,sort_column=columns[ order_index + 1 ],sort_direction=arguments.order_dir,search=arguments.search_value};
		var rtn = {"draw"=arguments.draw, "recordsTotal"=0, "recordsFiltered"=0,"data"=[]};
		var photos = getSessionDao().SessionPhotosList( argumentCollection:params ).result.photo_list;
		var opt = "";
		var tags = "";
		var html_tag = "";
		var tag = "";
		queryAddColumn( photos, "options", [] );

		for ( var i=1; i <= photos.RecordCount; i++) {
			opt = "<div class=""btn-group""><a href='##' data-remove_media='true' data-link='/media/disassociate/session_media_type/image/media_id/"&photos.media_id[ i ]&"/session_id/"& arguments.session_id &"' class='btn btn-danger btn-sm'>Remove</a>";
			opt &= " <a href='##' data-manage_media='true' data-media_id='"&photos.media_id[ i ]&"' data-session_id='"& arguments.session_id &"' class='btn btn-primary btn-sm'>Manage</a></div>";

			querySetCell(photos, "options", opt, i);

			html_tags = "";
			tags = listToArray( photos.tags[ i ] );
			for( tag in tags ){
				html_tags &= '<span class="label label-default">' & tag & '</span> ';
			}
			querySetCell(photos, "tags", html_tags, i);
			arrayappend( rtn['data'], queryRowToStruct( photos, i, true ));

		}

		rtn['recordsTotal'] = photos.total;
		rtn['recordsFiltered'] =photos.total;

		return rtn;
	}
	/**
	* I get all of the photos for a session
	*
	*/
	public struct function getFilesListing( required numeric session_id, numeric order_index=0, string order_dir="asc", string search_value="", numeric start_row=0, numeric total_rows=10, numeric draw=1 ) {
		var iTotalDisplayRecords = 0;
		var columns = [ "filename", "label", "mimetype", "uploaded", "options" ];
		var params = {session_id=arguments.session_id,start=(start_row+1),results=arguments.total_rows,sort_column=columns[ order_index + 1 ],sort_direction=arguments.order_dir,search=arguments.search_value};
		var rtn = {"draw"=arguments.draw, "recordsTotal"=0, "recordsFiltered"=0,"data"=[]};
		var files = getSessionDao().SessionFilesList( argumentCollection:params ).result.files_list;
		var opt = "";
		var tags = "";
		var html_tag = "";
		var tag = "";
		queryAddColumn( files, "options", [] );

		for ( var i=1; i <= files.RecordCount; i++) {
			opt = "<div class=""btn-group""><a href='##' data-remove_media='true' data-link='/media/disassociate/session_media_type/image/media_id/"&files.media_id[ i ]&"/session_id/"& arguments.session_id &"' class='btn btn-danger btn-sm'>Remove</a>";
			opt &= "<a href='##' data-manage_media='true' data-media_id='"&files.media_id[ i ]&"' data-session_id='"& arguments.session_id &"' class='btn btn-primary btn-sm'>Manage</a></div>";

			querySetCell(files, "options", opt, i);
			html_tags = "";
			tags = listToArray( files.tags[ i ] );
			for( tag in tags ){
				html_tags &= '<span class="label label-default">' & tag & '</span> ';
			}
			querySetCell(files, "tags", html_tags, i);

			arrayappend( rtn['data'], queryRowToStruct( files, i, true ));
		}

		rtn['recordsTotal'] = files.total;
		rtn['recordsFiltered'] =files.total;

		return rtn;
	}
	/**
	* I get all of a session's details, speakers, tags, files, photos and logs
	* @session_id The session ID of the session that you want to get detals on.
	*/
	public struct function getSessionDetails( required numeric session_id ) {

		return getSessionDao().SessionGet( arguments.session_id );
	}
	/**
	* I save a session
	* @session_id INT = NULL OUTPUT,
	* @event_id INT,
	* @title NVARCHAR(150),
	* @slug VARCHAR(300),
	* @description NVARCHAR(250),
	* @summary NVARCHAR(1000),
	* @overview NVARCHAR(MAX)
	*/
	public any function save(
		numeric session_id=0,
		required numeric event_id,
		required string title,
		required string description,
		required string summary,
		required string overview,
		string category=""
	) {
		arguments['slug'] = getSlugManager().generate( arguments.title );
		if( !getSessionDao().SessionSlugExists( arguments.event_id, slug ) ){
			getSlugManager().save( slug );
		}
		getCacheManager().purgeAgendaCache( arguments.event_id );
		return getSessionDao().SessionSet( argumentCollection=arguments );
	}
	/**
	* I get all of a Sessions for an event
	* @event_id The Event ID of the to get the Sessions for
	*/
	public array function getSessions( required numeric event_id ) {
		var data = getSessionDao().EventSessionsGet( event_id = arguments.event_id );
		return queryToArray( recordset = data.result.sessions );
	}
	/**
	* I get all of a Sessions Query for an event
	* @event_id The Event ID of the to get the Sessions for
	*/
	public struct function getSessionsQuery( required numeric event_id ) {
		var data = getSessionDao().EventSessionsGet( event_id = arguments.event_id );
		return queryToStruct( recordset = data.result.sessions );
	}

}