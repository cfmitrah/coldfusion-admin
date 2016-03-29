<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<cfinclude template="shared/event-sidebar.cfm"/>

	<!--- Sidebar Ends Content Starts --->
	<div id="main-content-wrapper" class="has-sidebar">
		<div id="main-content">
			<ol class="breadcrumb">
			  <li><a href="#">Dashboard</a></li>
			  <li><a href="#">Events</a></li>
			  <li><a href="#">Event Name</a></li>
			  <li class="active">Schedule</li>
			</ol>
			<div id="action-btns" class="pull-right">
				<a href="event-schedule-view.cfm" class="btn btn-lg btn-warning">View Schedule on Calendar</a>
				<a href="event-schedule-create.cfm" class="btn btn-lg btn-primary">Create New Agenda Item</a>
			</div>
			<h2 class="page-title color-02">Schedule</h2>
			<p class="page-subtitle">The schedule is composed of agenda items. To create an agenda item, click the 'Create New Agenda Item' button above. You can manage the exisiting agenda items by clicking 'manage' in the related table row below.</p>

			<table class="table table-striped table-hover data-table tm-large">
				<thead>
					<tr>
						<th>Session Name</th>
						<th>Date Scheduled</th>
						<th>Start Time</th>
						<th>End Time</th>
						<th>Visible</th>
						<th>Associated Fee?</th>
						<th>Restrictions?</th>
						<th>Options</th>
					</tr>
				</thead>
				<tbody>
					<cfloop from="1" to="15" index="i">
						<tr>
							<td>This is a Sample Session Name</td>
							<td>7/30/2014</td>
							<td>10:00 AM</td>
							<td>11:00 AM</td>
							<td><span class="glyphicon glyphicon-ok"></span></td>
							<td><span class="glyphicon glyphicon-ok"></span></td>
							<td><span class="glyphicon glyphicon-ok"></span></td>
							<td>
								<a href="event-schedule-edit.cfm"><span class="glyphicon glyphicon-edit"></span> <strong>Manage</strong> </a>&nbsp;&nbsp;
								<a href="" class="text-danger"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Delete</strong> </a>
							</td>
						</tr>
					</cfloop>
				</tbody>
			</table>
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>