/**
*
* @file  /model/managers/EventPaymentTypes.cfc
* @author  
* @description
*
*/

component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="PaymentTypesDao" getter="true" setter="true";
	/**
	* I get all the application payment types
	*/
	public struct function getPaymentTypes() {
		var types = getPaymentTypesDao().PaymentTypesGet().result.payment_types;
		var payment_types = {};
		for( var i = 1; i lte types.recordCount; i++ ) {
			var payment_type = types['payment_type'][ i ];
			var payment_type_id = types['payment_type_id'][ i ];
			var description = types['description'][ i ];

			payment_types[ payment_type ] = payment_type_id;
		}
		return payment_types;
	}
}