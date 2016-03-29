<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'standardReports.default' )#">Standard Reports</a></li>
  <li><a href="#buildURL( 'standardReports.invitationStatusReport' )#">Invitation Status Report Form</a></li>
  <li class="active">Invitation Status Report List Results</li>
</ol>
<div id="action-btns" class="pull-right">
	<a href="#buildURL( 'standardReports.invitationStatusReportPrintView' )#" target="_blank" class="btn btn-lg btn-default">Print View</a>
	<a href="#buildURL( 'standardReports.invitationStatusReportExcelView' )#" class="btn btn-lg btn-info">Export to Excel</a>
	<a href="#buildURL( 'standardReports.invitationStatusReportPDFView' )#" target="_blank" class="btn btn-lg btn-warning">Export to PDF</a>
</div>

<h2 class="page-title color-06">Invitation Status Report</h2>
<p><strong>Invitation Label:</strong> #rc.report_frm_values.invitation_label#</p>
<p><strong>Invitation Date Range:</strong> #rc.report_frm_values.dates#</p>

#view('common/Listing')#
</cfoutput>
