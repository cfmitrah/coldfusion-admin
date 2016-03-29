/**
*
* @file  /model/managers/StandardReport.cfc
* @author
* @description
*
*/
component output="false" displayname="Standard Report" accessors="true" extends="app.model.base.Manager" {
	property name="ReportDao" getter="true" setter="true";
	property name="AgendaDao" getter="true" setter="true";
	property name="CouponDao" getter="true" setter="true";
	property name="RegistrationDao" getter="true" setter="true";
	property name="SessionManageUserFacade" setter="true" getter="true";
	property name="registrationTypesManager" setter="true" getter="true";
	property name="EventsManager" setter="true" getter="true";
	property name="PaymentManager" setter="true" getter="true";
	property name="RegistrationManager" setter="true" getter="true";
	property name="CompanyManager" setter="true" getter="true";
	property name="SpreadSheetUtilities" setter="true" getter="true";
	property name="config" setter="true" getter="true";
	property name="EmailManagementManager" setter="true" getter="true";



	/**
	* getCoupons
	* This method will return in use fields for the fields report
	*/
	public any function getCoupons( required numeric event_id, string return_type="struct" ){
		if( arguments.return_type == "struct" ){
			return queryToStruct( getCouponDao().RegistrationCouponsGet( argumentCollection=arguments ).result );
		}
		return queryToArray( getCouponDao().RegistrationCouponsGet( argumentCollection=arguments ).result );
	}
	/**
	* getInUseFields
	* This method will return in use fields for the fields report
	*/
	private array function getInUseFields( required query fields ){
		var event_fields = queryToArray( arguments.fields );
		var event_fields_cnt = arrayLen( event_fields );
		var in_use_fields = [ "coupon_code_name", "coupon_code_amount", "attendee_status", "registration_type", "registration_timestamp" ];
		for( var i=1; i<=event_fields_cnt; i++ ){
			if( event_fields[ i ].in_use ) {
				var field_name = event_fields[ i ].field_name;
				if( event_fields[ i ].field_name == "hotel_id" ) {
					field_name = "hotel_name";
				}else if( event_fields[ i ].field_name == "hotel_room_type_id" ){
					field_name = "hotel_room_type";
				}
				arrayAppend( in_use_fields, field_name );
			}
		}


		return in_use_fields;
	}
	/**
	* createCustomFieldsReportQuery
	* This method will return all data pertained to retriving the custom data for questions
	*/
	public struct function createCustomFieldsReportQuery(
		required numeric event_id,
		string registration_type_id_list="",
		string registration_date_from="",
		string registration_date_to=""
	){
		var report_return = getReportDao().AttendeeRegistrationsFieldsReport( argumentCollection=arguments ).result;
		var report = queryToArray( report_return.report );
		var headers = getInUseFields( report_return.fields );
		var headers_cnt = arrayLen( headers );
		var report_cnt = arrayLen( report );
		var field_value = "";
		var report_data = "";
		var header_data = {};
		var time_reg_ex = "([0-2][0-9]|[0-9]):[0-5][0-9](\s?(am|AM|pm|PM)|\s?)";
		var header_text = "All Fields Export: " & report_return.event_details.name;
		//create the new query and get the count
		var query = queryNew( arrayToList( headers ) );
		for( var k=1;k<=report_return.fields.recordCount;k++ ) {
			header_data[ report_return.fields['field_name'][k] ] = report_return.fields['label'][k];
		}
		//create the body rows
		for( var i=1;i<=report_cnt;i++ ) {
			queryAddRow( query );
			//write the standards fields
			for( var k=1;k<=headers_cnt;k++ ){
				if( structKeyExists( report[ i ], headers[ k ] ) ){

					querySetCell( query, headers[ k ], report[ i ][ headers[ k ] ] );
				}
			}
			if( len( report[ i ][ 'custom' ] ) ){
				//get the custom fields object
				var custom_fields = deserializeJSON( report[ i ][ 'custom' ] );
				//die(custom_fields);
				//here we need to loop the customs and make sure the field actually exists, if it does get the value and set
				for( var j=1;j<=headers_cnt; j++ ){
					if( structKeyExists( custom_fields, headers[ j ] ) ) {
						field_value = custom_fields[ headers[ j ] ];
						if( listFindNoCase("hotel_checkout_date,hotel_checkin_date", headers[ j ] ) && ( isDate( field_value ) && !isValid("regex", trim(field_value), time_reg_ex) ) ) {
							field_value = " " & dateFormat( field_value, "dd/mm/yyyy");
						}else if( isValid("regex", trim(field_value), time_reg_ex) ){
							field_value = " '" & field_value;
						}
						querySetCell(query, headers[ j ], field_value );
					}
				}
			}
		}

		report_data = queryToArray( query );
		return {
			'query' : query,
			'formatted_headers' : formatCustomHeaders( headers, header_data ),
			'headers' : headers,
			'header_data': header_data,
			'header_cnt' : arrayLen( headers ),
			'report_data' : report_data,
			'report_data_cnt' : arrayLen( report_data ),
			'header_text':header_text
		};
	}
	/**
	* formatCustomHeaders
	* This method will return all data formatted for column headers
	*/
	private array function formatCustomHeaders( required array headers, struct header_data={} ){
		var columns = arguments.headers;
		var cnt = arrayLen( columns );
		var new_columns = [];

		for( var i=1; i<=cnt; i++ ){
			var column_label = columns[ i ];
			if( structKeyExists( header_data, column_label ) ) {
				arrayAppend( new_columns, replace( header_data[column_label], ",", " ", "ALL" ) );
			}else{
				var last_sub_part = listLast( column_label, '_' );
				if( findNoCase( "xxx", left( last_sub_part, 3 ) ) ){
					arrayAppend(
						new_columns,
						replace( listDeleteAt( column_label, listLen( column_label, "_" ), "_" ), "_", " ", "ALL" )
					);
				}else{
					arrayAppend( new_columns, replace( column_label, "_", " ", "ALL" ) );
				}
			}
		}
		return new_columns;
	}

	/**
	* createCustomFieldsReportXLS
	* This method will return a xls of the custom questions fields
	*/
	public any function createCustomFieldsReportXLS( required numeric event_id ){
		var data = createCustomFieldsReportQuery( event_id=event_id );
		var params = { 'xls_query'=data.query,
						'file_path'=getConfig().paths.media,
						'columns'=data.headers,
						'header_data'=data.header_data
					};
		if( structKeyExists( data, "header_text") && len( data.header_text ) ) {
			params['header_text'] = data.header_text;
		}
		return getSpreadSheetUtilities().createSimpleSpreadSheet( argumentCollection:params );
	}
	//START GET ATTENDEE REGISTRATION FIELDS REPORT
	/**
	* createAttendeeRegistrationFieldsReportXLS
	* This method will return a xls of the registration attendees report
	*/
	public any function createAttendeeRegistrationFieldsReportXLS( required numeric event_id ) {
		var report = getReportDao().AttendeeRegistrationsFieldsReport( event_id=arguments.event_id ).result.report;
		var report_cnt = report.recordCount;

		//standard fields
		var standard_field_keys_array = listToArray( report.columnList );
		var standard_columns_cnt = arrayLen( standard_field_keys_array );

		//custom fields
		var custom_fields_keys_list = arrayToList( queryToStruct( getReportDao().RegistrationFieldsList( event_id=arguments.event_id, standard_field=0 ).result.fields ).field_name );
		var custom_fields_column_array = listToArray( custom_fields_keys_list );
		var custom_columns_cnt = arrayLen( custom_fields_column_array );

		//need to merge the custom fields columns keys to the static
		var columns_list_array = listToArray( listAppend( report.columnList, custom_fields_keys_list ) );
		var all_columns_cnt = arrayLen( columns_list_array );


		//create the new query and get the count
		var query = queryNew( arrayToList( columns_list_array ) );


		//create the body rows
		for( var i=1;i<=report_cnt;i++ ) {
			queryAddRow( query );
			//write the standards fields
			for( var k=1;k<=standard_columns_cnt;k++ ){
				querySetCell(query, standard_field_keys_array[ k ], report[ standard_field_keys_array[ k ] ][ i ] );
			}
			if( len( report[ 'custom' ][ i ] ) ){
				//get the custom fields object
				var custom_fields = deserializeJSON( report[ 'custom' ][ i ] );
				//here we need to loop the customs and make sure the field actually exists, if it does get the value and set
				for( var j=1;j<=custom_columns_cnt; j++ ){
					if( structKeyExists( custom_fields, custom_fields_column_array[ j ] ) ){
						querySetCell(query, custom_fields_column_array[ j ], custom_fields[ custom_fields_column_array[ j ] ] );
					}
				}
			}
		}
		return getSpreadSheetUtilities().createSimpleSpreadSheet( query, getConfig().paths.media, columns_list_array );
	}

	//END GET ATTENDEE REGISTRATION FIELDS REPORT
	//---------------------------------------
	//START THE REPORT DATA GETS SUPPORTING METHODS
	//---------------------------------------
	/**
	* getAgendaItems
	* This method will return a list agenda items as a struct
	*/
	public struct function getAgendaItems( required numeric event_id ) {
		var agenda_items = queryToStruct( getAgendaDao().AgendasGet( argumentCollection=arguments ).result.agendas );
		var agenda_items_cnt = arrayLen( agenda_items.label );
		for( var i=1; i<=agenda_items_cnt; i++ ){
			agenda_items.label[ i ] =  agenda_items.label[ i ] & ' - ' & dateFormat( agenda_items.start_time[ i ], "MM/DD/YYYY" );
		}
		return agenda_items;
	}
	/**
	* getAgendaItemsArray
	* This method will return a list agenda items as an array
	*/
	public array function getAgendaItemsArray( required numeric event_id ) {
		var ret = getAgendaDao().AgendasGet( argumentCollection=arguments ).result.agendas;
		return queryToArray( ret );
	}
	//---------------------------------------
	//END THE REPORT DATA GETS SUPPORTING METHODS
	//---------------------------------------
	//---------------------------------------
	//---------------------------------------
	//START THE REPORT RESULT (NON LISTING)
	//---------------------------------------

	//START INVITATION STATUS REPORTS
	/**
	* getInvitationStatusReportResultsArray
	* This method will the report as an array
	*/
	public array function getInvitationStatusReportResultsArray() {
		var ret = queryToArray( getInvitationStatusReportResults( argumentCollection=arguments ).report );
		return ret;
	}
	/**
	* getRegistrationSummaryReportResults
	* This method will return the report as a query
	*/
	public struct function getInvitationStatusReportResults(
		required numeric event_id,
		required numeric company_id,
		required numeric invitation_id,
		string sent_date_from="",
		string sent_date_to=""
	) {
		var params = arguments;
		var report = getReportDao().InvitationStatusReport( argumentCollection=params ).result;
		return report;
	}
	/**
	* createRegistrationSummaryReportXLS
	* This method will create the XLS file
	*/
	public any function createInvitationStatusReportXLS() {
		var frm_values = getInvitationStatusReportParams();
		var data = getInvitationStatusReportResults( argumentCollection=frm_values );
		var header_text = "Invitation Status: " & data.event_details.name;
		var columns = [ "company_name", "first_name", "last_name", "email", "registration_status", "viewed", "registered", "event_name", "invitation_label", "sent_date" ];
		data.report = formatBooleansToStrings( data.report, [ "sent", "viewed" ]);
		return getSpreadSheetUtilities()
					.createSimpleSpreadSheet(
						xls_query:data.report,
						file_path:getConfig().paths.media,
						columns:columns,
						header_data:{'registered':"Status"},
						header_text:header_text
				);
	}
	/**
	* formatBooleansToStrings
	* format boolean strings
	*/
	private query function formatBooleansToStrings( required query query, required array fields ){
		var data = queryToArray( query );
		var tmp = [];
		var fields_cnt = arrayLen( fields );
		var idx = 1;
		var item = {};
		for( item in data ){
			for( idx = 1; idx <= fields_cnt; idx++ ){
				item[ fields[ idx ] ] = yesNoFormat( item[ fields[ idx ] ] ); 			
			}
			arrayAppend( tmp, item );	
		}
		return collectionToQuery( tmp );				
	}
	//END INVITATION STATUS REPORTS



	//START REGISTRATION SUMMARY REPORTS
	/**
	* getRegistrationSummaryReportResultsArray
	* This method will the report as an array
	*/
	public array function getRegistrationSummaryReportResultsArray() {
		var ret = queryToArray( getRegistrationSummaryReportResults( argumentCollection=arguments ).report );
		return ret;
	}
	/**
	* getRegistrationSummaryReportResults
	* This method will return the report as a query
	*/
	public struct function getRegistrationSummaryReportResults(
		required numeric event_id,
		string company="",
		numeric attendee_count=0,
		string attendee_count_operator="",
		numeric balance_due=0,
		string balance_due_operator=""
	) {
		var params = arguments;
		var report = getReportDao().RegistrationSummaryReport( argumentCollection=params ).result;
		return report;
	}
	/**
	* createRegistrationSummaryReportXLS
	* This method will create the XLS file
	*/
	public any function createRegistrationSummaryReportXLS() {
		var frm_values = getRegistrationSummaryReportParams();
		var data = getRegistrationSummaryReportResults( argumentCollection=frm_values );
		var header_text = "Registration Fees: " & data.event_details.name;
		var columns = [ "company", "fees_amount", "attendees_count", "balance_due" ];
		return getSpreadSheetUtilities().createSimpleSpreadSheet( xls_query:data.report, file_path:getConfig().paths.media, columns:columns, header_text:header_text );
	}
	//END REGISTRATION SUMMARY REPORTS
	//START REGISTRATION DETAILS REPORTS
	/**
	* getRegistrationDetailsReportResultsArray
	* This method will the report as an array
	*/
	public array function getRegistrationDetailsReportResultsArray() {
		var ret = queryToArray( getRegistrationDetailsReportResults( argumentCollection=arguments ).report );
		return ret;
	}
	/**
	* getRegistrationDetailsReportResults
	* This method will return the report as a query
	*/
	public struct function getRegistrationDetailsReportResults(
		required numeric event_id,
		required string detail_type_id_list,
		required numeric payment_type_id,
		string detail_date_from="",
		string detail_date_to="",
		string amount="",
		string amount_operator="",
		string attendee_id=0
	) {
		var params = arguments;
		if( ! len( params.detail_date_from) || ! len( params.detail_date_to ) ){
			structDelete( params, "detail_date_to" );
			structDelete( params, "detail_date_from" );
		}else{
			params.detail_date_to = dateFormat( params.detail_date_to, "MM/DD/YYYY" );
			params.detail_date_from = dateFormat( params.detail_date_from, "MM/DD/YYYY" );
		}
		if( ! len( params.attendee_id ) ) params.attendee_id = 0;
		if( ! len( params.amount ) ) params.amount = 0;

		var report = getReportDao().RegistrationDetailsReport( argumentCollection=params ).result;
		return report;
	}
	/**
	* createRegistrationDetailsReportXLS
	* This method will create the XLS file
	*/
	public any function createRegistrationDetailsReportXLS() {
		var frm_values = getFinancialTransactionsReportParams();
		var data = getRegistrationDetailsReportResults( argumentCollection=frm_values );
		var header_text = "Financial Transaction Detail: " & data.event_details.name;
		var columns = [  "registration_id", "company", "first_name", "last_name", "amount", "detail_name", "payment_type", "description" ];
		return getSpreadSheetUtilities().createSimpleSpreadSheet( xls_query:data.report, file_path:getConfig().paths.media, columns:columns, header_text:header_text );

	}
	//END REGISTRATION DETAILS REPORTS
	//START AGENDA ATTENDEES REPORTS
	/**
	* getAgendaAttendeesReport
	* This method will return the report as a query
	*/
	public struct function getAgendaAttendeesReport(
		required numeric event_id,
		required string agenda_id_list,
		required numeric report_type,
		string agenda_start_date_from="",
		string agenda_start_date_to="",
		required numeric location_id=0,
		required numeric category_id=0,
		numeric start_row=0,
		numeric total_rows=10
	 ) {
		var params = arguments;
		if( ! len( params.agenda_start_date_from) || ! len( params.agenda_start_date_to ) ){
			structDelete( params, "agenda_start_date_to" );
			structDelete( params, "agenda_start_date_from" );
		}else{
			params.agenda_start_date_to = dateFormat( params.agenda_start_date_to, "MM/DD/YYYY" );
			params.agenda_start_date_from = dateFormat( params.agenda_start_date_from, "MM/DD/YYYY" );
		}
		if( params.report_type ){
			var ret = getReportDao().AgendaAttendeesReport( argumentCollection=params ).result;
		}else{
			var ret = getReportDao().AgendaAttendeesWaitlistReport( argumentCollection=params ).result;
		}
		return ret;
	}
	/**
	* getAgendaAttendeesReportResultsArray
	* This method will the report as an array
	*/
	public array function getAgendaAttendeesReportResultsArray() {
		var ret = queryToArray( getAgendaAttendeesReport( argumentCollection=arguments ).report );
		return ret;
	}
	/**
	* createAgendaAttendeesXLS
	* This method will create the XLS file
	*/
	public any function createAgendaAttendeesXLS() {
		var frm_values = getAgendaParticipantsReportParams();
		var data = getAgendaAttendeesReport( argumentCollection=frm_values );
		var header_text = "Agenda Participants: " & data.event_details.name;
		var columns = [ "label", "title", "attendee_status", "company", "first_name", "last_name", "start_time", "registration_timestamp", "registration_type", "location_name", "category" ];
		return getSpreadSheetUtilities().createSimpleSpreadSheet( xls_query:data.report, file_path:getConfig().paths.media, columns:columns, header_text:header_text );
	}
	//END AGENDA ATTENDEES REPORTS
	//START ATTENDEE REGISTRATION REPORTS
	/**
	* getAttendeeReportResultsArray
	* This method will the report as an array
	*/
	public array function getAttendeeReportResultsArray() {
		var ret = queryToArray( getAttendeeReportResults( argumentCollection=arguments ).report );
		return ret;
	}
	/**
	* getAttendeeReportResults
	* This method will return the report as a query
	*/
	public struct function getAttendeeReportResults(
		required string balance_due_operator,
		required numeric balance_due,
		required numeric event_id,
		required string registration_type_id_list,
		string registration_date_to="",
		string registration_date_from=""
	) {
		var params = arguments;
		if( ! len( params.registration_date_to) || ! len( params.registration_date_from ) ){
			structDelete( params, "registration_date_to" );
			structDelete( params, "registration_date_from" );
		}else{
			params.registration_date_to = dateFormat( params.registration_date_to, "MM/DD/YYYY" );
			params.registration_date_from = dateFormat( params.registration_date_from, "MM/DD/YYYY" );
		}
		return getReportDao().AttendeeRegistrationsReport( argumentCollection=params ).result;
	}
	/**
	* createRegisteredAttendeeXLS
	* This method will create the XLS file
	*/
	public any function createRegisteredAttendeeXLS() {
		var frm_values = getRegisteredAttendeeReportParams();
		var data = getAttendeeReportResults( argumentCollection=frm_values );
		var header_text = "Registration List Report:" & data.event_details.name;
		var columns = [ "attendee_status", "balance_due", "company", "first_name", "last_name", "registration_timestamp", "registration_type", "total_charges" ];
		return getSpreadSheetUtilities().createSimpleSpreadSheet( xls_query:data.report, file_path:getConfig().paths.media, columns:columns, header_text:header_text );

	}
	//END ATTENDEE REGISTRATION REPORTS
	//START COUPON REPORTS
	/**
	* getCouponReportResultsArray
	* This method will the report as an array
	*/
	public array function getCouponReportResultsArray() {
		var ret = queryToArray( getCouponReportResults( argumentCollection=arguments ).report );
		return ret;
	}
	/**
	* getCouponReportResults
	* This method will return the report as a query
	*/
	public struct function getCouponReportResults(
		required numeric event_id,
		string coupon_code_list="",
		string coupon_type_list=""
	) {
		var params = arguments;
		return getReportDao().CouponAttendeesReport( argumentCollection=params ).result;
	}
	/**
	* createCouponReportXLS
	* This method will create the XLS file
	*/
	public any function createCouponReportXLS() {
		var frm_values = getCouponReportParams();
		var data = getCouponReportResults( argumentCollection=frm_values );
		var header_text = "Coupon Codes Report: " & data.event_details.name;
		var columns = [ "first_name", "last_name", "coupon_code", "amount", "total_due_before_coupon", "total_due_after_coupon" ];
		return getSpreadSheetUtilities().createSimpleSpreadSheet( xls_query:data.report, file_path:getConfig().paths.media, columns:columns, header_text:header_text );
	}
	//END COUPON REPORTS

	//START HOTEL RESERVATIONS REPORTS
	/**
	* gethotelReservationsReportResultsArray
	* This method will the report as an array
	*/
	public array function gethotelReservationsReportResultsArray() {
		var ret = queryToArray( gethotelReservationsReportResults( argumentCollection=arguments ).report );
		return ret;
	}
	/**
	* gethotelReservationsReportResults
	* This method will return the report as a query
	*/
	public struct function gethotelReservationsReportResults(
		required numeric event_id,
		required numeric hotel_id,
		string checkin_date="",
		numeric room_type_id=0,
		boolean hotel_requested=1
	) {
		var params = arguments;
		return getReportDao().RegistrationAttendeesHotelReport( argumentCollection=params ).result;
	}
	/**
	* createhotelReservationsReportXLS
	* This method will create the XLS file
	*/
	public any function createhotelReservationsReportXLS() {
		var frm_values = getHotelReservationsReportParams();
		var data = gethotelReservationsReportResults( argumentCollection=frm_values );
		var header_text = "Hotel Reservations Report: " & data.event_details.name;
		var columns = [ "first_name","last_name","email","hotel_name","room_type","hotel_checkin_date","hotel_checkout_date","hotel_number_rooms","hotel_reservation_name","hotel_reservation_email","hotel_reservation_phone"  ];
		return getSpreadSheetUtilities().createSimpleSpreadSheet( xls_query:data.report, file_path:getConfig().paths.media, columns:columns, header_text:header_text );
	}
	//END HOTEL RESERVATIONS REPORTS


	//---------------------------------------
	//END THE REPORT RESULT (NO LISTING
	//---------------------------------------
	//---------------------------------------
	//---------------------------------------
	//START THE REPORT RESULT LISTINGS
	//---------------------------------------
	/**
	* getAttendeeReportResultsListing
	* This method will return a list event transactions
	*/
	public struct function getCouponReportListing(
		required numeric event_id,
		string coupon_code_list="",
		string coupon_type_list="",
		numeric start_row=0,
		numeric total_rows=10
	 ) {
		//set the fields
		var columns = [ "first_name", "last_name", "coupon_code", "amount", "total_due_before_coupon", "total_due_after_coupon" ];
		var params = arguments;
		params['start'] = ( start_row + 1 );
		params['results'] = arguments.total_rows;

		var report = getReportDao().CouponAttendeesReportList( argumentCollection=params ).result.report;
		return {
			"draw" : arguments.draw,
			"recordsTotal" : val( report.total ) ? report.total : 0,
			"recordsFiltered" : val( report.total ) ? report.total : 0,
			"data": queryToArray( report )
		};
	}

	/**
	* getAttendeeReportResultsListing
	* This method will return a list event transactions
	*/
	public struct function getFinancialTransactionsReportListing(
		required numeric event_id,
		required string detail_type_id_list,
		required numeric payment_type_id,
		string detail_date_from="",
		string detail_date_to="",
		string amount="",
		string amount_operator="",
		string attendee_id=0,
		numeric start_row=0,
		numeric total_rows=10
	 ) {
		var columns = [  "registration_id", "company", "first_name", "last_name", "amount", "detail_name", "payment_type", "description" ];
		var params = arguments;
		if( ! len( params.detail_date_from) || ! len( params.detail_date_to ) ){
			structDelete( params, "detail_date_to" );
			structDelete( params, "detail_date_from" );
		}else{
			params.detail_date_to = dateFormat( params.detail_date_to, "MM/DD/YYYY" );
			params.detail_date_from = dateFormat( params.detail_date_from, "MM/DD/YYYY" );
		}
		params['start'] = ( start_row + 1 );
		params['results'] = arguments.total_rows;
		if( ! len( params.attendee_id ) ) params.attendee_id = 0;
		if( ! len( params.amount ) ) params.amount = 0;
		var report = getReportDao().RegistrationDetailsReportList( argumentCollection=params ).result.report;

		return {
			"draw" : arguments.draw,
			"recordsTotal" : val( report.total ) ? report.total : 0,
			"recordsFiltered" : val( report.total ) ? report.total : 0,
			"data": queryToArray( report )
		};
	}
	/**
	* getAttendeeReportResultsListing
	* This method will return a list of invitations per event
	*/
	public struct function getAttendeeReportResultsListing(
		required string balance_due_operator,
		required numeric balance_due,
		required numeric event_id,
		required string registration_type_id_list,
		string registration_date_to="",
		string registration_date_from=""
		numeric start_row=0,
		numeric total_rows=10
	 ) {
		var columns = ["attendee_status", "balance_due", "company", "first_name", "last_name", "registration_timestamp", "registration_type", "total", "total_charges" ];
		var params = arguments;
		if( ! len( params.registration_date_to) || ! len( params.registration_date_from ) ){
			structDelete( params, "registration_date_to" );
			structDelete( params, "registration_date_from" );
		}else{
			params.registration_date_to = dateFormat( params.registration_date_to, "MM/DD/YYYY" );
			params.registration_date_from = dateFormat( params.registration_date_from, "MM/DD/YYYY" );
		}
		params['start'] = ( start_row + 1 );
		params['result'] = arguments.total_rows;

		var report = getReportDao().AttendeeRegistrationsReportList( argumentCollection=params ).result.report;
		return {
			"draw" : arguments.draw,
			"recordsTotal" : val( report.total ) ? report.total : 0,
			"recordsFiltered" : val( report.total ) ? report.total : 0,
			"data": queryToArray( report )
		};
	}
	/**
	* getAgendaAttendeesReportListing
	* This method will return a list of invitations per event
	*/
	public struct function getAgendaAttendeesReportListing(
		required numeric event_id,
		required string agenda_id_list,
		required numeric report_type,
		string agenda_start_date_from="",
		string agenda_start_date_to="",
		required numeric location_id=0,
		required numeric category_id=0,
		numeric start_row=0,
		numeric total_rows=10
	 ) {
		var columns = [ "label", "title", "attendee_status", "company", "first_name", "last_name", "start_time", "start_time", "registration_timestamp", "registration_type", "location_name", "category" ];
		var params = arguments;
		if( ! len( params.agenda_start_date_from) || ! len( params.agenda_start_date_to ) ){
			structDelete( params, "agenda_start_date_to" );
			structDelete( params, "agenda_start_date_from" );
		}else{
			params.agenda_start_date_to = dateFormat( params.agenda_start_date_to, "MM/DD/YYYY" );
			params.agenda_start_date_from = dateFormat( params.agenda_start_date_from, "MM/DD/YYYY" );
		}
		params['start'] = ( start_row + 1 );
		params['results'] = arguments.total_rows;
		if( params.report_type ){
			var report = getReportDao().AgendaAttendeesReportList( argumentCollection=params ).result.report;
		}else{
			var report = getReportDao().AgendaAttendeesWaitlistReportList( argumentCollection=params ).result.report;
		}
		return {
			"draw" : arguments.draw,
			"recordsTotal" : val( report.total ) ? report.total : 0,
			"recordsFiltered" : val( report.total ) ? report.total : 0,
			"data": queryToArray( report )
		};
	}
	/**
	* getRegistrationSummaryReportListing
	* This method will return a list of invitations per event
	*/
	public struct function getRegistrationSummaryReportListing(
		required numeric event_id,
		string company="",
		numeric attendee_count="",
		string attendee_count_operator="",
		numeric balance_due=0,
		string balance_due_operator="",
		numeric start_row=0,
		numeric total_rows=10
	 ) {
		var columns = [ "company", "fees_amount", "total", "attendees_count", "balance_due" ];
		var params = arguments;
		params['start'] = ( start_row + 1 );
		params['results'] = arguments.total_rows;
		var report = getReportDao().RegistrationSummaryReportList( argumentCollection=params ).result.report;
		return {
			"draw" : arguments.draw,
			"recordsTotal" : val( report.total ) ? report.total : 0,
			"recordsFiltered" : val( report.total ) ? report.total : 0,
			"data": queryToArray( report )
		};
	}
	/**
	* getAgendaAttendeesReportListing
	* This method will return a list of invitations per event
	*/
	public struct function getInvitationStatusReportListing(
		required numeric event_id,
		required numeric company_id,
		required numeric invitation_id,
		string sent_date_from="",
		string sent_date_to="",
		numeric start_row=0,
		numeric total_rows=10
	 ) {
		var columns = [ "company_name", "first_name", "last_name", "email","decline_comment", "viewed", "registered", "event_name", "invitation_label", "sent_date" ];
		var params = arguments;
		if( ! len( params.sent_date_from) || ! len( params.sent_date_to ) ){
			structDelete( params, "sent_date_from" );
			structDelete( params, "sent_date_to" );
		}else{
			params.sent_date_from = dateFormat( params.sent_date_from, "MM/DD/YYYY" );
			params.sent_date_to = dateFormat( params.sent_date_to, "MM/DD/YYYY" );
		}
		params['start'] = ( start_row + 1 );
		params['results'] = arguments.total_rows;
		var report = getReportDao().InvitationStatusReportList( argumentCollection=params ).result.report;
		return {
			"draw" : arguments.draw,
			"recordsTotal" : val( report.total ) ? report.total : 0,
			"recordsFiltered" : val( report.total ) ? report.total : 0,
			"data": queryToArray( report )
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
	public any function getHotelReservationsReportListing(
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
		var columns = [ "first_name","last_name","email","hotel_name","hotel_room_type","hotel_checkin_date","hotel_checkout_date","hotel_number_rooms","hotel_reservation_name","hotel_reservation_email","hotel_reservation_phone"  ];
		var params = arguments;
		var report = "";
		params['start'] = ( start_row + 1 );
		params['results'] = arguments.total_rows;
		report = getReportDao().RegistrationAttendeesHotelReportList( argumentCollection=params ).result;
		return {
			"draw" : arguments.draw,
			"recordsTotal" : val( report.total ) ? report.total : 0,
			"recordsFiltered" : val( report.total ) ? report.total : 0,
			"data": queryToArray( recordSet:report, map=function( row, index, columns, data ) {
				row['hotel_checkin_date'] = dateFormat( row.hotel_checkin_date, "mm/dd/yyyy");
				row['hotel_checkout_date'] = dateFormat( row.hotel_checkout_date, "mm/dd/yyyy");
				return row;
			} )
		};

		return;
	}
	//---------------------------------------
	//END THE REPORT RESULT LISTINGS
	//---------------------------------------
	//---------------------------------------
	//---------------------------------------
	//START THE REPORT FORM VALUES GET METHODS
	//---------------------------------------
	/**
	* getFinancialTransactionsReportFrmValues
	* This method will return a list string literals for the form
	*/
	public struct function getFinancialTransactionsReportFrmValues() {
		var ret = {};
		var frm_values = getFinancialTransactionsReportParams();
		var payment_types = getPaymentManager().getPaymentTypesArray();
		var detail_types = getRegistrationManager().getDetailTypesArray();
		var type_array = [];
		var payment_array = [];
		var type_cnt = arrayLen( detail_types );
		var payment_cnt = arrayLen( payment_types );
		//set our form values
		for( var i = 1; i <= type_cnt; i++ ){
			if( listFindNoCase( frm_values.detail_type_id_list, detail_types[i].detail_type_id )){
				arrayAppend( type_array, detail_types[i].detail_name );
			}
		}
		for( var i = 1; i <= payment_cnt; i++ ){
			if( listFindNoCase( frm_values.payment_type_id, payment_types[i].payment_type_id )){
				arrayAppend( payment_array, payment_types[i].payment_type );
			}
		}
		ret['attendee_id'] = val( frm_values.attendee_id ) ? frm_values.attendee_id : 'Not Set';
		ret['payment'] = arrayToList( payment_array, ', ' );
		ret['types'] = arrayToList( type_array, ', ' );
		ret['amount'] = dollarFormat( frm_values.amount );
		ret['dates'] = 'All Dates';
		if( len( frm_values.detail_date_from ) && len( frm_values.detail_date_from ) ){
			ret.dates = frm_values.detail_date_to & " to " & frm_values.detail_date_to;
		}
		return ret;
	}
	/**
	* getRegistrationSummaryReportFrmValues
	* This method will return a list string literals for the form
	*/
	public struct function getRegistrationSummaryReportFrmValues() {
		var ret = {};
		var frm_values = getRegistrationSummaryReportParams();
		var companies = getCompanyManager().getCompanies().companies;
		var company_cnt = arrayLen( companies );
		var company_array = [];
		for( var i = 1; i <= company_cnt; i++ ){
			if( listFindNoCase( frm_values.company, companies[i].company_id )){
				arrayAppend( company_array, companies[i].company_name );
			}
		}
		ret['companies'] = arrayLen( company_array ) ? arrayToList( company_array, ', ' ) : 'All Companies';
		ret['attendee_count'] = frm_values.attendee_count;
		ret['balance_due'] = dollarFormat( frm_values.balance_due );
		return ret;
	}

	/**
	* getAgendaParticipantsReportFrmValues
	* This method will return a list string literals for the form
	*/
	public struct function getAgendaParticipantsReportFrmValues() {
		var ret = {};
		var frm_values = getAgendaParticipantsReportParams();
		var agenda_items = getAgendaItemsArray( event_id=frm_values.event_id );
		var agenda_array = [];
		var agenda_cnt = arrayLen( agenda_items );
		var report_type = [ 'Waitlisted Attendees', 'Confirmed Attendees' ];
		for( var i = 1; i <= agenda_cnt; i++ ){
			if( listFindNoCase( frm_values.agenda_id_list, agenda_items[i].agenda_id )){
				arrayAppend( agenda_array, agenda_items[i].label );
			}
		}
		ret[ 'report_type' ] = report_type[ frm_values.report_type + 1 ];
		ret['agenda_items'] = arrayToList( agenda_array, ", ");
		ret[ 'dates' ] = 'All Dates';
		if( len( frm_values.agenda_start_date_from ) && len( frm_values.agenda_start_date_from ) ){
			ret.dates = frm_values.agenda_start_date_from & " to " & frm_values.agenda_start_date_to;
		}
		return ret;
	}
	/**
	* getRegisteredAttendeeReportFrmValues
	* This method will return a list string literals for the form
	*/
	public struct function getRegisteredAttendeeReportFrmValues() {
		var ret = {};
		var frm_values = getRegisteredAttendeeReportParams();
		var registration_types = getRegistrationTypesManager().getRegistrationTypesArray( frm_values.event_id );
		var reg_array = [];
		var reg_cnt = arrayLen( registration_types );
		var balance_dict = {
			'<' : "Show all attendees",
			'>' : "Only show attendees who have a balance due",
			'<=': "Only show attendees who do NOT have a balance due"
		};
		for( var i = 1; i <= reg_cnt; i++ ){
			if( listFindNoCase( frm_values.registration_type_id_list, registration_types[i].registration_type_id )){
				arrayAppend( reg_array, registration_types[i].registration_type );
			}
		}
		ret['registration_types'] = arrayToList( reg_array, ", " );
		ret['account_balance'] = balance_dict[ frm_values.balance_due_operator ];
		ret['balance_due'] = frm_values.balance_due;
		ret[ 'dates' ] = 'All Dates';
		if( len( frm_values.registration_date_from ) && len( frm_values.registration_date_to ) ){
			ret.dates = frm_values.registration_date_from & " to " & frm_values.registration_date_to;
		}
		return ret;
	}

	/**
	* getInvitationStatusReportFrmValues
	* This method will return a list string literals for the form
	*/
	public struct function getInvitationStatusReportFrmValues() {
		var ret = {};
		var frm_values = getInvitationStatusReportParams();
		var invitation_labels = getEmailManagementManager().getInviationEmailLabelsAsArray( event_id=frm_values.event_id );
		var invitation_labels_cnt = arrayLen( invitation_labels );
		ret[ 'invitation_label' ] = "All";
		for( var i = 1; i <= invitation_labels_cnt; i++ ){
			if( invitation_labels[ i ].invitation_id == frm_values.invitation_id ){
				ret[ 'invitation_label' ] = invitation_labels[ i ].label;
			}
		}
		ret[ 'dates' ] = 'All Dates';
		if( len( frm_values.sent_date_from ) && len( frm_values.sent_date_to ) ){
			ret.dates = frm_values.sent_date_from & " to " & frm_values.sent_date_to;
		}
		return ret;
	}
	//---------------------------------------
	//END THE REPORT FORM VALUES GET METHODS
	//---------------------------------------
	//---------------------------------------
	//---------------------------------------
	//START THE REPORT PARAMS GET/SET METHODS
	//---------------------------------------
	/**
	* setReportParams
	* This method will return set the params for reports
	*/
	public void function setReportParams( required struct params ) {
		getSessionManageUserFacade().setValues( params );
		return;
	}
	/**
	* getFinancialTransactionsReportParams
	* This method will return a struct
	*/
	public struct function getRegistrationSummaryReportParams() {
		var persistance = getSessionManageUserFacade();
		var params = {
			'balance_due_operator' : persistance.getValue( 'balance_due_operator' ),
			'event_id' : persistance.getValue( 'event_id' ),
			'balance_due' : persistance.getValue( 'balance_due' ),
			'company' : persistance.getValue( 'company' ),
			'attendee_count_operator' : persistance.getValue( 'attendee_count_operator' ),
			'attendee_count' : persistance.getValue( 'attendee_count' )
		};
		return params;
	}

	/**
	* getFinancialTransactionsReportParams
	* This method will return a struct
	*/
	public struct function getFinancialTransactionsReportParams() {
		var persistance = getSessionManageUserFacade();
		var params = {
			'amount_operator' : persistance.getValue( 'amount_operator' ),
			'event_id' : persistance.getValue( 'event_id' ),
			'detail_date_from' : persistance.getValue( 'detail_date_from' ),
			'detail_date_to' : persistance.getValue( 'detail_date_to' ),
			'amount' : persistance.getValue( 'amount' ),
			'detail_type_id_list' : persistance.getValue( 'detail_type_id_list' ),
			'payment_type_id' : persistance.getValue( 'payment_type_id' ),
			'attendee_id' : persistance.getValue( 'attendee_id' )
		};
		return params;
	}

	/**
	* getRegisteredAttendeeReportParams
	* This method will return a struct
	*/
	public struct function getAgendaParticipantsReportParams() {
		var persistance = getSessionManageUserFacade();
		var params = {
			'report_type' : persistance.getValue( 'report_type' ),
			'agenda_id_list' : persistance.getValue( 'agenda_id_list' ),
			'event_id' : persistance.getValue( 'event_id' ),
			'agenda_start_date_from' : persistance.getValue( 'agenda_start_date_from' ),
			'agenda_start_date_to' : persistance.getValue( 'agenda_start_date_to' ),
			'location_id' : persistance.getValue( 'location_id' ),
			'category_id' : persistance.getValue( 'category_id' )
		};
		return params;
	}
	/**
	* getRegisteredAttendeeReportParams
	* This method will return a struct
	*/
	public struct function getRegisteredAttendeeReportParams() {
		var persistance = getSessionManageUserFacade();
		var params = {
			'balance_due_operator' : persistance.getValue( 'balance_due_operator' ),
			'balance_due' : persistance.getValue( 'balance_due' ),
			'event_id' : persistance.getValue( 'event_id' ),
			'registration_type_id_list' : persistance.getValue( 'registration_type_id_list' ),
			'registration_date_to' : persistance.getValue( 'registration_date_to' ),
			'registration_date_from' : persistance.getValue( 'registration_date_from' )
		};
		return params;
	}
	/**
	* getInvitationStatusReportParams
	* This method will return a struct
	*/
	public struct function getInvitationStatusReportParams() {
		var persistance = getSessionManageUserFacade();
		var params = {
			'company_id' : persistance.getValue( 'company_id' ),
			'invitation_id' : persistance.getValue( 'invitation_id' ),
			'event_id' : persistance.getValue( 'event_id' ),
			'sent_date_from' : persistance.getValue( 'sent_date_from' ),
			'sent_date_to' : persistance.getValue( 'sent_date_to' )
		};
		return params;
	}
	/**
	* getAllFieldsExportReportParams
	* This method will return a struct
	*/
	public struct function getAllFieldsExportReportParams() {
		var persistance = getSessionManageUserFacade();
		var params = {
			'company_id' : persistance.getValue( 'company_id' ),
			'event_id' : persistance.getValue( 'event_id' ),
			'registration_type_id_list' : persistance.getValue( 'registration_type_id_list' ),
			'registration_date_from' : persistance.getValue( 'registration_date_from' ),
			'registration_date_to' : persistance.getValue( 'registration_date_to' )
		};
		return params;
	}
	/**
	* getCouponReportParams
	* This method will return a struct
	*/
	public struct function getCouponReportParams() {
		var persistance = getSessionManageUserFacade();
		var params = {
			'event_id' : persistance.getValue( 'event_id' ),
			'coupon_code_list' : persistance.getValue( 'coupon_code_list' ),
			'coupon_type_list' : persistance.getValue( 'coupon_type_list' )
		};
		return params;
	}
	/**
	* getCouponReportParams
	* This method will return a struct
	*/
	public struct function getHotelReservationsReportParams() {
		var persistance = getSessionManageUserFacade();
		var params = {
			'event_id' : val(persistance.getValue( 'event_id' )),
			'room_type_id' : val( persistance.getValue( 'room_type_id' ) ),
			'hotel_id' : val( persistance.getValue( 'hotel_id' ) ),
			'checkin_date': persistance.getValue('checkin_date')
		};
		return params;
	}
	//---------------------------------------
	//END THE REPORT PARAMS GET/SET METHODS
	//---------------------------------------

}
