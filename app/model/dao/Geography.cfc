/**
* I am the DAO for the Geography object
* @file  /model/dao/Geography.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/**
	* I get all of the countries.
	*/
	public struct function CountriesGet( string has_regions="" ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "CountriesGet"
		});
		sp.addParam( type="in", dbvarname="@has_regions", cfsqltype="cf_sql_bit", value=arguments.has_regions, null=( !len( arguments.has_regions ) ) );
		sp.addProcResult( name="countries", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().countries
		};
	}
	/**
	* I get all of a countries regions.
	* @country_code The code of the country that you want to get regions for.
	*/
	public struct function CountryRegionsGet( required string country_code ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "CountryRegionsGet"
		});
		trim_fields( arguments );
		sp.addParam( type="in", dbvarname="@country_code", cfsqltype="cf_sql_char", maxlength=2, value=arguments.country_code );
		sp.addProcResult( name="countries", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().countries
		};
	}
	/**
	* I get all of the time zones for a country
	* @country_code The code of the country that you want to get time zones for.
	*/
	public struct function CountryTimezonesGet( required string country_code ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "CountryRegionsGet"
		});
		trim_fields( arguments );
		sp.addParam( type="in", dbvarname="@country_code", cfsqltype="cf_sql_char", maxlength=2, value=arguments.country_code );
		sp.addProcResult( name="timezones", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().timezones
		};
	}
	/*
	* Gets all of the Available country codes
	*/
	public struct function CountryCodesGet() {		
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CountryCodesGet"
		});
		sp.addProcResult( name="result1", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result1
		};
	}
	
}