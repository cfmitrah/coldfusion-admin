/**
*
* @file  /model/managers/Geography.cfc
* @author
* @description
*
*/
component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {

	property name="GeographyDao" getter="true" setter="true";
	/*
	* Gets all of the countries
	*/
	public struct function getCountries( ) {
		return queryToStruct( getGeographyDao().CountriesGet( argumentCollection=arguments ).result );
	}
	/*
	* Gets all of the country regions
	* @country_code The 2 letter iso country code
	*/
	public struct function getRegions( required string country_code ) {
		return queryToStruct( getGeographyDao().CountryRegionsGet( argumentCollection=arguments ).result );
	}
	/*
	* Gets all of the country regions as array
	* @country_code The 2 letter iso country code
	*/
	public array function getRegionsArray( required string country_code ) {
		return queryToArray( getGeographyDao().CountryRegionsGet( argumentCollection=arguments ).result );
	}
	/*
	* Gets all of the Available country codes
	*/
	public array function getCountryCodes() {
		return queryToArray( getGeographyDao().CountryCodesGet().result );
	}
	/*
	* Gets all of the country timezones
	* @country_code The 2 letter iso country code
	*/
	public struct function getTimezones( required string country_code ) {
		return queryToStruct( getGeographyDao().CountryTimezonesGet( argumentCollection=arguments ).result );
	}
	
}