/**
* I am the DAO for the Session object
* @file  /model/dao/Session.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/**
	* I check to see if an session slug exists for an event
	* @event_id The ID of the event that you are checking the session slug for
	* @slug The slug that you are checking
	*/
	public boolean function SessionSlugExists( required string event_id, required string slug ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SessionSlugExists"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", maxlength=300, value=trim( arguments.slug ) );
		sp.addParam( type="out", dbvarname="@in_use", cfsqltype="cf_sql_bit", variable="exists" );
		result = sp.execute();
		return result.getProcOutVariables().exists;
	}
	/**
	* I save a session
	* @session_id The id of the session that you are saving 0 if a new session
	* @event_id The ID of the event that you are adding the session to
	* @title The title of the session
	* @slug Slug for the session
	* @description The Description of the session
	* @summary The short summary of the session
	* @overview The overview of the session
	* @category A category for the Session
	*/
	public boolean function SessionSet(
		numeric session_id=0,
		required numeric event_id,
		required string title,
		required string slug,
		required string description,
		string summary="",
		string overview="",
		string category=""
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SessionSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@session_id", cfsqltype="cf_sql_integer", value=arguments.session_id, null=( !arguments.session_id ), variable="session_id" );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@title", cfsqltype="cf_sql_varchar", maxlength=150, value=arguments.title );
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", maxlength=300, value=arguments.slug );
		sp.addParam( type="in", dbvarname="@description", cfsqltype="cf_sql_varchar", maxlength=250, value=arguments.description );
		sp.addParam( type="in", dbvarname="@summary", cfsqltype="cf_sql_varchar", maxlength=1000, value=arguments.summary );
		sp.addParam( type="in", dbvarname="@overview", cfsqltype="cf_sql_varchar", value=arguments.overview );
		sp.addParam( type="in", dbvarname="@category", cfsqltype="cf_sql_varchar", maxlength=100, value=arguments.category );
		result = sp.execute();
		return result.getProcOutVariables().session_id;
	}
	/**
	* I get all of a session's details, speakers, tags, files, photos and logs
	* @session_id The session ID of the session that you want to get detals on.
	*/
	public struct function SessionGet( required numeric session_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SessionGet"
		});
		sp.addParam( type="in", dbvarname="@session_id", cfsqltype="cf_sql_integer", value=arguments.session_id );
		sp.addProcResult( name="details", resultset=1 );
		sp.addProcResult( name="speakers", resultset=2 );
		sp.addProcResult( name="tags", resultset=3 );
		sp.addProcResult( name="files", resultset=4 );
		sp.addProcResult( name="photos", resultset=5 );
		sp.addProcResult( name="logs", resultset=6 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I get all of the photos for a session
	* @session_id
	* @start
	* @results
	* @sort_column
	* @sort_direction
	* @search
	*/
	public struct function SessionPhotosList(
		required numeric session_id,
		required numeric start,
		required numeric results,
		required string sort_column,
		required string sort_direction,
		string search="" ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SessionPhotosList"
		});
		sp.addParam( type="in", dbvarname="@session_id", cfsqltype="cf_sql_integer", value=arguments.session_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", maxlength=50, value=arguments.sort_column );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", maxlength=4, value=arguments.sort_direction );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", maxlength=200, value=arguments.search, null=( !len(arguments.search) ) );

		sp.addProcResult( name="photo_list", resultset=1 );

		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I get all of the Files for a session
	* @session_id
	* @start
	* @results
	* @sort_column
	* @sort_direction
	* @search
	*/
	public struct function SessionFilesList(
		required numeric session_id,
		required numeric start,
		required numeric results,
		required string sort_column,
		required string sort_direction,
		string search="" ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SessionFilesList"
		});
		sp.addParam( type="in", dbvarname="@session_id", cfsqltype="cf_sql_integer", value=arguments.session_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", maxlength=50, value=arguments.sort_column );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", maxlength=4, value=arguments.sort_direction );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", maxlength=200, value=arguments.search, null=( !len(arguments.search) ) );

		sp.addProcResult( name="files_list", resultset=1 );

		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I get a list of filtered event sessions
	* @event_id The ID of the event that you want list sessions for
	* @start What row do you want your results to sart on
	* @results How many results do you want to return max 100
	* @sort_column The column to sort on
	* @sort_direction sort direction 'ASC',
	* @search Search string to filter the results
	*/
	public struct function EventSessionsList(
		required numeric event_id,
		required numeric start,
		required numeric results,
		required string sort_column,
		required string sort_direction,
		string search="" ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventSessionsList"
		});

		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", maxlength=50, value=arguments.sort_column );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", maxlength=4, value=arguments.sort_direction );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", maxlength=200, value=arguments.search, null=( !len(arguments.search) ) );

		sp.addProcResult( name="event_sessions", resultset=1 );

		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I get a list of event sessions
	* @event_id The ID of the event that you want list sessions for
	*/
	public struct function EventSessionsGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventSessionsGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="sessions", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
}
