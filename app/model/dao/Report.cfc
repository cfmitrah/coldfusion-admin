/**
* I am the DAO for the Airport object
* @file  /model/dao/Airport.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {
	/*
	* Report of coupon codes and attendees that used them for an event 
	* @event_id The id of the event
	* @coupon_code_list (optional) Comma seperated list of coupon codes to filter to
	* @coupon_type_list (optional) Comma seperated list of coupon types to filter to
	* @start The row to start on
	* @results The number of results to return
	* @sort_column The column to sort by - valid values:
	*	('first_name','last_name','email','coupon_type','amount','detail_timestamp','coupon_code','total_due_before_coupon','total_due_after_coupon')
	* @sort_direction The direction to sort
	*/	
	public struct function CouponAttendeesReportList(
		required numeric event_id,
		string coupon_code_list="",
		string coupon_type_list="",
		numeric start=1,
		numeric results=10,
		string sort_column="coupon_code",
		string sort_direction="ASC"
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CouponAttendeesReportList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@coupon_code_list", cfsqltype="cf_sql_longvarchar", value=arguments.coupon_code_list, null=( !len( arguments.coupon_code_list ) ) );
		sp.addParam( type="in", dbvarname="@coupon_type_list", cfsqltype="cf_sql_longvarchar", value=arguments.coupon_type_list, null=( !len( arguments.coupon_type_list ) ) );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", value=arguments.sort_column, maxlength=50, null=( !len( arguments.sort_column ) ) );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", value=arguments.sort_direction, maxlength=4, null=( !len( arguments.sort_direction ) ) );
		sp.addProcResult( name="report", resultset=1 );
		sp.addProcResult( name="event_details", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Report of coupon codes and attendees that used them for an event 
	* @event_id The id of the event
	* @coupon_code_list (optional) Comma seperated list of coupon codes to filter to
	* @coupon_type_list (optional) Comma seperated list of coupon types to filter to
	* @sort_column The column to sort by - valid values:
	*	('first_name','last_name','email','coupon_type','amount','detail_timestamp','coupon_code','total_due_before_coupon','total_due_after_coupon')
	* @sort_direction The direction to sort
	*/	
	public struct function CouponAttendeesReport(
		required numeric event_id,
		string coupon_code_list="",
		string coupon_type_list="",
		string sort_column="coupon_code",
		string sort_direction="ASC"
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "CouponAttendeesReport"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@coupon_code_list", cfsqltype="cf_sql_longvarchar", value=arguments.coupon_code_list, null=( !len( arguments.coupon_code_list ) ) );
		sp.addParam( type="in", dbvarname="@coupon_type_list", cfsqltype="cf_sql_longvarchar", value=arguments.coupon_type_list, null=( !len( arguments.coupon_type_list ) ) );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", value=arguments.sort_column, maxlength=50, null=( !len( arguments.sort_column ) ) );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", value=arguments.sort_direction, maxlength=4, null=( !len( arguments.sort_direction ) ) );
		sp.addProcResult( name="report", resultset=1 );
		sp.addProcResult( name="event_details", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Report of invitations sent and status
	* @company_id The id of the company to filter on
	* @event_id (optional) The id of the event to filter on
	* @invitation_id (optional) The id of the invitation to filter on
	* @invitation_schedule_id (optional) The id of the invitation schedule to filter on
	* @sent_date_from (optional) Sent date to filter from
	* @sent_date_to (optional) Sent date to filter to
	*/	
	public struct function InvitationStatusReport(
		required numeric company_id,
		required numeric event_id,
		required numeric invitation_id,
		numeric invitation_schedule_id=0,
		string sent_date_from="",
		string sent_date_to="",
		string sort_column="registered",
		string sort_direction="ASC"
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "InvitationStatusReport"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, null=( !arguments.event_id ) );
		sp.addParam( type="in", dbvarname="@invitation_id", cfsqltype="cf_sql_integer", value=arguments.invitation_id, null=( !arguments.invitation_id ) );
		sp.addParam( type="in", dbvarname="@invitation_schedule_id", cfsqltype="cf_sql_integer", value=arguments.invitation_schedule_id, null=( !arguments.invitation_schedule_id ) );
		sp.addParam( type="in", dbvarname="@sent_date_from", cfsqltype="cf_sql_timestamp", value=arguments.sent_date_from, null=( !len( arguments.sent_date_from ) ) );
		sp.addParam( type="in", dbvarname="@sent_date_to", cfsqltype="cf_sql_timestamp", value=arguments.sent_date_to, null=( !len( arguments.sent_date_to ) ) );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", value=arguments.sort_column, maxlength=50, null=( !len( arguments.sort_column ) ) );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", value=arguments.sort_direction, maxlength=4, null=( !len( arguments.sort_direction ) ) );
		sp.addProcResult( name="report", resultset=1 );
		sp.addProcResult( name="event_details", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Report of invitations sent and status
	* @company_id The id of the company to filter on
	* @event_id (optional) The id of the event to filter on
	* @invitation_id (optional) The id of the invitation to filter on
	* @invitation_schedule_id (optional) The id of the invitation schedule to filter on
	* @sent_date_from (optional) Sent date to filter from
	* @sent_date_to (optional) Sent date to filter to
	*/	
	public struct function InvitationStatusReportList(
		required numeric company_id,
		required numeric event_id,
		required numeric invitation_id,
		numeric invitation_schedule_id=0,
		string sent_date_from="",
		string sent_date_to="",
		numeric start=1,
		numeric results=10,
		string sort_column="registered",
		string sort_direction="ASC"
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "InvitationStatusReportList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, null=( !arguments.event_id ) );
		sp.addParam( type="in", dbvarname="@invitation_id", cfsqltype="cf_sql_integer", value=arguments.invitation_id, null=( !arguments.invitation_id ) );
		sp.addParam( type="in", dbvarname="@invitation_schedule_id", cfsqltype="cf_sql_integer", value=arguments.invitation_schedule_id, null=( !arguments.invitation_schedule_id ) );
		sp.addParam( type="in", dbvarname="@sent_date_from", cfsqltype="cf_sql_timestamp", value=arguments.sent_date_from, null=( !len( arguments.sent_date_from ) ) );
		sp.addParam( type="in", dbvarname="@sent_date_to", cfsqltype="cf_sql_timestamp", value=arguments.sent_date_to, null=( !len( arguments.sent_date_to ) ) );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", value=arguments.sort_column, maxlength=50, null=( !len( arguments.sort_column ) ) );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", value=arguments.sort_direction, maxlength=4, null=( !len( arguments.sort_direction ) ) );
		sp.addProcResult( name="report", resultset=1 );
		sp.addProcResult( name="event_details", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
    /**
	* I get a list of registration fields for an event
	* @event_id The ID of the event that you want to a list of registration fields for
	* @standard_field do you want the standard fields or custom fields
	*/
	public struct function RegistrationFieldsList( required numeric event_id, boolean standard_field ) {
        var sp = new StoredProc();
        var result = {};
        var params = arguments;
        var standard_field_null = isnull( arguments.standard_field );
        sp.setAttributes({
            'datasource' = getDSN(),
            'procedure' = "RegistrationFieldsList"
        });
        if( standard_field_null ) {
        	params.standard_field = false;
        }
        sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=params.event_id );
        sp.addParam( type="in", dbvarname="@standard_field", cfsqltype="cf_sql_bit", value=int( !!params.standard_field ), null=standard_field_null );
        sp.addProcResult( name="fields", resultset=1 );result = sp.execute();

        result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
			};
    }
	/*
	* Gets all of the Attendee Registrations for an event
	* @registration_type_id_list (optional) Comma seperated list of registration_type_id's to filter to
	* @attendee_status_list (optional) Comma seperated list of attendee_status's to filter to
	* @balance_due (optional) Amount to filter balance due on
	* @balance_due_operator (optional) Operator to use when comparing balance.  Valid values:  '<', '>', '=', '<=', '>=', '<>' 
	* @registration_date_from (optional) Date to filter from
	* @registration_date_to (optional) Date to filter to
	*/
	public struct function AttendeeRegistrationsFieldsReport(
		required numeric event_id,
		string registration_type_id_list=0,
		string attendee_status_list="",
		numeric balance_due=0,
		string balance_due_operator="",
		string registration_date_from="",
		string registration_date_to=""	
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeeRegistrationsFieldsReport"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		//sp.addParam( type="in", dbvarname="@registration_type_id_list", cfsqltype="cf_sql_longvarchar", value=arguments.registration_type_id_list, null=( !len( arguments.registration_type_id_list ) ) );
		sp.addParam( type="in", dbvarname="@attendee_status_list", cfsqltype="cf_sql_longvarchar", value=arguments.attendee_status_list, null=( !len( arguments.attendee_status_list ) ) );
		sp.addParam( type="in", dbvarname="@balance_due", cfsqltype="cf_sql_money", value=arguments.balance_due, null=( !arguments.balance_due ) );
		sp.addParam( type="in", dbvarname="@balance_due_operator", cfsqltype="cf_sql_varchar", value=arguments.balance_due_operator, maxlength=10, null=( !len( arguments.balance_due_operator ) ) );
		sp.addParam( type="in", dbvarname="@registration_date_from", cfsqltype="cf_sql_timestamp", value=arguments.registration_date_from, null=( !len( arguments.registration_date_from ) ) );
		sp.addParam( type="in", dbvarname="@registration_date_to", cfsqltype="cf_sql_timestamp", value=arguments.registration_date_to, null=( !len( arguments.registration_date_to ) ) );
		sp.addProcResult( name="report", resultset=1 );
		sp.addProcResult( name="fields", resultset=2 );
		sp.addProcResult( name="event_details", resultset=3 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Report Summary of registration fees
	* @event_id The id of the event
	* @attendee_count (optional) attendee count to filter on
	* @attendee_count_operator (optional) Operator to use when comparing attendee count.  Valid values:  '<', '>', '=', '<=', '>=', '<>' 
	* @balance_due (optional) Amount to filter balance due on
	* @balance_due_operator (optional) Operator to use when comparing balance.  Valid values:  '<', '>', '=', '<=', '>=', '<>' 
	*/
	public struct function RegistrationSummaryReport(
		required numeric event_id,
		string company="",
		numeric attendee_count=0,
		string attendee_count_operator="",
		numeric balance_due="",
		string balance_due_operator=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationSummaryReport"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@company", cfsqltype="cf_sql_varchar", value=arguments.company, maxlength=150, null=( !len( arguments.company ) ) );
		sp.addParam( type="in", dbvarname="@attendee_count", cfsqltype="cf_sql_integer", value=arguments.attendee_count, null=( !arguments.attendee_count ) );
		sp.addParam( type="in", dbvarname="@attendee_count_operator", cfsqltype="cf_sql_varchar", value=arguments.attendee_count_operator, maxlength=10, null=( !len( arguments.attendee_count_operator ) ) );
		sp.addParam( type="in", dbvarname="@balance_due", cfsqltype="cf_sql_money", value=arguments.balance_due, null=( !arguments.balance_due ) );
		sp.addParam( type="in", dbvarname="@balance_due_operator", cfsqltype="cf_sql_varchar", value=arguments.balance_due_operator, maxlength=10, null=( !len( arguments.balance_due_operator ) ) );
		sp.addProcResult( name="report", resultset=1 );
		sp.addProcResult( name="event_details", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Report of financial transactions for an event 
	* @event_id The id of the event
	* @detail_type_id_list (optional) Comma seperated list of detail_type_id's to filter to
	* @detail_date_from (optional) Date to filter from
	* @detail_start_date_to (optional) Date to filter to
	* @amount (optional) Amount to filter on
	* @amount_operator (optional) Operator to use when comparing amount.  Valid values:  '<', '>', '=', '<=', '>=', '<>' 
	* @attendee_id (optional) attendee id to filter to
	* @payment_type_id (optional) payment type id to filter to
	*/
	public struct function RegistrationDetailsReport(
		required numeric event_id,
		required string detail_type_id_list=0,
		string detail_date_from="",//set to a string because CF cannot handle null dates
		string detail_date_to="",//set to a string because CF cannot handle null dates
		numeric amount="",
		string amount_operator="",
		required numeric attendee_id=0,
		required numeric payment_type_id=0
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationDetailsReport"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@detail_type_id_list", cfsqltype="cf_sql_longvarchar", value=arguments.detail_type_id_list, null=( !len( arguments.detail_type_id_list ) ) );
		sp.addParam( type="in", dbvarname="@detail_date_from", cfsqltype="cf_sql_timestamp", value=arguments.detail_date_from, null=( !isdate( arguments.detail_date_from ) ) );
		sp.addParam( type="in", dbvarname="@detail_date_to", cfsqltype="cf_sql_timestamp", value=arguments.detail_date_to, null=( !isdate( arguments.detail_date_to ) ) );
		sp.addParam( type="in", dbvarname="@amount", cfsqltype="cf_sql_money", value=arguments.amount, null=( !arguments.amount ) );
		sp.addParam( type="in", dbvarname="@amount_operator", cfsqltype="cf_sql_varchar", value=arguments.amount_operator, maxlength=10, null=( !len( arguments.amount_operator ) ) );
		sp.addParam( type="in", dbvarname="@attendee_id", cfsqltype="cf_sql_bigint", value=arguments.attendee_id, null=( !arguments.attendee_id ) );
		sp.addParam( type="in", dbvarname="@payment_type_id", cfsqltype="cf_sql_integer", value=arguments.payment_type_id, null=( !arguments.payment_type_id ) );
		sp.addProcResult( name="report", resultset=1 );
		sp.addProcResult( name="event_details", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Report Summary of registration fees
	* @event_id The id of the event
	* @attendee_count (optional) attendee count to filter on
	* @attendee_count_operator (optional) Operator to use when comparing attendee count.  Valid values:  '<', '>', '=', '<=', '>=', '<>' 
	* @balance_due (optional) Amount to filter balance due on
	* @balance_due_operator (optional) Operator to use when comparing balance.  Valid values:  '<', '>', '=', '<=', '>=', '<>' 
	* @start The row to start on
	* @results The number of results to return
	*/
	public struct function RegistrationSummaryReportList(
		required numeric event_id,
		string company="",
		numeric attendee_count="",
		string attendee_count_operator="",
		numeric balance_due="",
		string balance_due_operator="",
		numeric start=1,
		numeric results=10
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationSummaryReportList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@company", cfsqltype="cf_sql_varchar", value=arguments.company, maxlength=150, null=( !len( arguments.company ) ) );
		sp.addParam( type="in", dbvarname="@attendee_count", cfsqltype="cf_sql_integer", value=arguments.attendee_count, null=( !arguments.attendee_count ) );
		sp.addParam( type="in", dbvarname="@attendee_count_operator", cfsqltype="cf_sql_varchar", value=arguments.attendee_count_operator, maxlength=10, null=( !len( arguments.attendee_count_operator ) ) );
		sp.addParam( type="in", dbvarname="@balance_due", cfsqltype="cf_sql_money", value=arguments.balance_due, null=( !arguments.balance_due ) );
		sp.addParam( type="in", dbvarname="@balance_due_operator", cfsqltype="cf_sql_varchar", value=arguments.balance_due_operator, maxlength=10, null=( !len( arguments.balance_due_operator ) ) );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addProcResult( name="report", resultset=1 );
		sp.addProcResult( name="event_details", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Report of financial transactions for an event 
	* @event_id The id of the event
	* @detail_type_id_list (optional) Comma seperated list of detail_type_id's to filter to
	* @detail_date_from (optional) Date to filter from
	* @detail_start_date_to (optional) Date to filter to
	* @amount (optional) Amount to filter on
	* @amount_operator (optional) Operator to use when comparing amount.  Valid values:  '<', '>', '=', '<=', '>=', '<>' 
	* @attendee_id (optional) attendee id to filter to
	* @payment_type_id (optional) payment type id to filter to
	* @start The row to start on
	* @results The number of results to return
	*/
	public struct function RegistrationDetailsReportList(
		required numeric event_id,
		required string detail_type_id_list=0,
		string detail_date_from="",
		string detail_date_to="",
		numeric amount=0,
		string amount_operator="",
		string attendee_id=0,
		required numeric payment_type_id=0,
		numeric start=1,
		numeric results=10
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationDetailsReportList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@detail_type_id_list", cfsqltype="cf_sql_longvarchar", value=arguments.detail_type_id_list, null=( !len( arguments.detail_type_id_list ) ) );
		sp.addParam( type="in", dbvarname="@detail_date_from", cfsqltype="cf_sql_timestamp", value=arguments.detail_date_from, null=( !len( arguments.detail_date_from ) ) );
		sp.addParam( type="in", dbvarname="@detail_date_to", cfsqltype="cf_sql_timestamp", value=arguments.detail_date_to, null=( !len( arguments.detail_date_to ) ) );
		sp.addParam( type="in", dbvarname="@amount", cfsqltype="cf_sql_money", value=arguments.amount, null=( !arguments.amount ) );
		sp.addParam( type="in", dbvarname="@amount_operator", cfsqltype="cf_sql_varchar", value=arguments.amount_operator, maxlength=10, null=( !len( arguments.amount_operator ) ) );
		sp.addParam( type="in", dbvarname="@attendee_id", cfsqltype="cf_sql_bigint", value=arguments.attendee_id, null=( !arguments.attendee_id ) );
		sp.addParam( type="in", dbvarname="@payment_type_id", cfsqltype="cf_sql_integer", value=arguments.payment_type_id, null=( !arguments.payment_type_id ) );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addProcResult( name="report", resultset=1 );
		sp.addProcResult( name="event_details", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Report of attendees waitlist grouped for each agenda item
	* @agenda_id_list (optional) Comma seperated list of agenda_id's to filter to
	* @agenda_start_date_from (optional) Date to filter from
	* @agenda_start_date_to (optional) Date to filter to
	* @location_id (optional) location id to filter to
	* @category_id (optional) category id to filter to
	*/
	public struct function AgendaAttendeesWaitlistReport(
		required numeric event_id,
		required string agenda_id_list=0,
		string agenda_start_date_from="",
		string agenda_start_date_to="",
		required numeric location_id=0,
		required numeric category_id=0
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendaAttendeesWaitlistReport"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@agenda_id_list", cfsqltype="cf_sql_longvarchar", value=arguments.agenda_id_list, null=( !len( arguments.agenda_id_list ) ) );
		sp.addParam( type="in", dbvarname="@agenda_start_date_from", cfsqltype="cf_sql_timestamp", value=arguments.agenda_start_date_from, null=( !len( arguments.agenda_start_date_from ) ) );
		sp.addParam( type="in", dbvarname="@agenda_start_date_to", cfsqltype="cf_sql_timestamp", value=arguments.agenda_start_date_to, null=( !len( arguments.agenda_start_date_to ) ) );
		sp.addParam( type="in", dbvarname="@location_id", cfsqltype="cf_sql_integer", value=arguments.location_id, null=( !arguments.location_id ) );
		sp.addParam( type="in", dbvarname="@category_id", cfsqltype="cf_sql_integer", value=arguments.category_id, null=( !arguments.category_id ) );
		sp.addProcResult( name="report", resultset=1 );
		sp.addProcResult( name="event_details", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Report of attendees grouped for each agenda item
	* @agenda_id_list (optional) Comma seperated list of agenda_id's to filter to
	* @agenda_start_date_from (optional) Date to filter from
	* @agenda_start_date_to (optional) Date to filter to
	* @location_id (optional) location id to filter to
	* @category_id (optional) category id to filter to
	*/
	public struct function AgendaAttendeesReport(
		required numeric event_id,
		required string agenda_id_list=0,
		string agenda_start_date_from="",
		string agenda_start_date_to="",
		required numeric location_id=0,
		required numeric category_id=0
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendaAttendeesReport"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@agenda_id_list", cfsqltype="cf_sql_longvarchar", value=arguments.agenda_id_list, null=( !len( arguments.agenda_id_list ) ) );
		sp.addParam( type="in", dbvarname="@agenda_start_date_from", cfsqltype="cf_sql_timestamp", value=arguments.agenda_start_date_from, null=( !len( arguments.agenda_start_date_from ) ) );
		sp.addParam( type="in", dbvarname="@agenda_start_date_to", cfsqltype="cf_sql_timestamp", value=arguments.agenda_start_date_to, null=( !len( arguments.agenda_start_date_to ) ) );
		sp.addParam( type="in", dbvarname="@location_id", cfsqltype="cf_sql_integer", value=arguments.location_id, null=( !arguments.location_id ) );
		sp.addParam( type="in", dbvarname="@category_id", cfsqltype="cf_sql_integer", value=arguments.category_id, null=( !arguments.category_id ) );
		sp.addProcResult( name="report", resultset=1 );
		sp.addProcResult( name="event_details", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Report of attendees grouped for each agenda item
	* @agenda_id_list (optional) Comma seperated list of agenda_id's to filter to
	* @agenda_start_date_from (optional) Date to filter from
	* @agenda_start_date_to (optional) Date to filter to
	* @location_id (optional) location id to filter to
	* @category_id (optional) category id to filter to
	* @start The row to start on
	* @results The number of results to return
	*/
	public struct function AgendaAttendeesReportList(
		required numeric event_id,
		required string agenda_id_list,
		string agenda_start_date_from="",
		string agenda_start_date_to="",
		required numeric location_id=0,
		required numeric category_id=0,
		numeric start=1
		numeric results=10
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendaAttendeesReportList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@agenda_id_list", cfsqltype="cf_sql_longvarchar", value=arguments.agenda_id_list, null=( !len( arguments.agenda_id_list ) ) );
		sp.addParam( type="in", dbvarname="@agenda_start_date_from", cfsqltype="cf_sql_timestamp", value=arguments.agenda_start_date_from, null=( !len( arguments.agenda_start_date_from ) ) );
		sp.addParam( type="in", dbvarname="@agenda_start_date_to", cfsqltype="cf_sql_timestamp", value=arguments.agenda_start_date_to, null=( !len( arguments.agenda_start_date_to ) ) );
		sp.addParam( type="in", dbvarname="@location_id", cfsqltype="cf_sql_integer", value=arguments.location_id, null=( !arguments.location_id ) );
		sp.addParam( type="in", dbvarname="@category_id", cfsqltype="cf_sql_integer", value=arguments.category_id, null=( !arguments.category_id ) );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addProcResult( name="report", resultset=1 );
		sp.addProcResult( name="event_details", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Report of attendees waitlist grouped for each agenda item
	* @agenda_id_list (optional) Comma seperated list of agenda_id's to filter to
	* @agenda_start_date_from (optional) Date to filter from
	* @agenda_start_date_to (optional) Date to filter to
	* @location_id (optional) location id to filter to
	* @category_id (optional) category id to filter to
	* @start The row to start on
	* @results The number of results to return
	*/
	public struct function AgendaAttendeesWaitlistReportList(
		required numeric event_id,
		required string agenda_id_list,
		string agenda_start_date_from="",
		string agenda_start_date_to="",
		numeric location_id=0,
		numeric category_id=0,
		numeric start=1,
		numeric results=10
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendaAttendeesWaitlistReportList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@agenda_id_list", cfsqltype="cf_sql_longvarchar", value=arguments.agenda_id_list, null=( !len( arguments.agenda_id_list ) ) );
		sp.addParam( type="in", dbvarname="@agenda_start_date_from", cfsqltype="cf_sql_timestamp", value=arguments.agenda_start_date_from, null=( !len( arguments.agenda_start_date_from ) ) );
		sp.addParam( type="in", dbvarname="@agenda_start_date_to", cfsqltype="cf_sql_timestamp", value=arguments.agenda_start_date_to, null=( !len( arguments.agenda_start_date_to ) ) );
		sp.addParam( type="in", dbvarname="@location_id", cfsqltype="cf_sql_integer", value=arguments.location_id, null=( !arguments.location_id ) );
		sp.addParam( type="in", dbvarname="@category_id", cfsqltype="cf_sql_integer", value=arguments.category_id, null=( !arguments.category_id ) );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addProcResult( name="report", resultset=1 );
		sp.addProcResult( name="event_details", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Gets all of the Attendee Registrations for an event
	* @registration_type_id_list (optional) Comma seperated list of registration_type_id's to filter to
	* @attendee_status_list (optional) Comma seperated list of attendee_status's to filter to
	* @balance_due (optional) Amount to filter balance due on
	* @balance_due_operator (optional) Operator to use when comparing balance.  Valid values:  '<', '>', '=', '<=', '>=', '<>' 
	* @registration_date_from (optional) Date to filter from
	* @registration_date_to (optional) Date to filter to
	*/
	public struct function AttendeeRegistrationsReport(
		required numeric event_id,
		required string registration_type_id_list,
		string attendee_status_list="",
		numeric balance_due="",
		string balance_due_operator="",
		string registration_date_from="",
		string registration_date_to=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeeRegistrationsReport"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@registration_type_id_list", cfsqltype="cf_sql_longvarchar", value=arguments.registration_type_id_list, null=( !len( arguments.registration_type_id_list ) ) );
		sp.addParam( type="in", dbvarname="@attendee_status_list", cfsqltype="cf_sql_longvarchar", value=arguments.attendee_status_list, null=( !len( arguments.attendee_status_list ) ) );
		sp.addParam( type="in", dbvarname="@balance_due", cfsqltype="cf_sql_money", value=arguments.balance_due, null=( !arguments.balance_due ) );
		sp.addParam( type="in", dbvarname="@balance_due_operator", cfsqltype="cf_sql_varchar", value=arguments.balance_due_operator, maxlength=10, null=( !len( arguments.balance_due_operator ) ) );
		sp.addParam( type="in", dbvarname="@registration_date_from", cfsqltype="cf_sql_timestamp", value=arguments.registration_date_from, null=( !len( arguments.registration_date_from ) ) );
		sp.addParam( type="in", dbvarname="@registration_date_to", cfsqltype="cf_sql_timestamp", value=arguments.registration_date_to, null=( !len( arguments.registration_date_to ) ) );
		sp.addProcResult( name="report", resultset=1 );
		sp.addProcResult( name="event_details", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Gets all of the Attendee Registrations for an event
	* @registration_type_id_list (optional) Comma seperated list of registration_type_id's to filter to
	* @attendee_status_list (optional) Comma seperated list of attendee_status's to filter to
	* @balance_due (optional) Amount to filter balance due on
	* @balance_due_operator (optional) Operator to use when comparing balance.  Valid values:  '<', '>', '=', '<=', '>=', '<>' 
	* @registration_date_from (optional) Date to filter from
	* @registration_date_to (optional) Date to filter to
	* @start The row to start on
	* @results The number of results to return
	*/
	public struct function AttendeeRegistrationsReportList(
		required numeric event_id,
		required string registration_type_id_list=0,
		string attendee_status_list="",
		numeric balance_due="",
		string balance_due_operator="",
		string registration_date_from="",
		string registration_date_to="",
		numeric start=1,
		numeric results=10
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AttendeeRegistrationsReportList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@registration_type_id_list", cfsqltype="cf_sql_longvarchar", value=arguments.registration_type_id_list, null=( !len( arguments.registration_type_id_list ) ) );
		sp.addParam( type="in", dbvarname="@attendee_status_list", cfsqltype="cf_sql_longvarchar", value=arguments.attendee_status_list, null=( !len( arguments.attendee_status_list ) ) );
		sp.addParam( type="in", dbvarname="@balance_due", cfsqltype="cf_sql_money", value=arguments.balance_due, null=( !arguments.balance_due ) );
		sp.addParam( type="in", dbvarname="@balance_due_operator", cfsqltype="cf_sql_varchar", value=arguments.balance_due_operator, maxlength=10, null=( !len( arguments.balance_due_operator ) ) );
		sp.addParam( type="in", dbvarname="@registration_date_from", cfsqltype="cf_sql_timestamp", value=arguments.registration_date_from, null=( !len( arguments.registration_date_from ) ) );
		sp.addParam( type="in", dbvarname="@registration_date_to", cfsqltype="cf_sql_timestamp", value=arguments.registration_date_to, null=( !len( arguments.registration_date_to ) ) );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addProcResult( name="report", resultset=1 );
		sp.addProcResult( name="event_details", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Report of attendees hotels
	* @agenda_id_list (optional) Comma seperated list of agenda_id's to filter to
	* @agenda_start_date_from (optional) Date to filter from
	* @agenda_start_date_to (optional) Date to filter to
	* @location_id (optional) location id to filter to
	* @category_id (optional) category id to filter to
	*/
	//Not sure why we need this (hotel_requested) flag
	public struct function RegistrationAttendeesHotelReportList(
		required numeric event_id,
		numeric hotel_id=0,
		string checkin_date="",
		numeric room_type_id=0,
		boolean hotel_requested=1,
		numeric start=1,
		numeric results=10,
		string sort_column="name",
		string sort_direction="ASC",
		string search=""
	) {
		var sp = new StoredProc();
		var result = {};
		var hotel_requested_null = false;
		if( isnull( arguments.hotel_requested ) ) {
			hotel_requested_null = true;
			arguments.hotel_requested = false;
		} 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationAttendeesHotelReportList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@hotel_id", cfsqltype="cf_sql_integer", value=arguments.hotel_id, null=( !arguments.hotel_id ) );
		sp.addParam( type="in", dbvarname="@checkin_date", cfsqltype="cf_sql_date", value=arguments.checkin_date, null=( !isdate( arguments.checkin_date ) ) );
		sp.addParam( type="in", dbvarname="@room_type_id", cfsqltype="cf_sql_integer", value=arguments.room_type_id, null=( !arguments.room_type_id ) );
		sp.addParam( type="in", dbvarname="@hotel_requested", cfsqltype="cf_sql_bit", value=arguments.hotel_requested, null=hotel_requested_null );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", value=arguments.sort_column, maxlength=50, null=( !len( arguments.sort_column ) ) );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", value=arguments.sort_direction, maxlength=4, null=( !len( arguments.sort_direction ) ) );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", value=arguments.search, maxlength=200, null=( !len( arguments.search ) ) );
		sp.addProcResult( name="report", resultset=1 );
		sp.addProcResult( name="event_details", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
		/*
	* Report of attendees hotels
	* @agenda_id_list (optional) Comma seperated list of agenda_id's to filter to
	* @agenda_start_date_from (optional) Date to filter from
	* @agenda_start_date_to (optional) Date to filter to
	* @location_id (optional) location id to filter to
	* @category_id (optional) category id to filter to
	*/
	public struct function RegistrationAttendeesHotelReport(
		required numeric event_id,
		required numeric hotel_id,
		string checkin_date="",
		numeric room_type_id=0,
		boolean hotel_requested=1
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationAttendeesHotelReport"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@hotel_id", cfsqltype="cf_sql_integer", value=arguments.hotel_id, null=( !arguments.hotel_id ) );
		sp.addParam( type="in", dbvarname="@checkin_date", cfsqltype="cf_sql_date", value=arguments.checkin_date, null=( !isdate( arguments.checkin_date ) ) );
		sp.addParam( type="in", dbvarname="@room_type_id", cfsqltype="cf_sql_integer", value=arguments.room_type_id, null=( !arguments.room_type_id ) );
		sp.addParam( type="in", dbvarname="@hotel_requested", cfsqltype="cf_sql_bit", value=arguments.hotel_requested, null=( !len( arguments.hotel_requested ) ) );
		sp.addProcResult( name="report", resultset=1 );
		sp.addProcResult( name="event_details", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
}
