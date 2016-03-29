/**
*
* @file  /model/managers/EventPaymentTypes.cfc
* @author  
* @description
*
*/

component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="EventPaymentTypeDao" getter="true" setter="true";
	/*
	* Gets all of the payment types and shows which are in use for the specified event
	* @event_id The event id
	*/
	public struct function getEventPaymentTypes( required numeric event_id ) {
		var result = getEventPaymentTypeDao().EventPaymentTypesInUseGet( argumentCollection=arguments ).result;
		return { 
			'data': queryToArray( result ),
			'count':result.recordCount
		};
	}
	/**
	* 
	*/
	public void function saveEventPaymentTypes( required numeric event_id, string payment_types="" ) {
		
		getEventPaymentTypeDao().EventPaymentTypesSet( argumentCollection=arguments );
		return;
	}
	
}