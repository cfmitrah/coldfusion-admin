/**
* I am the DAO for the Menu object
* @file  /model/dao/Menu.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {
	/*
	* Gets all of the menus for an event
	* @event_id The event id
	*/
	public struct function EventMenusGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventMenusGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="menus", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().menus
		};
	}
	/*
	* Gets a menu item
	* @menu_id The menu id
	*/
	public struct function MenuGet( required numeric menu_id ) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "MenuGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@menu_id", cfsqltype="cf_sql_integer", value=arguments.menu_id, variable="menu_id" );
		sp.addParam( type="out", dbvarname="@event_id", cfsqltype="cf_sql_integer", variable="event_id" );
		sp.addParam( type="out", dbvarname="@label", cfsqltype="cf_sql_varchar", variable="label" );
		sp.addParam( type="out", dbvarname="@link", cfsqltype="cf_sql_varchar", variable="link" );
		sp.addParam( type="out", dbvarname="@target", cfsqltype="cf_sql_varchar", variable="target" );
		sp.addParam( type="out", dbvarname="@sort", cfsqltype="cf_sql_smallint", variable="sort" );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
	/*
	* Gets the current max section sort value
	* @event_id The event id
	*/
	public struct function MenuMaxSortGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "MenuMaxSortGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="out", dbvarname="@sort", cfsqltype="cf_sql_smallint", variable="sort" );
		result = sp.execute();
		return result.getProcOutVariables().sort;
	}
	/*
	* Clears out all of the menu paths for an event
	* @event_id The event id
	*/
	public void function MenuPathsClear( required numeric event_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "MenuPathsClear"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.execute();
		return;
	}
	/*
	* Sets the Paths for a Given Parent Menu
	* @ancestor The parent menu_id
	* @descendants Comma-delimited list of sub menu_ids
	*/
	public void function MenuPathsSet( required numeric ancestor, required string descendants ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "MenuPathsSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@ancestor", cfsqltype="cf_sql_integer", value=arguments.ancestor );
		sp.addParam( type="in", dbvarname="@descendants", cfsqltype="cf_sql_varchar", value=arguments.descendants, maxlength=500 );
		sp.execute();
		return;
	}
	/*
	* Removes a Menu Item
	* @menu_id The id of the menu
	* @event_id The event id
	*/
	public void function MenuRemove( required numeric menu_id, required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "MenuRemove"
		});
		sp.addParam( type="in", dbvarname="@menu_id", cfsqltype="cf_sql_integer", value=arguments.menu_id );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		result = sp.execute();
		return;
	}
	/*
	* Creates or Updates an Menu and Returns the Menu ID
	* @menu_id (optional) The id of the menu if updating, 0 means add
	* @event_id The event id
	* @label A short name for the menu
	* @link A link for the menu item
	* @target The target to open the link as: _self, _parent, _top, _blank
	* @sort Where to position the menu
	*/
	public numeric function MenuSet(
		required numeric menu_id,
		required numeric event_id,
		required string label,
		required string link,
		string target="",
		numeric sort=0
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "MenuSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@menu_id", cfsqltype="cf_sql_integer", value=arguments.menu_id, variable="menu_id" );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@label", cfsqltype="cf_sql_varchar", value=arguments.label, maxlength=50 );
		sp.addParam( type="in", dbvarname="@link", cfsqltype="cf_sql_varchar", value=arguments.link, maxlength=500 );
		sp.addParam( type="in", dbvarname="@target", cfsqltype="cf_sql_varchar", value=arguments.target, maxlength=25, null=( !len( arguments.target ) ) );
		sp.addParam( type="in", dbvarname="@sort", cfsqltype="cf_sql_smallint", value=arguments.sort, null=( !arguments.sort ) );
		result = sp.execute();
		return result.getProcOutVariables().menu_id;
	}
	/*
	* Gets all of the menus for an event
	* @event_id The event id
	*/
	public struct function MenusGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "MenusGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="menus", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().menus
		};
	}
	/*
	* Updates the sort order for menus
	* @menu_ids Comma-delimited list of menu_ids
	* @event_id The event id
	*/
	public void function MenuSortOrderSet( required string menu_ids, required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "MenuSortOrderSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@menu_ids", cfsqltype="cf_sql_varchar", value=arguments.menu_ids, maxlength=500 );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		result = sp.execute();
		return;
	}
}