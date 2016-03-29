/**
*
* @file  /model/managers/ScheduledReports.cfc
* @author
* @description
*
*/
component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="EmailDao" getter="true" setter="true";
	property name="EmailManager" getter="true" setter="true";
	property name="StandardReportManager" getter="true" setter="true";
	property name="customReportsManager" getter="true" setter="true";
	property name="ScheduledReportDao" getter="true" setter="true";
	property name="SpreadSheetUtilities" setter="true" getter="true";
	property name="config" setter="true" getter="true";
	property name="ReportDao" getter="true" setter="true";
	property name="mailer" setter="true" getter="true";
	/**
	* sendScheduledReports
	* This method will generate all relative data and send out the reports as emails
	*/
	public void function sendScheduledReports( string send_date ){
		
		
		
		
		var scheduled_reports = queryToArray( getScheduledReportDao().ReportsToSend( schedule_date=arguments.send_date ).result.report );
		var email_template = getConfig().paths.emails & 'email.notification.cfm';
		var scheduled_reports_cnt = arrayLen( scheduled_reports );
		var do_not_include = [ "lauren.e.bidlack@pepsico.com", "carly@fuelleadership.com" ];



		for( var i=1; i<=scheduled_reports_cnt; i++ ){
			try{
				//verify the emails and json string are ok
				if( ! arrayFindNoCase( do_not_include, scheduled_reports[ i ].to_email ) && isValid( "email", scheduled_reports[ i ].from_email ) && isJSON( scheduled_reports[ i ].report_settings ) ){

					//setup report vars
					var report_params = deserializeJSON( scheduled_reports[ i ].report_settings );
					var fn_report = getReportFn( scheduled_reports[ i ].report );
					var report_xls_url = fn_report( report_params );
					var body = getReportEmailBody( subject=scheduled_reports[ i ].subject,report_url=report_xls_url );
			        var mail_body = "";
					
					//set the body
			        savecontent variable="mail_body"{ 
						include email_template;
			        };

					//send out the email
					getEmailManager().sendGeneralEmail(argumentCollection={
						'to_email' : scheduled_reports[ i ].to_email,
						'subject' : "Event: " & scheduled_reports[ i ].name & " - Scheduled Report: " & scheduled_reports[ i ].subject,
						'from_email' : scheduled_reports[ i ].from_email,
						'body' : mail_body
					});	

				}else{
					getEmailManager().sendErrorEmail(subject="Scheduled Report Error: Parameter Validation Error", error_data=scheduled_reports[ i ] );				
				}
				//temp
				//also removed BCC from mailer
				if( arrayFindNoCase( do_not_include, scheduled_reports[ i ].to_email )  ){
					//send out an error email
					getEmailManager().sendErrorEmail(subject="Scheduled Report Failure: email was sent to " & scheduled_reports[ i ].to_email, error_data = { email:scheduled_reports[ i ].to_email }, data = scheduled_reports[ i ] );
				}
			}catch( any e ){
				//send out an error email
				getEmailManager().sendErrorEmail(subject="Scheduled Report Failure", error_data = e, data = scheduled_reports[ i ] );
			}
		}
		return;
	}
	/**
	* getReportEmailBody
	* This method will get the report email body
	*/
	private string function getReportEmailBody( required string subject, required string report_url ){
		var body = "<h2>Scheduled Report: " & arguments.subject & "</h2>";
		body &= "<p>Here is a link to the XLS of this report: " & arguments.report_url & " (copy and paste in browser) or <a href=""" & arguments.report_url & """>Download Report Here</a></p>";
		return body;
	}	
	/**
	* getInviteStatusReport
	* This method will get the report data as xls
	*/
	private string function getInviteStatusReport( required struct report_params ){
		var report = getReportDao().InvitationStatusReport( argumentCollection=arguments.report_params ).result.report;
		var columns = [ "company_name", "first_name", "last_name", "email", "viewed", "registered", "event_name", "invitation_label", "sent_date" ];
		return getConfig().urls.wysiwyg_media & getSpreadSheetUtilities().createSimpleSpreadSheet( report, getConfig().paths.media, columns );
	}
	/**
	* getRegistrationFeesReport
	* This method will get the report data as xls
	*/
	private string function getRegistrationFeesReport( required struct report_params ){
		var report = getReportDao().RegistrationSummaryReport( argumentCollection=arguments.report_params ).result.report;
		var columns = [ "company", "fees_amount", "attendees_count", "balance_due" ];
		return getConfig().urls.wysiwyg_media & getSpreadSheetUtilities().createSimpleSpreadSheet( report, getConfig().paths.media, columns );
	}
	/**
	* getRegistrationFieldsReport
	* This method will get the report data as xls
	*/
	private string function getRegistrationFieldsReport( required struct report_params ){
		var params = arguments.report_params;
		if( ! len( params.registration_date_to) || ! len( params.registration_date_from ) ){
			structDelete( params, "registration_date_to" );
			structDelete( params, "registration_date_from" );
		}else{
			params.registration_date_to = dateFormat( params.registration_date_to, "MM/DD/YYYY" );
			params.registration_date_from = dateFormat( params.registration_date_from, "MM/DD/YYYY" );
		}		
		var report = getReportDao().AttendeeRegistrationsReport( argumentCollection=arguments.report_params ).result.report;
		var columns = [ "attendee_status", "balance_due", "company", "first_name", "last_name", "registration_timestamp", "registration_type", "total_charges" ];
		return getConfig().urls.wysiwyg_media & getSpreadSheetUtilities().createSimpleSpreadSheet( report, getConfig().paths.media, columns );
	}
	/**
	* getParticipantsReport
	* This method will get the report data as xls
	*/
	private string function getParticipantsReport( required struct report_params ){
		var params = arguments.report_params;
		if( ! len( params.agenda_start_date_from) || ! len( params.agenda_start_date_to ) ){
			structDelete( params, "agenda_start_date_to" );
			structDelete( params, "agenda_start_date_from" );
		}else{
			params.agenda_start_date_to = dateFormat( params.agenda_start_date_to, "MM/DD/YYYY" );
			params.agenda_start_date_from = dateFormat( params.agenda_start_date_from, "MM/DD/YYYY" );
		}		
		if( params.report_type ){
			var report = getReportDao().AgendaAttendeesReport( argumentCollection=params ).result.report;			
		}else{
			var report = getReportDao().AgendaAttendeesWaitlistReport( argumentCollection=params ).result.report;			
		}	
		var columns = [ "label", "title", "attendee_status", "company", "first_name", "last_name", "registration_timestamp", "registration_type", "location_name", "category" ];
		return getConfig().urls.wysiwyg_media & getSpreadSheetUtilities().createSimpleSpreadSheet( report, getConfig().paths.media, columns );
	}
	/**
	* getFinancialReport
	* This method will get the report data as xls
	*/
	private string function getCouponsReport( required struct report_params ){
		var report = getReportDao().CouponAttendeesReport( argumentCollection=arguments.report_params ).result.report;
		var columns = [ "first_name", "last_name", "coupon_code", "amount", "total_due_before_coupon", "total_due_after_coupon" ];
		return getConfig().urls.wysiwyg_media & getSpreadSheetUtilities().createSimpleSpreadSheet( report, getConfig().paths.media, columns );
	}
	/**
	* getFinancialReport
	* This method will get the report data as xls
	*/
	private string function getFinancialReport( required struct report_params ){
		var report = getReportDao().RegistrationDetailsReport( argumentCollection=arguments.report_params ).result.report;
		var columns = [ "company", "fees_amount", "attendees_count", "balance_due" ];
		return getConfig().urls.wysiwyg_media & getSpreadSheetUtilities().createSimpleSpreadSheet( report, getConfig().paths.media, columns );
	}
	/**
	* getAllFieldsReport
	* This method will get the report data as xls
	*/
	private string function getAllFieldsReport( required struct report_params ){
		var report = getStandardReportManager().createCustomFieldsReportQuery( argumentCollection=arguments.report_params );
		var columns = report.headers;
		return getConfig().urls.wysiwyg_media & getSpreadSheetUtilities().createSimpleSpreadSheet( report.query, getConfig().paths.media, columns );
	}
	/**
	* getAllFieldsReport
	* This method will get the report data as xls
	*/
	private string function getCustomReport( required struct report_params ){
		var filename = getCustomReportsManager().createCustomReportXLS( argumentCollection=arguments.report_params );
		return getConfig().urls.wysiwyg_media & filename;
	}
	/**
	* getStandardReportFn
	* This method will return the correct method to generate the report
	*/
	private any function getReportFn( required string report_name ){
		var report_names = {
			'agenda_participants' : getParticipantsReport,
			'all_fields' : getAllFieldsReport,
			'financial_transactions' : getFinancialReport,
			'invitation_status' : getInviteStatusReport,
			'registration_list' : getRegistrationFieldsReport,
			'registration_fees' : getRegistrationFeesReport,
			'custom_report' : getCustomReport,
			'coupons' : getCouponsReport
		};
		return report_names[ arguments.report_name ];
	}
	/**
	* getScheduledReport
	* This method will get thescheduled report data
	*/
	public struct function getScheduledReport( required numeric event_id, required numeric report_schedule_id ){
		var report = getScheduledReportDao().ReportScheduleGet( argumentCollection=arguments );
		report.from_email = getScheduledReportDao().emailGet( email_id=report.from_email_id ).result.email;
		report.begin_on = dateFormat( report.begin_on, "mm/dd/yyyy" );
		report.end_on = dateFormat( report.end_on, "mm/dd/yyyy" );
		return report;
	}
	/**
	* getScheduledReports
	* This method will get all schedule reports
	*/
	public array function getScheduledReports( required numeric event_id ){
		return queryToArray( getScheduledReportDao().ReportSchedulesGet( argumentCollection=arguments ).result.report );
	}
	/**
	* updateScheduledReport
	* This method will update the scheduled reports
	*/
	public void function updateScheduledReport( 
		required numeric report_schedule_id,
		required numeric event_id,
		required string frequency,
		required string begin_on,
		required string end_on,
		required string from_email,
		required string to_email,
		required string subject,
		numeric day=0
	){
		var params = arguments;
		params[ 'from_email_id' ] = getScheduledReportDao().emailSet( email_type="default", email=params.from_email, opt_out=0 );
		params[ 'to_email' ] = params.to_email;
		structDelete( params, "from_email" );
		getScheduledReportDao().ReportScheduleSet( argumentCollection=params );
		return;
	}
	/**
	* saveScheduledReport
	* This method will save the scheduled report
	*/
	public void function saveScheduledReport( required string report_params, required string scheduled_params ){
		var params = deserializeJSON( arguments.scheduled_params );
		var report = deserializeJSON( arguments.report_params );
		var data = {
			'event_id' : report.event_id,
			'from_email_id' : getScheduledReportDao().emailSet( email_type="default", email=params.from_email, opt_out=0 ),
			'to_email' : params.to_email,
			'subject' : params.scheduled_subject,
			'report' : params.report,
			'report_settings' : arguments.report_params,
			'begin_on' : params.scheduled_startdate,
			'end_on' : params.scheduled_enddate,
			'frequency' : params.scheduled_frequency,
			'day' : params['day-picker']
		};
		getScheduledReportDao().ReportScheduleSet( argumentCollection=data );
		return;
	}
	/**
	* saveCustomScheduledReport
	* This method will save the scheduled report
	*/
	public void function saveCustomScheduledReport(
		numeric report_schedule_id=0,
		required numeric custom_report_id,
		required numeric event_id,
		required string frequency,
		required string begin_on,
		required string end_on,
		required string from_email,
		required string to_email,
		required string subject,
		numeric day=0
	){
		var params = arguments;
		var report = {};
		report[ 'custom_report_id' ] = params.custom_report_id; 
		var data = {
			'event_id' : params.event_id,
			'from_email_id' : getScheduledReportDao().emailSet( email_type="default", email=params.from_email, opt_out=0 ),
			'to_email' : params.to_email,
			'subject' : params.subject,
			'report' : "custom_report",
			'report_settings' : serializeJSON( report ),
			'begin_on' : params.begin_on,
			'end_on' : params.end_on,
			'frequency' : params.frequency,
			'day' : params.day
		};
		getScheduledReportDao().ReportScheduleSet( argumentCollection=data );
		return;
	}

}
