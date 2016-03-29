/**
* 
* I am the DAO for the Registration Section object
* @file  /model/dao/RegistrationSection.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {
	/*
	* Gets all of Registration Section Types with count of how many in use
	* @registration_type_id 
	*/
	public struct function RegistrationSectionTypesGet( required numeric registration_type_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationSectionTypesGet"
		});
		sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );
		sp.addProcResult( name="result", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result
		};
	}
	/**
	* I save a registration section
	* @section_id The ID of the section that you want to save
	* @registration_type_id The registration type id
	* @registration_type The registration_type
	* @label The label for the section
	* @title The titl for the section
	* @summary A breif summary for the section
	* @layout The layout for the section
	* @sort The sort for the section
	*/
	public numeric function RegistrationSectionSet( 
		numeric section_id=0,
		required numeric registration_type_id,
		required string label,
		required string title,
		string summary="",
		string layout="",
		numeric sort=0,
		required numeric section_type_id ) {
        var sp = new StoredProc();
        var result = {};
        sp.setAttributes({
            'datasource' = getDSN(),
            'procedure' = "RegistrationSectionSet"
        });
        sp.addParam( type="inout", dbvarname="@section_id", cfsqltype="cf_sql_integer", value=arguments.section_id, variable="section_id", null=( !arguments.section_id ) );
        sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );
        sp.addParam( type="in", dbvarname="@label", cfsqltype="cf_sql_varchar", maxlength=50, value=trim( arguments.label ) );
        sp.addParam( type="in", dbvarname="@title", cfsqltype="cf_sql_varchar", maxlength=250, value=trim( arguments.title ) );
        sp.addParam( type="in", dbvarname="@summary", cfsqltype="cf_sql_longvarchar", value=trim( arguments.summary ), null=( !len( trim( arguments.summary ) ) ) );
        sp.addParam( type="in", dbvarname="@layout", cfsqltype="cf_sql_varchar", maxlength=50, value=trim( arguments.layout ), null=( !len( trim( arguments.layout ) ) ) );
        sp.addParam( type="in", dbvarname="@sort", cfsqltype="cf_sql_integer", value=arguments.sort, null=( !arguments.sort ) );
        sp.addParam( type="in", dbvarname="@section_type_id", cfsqltype="cf_sql_integer", value=arguments.section_type_id, null=( !arguments.section_type_id ) );
		sp.addParam( type="in", dbvarname="@settings", cfsqltype="cf_sql_longvarchar", value=arguments.settings, null=( !len( arguments.settings ) ) );
		
        result = sp.execute();
        return result.getProcOutVariables().section_id;
    }
	/**
	* I get max sort order for registration section
	* @registration_type_id The registration type ID that you want to get the max sort for
	*/
	public struct function RegistrationSectionsMaxSortGet( required numeric registration_type_id ) {
        var sp = new StoredProc();
        var result = {};
        var data = {};
        sp.setAttributes({
            'datasource' = getDSN(),
            'procedure' = "RegistrationSectionsMaxSortGet"
        });
        sp.addParam( type="inout", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id, variable="registration_type_id" );
        sp.addParam( type="out", dbvarname="@sort", cfsqltype="cf_sql_integer", variable="sort" );

        result = sp.execute();
        return result.getProcOutVariables().sort;
    }
	/**
    * I remove a section
    * @section_id The ID of the section that you want to remove.
    * @registration_type_id  The registration type ID that you want to remove
    */
    public void function RegistrationSectionRemove( required numeric section_id, required numeric registration_type_id ) {
    	var sp = new StoredProc();
        var result = {};
        sp.setAttributes({
            'datasource' = getDSN(),
            'procedure' = "RegistrationSectionRemove"
        });
        sp.addParam( type="in", dbvarname="@section_id", cfsqltype="cf_sql_integer", value=arguments.section_id );
        sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );

        result = sp.execute();
		return;
    }
    /**
	* I get a registration section
	* @section_id The ID of the section that you want to get 
	*/
	public struct function RegistrationSectionGet( required numeric section_id ) {
        var sp = new StoredProc();
        var result = {};
        var data = {};
        sp.setAttributes({
            'datasource' = getDSN(),
            'procedure' = "RegistrationSectionGet"
        });
        sp.addParam( type="inout", dbvarname="@section_id", cfsqltype="cf_sql_integer", value=arguments.section_id, variable="section_id" );
        sp.addParam( type="out", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", variable="registration_type_id" );
        sp.addParam( type="out", dbvarname="@registration_type", cfsqltype="cf_sql_varchar", variable="registration_type" );
        sp.addParam( type="out", dbvarname="@label", cfsqltype="cf_sql_varchar", variable="label" );
        sp.addParam( type="out", dbvarname="@title", cfsqltype="cf_sql_varchar", variable="title" );
        sp.addParam( type="out", dbvarname="@summary", cfsqltype="cf_sql_longvarchar", variable="summary" );
        sp.addParam( type="out", dbvarname="@layout", cfsqltype="cf_sql_varchar", variable="layout" );
        sp.addParam( type="out", dbvarname="@sort", cfsqltype="cf_sql_integer", variable="sort" );
        sp.addParam( type="out", dbvarname="@section_type_id", cfsqltype="cf_sql_integer", variable="section_type_id" );
		sp.addParam( type="out", dbvarname="@section_type", cfsqltype="cf_sql_varchar", variable="section_type" );
		sp.addParam( type="out", dbvarname="@section_type_name", cfsqltype="cf_sql_varchar", variable="section_type_name" );
		sp.addParam( type="out", dbvarname="@settings", cfsqltype="cf_sql_longvarchar", variable="settings" );
        sp.addProcResult( name="fields", resultset=1 );result = sp.execute();

        data['prefix'] = result.getPrefix();
        structAppend( data, result.getProcOutVariables() );
        structAppend( data, result.getProcResultSets() );
        return data;
    }
	/**
	* I get a list of fields for a section
	* @section_id I ID of the section that you want to get the fields for 
	*/
	public struct function RegistrationSectionFieldsList( required numeric section_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "RegistrationSectionFieldsList"
		});
		
		sp.addParam( type="in", dbvarname="@section_id", cfsqltype="cf_sql_integer", value=arguments.section_id );
		sp.addProcResult( name="fields", resultset=1 );
		
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().fields
			};
	}
	/**
	* I add a field to a section
	* @section_id The ID of the section that you want add a field to.
	* @field_id The ID of the field that you want to add
	* @sort The sort order that you want the field to display in
	*/
	public void function RegistrationSectionFieldSet( 
		required numeric section_id, 
		required numeric field_id,
		numeric sort=0 ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "RegistrationSectionFieldSet"
		});
		
		sp.addParam( type="in", dbvarname="@section_id", cfsqltype="cf_sql_integer", value=arguments.section_id );
        sp.addParam( type="in", dbvarname="@field_id", cfsqltype="cf_sql_integer", value=arguments.field_id );
        sp.addParam( type="in", dbvarname="@sort", cfsqltype="cf_sql_integer", value=arguments.sort, null=( !arguments.sort ) );
		
		result = sp.execute();
		return ;
	}
	/**
    * I remove field from a section
    * @field_id The ID of the field that you want to remove
    * @section_id The ID of the section that you want to remove a field from
    */
    public void function RegistrationSectionFieldRemove( required numeric field_id, required numeric section_id ) {
    	var sp = new StoredProc();
        var result = {};
        sp.setAttributes({
            'datasource' = getDSN(),
            'procedure' = "RegistrationSectionFieldRemove"
        });
        sp.addParam( type="in", dbvarname="@section_id", cfsqltype="cf_sql_integer", value=arguments.section_id );
        sp.addParam( type="in", dbvarname="@field_id", cfsqltype="cf_sql_integer", value=arguments.field_id );
        

        result = sp.execute();
		return;
    }
    /**
    * I get a list of section for a registration type
    * @registration_type_id ID of the registration type that you want a list of sections for
    */
    public struct function RegistrationSectionsList( required numeric registration_type_id ) {
        var sp = new StoredProc();
        var result = {};
        sp.setAttributes({
            'datasource' = getDSN(),
            'procedure' = "RegistrationSectionsList"
        });
        
        sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );
        sp.addProcResult( name="sections", resultset=1 );
        
        result = sp.execute();
        return {
            'prefix' = result.getPrefix(),
            'result' = result.getProcResultSets().sections
            };
    }
    /**
    * I get a list of sections for an event
    * @event_id I ID of the event that you want sections for
    * @registration_type_id The registration type id that you want sections for
    */
    public struct function EventRegistrationSectionsList( required numeric event_id, numeric registration_type_id=0 ) {
        var sp = new StoredProc();
        var result = {};
        sp.setAttributes({
            'datasource' = getDSN(),
            'procedure' = "EventRegistrationSectionsList"
        });
        
        sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
        sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id, null=( !arguments.registration_type_id ) );
        sp.addProcResult( name="sections", resultset=1 );
        
        result = sp.execute();
        return {
            'prefix' = result.getPrefix(),
            'result' = result.getProcResultSets().sections
            };
    }
    /**
    * I update the sort of the registration sections
    * @section_ids A comma seperated list of section IDs
    * @registration_type_id  The registration type ID
    */
    public void function RegistrationSectionsSortOrderSet( required string section_ids, required numeric registration_type_id ) {
        var sp = new StoredProc();
        var result = {};
        sp.setAttributes({
            'datasource' = getDSN(),
            'procedure' = "RegistrationSectionsSortOrderSet"
        });
        sp.addParam( type="in", dbvarname="@section_ids", cfsqltype="cf_sql_varchar", value=arguments.section_ids );
        sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );

        result = sp.execute();
        return;
    }
    /**
    * I update the sort of the registration section fields
    * @field_ids A comma seperated list of field IDs
    * @section_id  The section ID
    */
    public void function RegistrationSectionFieldsSortOrderSet( required string field_ids, required numeric section_id ) {
        var sp = new StoredProc();
        var result = {};
        sp.setAttributes({
            'datasource' = getDSN(),
            'procedure' = "RegistrationSectionFieldsSortOrderSet"
        });
        sp.addParam( type="in", dbvarname="@field_ids", cfsqltype="cf_sql_varchar", value=arguments.field_ids );
        sp.addParam( type="in", dbvarname="@section_id", cfsqltype="cf_sql_integer", value=arguments.section_id );

        result = sp.execute();
        return;
    }
    /*
	* Copies all the registration sections for a registration type to a new registration type
	* @registration_type_id The id of the registration type to copy
	* @registration_type_id_copy_to The id of the registration type to copy to
	*/
	public void function RegistrationSectionPathsCopy(
		required numeric registration_type_id,
		required numeric registration_type_id_copy_to
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationSectionPathsCopy"
		});
		sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );
		sp.addParam( type="in", dbvarname="@registration_type_id_copy_to", cfsqltype="cf_sql_integer", value=arguments.registration_type_id_copy_to );
		result = sp.execute();
		return;
	}
}