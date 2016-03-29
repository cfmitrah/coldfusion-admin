/**
*
* @file  /controllers/StandardReports.cfc
* @author - JG
* @description - This will control all things Standard Reports.
*
*/
component extends="$base" accessors="true"
{
	property name="standardReportManager" setter="true" getter="true";
	property name="registrationTypesManager" setter="true" getter="true";
	property name="VenuesManager" setter="true" getter="true";
	property name="SessionsManager" setter="true" getter="true";
	property name="EmailManagementManager" setter="true" getter="true";
	property name="EventsManager" setter="true" getter="true";
	property name="PaymentManager" setter="true" getter="true";
	property name="RegistrationManager" setter="true" getter="true";
	property name="CompanyManager" setter="true" getter="true";
	property name="HotelManager" setter="true" getter="true";
	property name="config" setter="true" getter="true";
	/**
	* before
	* This method will be executed before running any agenda controller methods
	*/
	public void function before( rc ) {
		setting requesttimeout="180";
		//we need to make sure we do in fact have a company ID
		if( ! getCurrentCompanyID() ){
			redirect('company.select');
		}
		if( !getCurrentEventID() ){
			redirect('event.select');
		}
		rc['event_id'] = getCurrentEventID();
		rc['company_id'] = getCurrentCompanyID();
		rc['sidebar'] = "sidebar.event.details";
		super.before( rc );
		getCfStatic().include("/css/plugins/date-timepicker/date-timepicker.css");
		return;
	}
	//START PAGE VIEWS
	/**
	* Default
	* This method will render main report view
	**/
	public void function default( rc ) {
		return;
	}
	/**
	* getCustomFieldsReport
	* This method will render all custom fields export as XLSX
	**/
	public void function getCustomFieldsReport( rc ){
		rc['filename'] = getStandardReportManager().createCustomFieldsReportXLS( event_id=rc.event_id );
		location( getConfig().urls.wysiwyg_media & rc.filename, false );
		return;

	}
	//START COUPONS REPORT
	/**
	* scheduledReporting
	**/
	public void function scheduledReporting( rc ){
		getCfStatic().include("/js/pages/reports/general.js");
		return;

	}
	/**
	* couponReporting
	**/
	public void function couponReport( rc ){
		var coupons = getStandardReportManager().getCoupons( event_id=rc.event_id, return_type="struct" );
		rc['coupon_opts'] = getFormUtilities().buildOptionList(
			display=coupons.code,
			values=coupons.code
		);
		getCfStatic()
			.include("/css/plugins/chosen/chosen.css")
			.include("/js/plugins/chosen/chosen.jquery.js")
			.include("/js/pages/reports/general.js");
		return;

	}
	/**
	* couponReportResults
	* This method will render the report results
	**/
	public void function couponReportResults( rc ){
		//check to see if you are allowed here
		if( structKeyExists( rc, "report") && isStruct( rc.report ) ){
			//setup the table
			var listing_config = getCouponReportConfig();
			rc['table_id'] = listing_config.table_id;
			rc['columns'] = listing_config.columns;
			//persist the report params
			getStandardReportManager().setReportParams( rc.report );
			//write the table
			getCfStatic().includeData( listing_config )
				.include("/js/pages/common/listing.js")
				.include("/css/pages/common/listing.css")
				.include("/css/pages/reports/general.css");
			return;
		}
		redirect( "standardReports.default" );
		return;
	}
	/**
	* couponReportPrintView
	* This method will render the report results as print view
	**/
	public void function couponReportPrintView( rc ) {
		//get the string literals of the form
		var frm_values = getStandardReportManager().getCouponReportParams();
		rc['report'] = getStandardReportManager().getCouponReportResultsArray( argumentCollection=frm_values );
		rc['registered_keys'] = [ "N/A", "Accepted", "Declined" ];
		rc['report_cnt'] = arrayLen( rc.report );
		return;
	}
	/**
	* couponReportPDFView
	* This method will render the report results as pdf
	**/
	public void function couponReportPDFView( rc ) {
		//get the string literals of the form
		var frm_values = getStandardReportManager().getCouponReportParams();
		rc['report'] = getStandardReportManager().getCouponReportResultsArray( argumentCollection=frm_values );
		rc['report_cnt'] = arrayLen( rc.report );
		return;
	}
	/**
	* couponReportExcelView
	* This method will render the report results as a xls
	**/
	public void function couponReportExcelView( rc ) {
		//get the string literals of the form
		rc['filename'] = getStandardReportManager().createCouponReportXLS();
		location( getConfig().urls.wysiwyg_media & rc.filename, false );

	}
	//END COUPONS REPORT

	// Start Hotel Reservations Report
	/**
	* hotelReservationsReport
	**/
	public void function hotelReservationsReport( rc ){
		rc['filter_options'] = getHotelManager().getHotelFilters( rc.event_id );
		getCfStatic()
			.include("/css/plugins/chosen/chosen.css")
			.include("/js/plugins/chosen/chosen.jquery.js")
			.include("/js/pages/reports/general.js");
		return;

	}
	// End Hotel Reservations Report


	//START ALL FIELDS EXPORT REPORT
	/**
	* allFieldsExportReport
	* This method will render the report form
	**/
	public void function allFieldsExportReport( rc ){
		var registration_types = getRegistrationTypesManager().getRegistrationTypesStruct( rc.event_id );
		rc['registration_types_opts'] = getFormUtilities().buildOptionList(
			display=registration_types.registration_type,
			values=registration_types.registration_type_id
		);
		getCfStatic().include("/js/pages/reports/general.js");
		return;
	}
	/**
	* allFieldsExportReportResults
	* This method will render the report results
	**/
	public void function allFieldsExportReportResults( rc ){
		//check to see if you are allowed here
		if( structKeyExists( rc, "report") && isStruct( rc.report ) ){
			//persist the report params
			getStandardReportManager().setReportParams( rc.report );
			//get the report
			rc[ 'report_data' ] = getStandardReportManager().createCustomFieldsReportQuery( argumentCollection=rc.report );
			getCfStatic()
				.include("/css/pages/common/listing.css")
				.include("/css/pages/reports/general.css");
			return;
		}
		redirect( "standardReports.default" );
		return;
	}
	/**
	* allFieldsExportReportPrintView
	* This method will render the report results as print view
	**/
	public void function allFieldsExportReportPrintView( rc ) {
		//get the string literals of the form
		var frm_values = getStandardReportManager().getAllFieldsExportReportParams();
		rc['report_data'] = getStandardReportManager().createCustomFieldsReportQuery( argumentCollection=frm_values );
		return;
	}
	/**
	* allFieldsExportReportPDFView
	* This method will render the report results as pdf
	**/
	public void function allFieldsExportReportPDFView( rc ) {
		//get the string literals of the form
		var frm_values = getStandardReportManager().getAllFieldsExportReportParams();
		rc['report_data'] = getStandardReportManager().createCustomFieldsReportQuery( argumentCollection=frm_values );
		return;
	}
	//END ALL FIELDS EXPORT REPORT

	//START INVITATION STATUS REPORT
	/**
	* invitationStatusReport
	* This method will render the report form
	**/
	public void function invitationStatusReport( rc ){
		var email_labels = getEmailManagementManager().getInviationEmailLabelsAsStruct( event_id=rc.event_id );
		rc['invitation_email_opts'] = getFormUtilities().buildOptionList(
			display=email_labels.label,
			values=email_labels.invitation_id
		);
		getCfStatic().include("/js/pages/reports/general.js");
		return;
	}
	/**
	* invitationStatusReportResults
	* This method will render the report results
	**/
	public void function invitationStatusReportResults( rc ){
		//check to see if you are allowed here
		if( structKeyExists( rc, "report") && isStruct( rc.report ) ){
			//setup the table
			var listing_config = getInvitationStatusReportConfig();
			rc['table_id'] = listing_config.table_id;
			rc['columns'] = listing_config.columns;
			//persist the report params
			getStandardReportManager().setReportParams( rc.report );
			//get the string literals of the form
			rc['report_frm_values'] = getStandardReportManager().getInvitationStatusReportFrmValues();
			//write the table
			getCfStatic().includeData( listing_config )
				.include("/js/pages/common/listing.js")
				.include("/css/pages/common/listing.css")
				.include("/css/pages/reports/general.css");
			return;
		}
		redirect( "standardReports.default" );
		return;
	}
	/**
	* invitationStatusReportPrintView
	* This method will render the report results as print view
	**/
	public void function invitationStatusReportPrintView( rc ) {
		//get the string literals of the form
		var frm_values = getStandardReportManager().getInvitationStatusReportParams();
		rc['report'] = getStandardReportManager().getInvitationStatusReportResultsArray( argumentCollection=frm_values );
		rc['registered_keys'] = [ "N/A", "Accepted", "Declined" ];
		rc['report_cnt'] = arrayLen( rc.report );
		return;
	}
	/**
	* invitationStatusReportPDFView
	* This method will render the report results as pdf
	**/
	public void function invitationStatusReportPDFView( rc ) {
		//get the string literals of the form
		var frm_values = getStandardReportManager().getInvitationStatusReportParams();
		rc['report'] = getStandardReportManager().getInvitationStatusReportResultsArray( argumentCollection=frm_values );
		rc['report_cnt'] = arrayLen( rc.report );
		return;
	}
	/**
	* invitationStatusReportExcelView
	* This method will render the report results as a xls
	**/
	public void function invitationStatusReportExcelView( rc ) {
		//get the string literals of the form
		rc['filename'] = getStandardReportManager().createInvitationStatusReportXLS();
		location( getConfig().urls.wysiwyg_media & rc.filename, false );

	}
	//END INVITATION STATUS REPORT


	//START CUSTOM FIELDS REPORT
	public void function AttendeeRegistrationsFieldsReport( rc ) {
		rc['filename'] = getStandardReportManager().createAttendeeRegistrationFieldsReportXLS( event_id=rc.event_id );
		location( getConfig().urls.wysiwyg_media & rc.filename, false );
		return;
	}
	//END CUSTOM FIELDS REPORT


	//START REGISTRATION SUMMARY REPORT
	/**
	* financialTransactionsReport
	* This method will render the report form
	**/
	public void function registrationSummaryReport( rc ){
		rc['company_opts'] = getCompanyManager().getCompanySelectOptions();
		getCfStatic().include("/js/pages/reports/general.js");
		return;
	}
	/**
	* financialTransactionsReportResults
	* This method will render the report results
	**/
	public void function registrationSummaryReportResults( rc ){
		//check to see if you are allowed here
		if( structKeyExists( rc, "report") && isStruct( rc.report ) ){
			//setup the table
			var listing_config = getRegistrationSummaryReportConfig();
			rc['table_id'] = listing_config.table_id;
			rc['columns'] = listing_config.columns;
			//persist the report params
			getStandardReportManager().setReportParams( rc.report );
			//get the string literals of the form
			rc['report_frm_values'] = getStandardReportManager().getRegistrationSummaryReportFrmValues();
			//write the table
			getCfStatic().includeData( listing_config )
				.include("/js/pages/common/listing.js")
				.include("/css/pages/common/listing.css")
				.include("/css/pages/reports/general.css");
			return;
		}
		redirect( "standardReports.default" );
		return;
	}
	/**
	* financialTransactionsReportPrintView
	* This method will render the report results as print view
	**/
	public void function registrationSummaryReportPrintView( rc ) {
		//get the string literals of the form
		var frm_values = getStandardReportManager().getRegistrationSummaryReportParams();
		rc['report'] = getStandardReportManager().getRegistrationSummaryReportResultsArray( argumentCollection=frm_values );
		rc['report_cnt'] = arrayLen( rc.report );
		return;
	}
	/**
	* financialTransactionsReportPDFView
	* This method will render the report results as pdf
	**/
	public void function registrationSummaryReportPDFView( rc ) {
		//get the string literals of the form
		var frm_values = getStandardReportManager().getRegistrationSummaryReportParams();
		rc['report'] = getStandardReportManager().getRegistrationSummaryReportResultsArray( argumentCollection=frm_values );
		rc['report_cnt'] = arrayLen( rc.report );
		return;
	}
	/**
	* financialTransactionsReportExcelView
	* This method will render the report results as a xls
	**/
	public void function registrationSummaryReportExcelView( rc ) {
		//get the string literals of the form
		rc['filename'] = getStandardReportManager().createRegistrationSummaryReportXLS();
		location( getConfig().urls.wysiwyg_media & rc.filename, false );

	}
	//END REGISTRATION SUMMARY REPORT



	//START FINANCIAL TRANSACTIONS REPORT
	/**
	* financialTransactionsReport
	* This method will render the report form
	**/
	public void function financialTransactionsReport( rc ){
		var payment_types = getPaymentManager().getPaymentTypesOptsList();
		var detail_types = getRegistrationManager().getDetailTypesOptsList();
		rc['payment_types_opts'] = getFormUtilities().buildOptionList(
			display=payment_types.payment_type,
			values=payment_types.payment_type_id
		);
		rc['detail_types_opts'] = getFormUtilities().buildOptionList(
			display=detail_types.detail_name,
			values=detail_types.detail_type_id
		);
		getCfStatic().include("/js/pages/reports/general.js");
		return;
	}
	/**
	* financialTransactionsReportResults
	* This method will render the report results
	**/
	public void function financialTransactionsReportResults( rc ){
		//check to see if you are allowed here
		if( structKeyExists( rc, "report") && isStruct( rc.report ) ){
			//setup the table
			var listing_config = getFinancialTransactionsReportConfig();
			rc['table_id'] = listing_config.table_id;
			rc['columns'] = listing_config.columns;
			//persist the report params
			getStandardReportManager().setReportParams( rc.report );
			//get the string literals of the form
			rc['report_frm_values'] = getStandardReportManager().getFinancialTransactionsReportFrmValues();
			//write the table
			getCfStatic().includeData( listing_config )
				.include("/js/pages/common/listing.js")
				.include("/css/pages/common/listing.css")
				.include("/css/pages/reports/general.css");
			return;
		}
		redirect( "standardReports.default" );
		return;
	}
	/**
	* financialTransactionsReportPrintView
	* This method will render the report results as print view
	**/
	public void function financialTransactionsReportPrintView( rc ) {
		//get the string literals of the form
		var frm_values = getStandardReportManager().getFinancialTransactionsReportParams();
		rc['report'] = getStandardReportManager().getRegistrationDetailsReportResultsArray( argumentCollection=frm_values );
		rc['report_cnt'] = arrayLen( rc.report );
		return;
	}
	/**
	* financialTransactionsReportPDFView
	* This method will render the report results as pdf
	**/
	public void function financialTransactionsReportPDFView( rc ) {
		//get the string literals of the form
		var frm_values = getStandardReportManager().getFinancialTransactionsReportParams();
		rc['report'] = getStandardReportManager().getRegistrationDetailsReportResultsArray( argumentCollection=frm_values );
		rc['report_cnt'] = arrayLen( rc.report );
		return;
	}
	/**
	* financialTransactionsReportExcelView
	* This method will render the report results as a xls
	**/
	public void function financialTransactionsReportExcelView( rc ) {
		//get the string literals of the form
		rc['filename'] = getStandardReportManager().createRegistrationDetailsReportXLS();
		location( getConfig().urls.wysiwyg_media & rc.filename, false );

	}
	//END FINANCIAL TRANSACTIONS REPORT
	//START AGENDA PARTICIPANTS REPORT
	/**
	* agendaParticipantsReport
	* This method will render the report form
	**/
	public void function agendaParticipantsReport( rc ) {
		var agenda_items = getStandardReportManager().getAgendaItems( event_id=rc.event_id );
		var locations = getVenuesManager().getEventVenueLocations( event_id=rc.event_id );
		var categories = getEventsManager().getEventCategoriesStruct( event_id=rc.event_id );
		rc['agenda_items_opts'] = getFormUtilities().buildOptionList(
			values=agenda_items.agenda_id,
			display=agenda_items.label
		);
		rc['location_opts'] = getFormUtilities().buildOptionList(
			values=locations.location_id,
			display=locations.location_name
		);
		rc['categories_opts'] = getFormUtilities().buildOptionList(
			values=categories.category_id,
			display=categories.category
		);
		getCfStatic().include("/js/pages/reports/general.js");
		return;
	}
	/**
	* agendaParticipantsReportResults
	* This method will render the report results
	**/
	public void function agendaParticipantsReportResults( rc ){
		//check to see if you are allowed here
		if( structKeyExists( rc, "report") && isStruct( rc.report ) ){
			//setup the table
			var listing_config = getAgendaParticipantsReportConfig();
			rc['table_id'] = listing_config.table_id;
			rc['columns'] = listing_config.columns;
			//persist the report params
			getStandardReportManager().setReportParams( rc.report );
			//get the string literals of the form
			rc['report_frm_values'] = getStandardReportManager().getAgendaParticipantsReportFrmValues();
			//write the table
			getCfStatic().includeData( listing_config )
				.include("/js/pages/common/listing.js")
				.include("/css/pages/common/listing.css")
				.include("/css/pages/reports/general.css");
			return;
		}
		redirect( "standardReports.default" );
		return;
	}
	/**
	* agendaParticipantsReportPrintView
	* This method will render the report results as print view
	**/
	public void function agendaParticipantsReportPrintView( rc ) {
		//get the string literals of the form
		var frm_values = getStandardReportManager().getAgendaParticipantsReportParams();
		rc['report'] = getStandardReportManager().getAgendaAttendeesReportResultsArray( argumentCollection=frm_values );
		rc['report_cnt'] = arrayLen( rc.report );
		return;
	}
	/**
	* agendaParticipantsReportPDFView
	* This method will render the report results as pdf
	**/
	public void function agendaParticipantsReportPDFView( rc ) {
		//get the string literals of the form
		var frm_values = getStandardReportManager().getAgendaParticipantsReportParams();
		rc['report'] = getStandardReportManager().getAgendaAttendeesReportResultsArray( argumentCollection=frm_values );
		rc['report_cnt'] = arrayLen( rc.report );
		return;
	}
	/**
	* agendaParticipantsReportExcelView
	* This method will render the report results as a xls
	**/
	public void function agendaParticipantsReportExcelView( rc ) {
		//get the string literals of the form
		rc['filename'] = getStandardReportManager().createAgendaAttendeesXLS();
		location( getConfig().urls.wysiwyg_media & rc.filename, false );

	}
	//END AGENDA PARTICIPANTS REPORT
	//START REGISTERED ATTENDEES REPORT
	/**
	* registeredAttendeesReport
	* This method will render the report form
	**/
	public void function registeredAttendeesReport( rc ) {
		rc['registration_types'] = getRegistrationTypesManager().getRegistrationTypesArray( rc.event_id );
		getCfStatic().include("/js/pages/reports/general.js");
		return;
	}
	/**
	* registeredAttendeesReportResults
	* This method will render the report results
	**/
	public void function registeredAttendeesReportResults( rc ){
		//check to see if you are allowed here
		if( structKeyExists( rc, "report") && isStruct( rc.report ) ){
			//we need to make sure we have this field
			if( ! structKeyExists( rc.report, 'registration_type_id_list' )){
				addErrorAlert( 'At least one registration type is required' );
				redirect( "standardReports.registeredAttendeesReport" );
			}
			//setup the table
			var listing_config = getRegisteredAttendeeReportConfig();
			rc['table_id'] = listing_config.table_id;
			rc['columns'] = listing_config.columns;
			//persist the report params
			getStandardReportManager().setReportParams( rc.report );
			//get the string literals of the form
			rc['report_frm_values'] = getStandardReportManager().getRegisteredAttendeeReportFrmValues();
			//write the table
			getCfStatic().includeData( listing_config )
				.include("/js/pages/common/listing.js")
				.include("/css/pages/common/listing.css")
				.include("/css/pages/reports/general.css");
			return;
		}
		redirect( "standardReports.default" );
		return;
	}

	public void function hotelReservationsReportResults( rc) {

		//check to see if you are allowed here
		if( structKeyExists( rc, "report") && isStruct( rc.report ) ){
			//setup the table
			var listing_config = getHotelReportConfig();
			rc['table_id'] = listing_config.table_id;
			//persist the report params

			getStandardReportManager().setReportParams( rc.report );
			//get the string literals of the form
			//rc['report_frm_values'] = getStandardReportManager().getRegisteredAttendeeReportFrmValues();
			//write the table
			getCfStatic().includeData( listing_config )
				.include("/js/pages/common/listing.js")
				.include("/css/pages/common/listing.css")
				.include("/css/pages/reports/general.css");
		}else{
			redirect( "standardReports.hotelReservationsReport" );
		}
		return;
	}
	/**
	* hotelReservationsReportPrintView
	* This method will render the report results as print view
	**/
	public void function hotelReservationsReportPrintView( rc ) {
		//get the string literals of the form
		var frm_values = getStandardReportManager().getHotelReservationsReportParams();
		rc['report_config'] = getHotelReportConfig();
		rc['report'] = getStandardReportManager().gethotelReservationsReportResultsArray( argumentCollection=frm_values );
		rc['report_cnt'] = arrayLen( rc.report );
		return;
	}
	/**
	* hotelReservationsReportPDFView
	* This method will render the report results as pdf
	**/
	public void function hotelReservationsReportPDFView( rc ) {
		//get the string literals of the form
		var frm_values = getStandardReportManager().getHotelReservationsReportParams();
		rc['report_config'] = getHotelReportConfig();
		rc['report'] = getStandardReportManager().gethotelReservationsReportResultsArray( argumentCollection=frm_values );
		rc['report_cnt'] = arrayLen( rc.report );
		return;
	}
	/**
	* hotelReservationsReportExcelView
	* This method will render the report results as a xls
	**/
	public void function hotelReservationsReportExcelView( rc ) {
		//get the string literals of the form
		rc['filename'] = getStandardReportManager().createhotelReservationsReportXLS();
		location( getConfig().urls.wysiwyg_media & rc.filename, false );

	}
	/**
	* registeredAttendeesReportPrintView
	* This method will render the report results as print view
	**/
	public void function registeredAttendeesReportPrintView( rc ) {
		//get the string literals of the form
		var frm_values = getStandardReportManager().getHotelReservationsReportParams();
		rc['report'] = getStandardReportManager().getAttendeeReportResultsArray( argumentCollection=frm_values );
		rc['report_cnt'] = arrayLen( rc.report );
		return;
	}
	/**
	* registeredAttendeesReportPDFView
	* This method will render the report results as pdf
	**/
	public void function registeredAttendeesReportPDFView( rc ) {
		var frm_values = getStandardReportManager().getRegisteredAttendeeReportParams();
		rc['report'] = getStandardReportManager().getAttendeeReportResultsArray( argumentCollection=frm_values );
		rc['report_cnt'] = arrayLen( rc.report );
		return;
	}
	/**
	* registeredAttendeesReportExcelView
	* This method will render the report results as a xls
	**/
	public void function registeredAttendeesReportExcelView( rc ) {
		rc['filename'] = getStandardReportManager().createRegisteredAttendeeXLS();
		location( getConfig().urls.wysiwyg_media & rc.filename, false );

	}
	//END REGISTERED ATTENDEES REPORT
	//END PAGE VIEWS
	//START AJAX VIEWS
	/**
	* ajaxHotelReservationsReportListing
	* - This method will return the ajax JSON for event Hotel Reservations
	*/
	 public void function ajaxHotelReservationsReportListing(rc) {
	 	//get the persisted params
		var params = getGenericListingParams();
		var data = {};
		structAppend( params, getStandardReportManager().getHotelReservationsReportParams(), true);
		params['start_row'] = ( structKeyExists( rc, 'start') ? rc.start:0);
		params['total_rows'] = ( structKeyExists( rc, 'length') ? rc.length:10);
		params['draw'] = ( structKeyExists( rc, 'draw') ? rc.draw:0);

		getStandardReportManager().setReportParams( {'event_id':getCurrentEventID()} );

		//get the report
		data = getStandardReportManager().getHotelReservationsReportListing( argumentCollection = params );
		data['cnt'] = arrayLen(data.data);

		getFW().renderData( "json", data );
		request.layout = false;
	 	return;
	 }
	/**
	* ajaxRegistrationSummaryReportListing
	* - This method will return the ajax JSON for event agenda list
	*/
	public void function ajaxRegistrationSummaryReportListing( rc ) {
		//get the persisted params
		var params = getStandardReportManager().getRegistrationSummaryReportParams();
		params['start_row'] = ( structKeyExists( rc, 'start') ? rc.start:0);
		params['total_rows'] = ( structKeyExists( rc, 'length') ? rc.length:0);
		params['draw'] = ( structKeyExists( rc, 'draw') ? rc.draw:0);
		var data = {};
		//get the report
		data = getStandardReportManager().getRegistrationSummaryReportListing( argumentCollection = params );
		data['cnt'] = arrayLen(data.data);
		for( var i = 1; i <= data.cnt; i++ ) {
			data['data'][i]['fees_amount'] = "" & dollarFormat( data['data'][i]['fees_amount'] );
			data['data'][i]['total'] = "" & dollarFormat( data['data'][i]['total'] );
			data['data'][i]['balance_due'] = "" & dollarFormat( data['data'][i]['balance_due'] );
		}
		getFW().renderData( "json", data );
		request.layout = false;
	}
	/**
	* ajaxRegisteredAttendeeReportListing
	* - This method will return the ajax JSON for event agenda list
	*/
	public void function ajaxRegisteredAttendeeReportListing( rc ) {
		//get the persisted params
		var params = getStandardReportManager().getRegisteredAttendeeReportParams();
		params['start_row'] = ( structKeyExists( rc, 'start') ? rc.start:0);
		params['total_rows'] = ( structKeyExists( rc, 'length') ? rc.length:0);
		params['draw'] = ( structKeyExists( rc, 'draw') ? rc.draw:0);
		var data = {};
		//get the report
		data = getStandardReportManager().getAttendeeReportResultsListing( argumentCollection = params );
		data['cnt'] = arrayLen(data.data);
		for( var i = 1; i <= data.cnt; i++ ) {
			data['data'][i]['registration_timestamp'] = "" & dateFormat(data.data[i].registration_timestamp, 'mm/dd/yyyy');
			data['data'][i]['total'] = "" & data['data'][i]['total'];
			data['data'][i]['total_charges'] = "" & dollarFormat( data['data'][i]['total_charges'] );
			data['data'][i]['balance_due'] = "" & dollarFormat( data['data'][i]['balance_due'] );
		}
		getFW().renderData( "json", data );
		request.layout = false;
	}
	/**
	* ajaxRegisteredAttendeeReportListing
	* - This method will return the ajax JSON for event agenda list
	*/
	public void function ajaxAgendaParticipantsReportListing( rc ) {
		//get the persisted params
		var params = getStandardReportManager().getAgendaParticipantsReportParams();
		params['start_row'] = ( structKeyExists( rc, 'start') ? rc.start:0);
		params['total_rows'] = ( structKeyExists( rc, 'length') ? rc.length:0);
		params['draw'] = ( structKeyExists( rc, 'draw') ? rc.draw:0);
		var data = {};

		//get the report
		data = getStandardReportManager().getAgendaAttendeesReportListing( argumentCollection = params );
		data['cnt'] = arrayLen(data.data);
		for( var i = 1; i <= data.cnt; i++ ) {
			data['data'][i]['start_date'] = "" & dateFormat(data.data[i].start_time, 'mm/dd/yyyy');
			data['data'][i]['start_time'] = "" & timeFormat(data.data[i].start_time, 'h:MM TT');
			data['data'][i]['registration_timestamp'] = "" & dateFormat(data.data[i].registration_timestamp, 'mm/dd/yyyy');
		}
		getFW().renderData( "json", data );
		request.layout = false;
	}
	/**
	* ajaxRegisteredAttendeeReportListing
	* - This method will return the ajax JSON for event agenda list
	*/
	public void function ajaxFinancialTransactionsReportListing( rc ) {
		//get the persisted params
		var params = getStandardReportManager().getFinancialTransactionsReportParams();
		params['start_row'] = ( structKeyExists( rc, 'start') ? rc.start:0);
		params['total_rows'] = ( structKeyExists( rc, 'length') ? rc.length:0);
		params['draw'] = ( structKeyExists( rc, 'draw') ? rc.draw:0);
		var data = {};

		//get the report
		data = getStandardReportManager().getFinancialTransactionsReportListing( argumentCollection = params );
		getFW().renderData( "json", data );
		request.layout = false;
	}
	/**
	* ajaxRegisteredAttendeeReportListing
	* - This method will return the ajax JSON for event agenda list
	*/
	public void function ajaxCouponReportListing( rc ) {
		//get the persisted params
		var params = getStandardReportManager().getCouponReportParams();
		params['start_row'] = ( structKeyExists( rc, 'start') ? rc.start:0);
		params['total_rows'] = ( structKeyExists( rc, 'length') ? rc.length:0);
		params['draw'] = ( structKeyExists( rc, 'draw') ? rc.draw:0);
		var data = {};
		//get the report
		data = getStandardReportManager().getCouponReportListing( argumentCollection = params );
		data['cnt'] = arrayLen(data.data);
		for( var i = 1; i <= data.cnt; i++ ) {
			data['data'][i]['amount'] = "" & dollarFormat(data.data[i].amount );
			data['data'][i]['total'] = "" & dollarFormat(data.data[i].total );
			data['data'][i]['total_due_before_coupon'] = "" & dollarFormat(data.data[i].total_due_before_coupon );
			data['data'][i]['total_due_after_coupon'] = "" & dollarFormat(data.data[i].total_due_after_coupon );
		}
		getFW().renderData( "json", data );
		request.layout = false;
	}
	/**
	* ajaxInvitationStatusReportListing
	* - This method will return the ajax JSON for event agenda list
	*/
	public void function ajaxInvitationStatusReportListing( rc ) {
		//get the persisted params
		var params = getStandardReportManager().getInvitationStatusReportParams();
		params['start_row'] = ( structKeyExists( rc, 'start') ? rc.start:0);
		params['total_rows'] = ( structKeyExists( rc, 'length') ? rc.length:0);
		params['draw'] = ( structKeyExists( rc, 'draw') ? rc.draw:0);
		var data = {};

		//get the report
		data = getStandardReportManager().getInvitationStatusReportListing( argumentCollection = params );
		data['cnt'] = arrayLen(data.data);
		var registered_keys = [ "N/A", "Accepted", "Declined" ];
		for( var i = 1; i <= data.cnt; i++ ) {
			data['data'][i]['sent_date'] = "" & dateFormat(data.data[i].sent_date, 'mm/dd/yyyy') & " " & timeFormat( data.data[i].sent_date, 'hh:mm tt' );
			data['data'][i]['registered'] = "" & registered_keys[ (data.data[i].registered + 1 )];
			data['data'][i]['viewed'] = "" & data.data[i].viewed eq 1 ? "<span>Yes</span>" : "<span>No</span>";
		}
		getFW().renderData( "json", data );
		request.layout = false;
	}
	//END AJAX VIEWS
	//START PRIVATE METHODS
	//all methods get the configs from the tabls
	private struct function getRegistrationSummaryReportConfig() {
		var report_listing_config = {
			"table_id":"report_listing"
			,"ajax_source":"standardReports.ajaxRegistrationSummaryReportListing"
			,"columns":"Company, Total Amount Collected, Total Transaction Fees, Number of Attendees Registered, Balance Due"
		    ,"aoColumns":[
		             {"data":"company"}
		            ,{"data":"fees_amount"}
		            ,{"data":"total"}
		            ,{"data":"row"}
		            ,{"data":"balance_due"}
		    ]
		};
		report_listing_config['ajax_source'] = buildURL( ( structKeyExists( report_listing_config,'ajax_source' ) ? report_listing_config.ajax_source: '' ) );
		return report_listing_config;
	}
	private struct function getFinancialTransactionsReportConfig() {
		var report_listing_config = {
			"table_id":"report_listing"
			,"ajax_source":"standardReports.ajaxFinancialTransactionsReportListing"
			,"columns":"Registration ID, Company, First Name, Last Name, Amount, Detail Name, Payment Type, Description"
		    ,"aoColumns":[
		             {"data":"registration_id"}
		            ,{"data":"company"}
		            ,{"data":"first_name"}
		            ,{"data":"last_name"}
		            ,{"data":"amount"}
		            ,{"data":"detail_name"}
		            ,{"data":"payment_type"}
		            ,{"data":"description"}
		    ]
		};
		report_listing_config['ajax_source'] = buildURL( ( structKeyExists( report_listing_config,'ajax_source' ) ? report_listing_config.ajax_source: '' ) );
		return report_listing_config;
	}
	private struct function getRegisteredAttendeeReportConfig() {
		var report_listing_config = {
			"table_id":"report_listing"
			,"ajax_source":"standardReports.ajaxRegisteredAttendeeReportListing"
			,"columns":"Attendee Status, Balance Due, Company, First Name, Last Name, Registration Date, Registration Type, Total, Total Charges"
		    ,"aoColumns":[
		            {"data":"attendee_status"}
		            ,{"data":"balance_due"}
		            ,{"data":"company"}
		            ,{"data":"first_name"}
		            ,{"data":"last_name"}
		            ,{"data":"registration_timestamp"}
		            ,{"data":"registration_type"}
		            ,{"data":"row"}
		            ,{"data":"total_charges"}
		    ]
		};
		report_listing_config['ajax_source'] = buildURL( ( structKeyExists( report_listing_config,'ajax_source' ) ? report_listing_config.ajax_source: '' ) );
		return report_listing_config;
	}
	private struct function getAgendaParticipantsReportConfig() {
		var report_listing_config = {
			"table_id":"report_listing"
			,"ajax_source":"standardReports.ajaxAgendaParticipantsReportListing"
			,"columns":"Agenda Label, Session Title, Attendee Status, Company, First Name, Last Name, Agenda Start Date, Agenda Start Time,Registration Date, Registration Type, Location, Category"
		    ,"aoColumns":[
					 {"data":"label"}
					,{"data":"title"}
		            ,{"data":"attendee_status"}
		            ,{"data":"company"}
		            ,{"data":"first_name"}
		            ,{"data":"last_name"}
		            ,{"data":"start_date"}
		            ,{"data":"start_time"}
		            ,{"data":"registration_timestamp"}
		            ,{"data":"registration_type"}
		            ,{"data":"location_name"}
		            ,{"data":"category"}
		    ]
		};
		report_listing_config['ajax_source'] = buildURL( ( structKeyExists( report_listing_config,'ajax_source' ) ? report_listing_config.ajax_source: '' ) );
		return report_listing_config;
	}
	private struct function getInvitationStatusReportConfig() {
		var report_listing_config = {
			"table_id":"report_listing"
			,"ajax_source":"standardReports.ajaxInvitationStatusReportListing"
			,"columns":"Company Name, First Name, Last Name, Decline comment, Email, Viewed, Status, Event Name, Invitation label, Sent Date"
		    ,"aoColumns":[
					 {"data":"company_name"}
					,{"data":"first_name"}
		            ,{"data":"last_name"}
                    ,{"data":"decline_comment"}
		            ,{"data":"email"}
		            ,{"data":"viewed"}
		            ,{"data":"registered"}
		            ,{"data":"event_name"}
		            ,{"data":"invitation_label"}
		            ,{"data":"sent_date"}
		    ]
		};
		report_listing_config['ajax_source'] = buildURL( ( structKeyExists( report_listing_config,'ajax_source' ) ? report_listing_config.ajax_source: '' ) );
		return report_listing_config;
	}
	private struct function getCouponReportConfig() {
		var report_listing_config = {
			"table_id":"report_listing"
			,"ajax_source":"standardReports.ajaxCouponReportListing"
			,"columns":"First Name, Last Name, Email, Coupon Code, Coupon Type, Amount, Total Due Before Coupon, Total Due After Coupon"
		    ,"aoColumns":[
					 {"data":"first_name"}
		            ,{"data":"last_name"}
		            ,{"data":"email"}
		            ,{"data":"coupon_code"}
		            ,{"data":"coupon_type"}
		            ,{"data":"amount"}
		            ,{"data":"total_due_before_coupon"}
		            ,{"data":"total_due_after_coupon"}
		    ]
		};
		report_listing_config['ajax_source'] = buildURL( ( structKeyExists( report_listing_config,'ajax_source' ) ? report_listing_config.ajax_source: '' ) );
		return report_listing_config;
	}
	private struct function getHotelReportConfig() {
		var report_listing_config = {
		    'table_id': "report_listing",
		    'ajax_source': buildURL( "standardReports.ajaxHotelReservationsReportListing" ),
		    'aoColumns':[
	            {
	            	'data':"first_name",
	            	'sTitle': "First Name"
				},
				{
	            	'data':"last_name",
	            	'sTitle': "Last Name"
				},
	            {
	            	'data':"email",
	            	'sTitle': "Email"
				},
	            {
	            	'data':"hotel_name",
	            	'sTitle': "Hotel Name"
				},
	            {
	            	'data':"room_type",
	            	'sTitle': "Room Type"
				},
				{
	            	'data':"hotel_checkin_date",
	            	'sTitle': "Check in Date"
				},
				{
	            	'data':"hotel_checkout_date",
	            	'sTitle': "Check Out Date"
				},
				{
	            	'data':"hotel_number_rooms",
	            	'sTitle': "Hotel Number Rooms"
				},
				{
	            	'data':"hotel_reservation_name",
	            	'sTitle': "Hotel Reservation Name"
				},
				{
	            	'data':"hotel_reservation_email",
	            	'sTitle': "Hotel Reservation Email"
				},
				{
	            	'data':"hotel_reservation_phone",
	            	'sTitle': "Hotel Reservation Phone"
				}
		    ]
		};

		return report_listing_config;
	}
	//END PRIVATE METHODS
}
