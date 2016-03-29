<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'standardReports.default' )#">Standard Reports</a></li>
  <li><a href="#buildURL( 'standardReports.registrationSummaryReport' )#">Registration Fees List Form</a></li>
  <li class="active">Registration Fees List Results</li>
</ol>
<div id="action-btns" class="pull-right">
	<a href="#buildURL( 'standardReports.registrationSummaryReportPrintView' )#" target="_blank" class="btn btn-lg btn-default">Print View</a>
	<a href="#buildURL( 'standardReports.registrationSummaryReportExcelView' )#" class="btn btn-lg btn-info">Export to Excel</a>
	<a href="#buildURL( 'standardReports.registrationSummaryReportPDFView' )#" target="_blank" class="btn btn-lg btn-warning">Export to PDF</a>
</div>

<h2 class="page-title color-06">Registration Fees List Report</h2>
<p><strong>Companies:</strong> #rc.report_frm_values.companies#</p>
<p><strong>Balance Due:</strong> #rc.report_frm_values.balance_due#</p>
<p><strong>Attendee Count:</strong> #rc.report_frm_values.attendee_count#</p>

#view('common/Listing')#
</cfoutput>