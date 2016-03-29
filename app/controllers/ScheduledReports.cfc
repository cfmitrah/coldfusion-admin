component extends="$base" accessors="true" {
	property name="ScheduledReportsManager" setter="true" getter="true";
	property name="CustomReportsManager" setter="true" getter="true";
	property name="ScheduledReportDao" getter="true" setter="true";
	property name="config" setter="true" getter="true";
	/**
	* before
	* This method will be executed before running any agenda controller methods
	*/
	public void function before( rc ) {
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
	* default
	* - This method the default rendering of the table list
	*/
	public void function default( rc ){
		var config = {
			'edit_report_url' : buildURL( "ScheduledReports.ajaxGetReport" ),
			'delete_report_url' : buildURL( "ScheduledReports.ajaxDeleteReport" ),
			'get_custom_reports' : buildURL( "ScheduledReports.ajaxGetCustomReports" )
		};
		rc[ 'report' ] = getScheduledReportsManager().getScheduledReports( event_id=rc.event_id );
		rc[ 'report_cnt' ] = arrayLen( rc.report );
		getCfStatic()
			.includeData( config )		
			.include( "/js/pages/reports/schedules.js" );
		return;
	}
	//END PAGE VIEWS
	//START PAGE PROCESSING
	/**
	* doSaveSchedule
	* - This method will save the editing of the schedule
	*/
	public void function doSaveSchedule( rc ){
		if( structKeyExists( rc, "report") && isStruct( rc.report ) ){
			getScheduledReportsManager().updateScheduledReport( argumentCollection=rc.report );
			addSuccessAlert( 'The report schedule was updated.' );
			redirect( action="scheduledReports.default" );
		}
		redirect("scheduledReports.default");
	}
	/**
	* doSaveCustomSchedule
	* - This method will save the editing of the schedule
	*/
	public void function doSaveCustomSchedule( rc ){
		if( structKeyExists( rc, "report") && isStruct( rc.report ) ){
			getScheduledReportsManager().saveCustomScheduledReport( argumentCollection=rc.report );
			addSuccessAlert( 'The report schedule was updated.' );
			redirect( action="scheduledReports.default" );
		}
		redirect("scheduledReports.default");

	}
	//END PAGE PROCESSING
	//START PAGE AJAX
	/**
	* ajaxGetReport
	* - This method will get the scheduled report data
	*/
	public void function ajaxGetReport( rc ){
		request.layout = false;
		var report = getScheduledReportsManager().getScheduledReport( argumentCollection=rc );
		getFW().renderData( "json", {
			"report": report
		} );
	}
	/**
	* ajaxDeleteReport
	* - This method will delete the report
	*/
	public void function ajaxDeleteReport( rc ){
		
	}
	/**
	* ajaxDoSaveSchedule
	* - This method save a schedule
	*/
	public void function ajaxDoSaveSchedule( rc ) {
		request.layout = false;
		getScheduledReportsManager().saveScheduledReport( report_params=rc.report_params, scheduled_params=rc.scheduled_params );
		getFW().renderData( "json", {
			"success": true
		} );
		return;
	}
	/**
	* ajaxGetCustomReports
	* - This method get all custom reports label/id
	*/
	public void function ajaxGetCustomReports( rc ){
		request.layout = false;
		var custom_reports = getCustomReportsManager().getCustomReportList( event_id=rc.event_id ); 
		getFW().renderData( "json", {
			"reports": serializeJSON( custom_reports )
		} );
		return;
	}
	//END PAGE AJAX	
}