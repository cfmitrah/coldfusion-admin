/**
*
* @file  /app/model/dao/CompanyUsers.cfc
* @author
* @description
*
*/
component accessors="true" extends="app.model.base.Dao" {

	/*
	* Gets all of the account managers for a given company
	* @company_id The Company id
	*/
	public struct function CompanyAccountManagersGet( required numeric company_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CompanyAccountManagersGet"
		});
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addProcResult( name="result1", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result1
		};
	}

	/*
	* Gets all of the users for a given company
	* @company_id The Company id
	*/
	public struct function CompanyUsersGet( required numeric company_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CompanyUsersGet"
		});
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addProcResult( name="result1", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result1
		};
	}
}