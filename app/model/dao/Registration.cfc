/**
*
* @file  /app/model/dao/Registration.cfc
* @author
* @description
*
*/
component output="false" extends="app.model.base.Dao" {

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
	public numeric function RegistrationDetailSet(
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
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationDetailSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@registration_detail_id", cfsqltype="cf_sql_bigint", value=arguments.registration_detail_id, null=( !arguments.registration_detail_id ), variable="registration_detail_id" );
		sp.addParam( type="in", dbvarname="@registration_id", cfsqltype="cf_sql_bigint", value=arguments.registration_id );
		sp.addParam( type="in", dbvarname="@attendee_id", cfsqltype="cf_sql_bigint", value=arguments.attendee_id );
		sp.addParam( type="in", dbvarname="@detail_type_id", cfsqltype="cf_sql_tinyint", value=arguments.detail_type_id );
		sp.addParam( type="in", dbvarname="@amount", cfsqltype="cf_sql_money", value=arguments.amount );
		sp.addParam( type="in", dbvarname="@payment_type_id", cfsqltype="cf_sql_tinyint", value=arguments.payment_type_id, null=( !arguments.payment_type_id ) );
		sp.addParam( type="in", dbvarname="@description", cfsqltype="cf_sql_varchar", value=arguments.description, maxlength=300 );
		sp.addParam( type="in", dbvarname="@ip", cfsqltype="cf_sql_varchar", value=arguments.ip, maxlength=45 );
		sp.addParam( type="in", dbvarname="@item_id", cfsqltype="cf_sql_bigint", value=arguments.item_id, null=( !arguments.item_id ) );
		sp.addParam( type="in", dbvarname="@processor_id", cfsqltype="cf_sql_tinyint", value=arguments.processor_id, null=( !arguments.processor_id ) );
		sp.addParam( type="in", dbvarname="@processor_tx_id", cfsqltype="cf_sql_varchar", value=arguments.processor_tx_id, maxlength=50, null=( !len( arguments.processor_tx_id ) ) );
		sp.addParam( type="in", dbvarname="@receipt", cfsqltype="cf_sql_longvarchar", value=arguments.receipt, null=( !len( arguments.receipt ) ) );
		result = sp.execute();
		return result.getProcOutVariables().registration_detail_id;
	}
	/*
	* Gets registration details
	* @registration_id The registration_id
	* @attendee_id (optional) If supplied, filters to only the details for that attendee
	*/
	public struct function RegistrationDetailsGet(
		required numeric registration_id,
		numeric attendee_id=0
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationDetailsGet"
		});
		sp.addParam( type="in", dbvarname="@registration_id", cfsqltype="cf_sql_bigint", value=arguments.registration_id );
		sp.addParam( type="in", dbvarname="@attendee_id", cfsqltype="cf_sql_bigint", value=arguments.attendee_id, null=( !arguments.attendee_id ) );
		sp.addProcResult( name="details", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().details
		};
	}
	/*
	* Gets registration details
	* @registration_id The registration_id
	* @attendee_id (optional) If supplied, filters to only the details for that attendee
	*/
	public struct function RegistrationDetailPaymentsGet(
		required numeric registration_id,
		numeric attendee_id=0
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationDetailPaymentsGet"
		});
		sp.addParam( type="in", dbvarname="@registration_id", cfsqltype="cf_sql_bigint", value=arguments.registration_id );
		sp.addParam( type="in", dbvarname="@attendee_id", cfsqltype="cf_sql_bigint", value=arguments.attendee_id, null=( !arguments.attendee_id ) );
		sp.addProcResult( name="Payments", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().Payments
		};
	}
	/*
	* Gets all of the registration detail types
	*/
	public struct function RegistrationDetailTypesGet() {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationDetailTypesGet"
		});
		sp.addProcResult( name="detail_types", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().detail_types
		};
	}
	/*
	* Allocates a payment for a group to all the group members
	*  First allocates payment to the parent attendee, and then
	*  waterfalls down to all remaining or until payment is used up
	* @registration_id The id of the registration for the group
	* @payment_amount The amount of the payment to apply
	* @ip The ip address that made the payment
	* @payment_registration_detail_id (optional) The registraiton detail id of the payment record.
	* 		If not provided, it will try to look it up based on the last payment made for the amount
	* @result (output) Output as to whether the procs was succesful (= 1) or failed (= 0)
	*/
	public struct function GroupPaymentWaterfall(
		required numeric registration_id,
		required numeric payment_amount,
		required string ip,
		numeric payment_registration_detail_id=0
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "GroupPaymentWaterfall"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@registration_id", cfsqltype="cf_sql_bigint", value=arguments.registration_id );
		sp.addParam( type="in", dbvarname="@payment_amount", cfsqltype="cf_sql_money", value=arguments.payment_amount );
		sp.addParam( type="in", dbvarname="@ip", cfsqltype="cf_sql_varchar", value=arguments.ip, maxlength=45 );
		sp.addParam( type="in", dbvarname="@payment_registration_detail_id", cfsqltype="cf_sql_bigint", value=arguments.payment_registration_detail_id, null=( !arguments.payment_registration_detail_id ) );
		sp.addParam( type="out", dbvarname="@result", cfsqltype="cf_sql_integer", variable="result" );
        try {
            result = sp.execute();
            data['prefix'] = result.getPrefix();
            structAppend( data, result.getProcOutVariables() );
        } catch(any e) {
            data = {};
        }

		return data;
	}
}