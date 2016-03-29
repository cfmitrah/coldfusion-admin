/**
* I am the DAO for the Payments
* Description goes here
* @file  /model/dao/Payments.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

/*
	* Gets all of the Credit Cards
	*/
	public struct function PaymentCreditCardsGet() {		
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PaymentCreditCardsGet"
		});
		sp.addProcResult( name="result1", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result1
		};
	}

	/*
	* Gets all Payment Processor
	* @active If null all are returned, otherwise results are filtered on the active state
	*/
	public struct function PaymentProcessorsGet( boolean active ) {
		param name="arguments.active" default=1;
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PaymentProcessorsGet"
		});
		sp.addParam( type="in", dbvarname="@active", cfsqltype="cf_sql_bit", value=arguments.active, null=( !len( arguments.active ) ) );
		sp.addProcResult( name="result1", resultset=1 );
		//sp.addProcResult( name="result2", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
}