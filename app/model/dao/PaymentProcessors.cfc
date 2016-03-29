/**
* I am the DAO for the Payment Processors
* @file  /model/dao/PaymentProcessors.cfc
* @author
* @description
*
*/

component accessors="true" extends="app.model.base.Dao" {

   /*
	* Gets all Payment Processor
	* @active If null all are returned, otherwise results are filtered on the active state
	*/
	public struct function PaymentProcessorsGet( boolean active = 1 ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PaymentProcessorsGet"
		});
		sp.addParam( type = "in", dbvarname = "@active", cfsqltype = "cf_sql_bit", value = arguments.active, null = ( !len( arguments.active ) ) );
		sp.addProcResult( name = "result1", resultset = 1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
}