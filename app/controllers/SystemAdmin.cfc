component extends="$base" accessors="true" securityroles="System Administrator"{
	property name="systemAdminManager" setter="true" getter="true";
	property name="cacheManager" setter="true" getter="true";
	public void function before( rc ) {
		rc.sidebar = 'sidebar.systemAdmin';
		if( !getSessionManageUserFacade().isSystemAdmin() ){
			redirect("company.default");
		}
		super.before( rc );
		return;
	}
	/**
	* Multi line method description
	*/
	public any function default( rc ) {
		var listing_config = {
			"table_id":"systemadmin_listing"
			,"ajax_source":"systemadmin.ajaxListing"
			,"columns":"ID,User Name,First Name,Last Name"
			,"aoColumns":[
				{"data":"user_id"}
		        ,{"data":"username"}
		        ,{"data":"first_name"}
		        ,{"data":"last_name"}
		    ]
		};
		rc.has_sidebar = false;
		rc['table_id'] = listing_config.table_id;
		listing_config['ajax_source'] = buildURL( (structKeyExists(listing_config,'ajax_source') ? listing_config.ajax_source: '') );
		rc['columns'] = listing_config.columns;

		getCfStatic().includeData( listing_config ).include("/js/pages/common/listing.js").include("/css/pages/common/listing.css");

		return;
	}
	/**
	* Multi line method description
	*/
	public any function ajaxListing( rc ) {
		var params = {
			order_index=( structKeyExists( rc, 'order[0][column]') ? rc['order[0][column]']:0)
			, order_dir=( structKeyExists( rc, 'order[0][dir]') ? rc['order[0][dir]']:"asc")
			, search_value=( structKeyExists( rc, 'search[value]') ? rc['search[value]']:"")
			, start_row=( structKeyExists( rc, 'start') ? rc.start:0)
			, total_rows=( structKeyExists( rc, 'length') ? rc.length:0)
			, draw=( structKeyExists( rc, 'draw') ? rc.draw:0)
		};
		var list_data = getSystemAdminManager().getListing( argumentCollection=params );

		getFW().renderData( 'json', list_data );
		request.layout = false;
		return;

	}
	/**
	* Handles building daos
	*/
	public any function dao( rc ) {
		structAppend( rc, {
			'procedure': "",
			'rendered': false,
			'method': ""
		}, false );
		rc['procs'] = getSystemAdminManager().getStoredProcedures();
		rc['procs']['opts'] = getFormUtilities().buildOptionList( values=rc.procs.name, selected=rc.procedure );
		if( len( rc.procedure ) ) {
			rc['detail'] = getSystemAdminManager().getStoredProcedure( name=rc.procedure );
			rc['dao_method'] = getSystemAdminManager().buildDaoMethod( details=rc.detail );
			rc['rendered'] = true;
		}
		return;
	}
	/**
	* Handles cache management
	*/
	public any function cache( rc ) {
		if( structKeyExists( rc, "event_cache_key" ) ){
			// an event_cache_key was passed in, pull all caches that match
			rc['event_cache'] = getCacheManager().getEventCache( event_cache_key=rc.event_cache_key );
			rc['looked_up'] = true;
		}
		else{
			rc['looked_up'] = false;
			rc['event_cache_key'] = "";
		}
		rc['event_caches'] = getCacheManager().getAvailableEventCaches( event_cache_key=rc.event_cache_key ).opts;
		getCfStatic()
			.include( "/js/pages/systemadmin/cache.js" );
		return;
	}
	/**
	* Removes an Event Cache Key
	*/
	public void function removeCache( rc ) {
		var success = false;
		if( structKeyExists( rc, "cache_key")  ){
			getCacheManager().removeCache( cache_key=rc.cache_key );
			succes = true;
		}
		getFW().renderData( "json", {
			'success': success
		} );
		return;
	}
	/**
	* Purges an events entire cache
	*/
	public void function purgeCache( rc ) {
		var success = false;
		if( structKeyExists( rc, "cache_key")  ){
			getCacheManager().purgeCache( cache_key=rc.cache_key );
			succes = true;
		}
		getFW().renderData( "json", {
			'success': success
		} );
		return;
	}
	/**
	* Purges an events entire cache
	*/
	public void function viewCache( rc ) {
		if( structKeyExists( rc, "cache_key")  ){
			getFW().renderData( "json", getCacheManager().getCacheData( cache_key=rc.cache_key ) );
		}
		else{
			getFW().renderData( "json", {} );
		}
		return;
	}

}