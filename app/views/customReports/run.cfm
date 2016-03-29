<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'customReports.default' )#">Custom Reports</a></li>
  <li class="active">Run Custom Report #rc.report_params.label#</li>
</ol>

<div id="action-btns" class="pull-right">
	<a href="#buildURL( 'customReports.reportPrintView?custom_report_id=' & rc.custom_report_id )#" target="_blank" class="btn btn-lg btn-default">Print View</a>
	<a href="#buildURL( 'customReports.reportExcelView?custom_report_id=' & rc.custom_report_id )#" class="btn btn-lg btn-info">Export to Excel</a>
	<a href="#buildURL( 'customReports.reportPDFView?custom_report_id=' & rc.custom_report_id )#" target="_blank" class="btn btn-lg btn-warning">Export to PDF</a>
</div>
<h2 class="page-title color-01">Custom Reporting</h2>
<p class="page-subtitle">Below you will find the custom report results for #rc.report_params.label#</p>
<div class="basic-wrap" style="overflow: auto;">
	<div id="report_listing_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">

		<div class="row">
			<div class="col-xs-6">&nbsp;</div>
			<div class="col-xs-6">&nbsp;</div>
		</div>	
		<table class="table table-striped table-hover data-table tm-large dataTable no-footer" role="grid">
			
			<thead>
				<tr>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Email</th>
					<cfloop from="1" to="#rc.report_headers_cnt#" index="local.i">
						<th>#rc.fn_set_headers( rc.report_headers[ local.i ], rc.labels, rc.selected_agenda_ids )#</th>
					</cfloop>	
				</tr>
			</thead>
			<tbody>
				<cfloop from="1" to="#rc.report_results_cnt#" index="local.k">
					<tr>
						<td>#rc.report_results[ local.k ][ 'first_name' ]#</td>
						<td>#rc.report_results[ local.k ][ 'last_name' ]#</td>
						<td>#rc.report_results[ local.k ][ 'email' ]#</td>
						<cfloop from="1" to="#rc.report_columns_cnt#" index="local.j">
							<td>#rc.fn_set_columns( rc.report_results[ local.k ][ rc.report_columns[ local.j ] ], rc.report_columns[ local.j ] )#</td>
						</cfloop>
					</tr>	
				</cfloop>	
			</tbody>
		</table>
	</div>	
</div>
</cfoutput>

