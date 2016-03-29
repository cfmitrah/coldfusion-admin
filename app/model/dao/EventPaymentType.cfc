/**
* I am the DAO for the PaymentTypes object
* Description goes here
* @file  /model/dao/EventPaymentType.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/*
	* Gets all of the payment types and shows which are in use for the specified event
	* @event_id The event id
	*/
	public struct function EventPaymentTypesInUseGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventPaymentTypesInUseGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="result", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result
		};
	}
	/*
	* Associates 1 or more payment types to an Event
	* @event_id The id of the Event
	* @payment_types A comma-delimited list of payment_types
	*/
	public void function EventPaymentTypesSet( required numeric event_id, string payment_types="" ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EventPaymentTypesSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@payment_types", cfsqltype="cf_sql_varchar", value=arguments.payment_types, maxlength=500, null=( !len( arguments.payment_types ) ) );

		result = sp.execute();
		return;
	}
}