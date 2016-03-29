/**
*
* @file  /cfpayment/api/gateway/paytrace/Paytrace.cfc
* @author  
* @description
*
*/

component displayname="Pay Trace Interface" extends="cfpayment.api.gateway.base" hint="paytrace" output="false" {

	variables.cfpayment.GATEWAY_NAME = "paytrace";
	variables.cfpayment.GATEWAY_VERSION = "1.0";		
	// The test URL requires a separate developer transKey and login
	// Request a developer account here: http://help.paytrace.com/api
	variables.cfpayment.GATEWAY_TEST_URL = "https://PayTrace.com/API/default.pay";
	variables.cfpayment.GATEWAY_LIVE_URL = "https://PayTrace.com/API/default.pay";
	/**
	* process
	*/
	public any function process( required string param_list, string email="" ) {
		var payLoad = { 'parmlist': param_list };
		var response = super.process( payload=payLoad, method="GET" );
		var result = listToArray( response.getRESULT(), "|" );
		var parsedresult = {};
		response.setStatus( 99 );
		for( var item in result ) {
			var key = listFirst( item, "~" );
			var value = listLast( item, "~" );
			parsedresult[ lcase( key ) ] = value;
			switch( key ){
				case "response":
					response.setMessage( value );
					if( listFind( "101,106,109", left( value, 3 ) ) ) {
						response.setStatus( getService().getStatusSuccessful() );
					}else if( listFind( "102", left( value, 3 ) ) ) {
						response.setStatus( getService().getStatusDeclined() );
					}else{
						response.setStatus( getService().getStatusUnknown() );
					}
				break;
				case "transactionid":
					response.setTransactionID( value );
					if( len(trim(value)) && isvalid("email", arguments.email ) ) {
						emailReceipt( value, arguments.email );
					}
				break;
				case "error":
					response.setMessage( value );
					response.setStatus( left( value, 3 ) );
				break;
			}
		}
		
		response.setParsedResult( parsedresult );
		return response;
	}
	
	/**
	* Void
	* @money api.model.money
	* @money api.model.CreditcCard
	* @RefID Reference ID
	*/
	public any function purchase( required any money, required any account, any RefID="" ) {
		var param_list = "";
		var d = "|";
		
		param_list &= "UN~" & trim( getUsername() ) & d;
		param_list &= "PSWD~" & trim( getPassword() ) & d;
		param_list &= "METHOD~ProcessTranx" & d;
		param_list &= "TRANXTYPE~Sale" & d;
		param_list &= "TERMS~Y" & d;
		param_list &= "CC~" & trim( account.getAccount() ) & d;
		param_list &= "EXPMNTH~" & trim( account.getMonth() ) & d;
		param_list &= "EXPYR~" & trim( right(account.getYear(),2) ) & d;
		param_list &= "AMOUNT~" & trim( money.getAmount() ) & d;
		param_list &= "BADDRESS~" & trim( account.getAddress() ) & d;
		param_list &= "BZIP~" & trim( account.getPostalCode() ) & d;
		param_list &= "BNAME~" & trim( account.getFirstName() ) & " " & trim( account.getLastName() ) & d;
		param_list &= "LAST4~" & right( account.getAccount(), 4 ) & d;
		// BCITY, BSTATE, SNAME, SADDRESS, SADDRESS2, SCITY, SCOUNTY, SSTATE, SZIP, SCOUNTRY, EMAIL, CSC, INVOICE, DESCRIPTION, TAX, CUSTREF, RETURNCLR, CUSTOMDBA, ENABLEPARTIALAUTH, DISCRETIONARY DATA
		if( len( trim( arguments.refid ) ) ) {
			param_list &= "INVOICE~" & trim( arguments.refid ) & d;
		}
		return process( param_list=param_list );
	}
	/**
	* Void
	* @transactionid the procssor transaction ID
	*/
	public any function void( rquired any transactionid ) {
		var param_list = "";
		var d = "|";
		param_list &= "un~" & trim( getUsername() ) & d;
		param_list &= "pswd~" & trim( getPassword() ) & d;
		param_list &= "terms~Y" & d;
		param_list &= "method~processtranx" & d;
		param_list &= "tranxtype~Void" & d;
		param_list &= "TranxID~" & arguments.transactionid & d;
		
		return process( param_list );
	}
	/**
	* Refund
	* @money api.model.money 
	* @customer_id the customer id issued by the processor 
	*/
	public any function credit( required any money, required any transactionid ) {
		var param_list = "";
		var d = "|";
		param_list &= "un~" & trim( getUsername() ) & d;
		param_list &= "pswd~" & trim( getPassword() ) & d;
		param_list &= "terms~Y" & d;
		param_list &= "method~processtranx" & d;
		param_list &= "tranxtype~Refund" & d;
		param_list &= "amount~" & trim( money.getAmount() ) & d;
		param_list &= "TRANXID~" & arguments.transactionid & d;
				 
		return process( param_list );
	}
	/**
	* Email
	* @transactionid the procssor transaction ID
	*/
	public any function emailReceipt( required any transactionid, required string email ) {
		var param_list = "";
		var d = "|";
		param_list &= "un~" & trim( getUsername() ) & d;
		param_list &= "pswd~" & trim( getPassword() ) & d;
		param_list &= "terms~Y" & d;
		param_list &= "METHOD~EmailReceipt" & d;
		param_list &= "TRANXID~" & arguments.transactionid & d;
		param_list &= "EMAIL~" & arguments.email & d;

		return super.process( payload={ 'parmlist': param_list }, method="GET" );
	}
}