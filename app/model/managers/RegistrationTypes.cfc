/**
*
* @file  /model/managers/RegistrationTypes.cfc
* @author - JG
* @description - This will manage all things RegistrationTypes.
*
*/

component output="false" displayname="Agenda" accessors="true" extends="app.model.base.Manager" {
	property name="RegistrationTypesDao" getter="true" setter="true";
	
	
	public struct function getRegistrationTypes( required numeric event_id ) {
		var data = {};
		data['opts'] = queryToArray( getRegistrationTypesDao().registrationTypesGet( argumentCollection = arguments ).result.registration_types );
		data['cnt'] = arrayLen( data['opts']);
		data['types'] = data.opts;
		data['count'] = data.cnt;
		return data;
	}	

	/*
	* Gets all of the registration types associated to an event
	* @event_id The event id
	*/
	public struct function getRegistrationTypesStruct( required numeric event_id ){
		var data = getRegistrationTypesDao().registrationTypesGet( argumentCollection = arguments );
		return queryToStruct( recordset=data.result.registration_types );
	}
	/*
	* Gets all of the registration types associated to an event
	* @event_id The event id
	*/
	public array function getRegistrationTypesArray( required numeric event_id ){
		var data = getRegistrationTypesDao().registrationTypesGet( argumentCollection = arguments );
		return queryToArray( recordset=data.result.registration_types );
	}
	/**
	* I get the fee for a registration type
	* @registration_type_id
	*/
	public struct function getRegistrationFee( required numeric registration_type_id ) {
		var data = getRegistrationTypeDao().RegistrationPriceByTypeGet( argumentCollection:arguments );
		return data;
	}
	
}	