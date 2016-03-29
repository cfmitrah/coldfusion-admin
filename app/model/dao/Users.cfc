/**
* I am the DAO for the Users
* @file  /model/dao/Users.cfc
* @author
* @description
*
*/

component accessors="true" extends="app.model.base.Dao" {

	/*
	* Gets all of the Users in the system
	*/
	public struct function usersGet() {		
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "UsersGet"
		});
		sp.addProcResult( name="result1", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Gets all of the Users
	* @start The row to start on
	* @results The number of results to return
	* @sort_column The column to sort by - valid values ('label','subject','from_email_id','from_email')
	* @sort_direction The direction to sort
	* @search a Keyword to filter the results on
	*/
	public struct function UsersList(
		numeric start=1
		,numeric results=10
		,string sort_column="username"
		,string sort_direction="ASC"
		,string search=""

	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "UsersList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", value=arguments.sort_column, maxlength=50, null=( !len( arguments.sort_column ) ) );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", value=arguments.sort_direction, maxlength=4, null=( !len( arguments.sort_direction ) ) );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", value=arguments.search, maxlength=200, null=( !len( arguments.search ) ) );
		sp.addProcResult( name="result", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result
		};
	}

}