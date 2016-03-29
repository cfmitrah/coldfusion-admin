/**
*
* @file  /model/managers/AttendeeSettings.cfc
* @author
* @description
*
*/

component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="registrationTypesDao" getter="true" setter="true";
	property name="registrationTypeDao" getter="true" setter="true";
	property name="RegistrationPriceDao" getter="true" setter="true";
	property name="FormUtilities" getter="true" setter="true";
	/**
	* I get all of the registration type list for an event
	*
	*/
	public struct function getRegistrationTypeList( required numeric event_id, numeric draw=1, boolean includeOptions=false ) {
		var types = getRegistrationTypes( event_id );
		var rtn = {"draw"=arguments.draw, "recordsTotal"=types.recordCount, "recordsFiltered"=types.recordCount,"data"=[]};
		var params = { "recordset": types, "columns": types.columnList };
		if( includeOptions ){
			params.columns=listAppend( params.columns, "options,path_url,event_domain_name,event_slug,slug" );
			params.map=function( row, index, columns, data ){
				var url = data.prefix & "://" & row.event_domain_name & "/" & row.event_slug & "/" & row.slug & "/register/";
					row['valid_from'] = dateTimeFormat( row.valid_from, "mm/dd/yyyy h:mm tt");
					row['valid_to'] = dateTimeFormat( row.valid_to, "mm/dd/yyyy h:mm tt");
					row['active'] = " " & yesNoFormat( row.active );
					row['options']  = "<div class='btn-group pull-right'>";
					row['options']  &= "<button data-typeid='" & row.registration_type_id & "' data-type='" & row.registration_type & "' type='button' data-modifytype='true' class='btn btn-sm btn-primary'>Modify</button>";
					row['options']  &= "<button data-typeid='" & row.registration_type_id & "' data-type='" & row.registration_type & "' type='button' data-modifypricing='true' class='btn btn-sm btn-success'>Modify Pricing</button>";
					row['options']  &= "</div>";
					
					row['path_url'] = "<a href=""" & url & """ target=""_blank"">" & url & "</a>";
				
			        return row;
			    };
		}
		params['data']['prefix'] = "https";
		if( cgi.SERVER_PORT EQ 80 ) {
			params['data']['prefix'] = "http";
		}
		rtn['data'] = queryToArray( argumentCollection=params );
		return rtn;
	}
	/**
	* I get all of the registration type for an event
	*
	*/
	public query function getRegistrationTypes( required numeric event_id ) {
		return getRegistrationTypesDao().registrationTypesGet( event_id ).result.registration_types;
	}
	/**
	* I get all of the registration type for an event returned as a HTML select input
	*
	*/
	public string function getRegistrationTypesSelect( required numeric event_id, numeric selected_value=0 ) {
		var types = queryToStruct( getRegistrationTypes( arguments.event_id ) );
		var rtn = getFormUtilities().buildOptionList( 
			values=types.registration_type_id 
			,display=types.registration_type
			,selected=arguments.selected_value );

		return rtn;
	}
	/**
	* I save a registration type for an event
	*
	*/
	public numeric function saveRegistrationType( required numeric event_id, required string registration_type, numeric registration_type_id=0, boolean active=0,numeric sort=0, boolean group_allowed=false ) {

		return getRegistrationTypeDao().registrationTypeSet( argumentCollection:arguments );
	}
	/**
	* I get a registration type for an event
	*/
	public struct function getRegistrationType( required numeric event_id, required numeric registration_type_id ) {
		var registrationType = getRegistrationTypeDao().registrationTypeGet( arguments.event_id, arguments.registration_type_id ).result;
		var data = {
			'registration_type':{ 
				'count':registrationType.registration_type.recordCount, 
				'data': queryToArray(registrationType.registration_type)
			},
			'registration_pricing':{ 
				'count':registrationType.registration_pricing.recordCount, 
				'data': queryToArray(registrationType.registration_pricing)
			}
		};
		
		return data;
	}
	/**
	* I get the pricing for a registration type
	*/
	public struct function getRegistrationTypePricing( required numeric event_id, required numeric registration_type_id ) {
		return getRegistrationType( arguments.event_id, arguments.registration_type_id ).registration_pricing;
	}
	/**
	* I save pricing for a registration type
	*/
	public numeric function saveRegistrationPrice(
		numeric registration_price_id=0,
		required numeric registration_type_id,
		required numeric price,
		required date valid_from,
		required date valid_to,
		required boolean is_default) {

		return getRegistrationPriceDao().RegistrationPriceSet( argumentCollection=arguments );
	}
	/**
	* I am a quick save pricing for a registration type
	*/
	public numeric function quickSaveRegistrationPrice(
		required numeric registration_price_id,
		required numeric registration_type_id,
		numeric price,
		date valid_from,
		date valid_to) {

		return getRegistrationPriceDao().RegistrationPriceQuickSet( argumentCollection=arguments );
	}
	/**
	* I remove pricing for a registration type
	*/
	public void function removeRegistrationPrice( required numeric registration_price_id, required numeric registration_type_id) {
		getRegistrationPriceDao().RegistrationPriceRemove( argumentCollection=arguments );
	}
	/**
	* I get all of the Pages for an event
	*/
	public struct function getRegistrationTypesList(
		required numeric event_id=0,
		start=0
		results=10,
		sort_column="registration_type",
		sort_direction="ASC",
		numeric draw=1
	 ) {
		var reg_types = getRegistrationTypesDao().RegistrationTypesList( argumentCollection=arguments ).result;
		return {
			"draw": arguments.draw,
			"recordsTotal": isDefined("reg_types.total") ? reg_types.total : reg_types.recordCount,
			"recordsFiltered": isDefined("reg_types.total") ? reg_types.total : reg_types.recordCount,
			"data": queryToArray(recordset=reg_types, map=function( row, index, columns ){
				row['valid_from'] = dateTimeFormat( row.valid_from, "mm/dd/yyyy h:mm tt");
				row['valid_to'] = dateTimeFormat( row.valid_to, "mm/dd/yyyy h:mm tt");
				row['active'] = " " & yesNoFormat( row.active );
				return row;
			})
		};
	}

}