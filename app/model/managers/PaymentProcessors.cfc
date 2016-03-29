/**
* @file  /model/managers/PaymentProcessor.cfc
*/

component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="PaymentProcessorDAO" setter="true" getter="true";
	property name="PaymentProcessorsDAO" setter="true" getter="true";
	property name="paymentsDAO" setter="true" getter="true";
	property name="FormUtilities" setter="true" getter="true";
	/**
	* Gets all of the payment processors and creates selectbox options
	*/
	public string function getPaymentProcessorSelectOptions( numeric selected_payment_processor_id = 0 ) {
		var payment_processors = queryToStruct( getPaymentProcessorsDao().payment_processorsGet().result.payment_processors );
		var opts = getFormUtilities().buildOptionList( payment_processors.payment_processor_id, payment_processors.payment_processor_name, arguments.selected_payment_processor_id );
		return opts;
	}
	/**
	* I get all payment_processors
	*
	*/
	public struct function getPaymentProcessors() {
		var payment_processors = getPaymentProcessorsDao().paymentProcessorsGet().result.result1;
		var data = {};
	    data['data'] = queryToArray(
	            recordSet = payment_processors,
	            columns = listAppend( payment_processors.columnList, "options" ),
	            map = function( row, index, columns, data ){
		            row['options'] = "<a href=""/paymentprocessors/details/processor_id/" & row.processor_id & """ class=""btn btn-primary btn-sm"" >";
					row['options'] &= "<span class=""glyphicon glyphicon-edit""></span> <strong>Manage</strong> </a>";
	                return row;
	           });
	    data['count'] = payment_processors.recordCount;
	    return data;
    }
	/**
	* Get the details for an individual payment_processor
	*
	*/
	public struct function getPaymentProcessorDetails( required numeric payment_processor_id ) {
		var processor = getPaymentProcessorDAO().paymentProcessorGet( arguments.payment_processor_id ).result;
		var data = {'active':1,
			'api_url':"",
			'docs_url':"",
			'processor_id':0,
			'processor_name':"",
			'cards':[],
			'card_count':0};

		if( processor.result1.recordCount ) {
			data = queryToArray( processor.result1 )[1];
			data['cards'] = queryToArray( processor.result2 );
			data['card_count'] = processor.result2.recordCount;
			
		}
		return data;
	}
	/*
	* Gets all of the Credit Cards for a PaymentProcessors Payment Processor
	* @payment_processor_id The payment_processor_id id
	* @processor_id The id of the payment processor
	*/
	public struct function getPaymentProcessorCreditCards( required numeric payment_processor_id ) {
		var params = {};
		var data = {};
		params = arguments;
		data['credit_card_types']['data'] = [];
		if( len( params['payment_processor_id'] ) ) {
			data['credit_card_types']['data'] = queryToArray( getPaymentProcessorDAO().PaymentProcessorCreditCardsGet( params['payment_processor_id'] ).result );
		}
		data['credit_card_types']['count'] = arrayLen( data.credit_card_types.data );
		return data;
	}
	/**
	* Get Payment processor list
	*/
	public struct function getPaymentProcessorsList() {
		var paymentProcessors = {};
		paymentProcessors = queryToStruct( recordset=getPaymentProcesssorsDao().PaymentProcessorsGet().result.result1 );
		return paymentProcessors;
	}
	/**
	* Get credit card list
	*/
	public struct function getCreditCardsList() {
		var creditCards = {};
		creditCards = queryToStruct( recordset=getPaymentsDao().PaymentCreditCardsGet().result );
		return creditCards;
	}
	/**
	* Multi line method description
	*
	*/
	public struct function getListing(
		required numeric order_index = 0,
		string sort_direction = "asc",
		string search_value = "",
		numeric start_row = 0,
		numeric total_rows = 10,
		numeric draw = 1
	) {
		var columns = [];
		var payment_processors = getPaymentProcessors( argumentCollection = arguments );

		return {
			'draw': arguments.draw,
			'recordsTotal': payment_processors.count,
			'recordsFiltered': payment_processors.count,
			'data': payment_processors.data
		};
	}
	/**
	*	Remove a processor from a payment_processor
	*/
	public void function paymentProcessorRemoveCreditCard( required numeric processor_id, required numeric credit_card_id ){
		getPaymentProcessorDao().PaymentProcessorCreditCardRemove( argumentCollection = arguments );
		return;
	}
	/**
	* Set User
	*/
	public void function setCreditCard(required numeric processor_id, required numeric credit_card_id ) {
		getPaymentProcessorDao().PaymentProcessorCreditCardAdd( processor_id = arguments.processor_id, credit_card_id = arguments.credit_card_id );
		return;
	}
	/*
	* Sets a PaymentProcessor's Information
	* @payment_processor_id The id of the payment_processor
	* @payment_processor_name The name of the payment_processor
	* @api_url The API's url
	* @docs_url The documentation url
	* @active Is this payment processor active?
	*/
	public numeric function save(
		required numeric processor_id,
		required string processor_name,
		string api_url,
		required string docs_url,
		boolean active=0
	) {

		return getPaymentProcessorDao().PaymentProcessorSet( argumentCollection = arguments );
	}
}
