/**
*
* @file  /model/managers/RegistrationField.cfc
* @author  
* @description
*
*/
component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="RegistrationSectionDAO" setter="true" getter="true";
	property name="RegistrationTypesDAO" setter="true" getter="true";
	property name="RegistrationFieldManager" setter="true" getter="true";
	property name="RegistrationFieldDependencyManager" setter="true" getter="true";
	property name="FormUtilities" setter="true" getter="true";

	public struct function getSectionTypes( required numeric registration_type_id, string type="all" ) 
	{
		var results = getRegistrationSectionDAO().RegistrationSectionTypesGet( argumentCollection:arguments ).result;
		var rtn = queryToArray( recordSet=results, data=arguments, map=function( row, index, columns, data ) {

			if( ( data.type == "hotel" ) 
				|| ( row.section_type != "hotel" )
				|| ( row.section_type == "hotel" && row.number_in_use == 0 && data.type != "hotel")
				
			) {
				return row;
			}
		});

		rtn = getFormUtilities().arrayRemoveEmpty( rtn );
		return {
			'data':rtn,
			'count':arrayLen( rtn )
		};
	}
	/**
    * I get a list of section for a registration type
    * @registration_type_id ID of the registration type that you want a list of sections for
    */
	public struct function getRegistrationSections( 
		required numeric registration_type_id,
		boolean include_fields=false, 
		boolean include_fields_choices=false, 
		boolean include_field_dependencies=false  ) 
	{
		var sections = getRegistrationSectionDAO().RegistrationSectionsList( arguments.registration_type_id ).result;
		var result = { 'count': sections.recordCount };
		var params = { 'recordset': sections, 'columns': listAppend( sections.columnList, "fields,field_count,dependency_count,field_dependency" ), 'data'={'include_choices':arguments.include_fields_choices, 'include_field_dependencies':arguments.include_field_dependencies} };
		if( arguments.include_fields ) {
			params['map'] = 
			function( row, index, columns, data ) {
				var fields = getRegistrationSectionDAO().RegistrationSectionFieldsList( row.section_id ).result;
				var params = {'recordset'=fields};
				params['data'] = data;
				params['columns'] = listAppend( fields.columnList, "choices" );
				params['map'] = 
				function( row, index, columns, data ) {
					var dependencies = "";
					if( data.include_choices ) {
						row['choices'] = getRegistrationFieldManager().getFieldChoices( row.field_id );
					}
					if( isJSON( row.attributes ) ) {
						row['attributes'] = deserializeJSON( row.attributes );
					}else{
						row['attributes'] = {};
					}
					if( data.include_choices ) {
						dependencies = getRegistrationFieldDependencyManager().getFieldDependencies( row.field_id );
						row[ 'dependency_count' ] = dependencies.count;
						row[ 'field_dependency' ] = dependencies.data;
					}

					return row;
				};
				row['fields'] = queryToArray( argumentCollection:params );
				row['field_count'] = fields.recordCount;
				return row;
			};
		}
		result['data'] = queryToArray( argumentCollection=params);
		return result;
	}
	/**
	* I get a registration section
	* @section_id The ID of the section that you want to get 
	*/
	public struct function getSection( required numeric section_id, boolean include_fields=false ) {
		var section = getRegistrationSectionDAO().RegistrationSectionGet( arguments.section_id );
		if( arguments.include_fields ) {
			section[ 'field_count' ] = section.fieldsrecordCount;
			section[ 'fields' ] = queryToArray( section.fields );
		}else {
			section[ 'fields' ] = '';
		}
		if( isjson( section.settings ) ){
			section['settings'] = deserializeJSON( section.settings );
		}else{
			section['settings'] = {};
		}
		
		structAppend( section['settings'], {'group_allowed':false}, false );
		section['settings'] = lowerStruct( section.settings );
		return section;
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
	public numeric function saveSection(numeric section_id=0,
		required numeric registration_type_id,
		required string label,
		required string title,
		string summary="",
		string layout="",
		numeric sort=0,
		required numeric section_type_id,
		string settings=""
		) {
		var arguments.section_id = getRegistrationSectionDAO().RegistrationSectionSet( argumentCollection:arguments );
		getCacheManager().purgeEventSectionCache( getSessionManageUserFacade().getValue('current_event_id'), arguments.registration_type_id );
		return arguments.section_id;
	}
	/**
    * I remove a section
    * @section_id The ID of the section that you want to remove.
    * @registration_type_id  The registration type ID that you want to remove
    */
	public void function removeSection( required numeric section_id, required numeric registration_type_id ) {
		getRegistrationSectionDAO().RegistrationSectionRemove( argumentCollection:arguments );
		getCacheManager().purgeEventSectionCache( getSessionManageUserFacade().getValue('current_event_id'), arguments.registration_type_id );
		return;
	}
	/**
    * I update the sort of the registration sections
    * @section_ids A comma seperated list of section IDs
    * @registration_type_id  The registration type ID
    */
    public void function updateSectionSort( required string section_ids, required numeric registration_type_id ) {
		getRegistrationSectionDAO().RegistrationSectionsSortOrderSet( argumentCollection:arguments );
		getCacheManager().purgeEventSectionCache( getSessionManageUserFacade().getValue('current_event_id'), arguments.registration_type_id );
		return;
	}
	/**
    * I update the sort of the registration section fields
    * @field_ids A comma seperated list of field IDs
    * @section_id  The section_id type ID
    */
    public void function updateSectionFieldSort( required string field_ids, required numeric section_id ) {
		getRegistrationSectionDAO().RegistrationSectionFieldsSortOrderSet( argumentCollection:arguments );
		getCacheManager().purgeEventSectionCache( getSessionManageUserFacade().getValue('current_event_id') );
		return;
	}
	/**
    * I get all of the registration forms, section and fields
    * @event_id
    */
	public struct function getEventRegistrationSections( required numeric event_id ) {
		var types = getRegistrationTypesDAO().registrationTypesGet( arguments.event_id ).result.registration_types;
		var result = { 
			'data'=queryToArray( 
				recordset=types,
				columns=listAppend( types.columnList, "sections,section_count" ),
				map=function( row, index, columns, data ){
					var sections = getRegistrationSectionDAO().EventRegistrationSectionsList( data.event_id, row.registration_type_id ).result;
					row['section_count'] = sections.recordCount;
					row['sections'] = queryToArray( 
						recordset=sections, 
						columns=listAppend( sections.columnList, "fields,field_count" ),
						map=function( row, index, columns, data ){
							var fields = getRegistrationSectionDAO().RegistrationSectionFieldsList( row.section_id ).result;
					    	row['fields'] = queryToArray( fields );
					    	row['field_count'] = fields.recordCount;
					        return row;
						});
			        return row;
				},data={ 'event_id': arguments.event_id } ),
			'count': types.recordCount
			 };
		return result;
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
		getRegistrationSectionDAO().RegistrationSectionFieldSet( argumentCollection:arguments );
		getCacheManager().purgeEventSectionCache( getSessionManageUserFacade().getValue('current_event_id') );
		return ;
	}
	/**
    * I remove field from a section
    * @field_id The ID of the field that you want to remove
    * @section_id The ID of the section that you want to remove a field from
    */
    public void function RegistrationSectionFieldRemove( required numeric field_id, required numeric section_id ) {
		getRegistrationSectionDAO().RegistrationSectionFieldRemove( argumentCollection:arguments );
		getCacheManager().purgeEventSectionCache( getSessionManageUserFacade().getValue('current_event_id') );
		return;
	}
	/**
    * I duplicate a section
    * @registration_type_id The ID of the type of path to copy
    * @registration_type_id_copy_to The ID of the type of path to copy to
    */
    public void function duplicateSection( required numeric registration_type_id, required numeric registration_type_id_copy_to ) {
		getRegistrationSectionDAO().RegistrationSectionPathsCopy( argumentCollection:arguments );
		getCacheManager().purgeEventSectionCache( getSessionManageUserFacade().getValue('current_event_id') );
		return;
	}
//	
	
	
}