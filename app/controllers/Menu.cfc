component extends="$base" accessors="true" {
	property name="menuManager" setter="true" getter="true";
	property name="eventsManager" setter="true" getter="true";
	property name="pagesManager" setter="true" getter="true";


	public void function before( rc ) {
		rc['event_id'] = getCurrentEventID();
		if( !rc.event_id ){
			redirect("event.select");
		}
		super.before( rc );
		rc.sidebar = 'sidebar.event.details';
		return;
	}
	/**
	* I am the event pages listing
	*/
	public void function default( rc ) {
		// get the event name
		rc['event_name'] = getEventsManager().getEventName( event_id=rc.event_id );
		rc['event_uri'] = getEventsManager().getEventURI( event_id=rc.event_id );
		rc['pages'] = getPagesManager().getPages( event_id=rc.event_id );
		rc['pages_cnt'] = arrayLen( rc.pages );
		rc['menus'] = getMenuManager().getMenus( event_id=rc.event_id );
		rc['menu_cnt'] = arrayLen( rc.menus );
		getCfStatic()
			.include( "/css/pages/menu/menu.css" )
			.include( "/js/plugins/nested-sortable/jqueryui.mjs.nested-sortable.js" )
			.include( "/js/pages/menu/menu.js" );
		return;
	}
	/**
	* Adds a Menu
	*/
	public void function save( rc ) {
		var result = {
			'success': false
		};
		if( structKeyExists(rc, "menu") && getFormUtilities().exists( "link||linkchoice", rc.menu ) && getFormUtilities().exists( "menu_id,label", rc.menu ) ){
			if( !isNumeric( rc.menu.menu_id ) ) {
				rc['menu']['menu_id'] = 0;
			}
			rc['menu']['event_id'] = rc.event_id;
		// If we are passing a slug from linkchoice, copy it to the link value.
			if (rc.menu.linkchoice neq "external"){
				rc.menu.link = rc.menu.linkchoice;
			}
			result['menu_id'] = getMenuManager().save( argumentCollection=rc.menu );
			result['label'] = rc.menu.label;
			result['link'] = rc.menu.link;
			result['message'] = "The menu has been successully updated / created.";
			result['success'] = !!result.menu_id;
		}
		getFW().renderData( "json", result );
		return;
	}
	/**
	* Removes a Menu
	*/
	public void function remove( rc ) {
		if( structKeyExists( rc, "menu_id") ){
			getMenuManager().remove( argumentCollection=rc );
		}
		getFW().renderData( "json", {
			'success': true
		} );
		return;
	}
	/**
	* Sets the Sort Order for the Menus
	*/
	public void function sort( rc ) {
		if( structKeyExists( rc, "sort") ){
			// set the sort order for all menus
			getMenuManager().sort( event_id=rc.event_id, menu_ids=rc.sort );
			// set the paths
			if( isJSON( rc.tree ) ){
				getMenuManager().paths( event_id=rc.event_id, paths=deserializeJSON( rc.tree ) );
			}
		}
		getFW().renderData( "json", {
			'success': true,
			'message': "The menu order has been successfully saved."
		} );
		return;
	}
}