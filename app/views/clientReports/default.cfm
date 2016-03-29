<cfoutput>
<h3 class="form-section-title mt-large">Client Reporting</h3>
<table id="" class="table table-striped table-hover data-table tm-large" >
	<thead>
	<tr>
		<th>Report Name</th>
		<th>Actions</th>
	</tr>
	</thead>
	<tbody>
		<cfloop from="1" to="#rc.reports.list_cnt#" index="local.i">
			<tr>
				<td>#rc.reports.list[ local.i ].label#</td>
				<td><a href="#buildURL( "clientReports.downloadReport?client_report_id=" & rc.reports.list[ local.i ].client_report_id )#" class="btn btn-sm btn-primary">Download</a></td>
			</tr>	
		</cfloop>
	</tbody>
</table>
</cfoutput>