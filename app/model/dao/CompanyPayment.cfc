/**
* I am the DAO for the Company Payment object
* @file  /model/dao/CompanyPayment.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {
	/*
	* Gets the company payment processors
	* @company_id The id of the company
	*/
	public struct function CompanyExcludedCreditCardList( required numeric company_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CompanytExcludedCreditCardsGet"
		});
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addProcResult( name="processors", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().processors
		};
	}

	/*
	* Gets the company payment processors
	* @company_id The id of the company
	*/
	public struct function CompanyPaymentProcessorList( required numeric company_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CompanyPaymentProcessorList"
		});
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addProcResult( name="processors", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().processors
		};
	}
}