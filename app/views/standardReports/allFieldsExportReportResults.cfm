<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'standardReports.default' )#">Standard Reports</a></li>
  <li><a href="#buildURL( 'standardReports.allFieldsExportReport' )#">All Fields Export  Report Form</a></li>
  <li class="active">All Fields Export Report List Results</li>
</ol>
<div id="action-btns" class="pull-right">
	<a href="#buildURL( 'standardReports.allFieldsExportReportPrintView' )#" target="_blank" class="btn btn-lg btn-default">Print View</a>
	<a href="#buildURL( 'standardReports.getCustomFieldsReport' )#" class="btn btn-lg btn-info">Export to Excel</a>
	<a href="#buildURL( 'standardReports.allFieldsExportReportPDFView' )#" target="_blank" class="btn btn-lg btn-warning">Export to PDF</a>
</div>

<h2 class="page-title color-06">All Fields Export Report</h2>
<p><strong>Report Date Range:</strong> #rc.report.registration_date_from# - #rc.report.registration_date_to#</p>

<table id="report_listing" class="table table-striped table-hover data-table tm-large dataTable no-footer" role="grid" aria-describedby="report_listing_info">
	<thead>
		<tr role="row">
			<cfloop from="1" to="#rc.report_data.header_cnt#" index="local.i">
				<cfset local.header_label = rc.report_data.formatted_headers[ local.i ] />
				<th rowspan="1" colspan="1">#local.header_label#</th>
			</cfloop>
		</tr>	
	</thead>
	<tbody>
		<cfloop from="1" to="#rc.report_data.report_data_cnt#" index="local.i">
			<tr>
				<cfloop from="1" to="#rc.report_data.header_cnt#" index="local.k">
					<td>
						<cfif listFindNocase( "hotel_checkin_date,hotel_checkout_date", rc.report_data.headers[ local.k ] )>
							#dateformat( rc.report_data.report_data[ local.i ][ rc.report_data.headers[ local.k ] ], "mm/dd/yyyy" )#
						<cfelse>
							#rc.report_data.report_data[ local.i ][ rc.report_data.headers[ local.k ] ]#		
						</cfif>
					</td>
				</cfloop>
			</tr>	
		</cfloop>
	</tbody>
</table>
</cfoutput>