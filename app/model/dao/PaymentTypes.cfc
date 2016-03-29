/**
* I am the DAO for the PaymentTypes object
* Description goes here
* @file  /model/dao/PaymentType.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/**
	* I get all of the payment types
	*/
	public struct function PaymentTypesGet() {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "PaymentTypesGet"
		});
		
		sp.addProcResult( name="payment_types", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
}