/**
*
* @file  /model/managers/Registration.cfc
* @author  
* @description
*
*/

component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="RegistrationDao" getter="true" setter="true";

	/*
	* Creates or Updates RegistrationDetail and Returns the RegistrationDetail ID
	* @registration_detail_id (output) The id of the detail record created
	* @registration_id The id of the registration
	* @attendee_id The id of the attendee
	* @detail_type_id The id of the detail type
	* @amount The amount of the transaction
	* @payment_type_id (optional) The payment type id
	* @description Description for the transaction
	* @ip The IP Address the transaction was placed from
	* @item_id (otional) The reference id for the detail_type
	* @processor_id (optional) The processor for the payment
	* @processor_tx_id (optional) The processors transaction id
	* @receipt A receipt of the transaction, this should be a JSON Object
	*/	
	public numeric function saveRegistrationDetail(
		numeric registration_detail_id=0,
		required numeric registration_id,
		required numeric attendee_id,
		required numeric detail_type_id,
		required numeric amount,
		numeric payment_type_id=0,
		required string description,
		required string ip,
		numeric item_id=0,
		numeric processor_id=0,
		string processor_tx_id="",
		string receipt=""
	) {
		return getRegistrationDao().RegistrationDetailSet( argumentCollection:arguments );
	}
	public struct function GroupPaymentWaterfall(
		required numeric registration_id,
		required numeric payment_amount,
		numeric payment_registration_detail_id=0
	) {
		var params = arguments;
		params['ip'] = cgi.REMOTE_ADDR;
		return getRegistrationDao().GroupPaymentWaterfall( argumentCollection:params );
	}
	/*
	* Gets registration details
	* @registration_id The registration_id
	* @attendee_id (optional) If supplied, filters to only the details for that attendee
	*/
	public struct function getRegistrationDetails(
		required numeric registration_id,
		numeric attendee_id=0,
		numeric draw=0
	) {
		var details = getRegistrationDao().RegistrationDetailsGet( argumentCollection:arguments ).result;
		var rtn = {
			"draw": arguments.draw,
			"recordsTotal": details.recordCount,
			"recordsFiltered": 0,
			"data": "" };
			rtn['data'] = queryToArray(
				recordSet=details,
				columns=listAppend( details.columnList, "options,receipt_data" ),
				map=function( row, index, columns, data ){					
					row['detail_timestamp'] = "" & dateformat( row.detail_timestamp, "m/dd/yyyy" ) & " " & timeformat( row.detail_timestamp, "h:mm tt" );
					if( isJson( row.receipt ) ) {
						row['receipt_data'] = deserializeJSON( row.receipt );
					}else{
						row['receipt_data'] = {};
					}
					row['attendee_name'] = row.first_name & " " & row.last_name;
					row['options'] = "";
					row['amount'] = dollarFormat( val( row.amount ) );
					return row;
			});
		
		return rtn;
	}
	/*
	* Gets registration detail payments
	* @registration_id The registration_id
	* @attendee_id (optional) If supplied, filters to only the details for that attendee
	*/
	public struct function getRegistrationDetailPayments(
		required numeric registration_id,
		numeric attendee_id=0
	) {
		var details = getRegistrationDao().RegistrationDetailPaymentsGet( argumentCollection:arguments ).result;
		var rtn = {
			'count':details.recordCount, 
			'payments':queryToArray( 
				recordSet=details,
				columns=listAppend( details.columnList, "options,refundable_amount,formatted_refundable_amount,formatted_amount,refund_notes,refund_description,tx_x_date,tx_last_4,allow_void" ),
				map=function( row, index, columns, data ){					
					row['detail_timestamp'] = "" & dateformat( row.detail_timestamp, "m/dd/yyyy" ) & " " & timeformat( row.detail_timestamp, "h:mm tt" );
					if( isJson( row.receipt ) ) {
						row['receipt'] = deserializeJSON( row.receipt );
					}else{
						row['receipt'] = {};
					}
					structAppend( row.receipt ,{'tx_last_4':"",'tx_x_date':""},false);
					row['formatted_amount'] = dollarFormat( val( row.amount*-1 ) );
					row['refundable_amount'] = val( row.amount*-1 ) + val( row.refunded_amount*-1 );
					row['formatted_refundable_amount'] = dollarFormat( row.refundable_amount );
					row['refund_description'] = row.description & ": " & row.formatted_amount & ", Refundable Amount: " & row.formatted_refundable_amount;
					row['refund_notes'] = "Refund for the amount of: " & row.formatted_refundable_amount;
					row['tx_last_4'] = row.receipt.tx_last_4;
					row['tx_x_date'] = row.receipt.tx_x_date;
					row['payment_type'] = row.payment_description.toLowerCase() // convert to lowercase
				.replaceAll( " ", "_" );
					if( !(datediff("d", dateformat( row.detail_timestamp, "m/dd/yyyy" ), dateformat( now(), "m/dd/yyyy" ) ) gt 0) 
						and listfindnocase("Credit Card,check,comp",row.payment_description) ) {
						row['allow_void'] = true;	
					}else{
						row['allow_void'] = false;
					}
					
					return row;
				}
				)
			};
		
		return rtn;
	}
	/**
	* I get all of the Registration Detail Types
	*/
	public struct function getDetailTypesOptsList() {
		var types = getRegistrationDao().RegistrationDetailTypesGet().result;
		return queryToStruct( types );
	}
	/**
	* I get all of the Registration Detail Types
	*/
	public struct function getDetailTypes() {
		var types = getRegistrationDao().RegistrationDetailTypesGet().result;
		var data = {};
		for ( var i=1; i LTE types.recordCount; i=i+1 ) {
			data[ types.detail_type[i] ] = types.detail_type_id[i];
		}
		return data;
	}

	public array function getDetailTypesArray() {
		var types = getRegistrationDao().RegistrationDetailTypesGet().result;
		return queryToArray( types );
	}
	/*
	* Creates or Updates an Registration and Returns the Registration ID
	* @registration_id (optional) The Attendee ID, if NULL it means to add
	* @event_id The id of the event
	* @payment_type_id The payment type
	* @ip The IP Address the registration was placed from
	* @total The total of the registration
	* @receipt A receipt of the transaction, this should be a JSON Object
	* @company The company the registration is for
	* @email_id The id of the email, null means add the email
	* @email The email address for the order
	* @address_id The address id, null means add
	* @address_1
	* @address_2 (optional)
	* @city
	* @region_code State / Province / Region / Territory i.e. US-NC
	* @country_code
	* @phone_id (optional) The id of the phone, NULL means add
	* @phone_number The actual phone number.  This should be only numbers, no formatted characters
	* @extension The extension of the phone number
	*/
	public struct function RegistrationSet(
		numeric registration_id=0,
		required numeric event_id,
		string company="",
		numeric email_id=0,
		required string email,
		numeric address_id=0,
		string address_1="",
		string address_2="",
		string city="",
		string region_code="",
		string postal_code="",
		string country_code="",
		numeric phone_id=0,
		string phone_number="",
		string extension="",
		numeric invite_id=0
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@registration_id", cfsqltype="cf_sql_bigint", value=arguments.registration_id, null=( !arguments.registration_id ), variable="registration_id" );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@company", cfsqltype="cf_sql_varchar", value=arguments.company, maxlength=300, null=( !len( arguments.company ) ) );
		sp.addParam( type="inout", dbvarname="@email_id", cfsqltype="cf_sql_bigint", value=arguments.email_id, null=( !arguments.email_id ), variable="email_id" );
		sp.addParam( type="in", dbvarname="@email", cfsqltype="cf_sql_varchar", value=arguments.email, maxlength=300 );
		sp.addParam( type="inout", dbvarname="@address_id", cfsqltype="cf_sql_bigint", value=arguments.address_id, null=( !arguments.address_id ), variable="address_id" );
		sp.addParam( type="in", dbvarname="@address_1", cfsqltype="cf_sql_varchar", value=arguments.address_1, maxlength=400, null=( !len( arguments.address_1 ) ) );
		sp.addParam( type="in", dbvarname="@address_2", cfsqltype="cf_sql_varchar", value=arguments.address_2, maxlength=400, null=( !len( arguments.address_2 ) ) );
		sp.addParam( type="in", dbvarname="@city", cfsqltype="cf_sql_varchar", value=arguments.city, maxlength=300,  null=( !len( arguments.city ) ) );
		sp.addParam( type="in", dbvarname="@region_code", cfsqltype="cf_sql_varchar", value=arguments.region_code, maxlength=6, null=( !len( arguments.region_code ) ) );
		sp.addParam( type="in", dbvarname="@postal_code", cfsqltype="cf_sql_varchar", value=arguments.postal_code, maxlength=30, null=( !len( arguments.postal_code ) ) );
		sp.addParam( type="in", dbvarname="@country_code", cfsqltype="cf_sql_char", value=arguments.country_code, maxlength=2, null=( !len( arguments.country_code ) ) );
		sp.addParam( type="inout", dbvarname="@phone_id", cfsqltype="cf_sql_bigint", value=arguments.phone_id, null=( !arguments.phone_id ), variable="phone_id" );
		sp.addParam( type="in", dbvarname="@phone_number", cfsqltype="cf_sql_varchar", value=arguments.phone_number, maxlength=15, null=( !len( arguments.phone_number ) ) );
		sp.addParam( type="in", dbvarname="@extension", cfsqltype="cf_sql_varchar", value=arguments.extension, maxlength=10, null=( !len( arguments.extension ) ) );
		sp.addParam( type="in", dbvarname="@invite_id", cfsqltype="cf_sql_bigint", value=arguments.invite_id, null=( !arguments.invite_id ) );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );

		return data;
	}


}