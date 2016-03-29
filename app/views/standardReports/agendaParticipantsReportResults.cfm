<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'standardReports.default' )#">Standard Reports</a></li>
  <li><a href="#buildURL( 'standardReports.agendaParticipantsReport' )#">Agenda Participants List Form</a></li>
  <li class="active">Agenda Participants List Results</li>
</ol>
<div id="action-btns" class="pull-right">
	<a href="#buildURL( 'standardReports.agendaParticipantsReportPrintView' )#" target="_blank" class="btn btn-lg btn-default">Print View</a>
	<a href="#buildURL( 'standardReports.agendaParticipantsReportExcelView' )#" class="btn btn-lg btn-info">Export to Excel</a>
	<a href="#buildURL( 'standardReports.agendaParticipantsReportPDFView' )#" target="_blank" class="btn btn-lg btn-warning">Export to PDF</a>
</div>

<h2 class="page-title color-06">Agenda Participants List Report</h2>


<p><strong>Report Type:</strong> #rc.report_frm_values.report_type#</p>
<p><strong>Agenda Items:</strong> #rc.report_frm_values.agenda_items#</p>
<p><strong>Registration Date Range:</strong> #rc.report_frm_values.dates#</p>


#view('common/Listing')#
</cfoutput>