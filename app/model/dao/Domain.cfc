/**
* I am the DAO for the Domain object
* @file  /model/dao/Domain.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/**
	* I check to see if a domain exists.
	* @domain_name The domain name that you are checking.
	*/
	public boolean function domainExists( required numeric domain_name ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "DomainExists"
		});
		sp.addParam( type="in", dbvarname="@domain_name", cfsqltype="cf_sql_varchar", maxlength=300, value=trim( arguments.domain_name ) );
		sp.addParam( type="out", dbvarname="@domain_exists", cfsqltype="cf_sql_bit", variable="exists" );
		result = sp.execute();
		return result.getProcOutVariables().exists;
	}
	/**
	* I check to see if a domain is assigned.
	* @domain_name The domain name that you are checking.
	*/
	public boolean function domainIsAssigned( required numeric domain_name ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "DomainIsAssigned"
		});
		sp.addParam( type="in", dbvarname="@domain_name", cfsqltype="cf_sql_varchar", maxlength=300, value=trim( arguments.domain_name ) );
		sp.addParam( type="out", dbvarname="@is_assigned", cfsqltype="cf_sql_bit", variable="exists" );
		result = sp.execute();
		return result.getProcOutVariables().exists;
	}

	
}