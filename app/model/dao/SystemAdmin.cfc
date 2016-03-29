/**
* I am the DAO for the SystemAdmin object
* @file  /model/dao/SystemAdmin.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/**
	* I remove a user from the system admin group.
	* @user_id The ID of the user that you want to remove from the system admin group.
	*/
	public void function systemAdminRemove( required numeric user_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SystemAdminRemove"
		});
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		result = sp.execute();

		return;
	}
	/**
	* I add a user to the system admin group.
	* @user_id The ID of the user that you want to add to the system admin group.
	*/
	public void function systemAdminAdd( required numeric user_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SystemAdminAdd"
		});
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		result = sp.execute();

		return;
	}
	/**
	* I get a list of system admins
	* @start What row do you want your results to sart on
	* @results How many results do you want to return max 100
	*/
	public struct function systemAdminsGet( required numeric start, required numeric results=10  ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SystemAdminsGet"
		});
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results );
		sp.addProcResult( name="system_admins", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* Gets all of the stored procedures
	*/
	public struct function StoredProceduresList() {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "StoredProceduresList"
		});
		sp.addProcResult( name="procedures", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().procedures
		};
	}
	/**
	* Gets a stored procedure and its metadata
	*/
	public struct function StoredProcedureGet( required string name ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "StoredProcedureGet"
		});
		sp.addParam( type="in", dbvarname="@name", cfsqltype="cf_sql_varchar", value=arguments.name );
		sp.addProcResult( name="metadata", resultset=1 );
		sp.addProcResult( name="parameters", resultset=2 );
		sp.addProcResult( name="definition", resultset=3 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}


}