/**
*
* @file  /model/dao/WebsiteTheme.cfc
* @author - JG
*
*/
component accessors="true" extends="app.model.base.Dao" {
	/*
	* Gets all of the Available font families
	*/
	public struct function FontFamiliesGet() {				
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "FontFamiliesGet"
		});
		sp.addProcResult( name="fonts", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Gets all of the Registration Theme Elments, Media and Fonts for the event
	* @event_id The id of the event
	*/
	public struct function RegistrationThemeElementsGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationThemeElementsGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="theme", resultset=1 );
		sp.addProcResult( name="media", resultset=2 );
		sp.addProcResult( name="fonts", resultset=3 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Gets all of the Available theme element types
	*/
	public struct function RegistrationThemeElementTypesGet() {		
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationThemeElementTypesGet"
		});
		sp.addProcResult( name="types", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Takes a JSON string of elements and Creates or Updates RegistrationTheme Elements, Media and Fonts
	* @event_id The id of the event
	* @elements_JSON The JSON string of element_types and element values for the event
	*/
	public struct function RegistrationThemeElementsSet(
		required numeric event_id,
		required string elements_JSON
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationThemeElementsSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@elements_JSON", cfsqltype="cf_sql_longvarchar", value=arguments.elements_JSON );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}	
	/*
	* Creates or Updates a RegistrationThemeMedia for the event and element type
	* @event_id The id of the event
	* @element_type The element_type of the media
	* @media_id The media_id of the media
	*/
	public struct function RegistrationThemeMediaSet(
		required numeric event_id,
		required string element_type,
		required numeric media_id
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationThemeMediaSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@element_type", cfsqltype="cf_sql_varchar", value=arguments.element_type, maxlength=25 );
		sp.addParam( type="in", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
}