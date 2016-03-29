/**
*
* @file  /model/managers/Menu.cfc
* @author
* @description
*
*/
component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="MenuDAO" getter="true" setter="true";
	/*
	* Gets all of the menus
	* @event_id The event id
	*/
	public array function getMenus( required numeric event_id ) {
		return queryToArray( recordset=getMenuDao().MenusGet( argumentCollection=arguments ).result );
	}
	/*
	* Adds / Updates a Menu
	* @menu_id (optional) The id of the address if updating, 0 means add
	* @event_id The event id
	* @label A short name for the menu
	* @link A URL for the menu
	* @target The target for the window: _self, _parent, _top, _blank
	* @sort Where to position the menu
	*/
	public numeric function save(
		numeric menu_id=0,
		required numeric event_id,
		required string label,
		required string link,
		required string target,
		numeric sort=0
	){
		if( len( arguments.label ) > 50 ) {
			arguments['label'] = left( arguments.label, 50 );
		}
		return getMenuDao().MenuSet( argumentCollection=arguments );
	}
	/*
	* Removes a Menu Item
	* @menu_id The id of the menu
	* @event_id The event id
	*/
	public void function remove( required numeric menu_id, required numeric event_id ) {
		getMenuDao().MenuRemove( argumentCollection=arguments );
		return;
	}
	/*
	* Updates the sort order for menus
	* @menu_ids Comma-delimited list of menu_ids
	* @event_id The event id
	*/
	public void function sort( required numeric event_id, required string menu_ids ) {
		getMenuDao().MenuSortOrderSet( argumentCollection=arguments );
		return;
	}
	/*
	* Updates the menu paths
	* @ancestor Comma-delimited list of parent menu ids menu_ids
	* @descendants The event id
	*/
	public void function paths( required numeric event_id, required array paths ){
		var path_cnt = arrayLen( arguments.paths );
		getMenuDao().MenuPathsClear( event_id=arguments.event_id );
		// set the new paths
		for( var i = 1; i <= path_cnt; i++ ){
			getMenuDao().MenuPathsSet( ancestor=arguments.paths[i].menu_id, descendants=arrayToList( arguments.paths[i].children ) );
		}
		return;
	}
}