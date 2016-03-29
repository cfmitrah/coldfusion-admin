/**
* I am the DAO for the Airport object
* @file  /model/dao/Airport.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/**
	* I check to see if an airport slug exists
	* @airport_id The ID of the airport that you are checking the slug for
	* @slug The slug that you are checking
	*/
	public boolean function airportSlugExists( required numeric airport_id, required string slug ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "AirportSlugExists"
		});
		sp.addParam( type="in", dbvarname="@airline_id", cfsqltype="cf_sql_integer", value=arguments.airline_id );
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", maxlength=300, value=trim( arguments.slug ) );
		sp.addParam( type="out", dbvarname="@in_use", cfsqltype="cf_sql_bit", variable="exists" );
		result = sp.execute();
		return result.getProcOutVariables().exists;
	}

}