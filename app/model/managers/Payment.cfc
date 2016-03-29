/**
*
* @file  /app/model/managers/Attendee.cfc
* @author  
* @description
*
*/

component output="false" extends="app.model.base.Manager" accessors="true" {
	property name="companyDao" getter="true" setter="true";
	property name="eventDao" getter="true" setter="true";
	property name="paymentTypesDao" getter="true" setter="true";
	
	public struct function getPaymentTypesOptsList() {
		var ret = getPaymentTypesDao().PaymentTypesGet();
		return queryToStruct( ret.result.payment_types );
	}

	public array function getPaymentTypesArray() {
		var ret = getPaymentTypesDao().PaymentTypesGet();
		return queryToArray( ret.result.payment_types );
	}
		
	public any function makeCCPayment(
		required numeric event_id,
		required numeric total,
		required struct account_info
	) {
		var paySvr = getPayService( arguments.event_id );
		var gw = paySvr.getGateway();
		var account = paySvr.createCreditCard();
		var response = "";
		var amount = arguments.total;
		var money = paySvr.createMoney(amount*100);
		var params = {};
		
		structAppend( account_info, {
			'account_number':"",
			'month':"",
			'year':"",
			'first_name':"",
			'last_name':"",
			'address':"",
			'postal_code':"",
			'cvv':"",
			'country':"",
			'region':"",
			'city':""
		}, false );
		
		account.setAccount( account_info.account_number );
		account.setMonth( account_info.month );
		account.setYear( account_info.year );
		account.setFirstName( account_info.first_name );
		account.setLastName( account_info.last_name );
		account.setAddress( account_info.address );
		account.setPostalCode( account_info.postal_code );
		account.setVerificationValue( account_info.cvv );
		account.setCity( account_info.city );
		account.setCountry( account_info.country );
		account.setRegion( account_info.region );
		
		params = {
			'money': money,
			'account': account,
			'refid': "EVENT-" & arguments.event_id & " - Registration URL: " & cgi.server_name
		};
		
		if( structKeyExists( account_info, "email" ) ) {
			params['email'] = account_info.email;
		}
		response = gw.purchase( argumentCollection:params );

		return response;
	}

	public any function getPayService( required numeric event_id ) {
		var config = {};
		var event_processor = getEventDAO().EventCompanyPaymentProcessorGet( arguments.event_id );
		
		var processor = getCompanyDao().CompanyPaymentProcessorGet( company_processor_id:event_processor.company_processor_id );
		var processor_service = "";
		structAppend( config, deserializeJSON( processor.config ), true );
		config[ 'path' ] = rereplaceNoCase( processor.processor_name, "[[:punct:][:cntrl:][:space:]]", "", "all" );
		config[ 'path' ] = config.path & "." & config.path;
		
		processor_service = new org.cfpayment.api.core( config );
		
		return processor_service; 
	}
	public any function doCCRefund( 
		required numeric event_id,
		required numeric amount,
		required string processor_tx_id,
		required string tx_x_date,
		required string tx_last_4
	) {
		var paySvr = getPayService( arguments.event_id );
		var gw = paySvr.getGateway();
		var account = paySvr.createCreditCard();
		var response = "";
		var money = paySvr.createMoney(amount*100);
		
		
		account.setAccount( arguments.tx_last_4 );
		account.setMonth( left(arguments.tx_x_date,2) );
		account.setYear( right(arguments.tx_x_date,2) );		
		response = gw.credit( money=money, account=account, transactionid=arguments.processor_tx_id );
		return response;

	}
	public any function doCCVoid( 
		required numeric event_id
	) {
		var paySvr = getPayService( arguments.event_id );
		var gw = paySvr.getGateway();
		var response = "";
	
		response = gw.void( transactionid=arguments.processor_tx_id, options={} );
		return response;

	}

}



