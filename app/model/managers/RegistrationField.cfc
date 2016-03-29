/**
*
* @file  /model/managers/RegistrationField.cfc
* @author  
* @description
*
*/
component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="RegistrationFieldDAO" setter="true" getter="true";
	property name="slugManager" getter="true" setter="true";
	property name="BaseX" getter="true" setter="true";
	
	/**
	* I remove a registration field
	* @field_id the ID of the filed that you want to remove
	*/
	public void function removeRegistrationField( required numeric field_id ) {
		getRegistrationFieldDAO().RegistrationFieldRemove( arguments.field_id );
		getCacheManager().purgeEventRegistrationFieldsCache( getSessionManageUserFacade().getValue('current_event_id') );
		return;
	}
	/**
	* I get a List of Registration Fields for an event
	* @event_id The ID of the event that you want the standard registration fields for
	*/
	public struct function getStandardRegistrationFields( required numeric event_id, numeric draw=1, numeric standard_field ) {
		var fields = getRegistrationFieldDAO().RegistrationFieldsStandardList( arguments.event_id, arguments.standard_field ).result;
		var rtn = {"draw": arguments.draw,
			"recordsTotal": fields.recordCount,
			"recordsFiltered": 0,
			"data": "" };
			rtn['data'] = queryToArray(
				recordset=fields,
				columns=listAppend( fields.columnList, "options" ),
					map=function( row, index, columns, data ){
				    	var icon = { "1": "<span class=""glyphicon glyphicon-ok""></span>", "0": "" };
				    	var manage_type = { '0': "standard", '1': "registration", '2':"login", '3':"hotel" };
				    	var assign = "<a href=""##"" data-manage=""quick_assign"" data-standard_field_type=""" & row.standard_field & """ data-standard_field_id=""" & row.standard_field_id & """ class=""btn btn-sm btn-info"">Quick Assign</a>";
				    	var unassign = "<a href=""##"" data-remove=""unassign"" data-standard_field_type=""" & row.standard_field & """ data-field_id=""" & row.field_id & """ class=""btn btn-sm btn-warning""> Unassign</a>";
				    	var quick = { "Yes": assign, "No": unassign };
				    	var manage = manage_type[ int( row.field_id != 0 ) ];
				    	//if( row.field_id == 0 && data.standard_field == 2 ) { manage = manage_type[ 2 ]; }
				    	row['options'] = "<a href=""##"" data-standard_field_id=""" & row.standard_field_id & """ class=""btn btn-primary btn-sm"" ";
						row['options'] &= " data-field_id=""" & row.field_id & """ ";
						
						row['options'] &= " data-manage=""" & manage & """ >";
						row['options'] &= "Manage</a>";
						
						
						
						if( row.in_use ) {
							row['options'] &= "&nbsp;<a class=""btn btn-sm btn-danger disabled"" disabled=""disabled"">";
							row['options'] &= "<span class=""glyphicon glyphicon-remove-circle""></span>&nbsp;";
							row['options'] &= "In Use</a>";		
						}
						else {
						//if( data.standard_field != 2 ) 
							row['options'] &= quick[ row.field_id == 0 ];
						}
						row['required'] = icon[ row['required'] ];
						row['visible'] = icon[ row['visible'] ];
						    
				        return row;
				    },
				data={'standard_field':arguments.standard_field}
				);
		
		return rtn;
	}
	/**
	* I get a List of Registration Fields for an event
	* @event_id The ID of the event that you want the standard registration fields for
	*/
	public struct function getRegistrationFields( required numeric event_id, boolean standard_field=false, numeric draw=1 ) {
		var fields = getRegistrationFieldDAO().RegistrationFieldsList( arguments.event_id, arguments.standard_field ).result.fields;
		var rtn = {"draw": arguments.draw,
			"recordsTotal": fields.recordCount,
			"recordsFiltered": 0,
			"data": "" };

			rtn['data'] = queryToArray(
				recordset=fields,
				columns=listAppend( fields.columnList, "options" ),
					map=function( row, index, columns ){
				    	var icon = {"1"="<span class=""glyphicon glyphicon-ok""></span>", "0"="" };
				    	var opts = {'remove_option': "", 'in_use_option': "", 'duplicate_option':""};
						var end_option = { 1:"in_use_option",0:"remove_option"};

						row['options'] = "<a href=""##"" data-field_id=""" & row.field_id & """ class=""btn btn-primary btn-sm"" ";
						row['options'] &= " data-manage=""custom"" >";
						row['options'] &= "<span class=""glyphicon glyphicon-edit""></span> <strong>Manage</strong> </a>";
						
						opts['in_use_option'] &= "&nbsp;<a class=""btn btn-sm btn-danger disabled"" disabled=""disabled"">";
						opts['in_use_option'] &= "<span class=""glyphicon glyphicon-remove-circle""></span>&nbsp;";
						opts['in_use_option'] &= "In Use</a>";						
				    	
						opts['remove_option'] &= "&nbsp;<a href=""##"" data-field_id=""" & row.field_id & """ class=""btn btn-danger btn-sm"" ";
						opts['remove_option'] &= " data-remove=""custom"" >";
						opts['remove_option'] &= "<span class=""glyphicon glyphicon-remove-circle""></span> <strong>Remove</strong> </a>";
						
						opts['duplicate_option'] &= "&nbsp;<a href=""##"" data-field_id=""" & row.field_id & """ class=""btn btn-success btn-sm"" ";
						opts['duplicate_option'] &= " data-duplicate=""true"" >";
						opts['duplicate_option'] &= "<i class=""fa fa-files-o""></i> <strong>Duplicate</strong> </a>";
						
						row['options'] &= opts[ end_option[ row.in_use ] ] & opts['duplicate_option'];
						row['required'] = icon[ row['required'] ];
						    
				        return row;
				    }
				);
		
		return rtn;
	}
	/**
	* I get a List of All of Registration Fields for an event
	* @event_id The ID of the event that you want the standard registration fields for
	*/
	public struct function getAllEventRegistrationFields( required numeric event_id ) {
		var fields = getRegistrationFieldDAO().RegistrationFieldsList( arguments.event_id ).result.fields;
		var rtn = {'count': fields.recordCount,
			'data': queryToArray( recordset=fields,
				columns=listAppend( fields.columnList, "has_options" ),
					map=function( row, index, columns ){
				    	var has_options = {"Yes"=true, "No"=false };
				    	row['has_options'] = has_options[ yesNoFormat( listFindNoCase( "radio,checkbox,select,multiple_select", row.field_type ) ) ];
						    
				        return row;
				    } )
			};

		return rtn;
	}
	/**
    * I get a list of un-used fields for an registration type
    * @event_id I ID of the event that you want un-used fields for
    * @registration_type_id The registration type id that you want un-used fields for
    */
	public struct function getUnusedRegistrationFields( required numeric event_id, required numeric registration_type_id ) {
		var fields = getRegistrationFieldDAO().RegistrationTypeUnusedFieldsList( argumentcollection:arguments ).result;
		var rtn = { 
			'data': queryToArray( recordset=fields ), 
			'count': fields.recordCount };
		return rtn;
	}
	/**
	* I save a Registration Field for an event
	* @event_id The ID of the event that you are adding the field to 
	* @field_type The field type 
	* @label The label for the field
	* @field_name The field name
	* @required Is the field required
	* @standard_field Is the field a standard field
	* @attributes The attributes of the field
	*/
	/* todo: ONCE REG HAS GONE LIVE FIELD LABEL CAN NOT BE CHANGED */
	public numeric function saveRegistrationField( 
		numeric field_id=0,
		required numeric event_id,
		required string field_type,
		required string label,
		boolean required=false,
		numeric standard_field=0,
		string attributes= "",
		string narrative= "",
		array choices=[],
		array delete_choices=[] ) {
		var params = arguments;
		var choice_cnt = arrayLen( choices );
		var choice_delete_cnt = arrayLen( delete_choices );
		var choice_id = 0;
		var choice = {};
		var choice_params = {};
		var old_field = {};
		

		if( !arguments.standard_field ){//If this is not a standard field generate awesome name.
			if(arguments.field_id) {
				old_field = getRegistrationField( arguments.field_id, arguments.event_id );
				params['field_name'] = old_field.field_name;
			}else{
				params['field_name'] = getSlugManager().generate( input=params.label, separator="_" ) & "_xxx" & getBaseX().epoch();
			}
		}
		params['field_id'] = getRegistrationFieldDAO().RegistrationFieldSet( argumentcollection:params );
		
		//handle adding choices
		if( choice_delete_cnt ){
			for (var i=1;i lte choice_delete_cnt; i = i+1 ) {
				getRegistrationFieldDAO().RegistrationFieldChoiceRemove( arguments.delete_choices[i].id );	
			};
		}

		if( choice_cnt ){
			for (var i=1;i lte choice_cnt; i = i+1 ) {
				choice = arguments.choices[i];
				choice_params = {
					'choice_id': choice.id,
					'field_id': params.field_id,
					'choice': choice.value,
					'value': choice.value,
					'sort': i
				};

				choice_id = getRegistrationFieldDAO().RegistrationFieldChoiceSet( argumentcollection:choice_params );	
			};
		}
		getCacheManager().purgeEventRegistrationFieldsCache( arguments.event_id );
		return params.field_id;
	}
	/**
	* I get a registration field
	* @field_id The ID of the field that you want to get
	*/
	public struct function getRegistrationField( required numeric field_id, required numeric event_id ) {
		var rtn = getRegistrationFieldDAO().RegistrationFieldGet( argumentcollection:arguments );
		rtn['choices'] = queryToArray( 
			recordset=rtn.choices,
					map=function( row, index, columns ){
				    	if( ListFindNoCase( "Yes,No", row.choice ) ) {
				    		row.choice = ' ' & row.choice;
				    	}
				    	if( ListFindNoCase( "Yes,No", row.value ) ) {
				    		row.value = ' ' & row.value;
				    	}
				        return row;
				    }
				 );

		rtn['dependencies'] = queryToArray( rtn.dependencies );
		if( isJson( rtn.attributes ) ){
			rtn['attributes'] = deserializeJSON( rtn.attributes );
			if( isStruct(rtn.attributes)) {
				rtn['attributes'] = lowerStruct( rtn.attributes );
			}
			
		}
		return lowerStruct( rtn );
	}
	/**
	* I get a standard registration field
	* @standard_field_id The ID of the standard field that you want to get
	*/
	public struct function getStandardRegistrationField( required numeric standard_field_id ) {
		var rtn = getRegistrationFieldDAO().RegistrationStandardFieldGet( argumentcollection:arguments );
		rtn['choices'] = queryToArray( rtn.choices );
		if( isJson( rtn.attributes ) ){
			rtn['attributes'] = deserializeJSON( rtn.attributes );
		}
		return rtn;
	}
	/**
	* 
	* @standard_field_id The ID of the standard field that you want to quick save
	*/
	public numeric function quickSaveStandardField( required numeric standard_field_id, required numeric event_id ) {
		var data = arguments;
		var field_id = 0;
		data['standard_field'] = true;
		structAppend( data, getRegistrationFieldDAO().RegistrationStandardFieldGet( argumentcollection:arguments ), true );
		data[ 'choices' ] = queryToArray( data.choices );

		field_id = saveRegistrationField( argumentCollection:data );

		getCacheManager().purgeEventRegistrationFieldsCache( arguments.event_id );
		return field_id;
	}
	/**
	* I get a list registration field types
	*/
	public struct function getRegistrationFieldTypes( ) {
		var field_types = getRegistrationFieldDAO().RegistrationFieldTypesGet().result.field_types;
		var data = { 
			"types": queryToArray( recordset=field_types,
					columns=listAppend( field_types.columnList, "allow_options" ),
					map=function( row, index, columns ){
						var opts = {'Yes':true,'No':false};
				    	row['allow_options']=opts[ ListFindNoCase( "select,checkbox,radio,multiple_select", row.field_type ) gt 0 ];
				        return row;
				    }
				), 
			"cnt": field_types.recordCount };
		return data;
	}
	/**
	* I get a list registration field for an event
	*/
	public struct function getEventRegistrationFields( required numeric event_id ) {
		var  fields = getRegistrationFieldDAO().RegistrationFieldsList( arguments.event_id ).result.fields;
		var result = {
			'data': queryToArray ( fields ),
			'count': fields.recordCount
		};
		
		return result;
	}
	/**
	* I get a list registration field for an event
	*/
	public struct function getFieldChoices( required numeric field_id ) {
		var choices = getRegistrationFieldDAO().RegistrationFieldChoicesList( arguments.field_id ).result.choices;
		var result = {
			'data': queryToArray ( 
				recordset=choices,
					map=function( row, index, columns ){
				    	if( ListFindNoCase( "Yes,No", row.choice ) ) {
				    		row.choice = ' ' & row.choice;
				    	}
				    	if( ListFindNoCase( "Yes,No", row.value ) ) {
				    		row.value = ' ' & row.value;
				    	}
						    
				        return row;
				    }
			 ),
			'count': choices.recordCount
		};
		
		return result;
	}
	/**
	* I copy a custom field
	*/
	public numeric function duplicateField( required numeric field_id, required string label ) {
		var params = arguments;
		
		params['field_name'] = getSlugManager().generate( input=params.label, separator="_" ) & "_xxx" & getBaseX().epoch();
		
		return getRegistrationFieldDAO().RegistrationFieldCopy( argumentCollection:params );
	}	
	/**
	* 
	*/
	public struct function getListingConfig( required string type ) {
		var fw = getbeanFactory().getBean("framework");
		var configs = {
			"standard":{
			    'table_id': "standard_field_listing",
			    'ajax_source': fw.buildURL("Registration.standardFields"),
			    'columns': "field_name,label,visible,required,options",
			    'display_length':200,
				'aoColumns': [
					{
						'data': "field_name",
						'sTitle': "Field Name",
						'bSortable': false
					},
					{
						'data': "label",
						'sTitle': "Label",
						'bSortable': false
					},
					{
						'data': "visible",
						'sTitle': "Use Field",
						'bSortable': false
					},
					{
						'data': "required",
						'sTitle': "Required",
						'bSortable': false
					},
					{
						'data': "options",
						'sTitle': "Options",
						'bSortable': false
					}
			    ]
			},
			"hotel":{
			    'table_id': "hotel_field_listing",
			    'ajax_source': fw.buildURL("Registration.hotelFields"),
			    'columns': "field_name,label,visible,required,options",
			    'display_length':200,
				'aoColumns': [
					{
						'data': "field_name",
						'sTitle': "Field Name",
						'bSortable': false
					},
					{
						'data': "label",
						'sTitle': "Label",
						'bSortable': false
					},
					{
						'data': "visible",
						'sTitle': "Use Field",
						'bSortable': false
					},
					{
						'data': "required",
						'sTitle': "Required",
						'bSortable': false
					},
					{
						'data': "options",
						'sTitle': "Options",
						'bSortable': false
					}
			    ]
			},
			'custom':{
			    'table_id': "custom_field_listing",
			    'ajax_source': fw.buildURL("Registration.customFields"),
			    'columns': "label,field_type,required,options",
			    'display_length':200,
				'aoColumns': [
					{
						'data': "label",
						'sTitle': "Field Label",
						'bSortable': false
					},
					{
						'data': "field_type",
						'sTitle': "Input Type",
						'bSortable': false
					},
					{
						'data': "required",
						'sTitle': "Required",
						'bSortable': false
					},
					{
						'data': "options",
						'sTitle': "Options",
						'bSortable': false
					}
			    ]
			},
			'dependencies':{
			    'table_id': "dependencies_field_listing",
			    'ajax_source': fw.buildURL("registration.dependencies"),
			    'columns': "parent_label,value,child_label,options",
			    'display_length':200,
				'aoColumns': [
					{
						'data': "parent_label",
						'sTitle': "Parent Field",
						'bSortable': false
					},
					{
						'data': "value",
						'sTitle': "Parent Field Value",
						'bSortable': false
					},
					{
						'data': "child_label",
						'sTitle': "Child Field",
						'bSortable': false
					},
					{
						'data': "options",
						'sTitle': "Options",
						'bSortable': false
					}
			    ]
			},
			'login':{
			    'table_id': "login_field_listing",
			    'ajax_source': fw.buildURL("registration.loginFields"),
			    'columns': "label,options",
			    'display_length':200,
				'aoColumns': [
					{
						'data': "label",
						'sTitle': "Field Label",
						'bSortable': false
					},
					{
						'data': "options",
						'sTitle': "Options",
						'bSortable': false
					}
			    ]
			}
		};
		
		return configs[ arguments.type ];
	}
	
}