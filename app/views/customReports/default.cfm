<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li class="active">Custom Reports</li>
</ol>
<div id="action-btns" class="pull-right">
	<a href="#buildURL( 'customReports.create' )#" class="btn btn-lg btn-info">New Custom Report</a>
</div>

<h2 class="page-title color-01">Custom Reporting</h2>
<p class="page-subtitle">Choose to run an existing report again or create a new one by clicking the button above.</p>
<div class="basic-wrap">
	<h3 class="form-section-title">Previous Custom Reports</h3>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Report Name</th>
				<th>Date Created</th>
				<th>Date Range</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>
			<cfloop from="1" to="#rc.custom_report_list_cnt#" index="local.i">
			<tr data-custom_report_id="#rc.custom_report_list[local.i].custom_report_id#">
				<td>#rc.custom_report_list[local.i].label#</td>
				<td>#dateFormat( rc.custom_report_list[local.i].created, "mm/dd/yyyy" )#</td>
				<td>#dateFormat( rc.custom_report_list[local.i].range_from, 'mm/dd/yyyy' )# - #dateFormat( rc.custom_report_list[local.i].range_to, 'mm/dd/yyyy' )#</td>
				<td>
					<a href="#buildURL( 'customReports.edit?custom_report_id=' & rc.custom_report_list[local.i].custom_report_id )#" class="btn btn-primary btn-sm" style="width: 80px;">Edit</a>
					<a href="" data-custom_report_id="#rc.custom_report_list[local.i].custom_report_id#" class="btn btn-info btn-sm run-report-modal" style="width: 80px;">Run</a>
					<a href="" data-custom_report_id="#rc.custom_report_list[local.i].custom_report_id#" class="btn btn-danger btn-sm delete-report-modal" style="width: 80px;">Delete</a>
				</td>
			</tr>
			</cfloop>
		</tbody>
	</table>
</div>
<!--//START INCLUDES OF MODALS //-->
<cfinclude template="_inc/modal.run_report.cfm" />
<cfinclude template="_inc/modal.delete_report.cfm" />
<!--//EMD INCLUDES OF MODALS //-->

</cfoutput>