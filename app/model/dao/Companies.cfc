/**
* I am the DAO for the Companies object
* @file  /model/dao/Companies.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {
	/**
	* I get all companies
	*/
	public struct function companiesGet() {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "CompaniesGet"
		});

		sp.addProcResult( name="companies", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}

/*
	* Gets all of the companies
	* @start The row to start on
	* @results The number of results to return
	* @sort_column The column to sort on.  Values can be: name
	* @sort_direction The direction to sort the results
	* @search A keyword to use to filter the results
	*/
	public struct function CompaniesList(
		numeric start_row=1,
		numeric total_rows=10,
		string sort_column="company_name",
		string sort_direction="DESC",
		string search_value=""
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CompanyList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start_row, null=( !arguments.start_row ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.total_rows, null=( !arguments.total_rows ) );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", value=arguments.sort_column, maxlength=50, null=( !len( arguments.sort_column ) ) );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", value=arguments.sort_direction, maxlength=4, null=( !len( arguments.sort_direction ) ) );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", value=arguments.search_value, maxlength=200, null=( !len( arguments.search_value ) ) );
		sp.addProcResult( name="companies", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}

}