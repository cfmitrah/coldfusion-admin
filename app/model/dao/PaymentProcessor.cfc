/**
* I am the DAO for the Payment Processor object
* @file  /model/dao/PaymentProcessor.cfc
* @author
* @description
*
*/

component accessors="true" extends="app.model.base.Dao" {

	/*
	* Creates or Updates an Address and Returns the Address ID
	* @name The id of the payment processor
	* @api_url (optional) The URL of the API
	* @docs_url (optional) The URL of the documentation
	* @active Whether or not the payment processor is active
	*/
	public numeric function PaymentProcessorSet(
		numeric processor_id = 0,
		required string processor_name,
		string api_url = "",
		string docs_url  ="",
		boolean active=1
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PaymentProcessorSet"
		});
		trim_fields( arguments );
		sp.addParam( type = "inout", dbvarname = "@processor_id", cfsqltype = "cf_sql_bigint", value = arguments.processor_id, null = ( !arguments.processor_id ), variable="processor_id" );
		sp.addParam( type = "in", dbvarname = "@processor_name", cfsqltype = "cf_sql_varchar", value = arguments.processor_name, maxlength = 100 );
		sp.addParam( type = "in", dbvarname = "@api_url", cfsqltype = "cf_sql_varchar", value = arguments.api_url, maxlength = 300, null = ( !len( arguments.api_url ) ) );
		sp.addParam( type = "in", dbvarname = "@docs_url", cfsqltype = "cf_sql_varchar", value = arguments.docs_url, maxlength = 300, null = ( !len( arguments.docs_url ) ) );
		sp.addParam( type = "in", dbvarname = "@active", cfsqltype = "cf_sql_bit", value = arguments.active, null = ( !len( arguments.active ) ) );
		result = sp.execute();
		return result.getProcOutVariables().processor_id;
	}

    /*
	* Gets a Payment Processor
	* @processor_id The processor_id id
	*/
	public struct function PaymentProcessorGet( required numeric processor_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PaymentProcessorGet"
		});
		sp.addParam( type = "in", dbvarname = "@processor_id", cfsqltype = "cf_sql_integer", value = arguments.processor_id );
		sp.addProcResult( name = "result1", resultset = 1 );
		sp.addProcResult( name = "result2", resultset = 2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}

	/*
	* Gets all of the Credit Cards for a Payment Processor
	* @processor_id The processor_id id
	*/
	public struct function PaymentProcessorCreditCardsGet( required numeric processor_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PaymentProcessorCreditCardsGet"
		});
		sp.addParam( type = "in", dbvarname = "@processor_id", cfsqltype = "cf_sql_integer", value = arguments.processor_id );
		sp.addProcResult( name = "result1", resultset = 1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result1
		};
	}

	/*
	* Adds a credit card to a Payment Processor
	* @processor_id The id of the Processor
	* @credit_card_id The id of the credit card
	*/
	public void function PaymentProcessorCreditCardAdd(
		required numeric processor_id,
		required numeric credit_card_id
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PaymentProcessorCreditCardAdd"
		});
		sp.addParam( type = "in", dbvarname = "@processor_id", cfsqltype = "cf_sql_tinyint", value = arguments.processor_id );
		sp.addParam( type = "in", dbvarname = "@credit_card_id", cfsqltype = "cf_sql_tinyint", value = arguments.credit_card_id );
		sp.execute();
		return;
	}

   /*
	* Remove a Excluded Credit Card from a Payment Processor
	* @processor_id The id of the Processor
	* @credit_card_id The id of the credit card
	*/
	public void function PaymentProcessorCreditCardRemove(
		required numeric processor_id,
		required numeric credit_card_id
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PaymentProcessorCreditCardRemove"
		});
		sp.addParam( type = "in", dbvarname = "@processor_id", cfsqltype = "cf_sql_integer", value = arguments.processor_id );
		sp.addParam( type = "in", dbvarname = "@credit_card_id", cfsqltype = "cf_sql_tinyint", value = arguments.credit_card_id );
		result = sp.execute();
		return;
	}

	/*
	* Activates a Payment Processor
	* @processor_id The id of the processor
	*/
	public void function PaymentProcessorActivate( required numeric processor_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "PaymentProcessorActivate"
		});
		sp.addParam( type = "in", dbvarname = "@processor_id", cfsqltype = "cf_sql_tinyint", value = arguments.processor_id );
		result = sp.execute();
		return;
	}



}