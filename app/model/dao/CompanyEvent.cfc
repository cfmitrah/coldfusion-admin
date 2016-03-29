/**
*
* @file  /app/model/dao/CompanyEvent.cfc
* @author  
* @description
*
*/
component accessors="true" extends="app.model.base.Dao" {
	/*
	* Gets all of the events for a given company
	* @company_id The id of the company
	* @start The row to start on
	* @results The number of results to return
	* @sort_column The column to sort on.  Values can be: name, start_date, end_date, publish_on, published, event_status, domain, slug
	* @sort_direction The direction to sort the results
	* @search A keyword to use to filter the results
	*/
	public struct function CompanyEventList(
		required numeric company_id,
		numeric start=1,
		numeric results=10,
		string sort_column="start_date",
		string sort_direction="DESC",
		string search="",
		numeric user_id=0
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CompanyEventList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", value=arguments.sort_column, maxlength=50, null=( !len( arguments.sort_column ) ) );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", value=arguments.sort_direction, maxlength=4, null=( !len( arguments.sort_direction ) ) );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", value=arguments.search, maxlength=200, null=( !len( arguments.search ) ) );
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id,  null=( !arguments.user_id ) );
		sp.addProcResult( name="events", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Gets all of the events for a given company
	*/
	public struct function CompanyEventSelectList( required numeric company_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CompanyEventSelectList"
		});
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addProcResult( name="events", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().events
		};
	}
}