<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'standardReports.default' )#">Standard Reports</a></li>
  <li><a href="#buildURL( 'standardReports.registeredAttendeesReport' )#">Registration List Form</a></li>
  <li class="active">Registration List Results</li>
</ol>
<div id="action-btns" class="pull-right">
	<a href="#buildURL( 'standardReports.registeredAttendeesReportPrintView' )#" target="_blank" class="btn btn-lg btn-default">Print View</a>
	<a href="#buildURL( 'standardReports.registeredAttendeesReportExcelView' )#" class="btn btn-lg btn-info">Export to Excel</a>
	<a href="#buildURL( 'standardReports.registeredAttendeesReportPDFView' )#" target="_blank" class="btn btn-lg btn-warning">Export to PDF</a>
</div>

<h2 class="page-title color-06">Registration List Report</h2>

<p><strong>Registration Types included:</strong> #rc.report_frm_values.registration_types#</p>
<p><strong>Account Balance Preferences:</strong> #rc.report_frm_values.account_balance#</p>
<p><strong>Registration Date Range:</strong> #rc.report_frm_values.dates#</p>

#view('common/Listing')#
</cfoutput>
