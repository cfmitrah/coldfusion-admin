component extends="$base" accessors="true" securityroles="System Administrator" {
	property name="paymentProcessorsManager" setter="true" getter="true";

	public void function before( rc ) {
		super.before( rc );
		return;
	}
	/**
	* I am the payment processors listing
	*/
	public void function default( rc ) {
		var listing_config = {
			"table_id": "paymentprocessors_listing",
			"ajax_source": "paymentprocessors.listing",
			"columns": "processor_name,api_url,docs_url,active",
			"aoColumns": [
				{
					"data": "processor_name",
					"sTitle": "Payment Processor Name"
				},
				{
					"data": "api_url",
					"sTitle": "API URL",
					"bSortable": false
				},
				{
					"data": "docs_url",
					"sTitle": "Documentation URL",
					"bSortable": false
				},
				{
					"data": "active",
					"sTitle": "Active",
					"bSortable": false
				},
				{
					"data": "options",
					"sTitle": "Options",
					"bSortable": false
				}
				
			]
		};
		rc['table_id'] = listing_config.table_id;
		listing_config['ajax_source'] = buildURL( (structKeyExists( listing_config, 'ajax_source' ) ? listing_config.ajax_source: '') );
		rc['columns'] = listing_config.columns;
		getCfStatic()
			.includeData( listing_config )
			.include( "/css/pages/common/listing.css" )
			.include( "/js/pages/common/listing.js" );

		return;
	}
	/**
	* Returns a listing based on a given id
	*/
	public any function listing( rc ) {
		var params = {
			'draw' = 1,
			'start' = 1,
			'length' = 10,
			'SEARCH[VALUE]' = "",
			'ORDER[0][COLUMN]' = "0",
			'ORDER[0][DIR]' = "ASC"
		};
		var rtn = {};
		var columns = [ "processor_name", "api_url", "docs_url", "active" ];
		structAppend(params, rc, false);
		params['results'] = params.length;
		params['sort_column'] = columns[ params['ORDER[0][COLUMN]'] + 1 ];
		params['sort_direction'] = params['ORDER[0][DIR]'];
		params['search'] = params['SEARCH[VALUE]'];
		rtn = getPaymentProcessorsManager().getListing( argumentCollection = params );
		
		getFW().renderData( "json", rtn );
		return;
	}
	/**
	* I render the new Payment Processor form
	*/
	public void function create( rc ) {
		redirect( "paymentprocessors.details" );
		return;
	}
	/**
	* I create a new Payment Processor
	*/
	public void function doCreate( rc ) {
		if( structKeyExists( rc, "paymentprocessor" ) && isStruct( rc.paymentprocessor ) ) {
			if( !structKeyExists( rc.paymentprocessor, "paymentprocessor_id" ) ) {
				rc['paymentprocessor']['paymentprocessor_id'] = 0;
			}
			structAppend( rc, getpaymentprocessorsManager().save( argumentCollection=rc.paymentprocessor ) );
			rc['payment_processor_id'] = rc.payment_processor_id;
			getPaymentProcessorsManager().addPaymentProcessor( payment_processor = rc.payment_processor );
			if( val( rc.payment_processor_id ) ){
				redirect( action="paymentprocessors.details", queryString="paymentprocessor_id=" & rc.paymentprocessor_id );
			}
		}
		redirect( "paymentprocessors.default" );
		return;
	}
	/**
	* I am the details for a given Payment Processor
	*/
	public void function details( rc ) {
		var payment_processor_config = {
			'ajax_remove_creditcard_url' = buildURL( "paymentProcessors.ajaxRemoveCreditCard" )
		};
		var creditcard_list = getPaymentProcessorsManager().getCreditCardsList();

		structAppend( rc, {'processor_id':0}, false );

		rc['payment_processor'] = getPaymentProcessorsManager().getPaymentProcessorDetails( payment_processor_id=rc.processor_id );
		rc['creditcard_list'] = creditcard_list;
		rc['selected'] = [ "", "" ];
		rc['selected'][rc.payment_processor.active + 1] = "selected = ""selected"" ";
		rc['creditcard_options'] = getFormUtilities().buildOptionList(
			values = creditcard_list.credit_card_id,
			display = creditcard_list.vendor,
			selected = 0
		);
		getCfStatic().includeData( payment_processor_config )
			.include("/js/pages/paymentProcessors/remove_creditcard_modal.js");
		return;
	}
	/**
	* I save a Payment Processor
	*/
	public void function doSave( rc ) {
		var processor_id = 0;
		if( structKeyExists( rc, "payment_processor" ) && isStruct( rc.payment_processor ) ){
			if( !structKeyExists( rc.payment_processor, "processor_id" ) ) {
				rc['payment_processor']['processor_id'] = 0;
			}
			processor_id = getPaymentProcessorsManager().save( argumentCollection=rc.payment_processor );
			if( val( rc.payment_processor.processor_id ) ){
				redirect( action="paymentprocessors.details", queryString="processor_id=" & processor_id );
			}
		}
		redirect("paymentprocessors.default");
		return;
	}
	/**
	* doSaveCard
	* This method will process the saving of event dates
	*/
	public void function doSaveCard( rc ) {
		if( structKeyExists( rc, "payment_processor" ) && isStruct( rc.payment_processor ) ){
			getPaymentProcessorsManager().setCreditCard( processor_id = rc.payment_processor.processor_id, credit_card_id = rc.payment_processor.credit_card_id );
			addSuccessAlert( 'The credit card has been added.' );
			redirect( action="paymentprocessors.details", queryString = "processor_id=" & rc.payment_processor.processor_id );
		}
		redirect("paymentprocessors.default");
		return;
	}
	/**
	* ajaxGetpaymentprocessors
	* - This method will return the ajax JSON for event agenda list
	*/
	public void function ajaxRemoveCreditCard( rc ) {
		getPaymentProcessorsManager().paymentProcessorRemoveCreditCard( processor_id = rc.processor_id, credit_card_id = rc.credit_card_id );
		getFW().renderData( "json", { "success": true } );
		return;
	}

}