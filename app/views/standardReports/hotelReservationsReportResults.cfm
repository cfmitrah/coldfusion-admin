<cfoutput>
<ol class="breadcrumb">
  <li><a href="/">Dashboard</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'standardReports.default' )#">Standard Reports</a></li>
  <li><a href="#buildURL( 'standardReports.hotelReservationsReport' )#">Hotel Reservations Report Form</a></li>
  <li class="active">Hotel Reservations Report List Results</li>
</ol>
<div id="action-btns" class="pull-right">
	<a href="#buildURL( 'standardReports.hotelReservationsReportPrintView' )#" target="_blank" class="btn btn-lg btn-default">Print View</a>
	<a href="#buildURL( 'standardReports.hotelReservationsReportExcelView' )#" class="btn btn-lg btn-info">Export to Excel</a>
	<a href="#buildURL( 'standardReports.hotelReservationsReportPDFView' )#" target="_blank" class="btn btn-lg btn-warning">Export to PDF</a>
</div>
<h2 class="page-title color-06">Hotel Reservations Report</h2>
#view('common/Listing')#
</cfoutput>
