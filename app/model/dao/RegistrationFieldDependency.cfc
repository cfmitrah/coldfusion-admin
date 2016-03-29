/**
* 
* I am the DAO for the Registration Fields object
* @file  /model/dao/RegistrationFieldDependency.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/*
	* Gets the field dependency
	* @field_id The id of the Field
	*/
	public struct function RegistrationFieldDependenciesList( required numeric field_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationFieldDependenciesList"
		});
		sp.addParam( type="in", dbvarname="@field_id", cfsqltype="cf_sql_bigint", value=arguments.field_id );
		sp.addProcResult( name="Dependencies", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().Dependencies
		};
	}
	/*
	* Gets the field dependency
	* @field_dependency_id The id of the Field dependency
	*/
	public struct function RegistrationFieldDependencyGet(
		required numeric field_dependency_id
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationFieldDependencyGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@field_dependency_id", cfsqltype="cf_sql_bigint", value=arguments.field_dependency_id, variable="field_dependency_id" );
		sp.addParam( type="out", dbvarname="@field_id", cfsqltype="cf_sql_bigint", variable="field_id" );
		sp.addParam( type="out", dbvarname="@dependency", cfsqltype="cf_sql_bigint", variable="dependency" );
		sp.addParam( type="out", dbvarname="@value", cfsqltype="cf_sql_longvarchar", variable="value" );

		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
    /*
	* Removes a Dependency to a Field
	* @field_dependency_id The id of the Field dependency
	*/
	public void function RegistrationFieldDependencyRemove( required numeric field_dependency_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationFieldDependencyRemove"
		});
		sp.addParam( type="in", dbvarname="@field_dependency_id", cfsqltype="cf_sql_bigint", value=arguments.field_dependency_id );
		result = sp.execute();
		return;
	}
	/*
	* Creates or Updates an Field Dependency and Returns the Field Dependency ID
	* @field_dependency_id The id of the field dependency, null means add
	* @field_id The id of the Field
	* @dependency The id of the field to show if the value matches
	* @value The value to match on to trigger the dependency
	*/
	public numeric function RegistrationFieldDependencySet(
		required numeric field_dependency_id,
		required numeric field_id,
		required numeric dependency,
		required string value
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationFieldDependencySet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@field_dependency_id", cfsqltype="cf_sql_bigint", value=arguments.field_dependency_id, null=( !arguments.field_dependency_id ), variable="field_dependency_id" );
		sp.addParam( type="in", dbvarname="@field_id", cfsqltype="cf_sql_bigint", value=arguments.field_id );
		sp.addParam( type="in", dbvarname="@dependency", cfsqltype="cf_sql_bigint", value=arguments.dependency );
		sp.addParam( type="in", dbvarname="@value", cfsqltype="cf_sql_longvarchar", value=arguments.value );
		result = sp.execute();
		return result.getProcOutVariables().field_dependency_id;
	}
	/*
	* Gets all field dependencies for an event
	* @event_id The id of the Event
	*/
	public struct function EventRegistrationFieldDependencies( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventRegistrationFieldDependencies"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="Dependencies", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().Dependencies
		};
	}
}