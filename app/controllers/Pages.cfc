component extends="$base" accessors="true" {
	property name="pagesManager" setter="true" getter="true";

	public void function before( rc ) {
		
		if( !getCurrentEventID() ){
			redirect("event.select");
		}
		rc.sidebar = "sidebar.event.details";
		super.before( rc );
		return;
	}
	/**
	* I am the event pages listing
	*/
	public void function default( rc ) {
		var cfjs = {
			"table_id": "pages_listing",
			"ajax_source": "pages.listing?event_id=" & getSessionManageUserFacade().getValue( "current_event_id" ),
			"columns": "title,description,tags,publish_on,expire_on,active,options",
			"aoColumns": [
				{
					"data": "title",
					"sTitle": "Title"
				},
				{
					"data": "description",
					"sTitle": "Description"
				},
				{
					"data": "tags",
					"sTitle": "Tags",
					"bSortable": false
				},
				{
					"data": "publish_on",
					"sTitle": "Publish On"
				},
				{
					"data": "expire_on",
					"sTitle": "Expire On"
				},
				{
					"data": "active",
					"sTitle": "Active"
				},
				{
					"data": "options",
					"sTitle": "Options",
					"bSortable": false
				}
			]
		};
		rc['table_id'] = cfjs.table_id;
		listing_config['ajax_source'] = buildURL( (structKeyExists(cfjs,'ajax_source') ? cfjs.ajax_source: '') );
		rc['columns'] = cfjs.columns;
		
		getCfStatic()
			.includeData( cfjs )
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
		var columns = [ "title", "description", "tags", "publish_on", "expire_on", "active" ];
		structAppend(params, rc);
		params['results'] = params.length;
		params['sort_column'] = columns[ params['ORDER[0][COLUMN]'] + 1 ];
		params['sort_direction'] = params['ORDER[0][DIR]'];
		params['search'] = params['SEARCH[VALUE]'];
		data = getPagesManager().getEventPages( argumentCollection=params );
		data['cnt'] = arrayLen(data.data);
		for( var i = 1; i <= data.cnt; i++ ) {
			data['data'][i]['options'] = "<a class=""btn btn-primary btn-sm"" href=""" & buildURL("pages.details?page_id=" & data.data[i].page_id ) & """><span class=""glyphicon glyphicon-edit""></span> <strong>Manage</strong></a>";
		}
		getFW().renderData( "json", data );
		return;
	}
	/**
	* I render the new page form
	*/
	public void function create( rc ) {
		getCfStatic()
			.include("/js/pages/pages/create.js");
		return;
	}
	/**
	* I create a new page
	*/
	public void function doCreate( rc ) {
		if( structKeyExists( rc, "page") && isStruct( rc.page ) ){
			rc['page']['event_id'] = getCurrentEventID();
			rc['page_id'] = getPagesManager().create( argumentCollection=rc.page );
			if( val( rc.page_id ) ){
				redirect( action="pages.details", queryString="page_id=" & rc.page_id );
			}
		}
		redirect("pages.default");
		return;
	}
	/**
	* I am the page details for a given page
	*/
	public void function details( rc ) {
		var page_id = ( structKeyExists( rc, "page_id" ) ? rc.page_id : 0 );
		var cfjs = {
				'media_list_url':buildURL('media.ajaxCompanyListing'),
				'media_save_url':buildURL('media.ajaxsave'),
				'media_get_url':buildURL('media.ajaxget')
			};
		rc['event_id'] = getCurrentEventID();
		rc['company_id'] = getCurrentCompanyID();
		if( !structKeyExists( rc, "page" ) ) {
			rc['page'] = {};
		}
		structAppend(rc.page, getPagesManager().getPageDetails( page_id=page_id ), false );
		// make sure records were found
		if( !rc.page.success ) {
			redirect("pages.default");
		}
		rc['checked']['yes'] = "checked=""checked""";
		rc['checked']['no'] = "";
		getCfStatic()
			.includeData(cfjs)
			.include("/js/pages/agendas/date_time.js")
			.include("/js/pages/pages/create.js")
			.include("/js/pages/pages/details.js");
		return;
	}
	/**
	* I save a page
	*/
	public void function doSave( rc ) {
		if( structKeyExists( rc, "page") && isStruct( rc.page ) && getFormUtilities().exists( fields="page_id,title,publish_on,expire_on,description,active,summary,tags,body", scope=rc.page ) ) {
			// get the current working event id
			rc['page']['event_id'] = getCurrentEventID();
			// save the page
			rc['page_id'] = getPagesManager().save( argumentCollection=rc.page );
			if( val( rc.page_id ) ) {
				redirect( action="pages.details", queryString="page_id=" & rc.page_id );
			}
		}
		return;
	}
}