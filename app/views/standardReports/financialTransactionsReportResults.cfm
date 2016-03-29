<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'standardReports.default' )#">Standard Reports</a></li>
  <li><a href="#buildURL( 'standardReports.financialTransactionsReport' )#">Financial Transactions List Form</a></li>
  <li class="active">Financial Transactions List Results</li>
</ol>
<div id="action-btns" class="pull-right">
	<a href="#buildURL( 'standardReports.financialTransactionsReportPrintView' )#" target="_blank" class="btn btn-lg btn-default">Print View</a>
	<a href="#buildURL( 'standardReports.financialTransactionsReportExcelView' )#" class="btn btn-lg btn-info">Export to Excel</a>
	<a href="#buildURL( 'standardReports.financialTransactionsReportPDFView' )#" target="_blank" class="btn btn-lg btn-warning">Export to PDF</a>
</div>
<h2 class="page-title color-06">Financial Transactions List Report</h2>

<p><strong>Attendee ID:</strong> #rc.report_frm_values.attendee_id#</p>
<p><strong>Amount:</strong> #rc.report_frm_values.amount#</p>
<p><strong>Payment Type:</strong> #rc.report_frm_values.payment#</p>
<p><strong>Transaction Detail Type:</strong> #rc.report_frm_values.types#</p>
<p><strong>Transaction Date Range:</strong> #rc.report_frm_values.dates#</p>

#view('common/Listing')#
</cfoutput>