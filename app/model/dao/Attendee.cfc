/**
* I am the DAO for the Attendee object
* @file  /model/dao/Attendee.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/*
	* Gets all of the attendees for an event
	* @event_id The id of the event to get the attendees for
	* @start (optional) The row to start on
	* @results (optional) The number of results to return
	* @sort_column (optional) The column to sort by
	* @sort_direction (optional) The direction to sort
	* @search (optional) A Keyword to filter the results on
	*/
	public struct function AttendeesList(
		required numeric event_id,
		numeric start=1,
		numeric results=10,
		string sort_column="first_name",
		string sort_direction="ASC",
		string search=""
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeesList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", value=arguments.sort_column, maxlength=50, null=( !len( arguments.sort_column ) ) );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", value=arguments.sort_direction, maxlength=4, null=( !len( arguments.sort_direction ) ) );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", value=arguments.search, maxlength=200, null=( !len( arguments.search ) ) );
		sp.addProcResult( name="result", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result
		};
	}
	/*
	* Gets an attendee
	* @attendee_id The attendee_id
	*/
	public struct function AttendeeGet( required numeric attendee_id, required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeeGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@attendee_id", cfsqltype="cf_sql_bigint", value=arguments.attendee_id, variable="attendee_id" );
		sp.addParam( type="inout", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, variable="event_id" );
		sp.addParam( type="out", dbvarname="@email", cfsqltype="cf_sql_varchar", variable="email" );
		sp.addParam( type="out", dbvarname="@registration_id", cfsqltype="cf_sql_bigint", variable="registration_id" );
		sp.addParam( type="out", dbvarname="@coupon_id", cfsqltype="cf_sql_integer", variable="coupon_id" );
		sp.addParam( type="out", dbvarname="@first_name", cfsqltype="cf_sql_varchar", variable="first_name" );
		sp.addParam( type="out", dbvarname="@middle_name", cfsqltype="cf_sql_varchar", variable="middle_name" );
		sp.addParam( type="out", dbvarname="@last_name", cfsqltype="cf_sql_varchar", variable="last_name" );
		sp.addParam( type="out", dbvarname="@prefix", cfsqltype="cf_sql_varchar", variable="prefix" );
		sp.addParam( type="out", dbvarname="@suffix", cfsqltype="cf_sql_varchar", variable="suffix" );
		sp.addParam( type="out", dbvarname="@job_title", cfsqltype="cf_sql_varchar", variable="job_title" );
		sp.addParam( type="out", dbvarname="@name_on_badge", cfsqltype="cf_sql_varchar", variable="name_on_badge" );
		sp.addParam( type="out", dbvarname="@company", cfsqltype="cf_sql_varchar", variable="company" );
		sp.addParam( type="out", dbvarname="@country_code", cfsqltype="cf_sql_char", variable="country_code" );
		sp.addParam( type="out", dbvarname="@address_1", cfsqltype="cf_sql_varchar", variable="address_1" );
		sp.addParam( type="out", dbvarname="@address_2", cfsqltype="cf_sql_varchar", variable="address_2" );
		sp.addParam( type="out", dbvarname="@city", cfsqltype="cf_sql_varchar", variable="city" );
		sp.addParam( type="out", dbvarname="@region_code", cfsqltype="cf_sql_varchar", variable="region_code" );
		sp.addParam( type="out", dbvarname="@postal_code", cfsqltype="cf_sql_varchar", variable="postal_code" );
		sp.addParam( type="out", dbvarname="@home_phone", cfsqltype="cf_sql_varchar", variable="home_phone" );
		sp.addParam( type="out", dbvarname="@work_phone", cfsqltype="cf_sql_varchar", variable="work_phone" );
		sp.addParam( type="out", dbvarname="@extension", cfsqltype="cf_sql_varchar", variable="extension" );
		sp.addParam( type="out", dbvarname="@fax_phone", cfsqltype="cf_sql_varchar", variable="fax_phone" );
		sp.addParam( type="out", dbvarname="@cell_phone", cfsqltype="cf_sql_varchar", variable="cell_phone" );
		sp.addParam( type="out", dbvarname="@dob", cfsqltype="cf_sql_date", variable="dob" );
		sp.addParam( type="out", dbvarname="@gender", cfsqltype="cf_sql_char", variable="gender" );
		sp.addParam( type="out", dbvarname="@emergency_contact_name", cfsqltype="cf_sql_varchar", variable="emergency_contact_name" );
		sp.addParam( type="out", dbvarname="@emergency_contact_phone", cfsqltype="cf_sql_varchar", variable="emergency_contact_phone" );
		sp.addParam( type="out", dbvarname="@secondary_email", cfsqltype="cf_sql_varchar", variable="secondary_email" );
		sp.addParam( type="out", dbvarname="@cc_email", cfsqltype="cf_sql_varchar", variable="cc_email" );
		sp.addParam( type="out", dbvarname="@custom", cfsqltype="cf_sql_longvarchar", variable="custom" );
		sp.addParam( type="out", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", variable="registration_type_id" );
		sp.addParam( type="out", dbvarname="@registration_type", cfsqltype="cf_sql_varchar", variable="registration_type" );
		sp.addParam( type="out", dbvarname="@active", cfsqltype="cf_sql_bit", variable="active" );
		sp.addParam( type="out", dbvarname="@company_id", cfsqltype="cf_sql_integer", variable="company_id" );
		sp.addParam( type="out", dbvarname="@attendee_status", cfsqltype="cf_sql_varchar", variable="attendee_status" );
		sp.addParam( type="out", dbvarname="@total_cost", cfsqltype="cf_sql_float", variable="total_cost" );
		sp.addParam( type="out", dbvarname="@total_credits", cfsqltype="cf_sql_float", variable="total_credits" );
		sp.addParam( type="out", dbvarname="@total_due", cfsqltype="cf_sql_float", variable="total_due" );
		sp.addParam( type="out", dbvarname="@total_discounts", cfsqltype="cf_sql_float", variable="total_discounts" );
		sp.addParam( type="out", dbvarname="@total_fees", cfsqltype="cf_sql_float", variable="total_fees" );
		sp.addParam( type="out", dbvarname="@total_agenda_fees", cfsqltype="cf_sql_float", variable="total_agenda_fees" );
		sp.addParam( type="out", dbvarname="@total_event_fees", cfsqltype="cf_sql_float", variable="total_event_fees" );
		sp.addParam( type="out", dbvarname="@total_cancels", cfsqltype="cf_sql_float", variable="total_cancels" );
		sp.addParam( type="out", dbvarname="@total_fees_cancels", cfsqltype="cf_sql_float", variable="total_fees_cancels" );
		sp.addParam( type="out", dbvarname="@last_payment_amount", cfsqltype="cf_sql_float", variable="last_payment_amount" );
		sp.addParam( type="out", dbvarname="@last_payment_type", cfsqltype="cf_sql_varchar", variable="last_payment_type" );
		sp.addParam( type="out", dbvarname="@last_cancel_amount", cfsqltype="cf_sql_float", variable="last_cancel_amount" );
		sp.addParam( type="out", dbvarname="@hotel_id", cfsqltype="cf_sql_integer", variable="hotel_id" );
		sp.addParam( type="out", dbvarname="@hotel_name", cfsqltype="cf_sql_varchar", variable="hotel_name" );
		sp.addParam( type="out", dbvarname="@hotel_room_type_id", cfsqltype="cf_sql_integer", variable="hotel_room_type_id" );
		sp.addParam( type="out", dbvarname="@hotel_room_type", cfsqltype="cf_sql_varchar", variable="hotel_room_type" );
		sp.addParam( type="out", dbvarname="@hotel_checkin_date", cfsqltype="cf_sql_date", variable="hotel_checkin_date" );
		sp.addParam( type="out", dbvarname="@hotel_checkout_date", cfsqltype="cf_sql_date", variable="hotel_checkout_date" );
		sp.addParam( type="out", dbvarname="@hotel_number_rooms", cfsqltype="cf_sql_smallint", variable="hotel_number_rooms" );
		sp.addParam( type="out", dbvarname="@hotel_reservation_name", cfsqltype="cf_sql_varchar", variable="hotel_reservation_name" );
		sp.addParam( type="out", dbvarname="@hotel_reservation_phone", cfsqltype="cf_sql_varchar", variable="hotel_reservation_phone" );
		sp.addParam( type="out", dbvarname="@hotel_reservation_email", cfsqltype="cf_sql_varchar", variable="hotel_reservation_email" );
		sp.addParam( type="out", dbvarname="@hotel_requested", cfsqltype="cf_sql_varchar", variable="hotel_requested" );
		sp.addParam( type="out", dbvarname="@parent_attendee_id", cfsqltype="cf_sql_bigint", variable="parent_attendee_id" );
		sp.addParam( type="out", dbvarname="@parent_name", cfsqltype="cf_sql_varchar", variable="parent_name" );
		sp.addParam( type="out", dbvarname="@group_allowed", cfsqltype="cf_sql_varchar", variable="group_allowed" );
		sp.addParam( type="out", dbvarname="@cc_email_2", cfsqltype="cf_sql_varchar", variable="cc_email_2" );
		sp.addParam( type="out", dbvarname="@cc_email_3", cfsqltype="cf_sql_varchar", variable="cc_email_3" );
		sp.addParam( type="out", dbvarname="@cc_email_4", cfsqltype="cf_sql_varchar", variable="cc_email_4" );
		
		sp.addProcResult( name="notes", resultset=1 );
		sp.addProcResult( name="logs", resultset=2 );
		sp.addProcResult( name="details", resultset=3 );
		sp.addProcResult( name="detailPayments", resultset=4 );
		sp.addProcResult( name="Group", resultset=5 );
		sp.addProcResult( name="custom_data", resultset=6 );
		
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		structAppend( data, result.getProcResultSets() );
		data['hotel_requested'] = ( data.hotel_requested ? 1:0);

		if( isJSON( data.custom_data.custom ) ) {
			data['custom'] = data.custom_data.custom;
		}

		return data;
	}
	/*
	* Gets the attendees agenda
	* @attendee_id The id of the attendee
	*/
	public struct function AttendeeAgendaGet( required numeric attendee_id, required numeric event_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeeAgendaGet"
		});
		sp.addParam( type="in", dbvarname="@attendee_id", cfsqltype="cf_sql_bigint", value=arguments.attendee_id );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_bigint", value=arguments.event_id );
		sp.addProcResult( name="result", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result
		};
	}
	/*
	* Creates or Updates an Attendee and Returns the Attendee ID
	* @attendee_id (optional) The Attendee ID, if NULL it means to add
	* @event_id The ID of the Event
	* @registration_type_id The type of registration
	* @email The attendees email address
	* @password The password hash
	* @salt The salt used to generate the password hash
	* @registration_id (optional) A paid registration to tie the attendee too
	* @coupon_id (optional) A coupon used for the attendee at the time of registration
	* @prefix (optional) The prefix of the attendee
	* @first_name (optional) The first name of the attendee
	* @middle_name (optional) The middle name of the attendee
	* @last_name (optional) The last name of the attendee
	* @suffix (optional) The suffix of the attendee
	* @job_title (optional) The job_title of the attendee
	* @name_on_badge (optional)
	* @company (optional) The company of the attendee
	* @country_code (optional) The country_code of the attendee
	* @address_1 (optional) The address_1 of the attendee
	* @address_2 (optional) The address_2 of the attendee
	* @region_code (optional) The region_code of the attendee
	* @postal_code (optional) The postal_code of the attendee
	* @home_phone (optional) The home_phone of the attendee
	* @work_phone (optional) The work_phone of the attendee
	* @extension (optional) The extension of the attendee
	* @fax_phone (optional) The fax_phone of the attendee
	* @cell_phone (optional) The cell_phone of the attendee
	* @dob (optional) The dob of the attendee
	* @gender (optional) The gender of the attendee
	* @emergency_contact_name (optional) The emergency_contact_name of the attendee
	* @emergency_contact_phone (optional) The emergency_contact_phone of the attendee
	* @secondary_email (optional) The secondary_email of the attendee
	* @custom (optional) The custom of the attendee
	*/
	public numeric function AttendeeSet(
		required numeric attendee_id=0,
		required numeric event_id,
		required numeric registration_type_id,
		required string email,
		string password="",
		string salt="",
		required numeric registration_id=0,
		required numeric coupon_id=0,
		string prefix="",
		string first_name="",
		string middle_name="",
		string last_name="",
		string suffix="",
		string job_title="",
		string name_on_badge="",
		string company="",
		string country_code="",
		string address_1="",
		string address_2="",
		string city="",
		string region_code="",
		string postal_code="",
		string home_phone="",
		string work_phone="",
		string extension="",
		string fax_phone="",
		string cell_phone="",
		string dob="",
		string gender="",
		string emergency_contact_name="",
		string emergency_contact_phone="",
		string secondary_email="",
		string cc_email="",
		string custom="",
		required numeric company_id=0,
		string attendee_status="Registered",
		numeric hotel_id=0,
		numeric hotel_room_type_id=0,
		string hotel_checkin_date="",
		string hotel_checkout_date="",
		numeric hotel_number_rooms=0,
		string hotel_reservation_name="",
		string hotel_reservation_phone="",
		string hotel_reservation_email="",
		boolean hotel_requested=false,
		numeric parent_attendee_id=0,
		string cc_email_2="",
		string cc_email_3="",
		string cc_email_4=""
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeeSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@attendee_id", cfsqltype="cf_sql_bigint", value=arguments.attendee_id, null=( !arguments.attendee_id ), variable="attendee_id" );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );
		sp.addParam( type="in", dbvarname="@email", cfsqltype="cf_sql_varchar", value=arguments.email, maxlength=300 );
		sp.addParam( type="in", dbvarname="@password", cfsqltype="cf_sql_char", value=arguments.password, maxlength=128, null=( !len( arguments.password ) ) );
		sp.addParam( type="in", dbvarname="@salt", cfsqltype="cf_sql_char", value=arguments.salt, maxlength=24, null=( !len( arguments.salt ) ) );
		sp.addParam( type="in", dbvarname="@registration_id", cfsqltype="cf_sql_bigint", value=arguments.registration_id, null=( !arguments.registration_id ) );
		sp.addParam( type="in", dbvarname="@coupon_id", cfsqltype="cf_sql_integer", value=arguments.coupon_id, null=( !arguments.coupon_id ) );
		sp.addParam( type="in", dbvarname="@prefix", cfsqltype="cf_sql_varchar", value=arguments.prefix, maxlength=50, null=( !len( arguments.prefix ) ) );
		sp.addParam( type="in", dbvarname="@first_name", cfsqltype="cf_sql_varchar", value=arguments.first_name, maxlength=200, null=( !len( arguments.first_name ) ) );
		sp.addParam( type="in", dbvarname="@middle_name", cfsqltype="cf_sql_varchar", value=arguments.middle_name, maxlength=200, null=( !len( arguments.middle_name ) ) );
		sp.addParam( type="in", dbvarname="@last_name", cfsqltype="cf_sql_varchar", value=arguments.last_name, maxlength=200, null=( !len( arguments.last_name ) ) );
		sp.addParam( type="in", dbvarname="@suffix", cfsqltype="cf_sql_varchar", value=arguments.suffix, maxlength=50, null=( !len( arguments.suffix ) ) );
		sp.addParam( type="in", dbvarname="@job_title", cfsqltype="cf_sql_varchar", value=arguments.job_title, maxlength=200, null=( !len( arguments.job_title ) ) );
		sp.addParam( type="in", dbvarname="@name_on_badge", cfsqltype="cf_sql_varchar", value=arguments.name_on_badge, maxlength=500, null=( !len( arguments.name_on_badge ) ) );
		sp.addParam( type="in", dbvarname="@company", cfsqltype="cf_sql_varchar", value=arguments.company, maxlength=200, null=( !len( arguments.company ) ) );
		sp.addParam( type="in", dbvarname="@country_code", cfsqltype="cf_sql_char", value=arguments.country_code, maxlength=2, null=( !len( arguments.country_code ) ) );
		sp.addParam( type="in", dbvarname="@address_1", cfsqltype="cf_sql_varchar", value=arguments.address_1, maxlength=200, null=( !len( arguments.address_1 ) ) );
		sp.addParam( type="in", dbvarname="@address_2", cfsqltype="cf_sql_varchar", value=arguments.address_2, maxlength=200, null=( !len( arguments.address_2 ) ) );
		sp.addParam( type="in", dbvarname="@city", cfsqltype="cf_sql_varchar", value=arguments.city, maxlength=150, null=( !len( arguments.city ) ) );
		sp.addParam( type="in", dbvarname="@region_code", cfsqltype="cf_sql_varchar", value=arguments.region_code, maxlength=6, null=( !len( arguments.region_code ) ) );
		sp.addParam( type="in", dbvarname="@postal_code", cfsqltype="cf_sql_varchar", value=arguments.postal_code, maxlength=15, null=( !len( arguments.postal_code ) ) );
		sp.addParam( type="in", dbvarname="@home_phone", cfsqltype="cf_sql_varchar", value=arguments.home_phone, maxlength=30, null=( !len( arguments.home_phone ) ) );
		sp.addParam( type="in", dbvarname="@work_phone", cfsqltype="cf_sql_varchar", value=arguments.work_phone, maxlength=30, null=( !len( arguments.work_phone ) ) );
		sp.addParam( type="in", dbvarname="@extension", cfsqltype="cf_sql_varchar", value=arguments.extension, maxlength=15, null=( !len( arguments.extension ) ) );
		sp.addParam( type="in", dbvarname="@fax_phone", cfsqltype="cf_sql_varchar", value=arguments.fax_phone, maxlength=30, null=( !len( arguments.fax_phone ) ) );
		sp.addParam( type="in", dbvarname="@cell_phone", cfsqltype="cf_sql_varchar", value=arguments.cell_phone, maxlength=30, null=( !len( arguments.cell_phone ) ) );
		sp.addParam( type="in", dbvarname="@dob", cfsqltype="cf_sql_date", value=arguments.dob, null=( !isdate( arguments.dob ) ) );
		sp.addParam( type="in", dbvarname="@gender", cfsqltype="cf_sql_char", value=arguments.gender, maxlength=6, null=( !len( arguments.gender ) ) );
		sp.addParam( type="in", dbvarname="@emergency_contact_name", cfsqltype="cf_sql_varchar", value=arguments.emergency_contact_name, maxlength=300, null=( !len( arguments.emergency_contact_name ) ) );
		sp.addParam( type="in", dbvarname="@emergency_contact_phone", cfsqltype="cf_sql_varchar", value=arguments.emergency_contact_phone, maxlength=15, null=( !len( arguments.emergency_contact_phone ) ) );
		sp.addParam( type="in", dbvarname="@secondary_email", cfsqltype="cf_sql_varchar", value=arguments.secondary_email, maxlength=300, null=( !len( arguments.secondary_email ) ) );
		sp.addParam( type="in", dbvarname="@cc_email", cfsqltype="cf_sql_varchar", value=arguments.cc_email, maxlength=300, null=( !len( arguments.cc_email ) ) );
		sp.addParam( type="in", dbvarname="@custom", cfsqltype="cf_sql_longvarchar", value=arguments.custom, null=( !len( arguments.custom ) ) );
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id, null=( !arguments.company_id ) );
		sp.addParam( type="in", dbvarname="@attendee_status", cfsqltype="cf_sql_varchar", value=arguments.attendee_status, maxlength=50, null=( !len( arguments.attendee_status ) ) );
		sp.addParam( type="in", dbvarname="@hotel_id", cfsqltype="cf_sql_integer", value=arguments.hotel_id, null=( !arguments.hotel_id ) );
		sp.addParam( type="in", dbvarname="@hotel_room_type_id", cfsqltype="cf_sql_integer", value=arguments.hotel_room_type_id, null=( !arguments.hotel_room_type_id ) );
		sp.addParam( type="in", dbvarname="@hotel_checkin_date", cfsqltype="cf_sql_date", value=arguments.hotel_checkin_date, null=( !isdate( arguments.hotel_checkin_date ) ) );
		sp.addParam( type="in", dbvarname="@hotel_checkout_date", cfsqltype="cf_sql_date", value=arguments.hotel_checkout_date, null=( !isdate( arguments.hotel_checkout_date ) ) );
		sp.addParam( type="in", dbvarname="@hotel_number_rooms", cfsqltype="cf_sql_smallint", value=arguments.hotel_number_rooms, null=( !arguments.hotel_number_rooms ) );
		sp.addParam( type="in", dbvarname="@hotel_reservation_name", cfsqltype="cf_sql_varchar", value=arguments.hotel_reservation_name, maxlength=100, null=( !len( arguments.hotel_reservation_name ) ) );
		sp.addParam( type="in", dbvarname="@hotel_reservation_phone", cfsqltype="cf_sql_varchar", value=arguments.hotel_reservation_phone, maxlength=30, null=( !len( arguments.hotel_reservation_phone ) ) );
		sp.addParam( type="in", dbvarname="@hotel_reservation_email", cfsqltype="cf_sql_varchar", value=arguments.hotel_reservation_email, maxlength=300, null=( !len( arguments.hotel_reservation_email ) ) );
		sp.addParam( type="in", dbvarname="@hotel_requested", cfsqltype="cf_sql_varchar", value=arguments.hotel_requested );
		sp.addParam( type="in", dbvarname="@parent_attendee_id", cfsqltype="cf_sql_integer", value=arguments.parent_attendee_id, null=( !arguments.parent_attendee_id ) );
		sp.addParam( type="in", dbvarname="@cc_email_2", cfsqltype="cf_sql_varchar", value=arguments.cc_email_2, maxlength=300, null=( !len( arguments.cc_email_2 ) ) );
		sp.addParam( type="in", dbvarname="@cc_email_3", cfsqltype="cf_sql_varchar", value=arguments.cc_email_3, maxlength=300, null=( !len( arguments.cc_email_3 ) ) );
		sp.addParam( type="in", dbvarname="@cc_email_4", cfsqltype="cf_sql_varchar", value=arguments.cc_email_4, maxlength=300, null=( !len( arguments.cc_email_4 ) ) );
		result = sp.execute();
		return result.getProcOutVariables().attendee_id;
	}
	/*
	* Adds a Scheduled Agenda Item to an Attendees Agenda
	* @event_id The id of the event
	* @attendee_id The id of the attendee
	* @agenda_id The id of the agenda
	*/
	public void function AttendeeAgendaAdd(
		required numeric event_id,
		required numeric attendee_id,
		required numeric agenda_id
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeeAgendaAdd"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@attendee_id", cfsqltype="cf_sql_integer", value=arguments.attendee_id );
		sp.addParam( type="in", dbvarname="@agenda_id", cfsqltype="cf_sql_integer", value=arguments.agenda_id );

		result = sp.execute();
		return;
	}
	/*
	* Updates the sort order for fields in a section in a given reg type
	* @agenda_ids Comma-delimited list of field_ids
	* @section_id The section id
	*/
	public void function AttendeeAgendasAdd(
		required numeric event_id,
		required numeric attendee_id,
		required string agenda_ids,
		string ip=""
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeeAgendasAdd"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@attendee_id", cfsqltype="cf_sql_integer", value=arguments.attendee_id );
		sp.addParam( type="in", dbvarname="@agenda_ids", cfsqltype="cf_sql_varchar", value=arguments.agenda_ids, maxlength=500 );
		sp.addParam( type="in", dbvarname="@ip", cfsqltype="cf_sql_varchar", value=arguments.ip, maxlength=45, null=( !len( arguments.ip ) ) );

		result = sp.execute();
		return ;
	}
	/*
	* Determines if an attendee email exists already or not in the database
	* @event_id The id of the event
	* @email The users name
	* @in_use (output) Whether or not the email exists
	*/
	public struct function AttendeeEmailExists(
		required numeric event_id,
		required string email
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeeEmailExists"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@email", cfsqltype="cf_sql_varchar", value=arguments.email, maxlength=300 );
		sp.addParam( type="out", dbvarname="@in_use", cfsqltype="cf_sql_bit", variable="in_use" );


		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
	/*
	* Creates or Updates an Registration and Returns the Registration ID
	* @registration_id The ID the of the registration
	* @attendee_id The Attendee ID
	* @attendee_status The attendee status
	*/
	public void function RegistrationAttendeeStatusSet(
		required numeric registration_id,
		required numeric attendee_id,
		required string attendee_status
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationAttendeeStatusSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@registration_id", cfsqltype="cf_sql_bigint", value=arguments.registration_id );
		sp.addParam( type="in", dbvarname="@attendee_id", cfsqltype="cf_sql_bigint", value=arguments.attendee_id );
		sp.addParam( type="in", dbvarname="@attendee_status", cfsqltype="cf_sql_varchar", value=arguments.attendee_status, maxlength=50 );
		result = sp.execute();
		return;
	}
	/*
	* Creates or Updates an Registration and Returns the Registration ID
	* @registration_id The ID the of the registration
	* @attendee_id The Attendee ID
	*/
	public struct function AttendeeCostBreakdownGet(
		required numeric registration_id,
		required numeric attendee_id
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeeCostBreakdownGet"
		});
		sp.addParam( type="in", dbvarname="@registration_id", cfsqltype="cf_sql_bigint", value=arguments.registration_id );
		sp.addParam( type="in", dbvarname="@attendee_id", cfsqltype="cf_sql_bigint", value=arguments.attendee_id );
		sp.addParam( type="out", dbvarname="@total_cost", cfsqltype="cf_sql_float", variable="total_cost" );
		sp.addParam( type="out", dbvarname="@total_credits", cfsqltype="cf_sql_float", variable="total_credits" );
		sp.addParam( type="out", dbvarname="@total_due", cfsqltype="cf_sql_float", variable="total_due" );
		sp.addParam( type="out", dbvarname="@total_fees", cfsqltype="cf_sql_float", variable="total_fees" );
		sp.addParam( type="out", dbvarname="@total_discounts", cfsqltype="cf_sql_float", variable="total_discounts" );
		sp.addParam( type="out", dbvarname="@total_agenda_fees", cfsqltype="cf_sql_float", variable="total_agenda_fees" );
		sp.addParam( type="out", dbvarname="@total_event_fees", cfsqltype="cf_sql_float", variable="total_event_fees" );
		sp.addParam( type="out", dbvarname="@total_cancels", cfsqltype="cf_sql_float", variable="total_cancels" );
		sp.addParam( type="out", dbvarname="@total_fees_cancels", cfsqltype="cf_sql_float", variable="total_fees_cancels" );
		sp.addParam( type="out", dbvarname="@last_payment_amount", cfsqltype="cf_sql_float", variable="last_payment_amount" );
		sp.addParam( type="out", dbvarname="@last_payment_type", cfsqltype="cf_sql_varchar", variable="last_payment_type" );
		sp.addParam( type="out", dbvarname="@last_cancel_amount", cfsqltype="cf_sql_float", variable="last_cancel_amount" );

		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
	/*
	* Calculates the costs and credits for an attendee
	* @registration_id The ID the of the registration
	* @total_cost The sum of all Fees, Cancels and Discounts/Coupons
	* @total_credits The sum of all Payments, Refunds and Voids
	* @total_due The total amount outstanding
	* @total_fees The sum of all Fees
	* @total_discounts The sum of all Discounts and Coupons
	* @total_agenda_fees The sum of all Agenda Fees and Cancels
	* @total_event_fees The sum of all Event Fees and Cancels
	* @total_cancels The sum of all the cancels
	* @total_fees_cancels_sum The sum of all Fees and Cancels
	* @last_payment_amount The amount of the last payment
	* @last_payment_type The type of the last payment
	* @last_cancel_amount The amount of the last cancelled item
	*/
	public struct function GroupCostBreakdownGet( required numeric registration_id ) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "GroupCostBreakdownGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@registration_id", cfsqltype="cf_sql_bigint", value=arguments.registration_id );
		sp.addParam( type="out", dbvarname="@total_cost", cfsqltype="cf_sql_money", variable="total_cost" );
		sp.addParam( type="out", dbvarname="@total_credits", cfsqltype="cf_sql_money", variable="total_credits" );
		sp.addParam( type="out", dbvarname="@total_due", cfsqltype="cf_sql_money", variable="total_due" );
		sp.addParam( type="out", dbvarname="@total_fees", cfsqltype="cf_sql_money", variable="total_fees" );
		sp.addParam( type="out", dbvarname="@total_discounts", cfsqltype="cf_sql_money", variable="total_discounts" );
		sp.addParam( type="out", dbvarname="@total_agenda_fees", cfsqltype="cf_sql_money", variable="total_agenda_fees" );
		sp.addParam( type="out", dbvarname="@total_event_fees", cfsqltype="cf_sql_money", variable="total_event_fees" );
		sp.addParam( type="out", dbvarname="@total_cancels", cfsqltype="cf_sql_money", variable="total_cancels" );
		sp.addParam( type="out", dbvarname="@total_fees_cancels", cfsqltype="cf_sql_money", variable="total_fees_cancels" );
		sp.addParam( type="out", dbvarname="@last_payment_amount", cfsqltype="cf_sql_money", variable="last_payment_amount" );
		sp.addParam( type="out", dbvarname="@last_payment_type", cfsqltype="cf_sql_varchar", variable="last_payment_type" );
		sp.addParam( type="out", dbvarname="@last_cancel_amount", cfsqltype="cf_sql_money", variable="last_cancel_amount" );
		
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		structAppend( data, result.getProcResultSets() );
		return data;
	}
	/*
	* Cancels a Agenda for an Attendee and puts appropriate credits in RegistrationDetails
	* @event_id The id of the event
	* @attendee_id The id of the attendee
	* @registration_id The id of the registration
	* @agenda_id The id of the agenda to cancel
	* @ip The ip of the person making the change
	* @removed (output) Flag indicating if
	* @registration_detail_id (output) The id of the credit record if created
	*/
	public struct function AttendeeAgendaCancel(
		required numeric event_id,
		required numeric attendee_id,
		required numeric registration_id,
		required numeric agenda_id,
		required string ip
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeeAgendaCancel"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@attendee_id", cfsqltype="cf_sql_integer", value=arguments.attendee_id );
		sp.addParam( type="in", dbvarname="@registration_id", cfsqltype="cf_sql_integer", value=arguments.registration_id );
		sp.addParam( type="in", dbvarname="@agenda_id", cfsqltype="cf_sql_integer", value=arguments.agenda_id );
		sp.addParam( type="in", dbvarname="@ip", cfsqltype="cf_sql_varchar", value=arguments.ip, maxlength=45 );
		sp.addParam( type="out", dbvarname="@removed", cfsqltype="cf_sql_bit", variable="removed" );
		sp.addParam( type="out", dbvarname="@registration_detail_id", cfsqltype="cf_sql_bigint", variable="registration_detail_id" );

		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
	/*
	* Cancels an Event for an Attendee and puts appropriate credits in RegistrationDetails
	* @event_id The id of the event
	* @attendee_id The id of the attendee
	* @registration_id The id of the registration
	* @ip The ip of the person making the change
	* @removed (output) Flag indicating if
	*/
	public struct function AttendeeRegistrationCancel(
		required numeric event_id,
		required numeric attendee_id,
		required numeric registration_id,
		required string ip
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeeRegistrationCancel"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@attendee_id", cfsqltype="cf_sql_integer", value=arguments.attendee_id );
		sp.addParam( type="in", dbvarname="@registration_id", cfsqltype="cf_sql_integer", value=arguments.registration_id );
		sp.addParam( type="in", dbvarname="@ip", cfsqltype="cf_sql_varchar", value=arguments.ip, maxlength=45 );
		sp.addParam( type="out", dbvarname="@removed", cfsqltype="cf_sql_bit", variable="removed" );

		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
	/*
	* Determines if an attendee email exists for the event already or not in the database
	* @event_id The id of the event
	* @company_id The id of the company
	* @email The attendees email address
	* @registered (output) Flag indicating if the Email for the Company is registered for the Event
	* @attendee_id (output) Returns attendee_id if the email exists for the company
	*/
	public struct function AttendeeEventEmailExists(
		required numeric event_id,
		required numeric company_id,
		required string email
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeeEventEmailExists"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addParam( type="in", dbvarname="@email", cfsqltype="cf_sql_varchar", value=arguments.email, maxlength=300 );
		sp.addParam( type="out", dbvarname="@registered", cfsqltype="cf_sql_bit", variable="registered" );
		sp.addParam( type="out", dbvarname="@attendee_id", cfsqltype="cf_sql_bigint", variable="attendee_id" );

		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
	/*
	* Gets an attendee
	* @attendee_id The attendee_id
	*/
	public struct function AttendeeOnlyGet(
		required numeric attendee_id
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeeOnlyGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@attendee_id", cfsqltype="cf_sql_bigint", value=arguments.attendee_id, variable="attendee_id" );
		sp.addParam( type="out", dbvarname="@email", cfsqltype="cf_sql_varchar", variable="email" );
		sp.addParam( type="out", dbvarname="@first_name", cfsqltype="cf_sql_varchar", variable="first_name" );
		sp.addParam( type="out", dbvarname="@middle_name", cfsqltype="cf_sql_varchar", variable="middle_name" );
		sp.addParam( type="out", dbvarname="@last_name", cfsqltype="cf_sql_varchar", variable="last_name" );
		sp.addParam( type="out", dbvarname="@prefix", cfsqltype="cf_sql_varchar", variable="prefix" );
		sp.addParam( type="out", dbvarname="@suffix", cfsqltype="cf_sql_varchar", variable="suffix" );
		sp.addParam( type="out", dbvarname="@job_title", cfsqltype="cf_sql_varchar", variable="job_title" );
		sp.addParam( type="out", dbvarname="@name_on_badge", cfsqltype="cf_sql_varchar", variable="name_on_badge" );
		sp.addParam( type="out", dbvarname="@company", cfsqltype="cf_sql_varchar", variable="company" );
		sp.addParam( type="out", dbvarname="@country_code", cfsqltype="cf_sql_char", variable="country_code" );
		sp.addParam( type="out", dbvarname="@address_1", cfsqltype="cf_sql_varchar", variable="address_1" );
		sp.addParam( type="out", dbvarname="@address_2", cfsqltype="cf_sql_varchar", variable="address_2" );
		sp.addParam( type="out", dbvarname="@city", cfsqltype="cf_sql_varchar", variable="city" );
		sp.addParam( type="out", dbvarname="@region_code", cfsqltype="cf_sql_varchar", variable="region_code" );
		sp.addParam( type="out", dbvarname="@postal_code", cfsqltype="cf_sql_varchar", variable="postal_code" );
		sp.addParam( type="out", dbvarname="@home_phone", cfsqltype="cf_sql_varchar", variable="home_phone" );
		sp.addParam( type="out", dbvarname="@work_phone", cfsqltype="cf_sql_varchar", variable="work_phone" );
		sp.addParam( type="out", dbvarname="@extension", cfsqltype="cf_sql_varchar", variable="extension" );
		sp.addParam( type="out", dbvarname="@fax_phone", cfsqltype="cf_sql_varchar", variable="fax_phone" );
		sp.addParam( type="out", dbvarname="@cell_phone", cfsqltype="cf_sql_varchar", variable="cell_phone" );
		sp.addParam( type="out", dbvarname="@dob", cfsqltype="cf_sql_date", variable="dob" );
		sp.addParam( type="out", dbvarname="@gender", cfsqltype="cf_sql_varchar", variable="gender" );
		sp.addParam( type="out", dbvarname="@emergency_contact_name", cfsqltype="cf_sql_varchar", variable="emergency_contact_name" );
		sp.addParam( type="out", dbvarname="@emergency_contact_phone", cfsqltype="cf_sql_varchar", variable="emergency_contact_phone" );
		sp.addParam( type="out", dbvarname="@secondary_email", cfsqltype="cf_sql_varchar", variable="secondary_email" );
		sp.addParam( type="out", dbvarname="@active", cfsqltype="cf_sql_bit", variable="active" );
		sp.addParam( type="out", dbvarname="@company_id", cfsqltype="cf_sql_integer", variable="company_id" );
		sp.addParam( type="out", dbvarname="@attendee_status", cfsqltype="cf_sql_varchar", variable="attendee_status" );
		sp.addParam( type="out", dbvarname="@cc_email", cfsqltype="cf_sql_varchar", variable="cc_email" );
		sp.addParam( type="out", dbvarname="@cc_email_2", cfsqltype="cf_sql_varchar", variable="cc_email_2" );
		sp.addParam( type="out", dbvarname="@cc_email_3", cfsqltype="cf_sql_varchar", variable="cc_email_3" );
		sp.addParam( type="out", dbvarname="@cc_email_4", cfsqltype="cf_sql_varchar", variable="cc_email_4" );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
	/*
	* Gets an AttendeeStatusesGet
	* @active The active id
	*/
	public struct function AttendeeStatusesGet( boolean active=1 ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeeStatusesGet"
		});
		sp.addParam( type="in", dbvarname="@active", cfsqltype="cf_sql_bit", value=arguments.active, null=( !len( arguments.active ) ) );
		sp.addProcResult( name="statuses", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Purges all records of an attendee for an Event
	*  NOTE:  This is a descructive purge and does not log any actions
	*		  Should only be used for system clean up
	* @attendee_id The id of the attendee
	* @event_id The id of the event
	*/
	public void function AttendeeEventPurge(
		required numeric attendee_id,
		required numeric event_id
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeeEventPurge"
		});
		sp.addParam( type="in", dbvarname="@attendee_id", cfsqltype="cf_sql_integer", value=arguments.attendee_id );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		result = sp.execute();
		return;
	}
	/*
	* Cancels a Event for an Attendee and puts appropriate credits in RegistrationDetails
	* @event_id The id of the event
	* @attendee_id The id of the attendee
	* @registration_id The id of the registration
	* @ip The ip of the person making the change
	* @removed (output) Flag indicating if removed
	* @ignore_rules Flag set to true if you do not want the cancel rules applied
	* @cancel_description Cancel description
	* @tx_date Transaction date to use for refund rules
	*/
	public struct function AttendeeEventCancel(
		required numeric event_id,
		required numeric attendee_id,
		required numeric registration_id,
		required string ip,
		string cancel_description="",
		string tx_date="",
		boolean ignore_rules=0
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeeEventCancel"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@attendee_id", cfsqltype="cf_sql_integer", value=arguments.attendee_id );
		sp.addParam( type="in", dbvarname="@registration_id", cfsqltype="cf_sql_integer", value=arguments.registration_id );
		sp.addParam( type="in", dbvarname="@ip", cfsqltype="cf_sql_varchar", value=arguments.ip, maxlength=45 );
		sp.addParam( type="in", dbvarname="@cancel_description", cfsqltype="cf_sql_varchar", value=arguments.cancel_description, maxlength=300, null=( !len( arguments.cancel_description ) ) );
		sp.addParam( type="in", dbvarname="@tx_date", cfsqltype="cf_sql_timestamp", value=arguments.tx_date, null=( !isdate( arguments.tx_date ) ) );
		sp.addParam( type="in", dbvarname="@ignore_rules", cfsqltype="cf_sql_bit", value=arguments.ignore_rules );
		sp.addParam( type="out", dbvarname="@removed", cfsqltype="cf_sql_bit", variable="removed" );

		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
	/*
	* Remove a coupon from an attendee's record
	* @event_id The id of the event
	* @attendee_id The id of the attendee
	* @registration_id The id of the registration
	*/
	public struct function AttendeeCouponsRemove(
		required numeric attendee_id,
		required numeric registration_id
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeeCouponsRemove"
		});
		sp.addParam( type="in", dbvarname="@attendee_id", cfsqltype="cf_sql_bigint", value=arguments.attendee_id );
		sp.addParam( type="in", dbvarname="@registration_id", cfsqltype="cf_sql_bigint", value=arguments.registration_id );
		sp.addProcResult( name="coupons", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Creates or Updates an Attende Note and Returns the Note ID
	* @note_id The note id
	* @attendee_id The attendee id
	* @note The note text
	* @event_id (optional) The event_id to associate the note to for the attendee
	*/
	public numeric function AttendeeNoteSet(
		numeric note_id=0,
		required numeric attendee_id,
		required string note,
		required numeric event_id
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeeNoteSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@note_id", cfsqltype="cf_sql_integer", value=arguments.note_id, null=( !arguments.note_id ), variable="note_id" );
		sp.addParam( type="in", dbvarname="@attendee_id", cfsqltype="cf_sql_bigint", value=arguments.attendee_id );
		sp.addParam( type="in", dbvarname="@note", cfsqltype="cf_sql_varchar", value=arguments.note, maxlength=4000 );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_bigint", value=arguments.event_id, null=( !arguments.event_id ) );

		result = sp.execute();
		return result.getProcOutVariables().note_id;
	}
	/*
	* Sets all the parent_attendee_id's for single group registration
	* @registration_id The id of the group registration to update
	* @parent_attendee_id The attendee_id to make the primary contact (parent) for each registration attendee
	*/
	public void function RegistrationAttendeesParentSet(
		required numeric registration_id,
		required numeric parent_attendee_id
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationAttendeesParentSet"
		});
		sp.addParam( type="in", dbvarname="@registration_id", cfsqltype="cf_sql_bigint", value=arguments.registration_id );
		sp.addParam( type="in", dbvarname="@parent_attendee_id", cfsqltype="cf_sql_bigint", value=arguments.parent_attendee_id );

		result = sp.execute();
		return;
	}
	/*
	* Updates an Attendee's password
	* @attendee_id The Attendee ID, if NULL it means to add
	* @password The password hash
	* @salt The salt used to generate the password hash
	*/
	public void function AttendeePasswordSet(
		required numeric attendee_id,
		required string password,
		required string salt
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeePasswordSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@attendee_id", cfsqltype="cf_sql_bigint", value=arguments.attendee_id );
		sp.addParam( type="in", dbvarname="@password", cfsqltype="cf_sql_char", value=arguments.password, maxlength=128 );
		sp.addParam( type="in", dbvarname="@salt", cfsqltype="cf_sql_char", value=arguments.salt, maxlength=24 );
		result = sp.execute();
		return;
	}
}