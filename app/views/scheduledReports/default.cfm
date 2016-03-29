<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'standardReports.default' )#">#rc.event_name#</a></li>
  <li class="active">Scheduled Reports</li>
</ol>
<div id="action-btns" class="pull-right">
	<a href="javascript:;" id="create-scheduled-custom-report" class="btn btn-lg btn-warning">Schedule Custom Reports</a>
</div>

<h2 class="page-title color-01">Scheduled Reports</h2>
<p class="page-subtitle">Reports you have saved and scheduled will appear below.</p>
<div class="basic-wrap">
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Subject/Name</th>
				<th>Send To</th>
				<th>Frequency</th>
				<th>Begin Sending On</th>
				<th>Stop Sending On</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>
			<cfloop from="1" to="#rc.report_cnt#" index="local.i">
				<tr id="row_#rc.report[ local.i ].report_schedule_id#">
					<td>#rc.report[ local.i ].subject#</td>
					<td>#rc.report[ local.i ].to_email#</td>
					<td>#rc.report[ local.i ].frequency#</td>
					<td>#dateFormat( rc.report[ local.i ].begin_on, "mm/dd/yyyy" )#</td>
					<td>#dateFormat( rc.report[ local.i ].end_on, "mm/dd/yyyy" )#</td>
					<td>
						<a data-report_title="#rc.report[ local.i ].subject#" data-event_id="#rc.event_id#" data-report_schedule_id="#rc.report[ local.i ].report_schedule_id#" href="##" data-toggle="modal" class="edit_schedule btn btn-sm btn-info">Edit</a>
						<a data-report_schedule_id="#rc.report[ local.i ].report_schedule_id#" href="" class="delete_schedule btn btn-sm btn-danger">Delete</a>
					</td>			
				</tr>
			</cfloop>
		</tbody>
	</table>
</div>
<cfinclude template="_inc/modal.delete_schedule.cfm" />
<cfinclude template="_inc/modal.schedule_report.cfm" />
<cfinclude template="_inc/modal.custom_schedule_report.cfm" />
</cfoutput>