/**
*
* @file  /model/managers/Pages.cfc
* @author
* @description
*
*/
component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="PageDAO" getter="true" setter="true";
	property name="slugManager" getter="true" setter="true";
	/**
	* I get all of the Pages for an event
	*/
	public struct function getEventPages(
		required numeric event_id=0,
		start = 0
		results = 10,
		sort_column = "title",
		sort_direction = "ASC",
		numeric draw = 1
	 ) {
		var event_pages = getPageDAO().PagesList( argumentCollection=arguments ).result;
		return {
			"draw": arguments.draw,
			"recordsTotal": isDefined("event_pages.total") ? event_pages.total : event_pages.recordCount,
			"recordsFiltered": isDefined("event_pages.total") ? event_pages.total : event_pages.recordCount,
			"data": queryToArray(recordset=event_pages, map=function( row, index, columns ){
				row['publish_on'] = dateTimeFormat( row.publish_on, "mm/dd/yyyy h:mm tt");
				row['expire_on'] = dateTimeFormat( row.expire_on, "mm/dd/yyyy h:mm tt");
				row['active'] = " " & yesNoFormat( row.active );
				return row;
			})
		};
	}
	/**
	* I create a Page
	* @event_id The id of the event
	* @title The title of the page
	*/
	public any function create( required numeric event_id, required string title ) {
		// generate a slug based on the display name
		arguments['slug'] = getSlugManager().generate( arguments.title );
		// check to see if the slug already exists, if it does it should be an error
		if( !getPageDao().PageSlugExists( arguments.event_id, arguments.slug ) ){
			getSlugManager().save( arguments.slug );
		}
		// save the page
		return getPageDao().PageCreate( argumentCollection=arguments );
	}
	/**
	* I save a Page
	* @page_id (optional) The id of the page, NULL means add
	* @event_id The id of the event
	* @title The title of the page
	* @slug The slug for the page
	* @description A description for the page
	* @summary A summary / blurb for the page
	* @body The Body of the page
	* @publish_on A date to publish the page
	* @expire_on A date to expire the page
	* @tags A comma-delimited list of tags for the page
	*/
	public any function save(
		required numeric page_id=0,
		required numeric event_id,
		required string title,
		string description="",
		string summary="",
		string body="",
		string publish_on="",
		string expire_on="",
		string tags="",
		numeric hero_graphic_id=0
	) {

		// generate a slug based on the display name
		arguments['slug'] = getSlugManager().generate( arguments.title );
		// check to see if the slug already exists, if it does it should be an error
		if( !getPageDao().PageSlugExists( arguments.event_id, arguments.slug ) ){
			getSlugManager().save( arguments.slug );
		}
		// save the page
		arguments.page_id = getPageDao().PageSet( argumentCollection=arguments );
		if( arguments.hero_graphic_id ) {
			arguments['media_id'] = arguments.hero_graphic_id;
			getPageDao().PageHeroSet( argumentCollection=arguments );
		}
		return arguments.page_id;
	}
	/**
	* I get all of a Page's details, tags, photos and logs
	* @page_id The Page ID of the Page that you want to get detals on.
	*/
	public struct function getPageDetails( required numeric page_id ) {
		var page = getPageDao().PageGet( arguments.page_id );
		var buffer = "";
		// tags
		page['tags'] = queryToArray( recordset=page.tags );
		page['tag_cnt'] = arrayLen(page.tags);
		page['tag_list'] = "";
		if( page.tag_cnt ) {
			buffer = createObject( "java", "java.lang.StringBuffer" );
			// loop over all the tags and create a list
			for( var i = 1; i <= page.tag_cnt; i++ ) {
				buffer.append(page.tags[i].tag).append(", ");
			}
			if( buffer.length() ) {
				buffer.setLength( javaCast( "int", buffer.length() - 2 ) );
				page['tag_list'] = buffer.toString();
				buffer.setLength( javaCast( "int", 0 ) );
			}
		}
		// sessions
		page['media'] = queryToArray( recordset=page.media );
		page['media_cnt'] = arrayLen(page.media);
		// logs
		page['logs'] = queryToArray( recordset=page.logs );
		page['log_cnt'] = arrayLen(page.logs);
		page['success'] = page.page_id ? true : false;
		page['body'] = page.body_html.body;
		return page;
	}
	/**
	* I get all of the pages for the event
	* @event_id The Event ID
	*/
	public array function getPages( required numeric event_id ) {
		return queryToArray( recordset=getPageDao().PagesGet( arguments.event_id ).result );
	}
}