/**
*
* @file  /model/managers/RegistrationFieldDependency.cfc
* @author  
* @description
*
*/
component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="RegistrationFieldDependencyDAO" setter="true" getter="true";
	
	/*
	* Gets the field dependency
	* @field_id The id of the Field
	*/
	public struct function getFieldDependencies( required numeric field_id ) {
		var dependencies = getRegistrationFieldDependencyDAO().RegistrationFieldDependenciesList( argumentCollection:arguments ).result;
		var data = { 'count': dependencies.recordCount, 'data': 
			queryToArray( 
				recordset=dependencies,
				columns=listAppend( dependencies.columnList, "options" ),
					map=function( row, index, columns ) {
						if( ListFindNoCase( "Yes,No", row.value ) ) {
				    		row.value = ' ' & row.value;
				    	}
				        return row;
				    }
			) 
		};
		
		return data;
	}
	/*
	* Gets the field dependency
	* @field_dependency_id The id of the Field dependency
	*/
	public struct function getDependencyByID( required numeric field_dependency_id	) {
		var data = getRegistrationFieldDependencyDAO().RegistrationFieldDependencyGet( argumentCollection:arguments );
		if( ListFindNoCase( "Yes,No", data.value ) ) {
    		data[ 'value' ] = ' ' & data.value;
    	}

		return data;
	}
    /*
	* Removes a Dependency to a Field
	* @field_dependency_id The id of the Field dependency
	*/
	public void function removeDependency( required numeric field_dependency_id ) {
		getRegistrationFieldDependencyDAO().RegistrationFieldDependencyRemove( argumentCollection:arguments );
		getCacheManager().purgeEventRegistrationFieldsCache( getSessionManageUserFacade().getValue('current_event_id') );
		return;
	}
	/*
	* Creates or Updates an Field Dependency and Returns the Field Dependency ID
	* @field_dependency_id The id of the field dependency, null means add
	* @field_id The id of the Field
	* @dependency The id of the field to show if the value matches
	* @value The value to match on to trigger the dependency
	*/
	public numeric function saveDependency(
		numeric field_dependency_id=0,
		required numeric field_id,
		required numeric dependency,
		required string value
	) {
		getCacheManager().purgeEventRegistrationFieldsCache( getSessionManageUserFacade().getValue('current_event_id') );
		return getRegistrationFieldDependencyDAO().RegistrationFieldDependencySet( argumentCollection:arguments );
	}
	/*
	* Gets all field dependencies for an event
	* @event_id The id of the Event
	*/
	public struct function getEventDependencies( required numeric event_id ) {
		var dependencies = getRegistrationFieldDependencyDAO().EventRegistrationFieldDependencies( argumentCollection:arguments ).result;
		var data = { 
			'count': dependencies.recordCount, 
			'data': queryToArray( 
				recordset=dependencies,
				columns=listAppend( dependencies.columnList, "options" ),
					map=function( row, index, columns ) {
						var opts = {'remove_option': "", 'in_use_option': ""};
						var end_option = { 1:"in_use_option",0:"remove_option"};
						if( ListFindNoCase( "Yes,No", row.value ) ) {
				    		row.value = ' ' & row.value;
				    	}
						row['options'] = "<a href=""##"" data-manage=""dependency"" data-field_dependency_id=""" & row.field_dependency_id & """ class=""btn btn-sm btn-primary"" >";
						row['options'] &= "<span class=""glyphicon glyphicon-edit""></span>&nbsp;";
						row['options'] &= "Edit</a>";
						
						opts['remove_option'] &= "&nbsp;<a href=""##"" data-remove=""dependency"" data-field_dependency_id=""" & row.field_dependency_id & """ class=""btn btn-sm btn-danger"" >";
						opts['remove_option'] &= "<span class=""glyphicon glyphicon-remove-circle""></span>&nbsp;";
						opts['remove_option'] &= "Remove</a>";
						
						opts['in_use_option'] &= "&nbsp;<a class=""btn btn-sm btn-danger disabled"" disabled=""disabled"">";
						opts['in_use_option'] &= "<span class=""glyphicon glyphicon-remove-circle""></span>&nbsp;";
						opts['in_use_option'] &= "In Use</a>";
						
						row['options'] &= opts[ end_option[ row.in_use ] ];
						  
				        return row;
				    }
			) 
		};
		
		return data;
	}
	
}