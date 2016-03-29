/**
*
* @file  /controllers/CustomReports.cfc
* @author - JG
* @description - This will control all things Custom Reports.
*
*/
component extends="$base" accessors="true"{
	property name="CustomReportsManager" setter="true" getter="true";
	property name="config" setter="true" getter="true";
	/**
	* before
	* This method will be executed before running any agenda controller methods
	*/
	public void function before( rc ) {
		//we need to make sure we do in fact have a company ID		
		if( ! getCurrentCompanyID() ){
			redirect('company.select');
		}
		if( !getCurrentEventID() ){
			redirect('event.select');
		}
		rc.sidebar = "sidebar.event.details";
		super.before( rc );
		return;
	}
	//START PAGE VIEWS
	/**
	* Default 		
	* This method will render main report view
	**/
	public void function default( rc ) {
		var modal_config = {
			'ajax_delete_report_url' : buildURL( "customReports.ajaxDeleteReport" ),
			'run_custom_report_url' : buildURL( "customReports.run" )
		};
		var event_id = getCurrentEventId();
		rc['custom_report_list'] = getCustomReportsManager().getCustomReportList( event_id=event_id );
		rc['custom_report_list_cnt'] = arrayLen( rc.custom_report_list );
		getCfStatic( modal_config ).includeData( modal_config )
			.include( "/js/pages/customReports/general.js" );
		return;
	}
	/**
	* create 		
	* This method will render create custom report view
	**/
	public void function create( rc ) {
		var event_id = getCurrentEventId();
		var attendee_types = getCustomReportsManager().getAttendeeTypesAsStruct( event_id=event_id );
		var attendee_statuses = getCustomReportsManager().getAttendeeStatusesAsStruct();
		var fields = getCustomReportsManager().getRegistrationFieldsAsStruct( event_id=event_id );
		var agendas = getCustomReportsManager().getAgendasAsStruct( event_id=event_id );
		var payment_processors = getCustomReportsManager().getPaymentProcessorsAsStruct();
		//set the options list below
		rc['attendee_types_opts'] = getFormUtilities().buildOptionList(
			values = attendee_types.registration_type_id,
			display = attendee_types.registration_type
		);
		rc['attendee_statuses_opts'] = getFormUtilities().buildOptionList(
			values = attendee_statuses.attendee_status,
			display = attendee_statuses.attendee_status
		);
		rc['registration_field_opts'] = getFormUtilities().buildOptionList(
			values = fields.field_name,
			display = fields.label
		);
		rc['agenda_grouped_opts' ] = getFormUtilities().buildGroupOptionList(
			recordset = agendas,
			group = "start_date",
			display = "name",
			value = "agenda_id"
		);
		rc['payment_processors_opts'] = getFormUtilities().buildOptionList(
			values = payment_processors.processor_id,
			display = payment_processors.processor_name
		);
		//set the event id
		rc['event_id'] = event_id;
		getCfStatic()
		.includeData( {'standard_fields':"",'standard_fields_array':[] } )
			.include( "/css/pages/customReports/general.css" )
			.include( "/js/pages/customReports/general.js" )
			.include("/js/pages/emailManagement/validate.js")
			.include( "/js/plugins/jquery.multi-select.js" )
			.include( "/css/plugins/multiselect.css");
		return;
	}
	/**
	* run 		
	* This method will trigger the running of the custom report selected
	**/
	public void function run( rc ) {
		if( structKeyExists( rc, "custom_report_id") && isNumeric( rc.custom_report_id ) ){
			report = getCustomReportsManager().runReport( custom_report_id=rc.custom_report_id );
			rc['report_headers'] = report.headers;
			rc['report_headers_cnt'] = arrayLen( report.headers );
			rc['report_columns'] = report.columns;
			rc['report_columns_cnt'] = arrayLen( report.columns );
			rc['report_results'] = report.results;
			rc['report_results_cnt'] = arrayLen( report.results );
			rc['report_params'] = report.params;
			rc['fn_set_headers'] = getCustomReportsManager().getFnHeaderSetter();
			rc['fn_set_columns'] = getCustomReportsManager().getFnBodySetter();
			rc['labels'] = report.labels;
			rc[ 'selected_agenda_ids' ] = report.selected_agenda_ids;
			return;	
		}
		redirect("customReports.default");
		return;	
	}
	/**
	* edit 		
	* This method will trigger the editing of the custom report selected
	**/
	public void function edit( rc ) {
		if( structKeyExists( rc, "custom_report_id") && isNumeric( rc.custom_report_id ) ){
			var event_id = getCurrentEventId();
			var attendee_types = getCustomReportsManager().getAttendeeTypesAsStruct( event_id=event_id );
			var attendee_statuses = getCustomReportsManager().getAttendeeStatusesAsStruct();
			var fields = getCustomReportsManager().getRegistrationFieldsAsStruct( event_id=event_id );
			var agendas = getCustomReportsManager().getAgendasAsStruct( event_id=event_id );
			var payment_processors = getCustomReportsManager().getPaymentProcessorsAsStruct();
			var report_params = getCustomReportsManager().getCustomReportParameters( custom_report_id=rc.custom_report_id ).proc_vars;
			//set the options list below
			rc['attendee_types_opts'] = getFormUtilities().buildOptionList(
				values = attendee_types.registration_type_id,
				display = attendee_types.registration_type,
				selected = report_params.attendee_types
			);
			rc['attendee_statuses_opts'] = getFormUtilities().buildOptionList(
				values = attendee_statuses.attendee_status,
				display = attendee_statuses.attendee_status,
				selected = report_params.attendee_statuses
			);
			rc['registration_field_opts'] = getFormUtilities().buildOptionList(
				values = fields.field_name,
				display = fields.label
				//,selected = report_params.fields
			);
			rc['agenda_grouped_opts' ] = getFormUtilities().buildGroupOptionList(
				recordset = agendas,
				group = "start_date",
				display = "name",
				value = "agenda_id",
				selected = report_params.agendas
			);
			rc['payment_processors_opts'] = getFormUtilities().buildOptionList(
				values = payment_processors.processor_id,
				display = payment_processors.processor_name,
				selected = report_params.payment_processors

			);
			rc['balance_due_opts'] = getFormUtilities().buildOptionList(
				values = [ '', '<', '>', '=' ],
				display = [ '', 'Greater Than', 'Less Than', 'Equal To' ],
				selected = report_params.balance_due_operator
			);
			rc['field_opts' ] = getCustomReportsManager().getRegistrationFieldsAsArray( event_id=event_id );

			//set the event id
			rc['event_id'] = event_id;
			//get tbe report params
			rc['report_params'] = report_params;
			rc['report_standard_fields'] = report_params.fields;
			getCfStatic()
				.includeData( {'standard_fields':report_params.fields,'standard_fields_array':listToArray(report_params.fields)} )
				.include( "/css/pages/customReports/general.css" )
				.include( "/js/pages/customReports/general.js" )
				.include("/js/pages/emailManagement/validate.js")
				.include( "/js/plugins/jquery.multi-select.js" )
				.include( "/css/plugins/multiselect.css");
			return;	
		}
		redirect("customReports.default");
	}
	/**
	* reportPrintView 		
	* This method will export the report to a print view
	**/
	public void function reportPrintView( rc ) {
		if( structKeyExists( rc, "custom_report_id") && isNumeric( rc.custom_report_id ) ){
			report = getCustomReportsManager().runReport( custom_report_id=rc.custom_report_id );
			rc['report_headers'] = report.headers;
			rc['report_headers_cnt'] = arrayLen( report.headers );
			rc['report_columns'] = report.columns;
			rc['report_columns_cnt'] = arrayLen( report.columns );
			rc['report_results'] = report.results;
			rc['report_results_cnt'] = arrayLen( report.results );
			rc['report_params'] = report.params;
			rc['fn_set_headers'] = getCustomReportsManager().getFnHeaderSetter();
			rc['fn_set_columns'] = getCustomReportsManager().getFnBodySetter();
			rc['labels'] = report.labels;
			rc[ 'selected_agenda_ids' ] = report.selected_agenda_ids;
			return;	
		}
		redirect("customReports.default");
	}
	/**
	* reportExcelView 		
	* This method will export the report to excel
	**/
	public void function reportExcelView( rc ) {
		if( structKeyExists( rc, "custom_report_id") && isNumeric( rc.custom_report_id ) ){
			rc['filename'] = getCustomReportsManager().createCustomReportXLS( custom_report_id=rc.custom_report_id );
			location( getConfig().urls.wysiwyg_media & rc.filename, false );
			return;	
		}
		redirect("customReports.default");
	}
	/**
	* reportPDFView 		
	* This method will export the report to pdf view. 
	**/
	public void function reportPDFView( rc ) {
		if( structKeyExists( rc, "custom_report_id") && isNumeric( rc.custom_report_id ) ){
			report = getCustomReportsManager().runReport( custom_report_id=rc.custom_report_id );
			rc['report_headers'] = report.headers;
			rc['report_headers_cnt'] = arrayLen( report.headers );
			rc['report_columns'] = report.columns;
			rc['report_columns_cnt'] = arrayLen( report.columns );
			rc['report_results'] = report.results;
			rc['report_results_cnt'] = arrayLen( report.results );
			rc['report_params'] = report.params;
			rc['fn_set_headers'] = getCustomReportsManager().getFnHeaderSetter();
			rc['fn_set_columns'] = getCustomReportsManager().getFnBodySetter();
			rc['labels'] = report.labels;
			rc[ 'selected_agenda_ids' ] = report.selected_agenda_ids;
			return;	
		}
		redirect("customReports.default");
	}
	//END PAGE VIEWS
	//START PAGE PROCESSING
	public void function doSave(){
		var custom_report_id = 0;
		if( structKeyExists( rc, "report") && isStruct( rc.report ) ){
//			writedump( rc.report );abort;
			custom_report_id = getCustomReportsManager().saveReport( argumentCollection=rc.report );
			redirect( action="customReports.run?custom_report_id=" & custom_report_id );
		}
		redirect("customReports.create");
		return;
	}
	//END PAGE PROCESSING
	//START AJAX ACTIONS
	public void function ajaxDeleteReport() {
		request.layout = false;
		getCustomReportsManager().deleteCustomReport( custom_report_id=rc.custom_report_id );
		getFW().renderData( "json", {
			"success": true
		} );
		return;
	}
	//END AJAX ACTIONS

	public string function test(){
		return 'hi';
	}
}