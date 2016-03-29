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
			  <li class="active">Agenda</li>
			</ol>
			<div id="action-btns" class="pull-right">
				<a href="event-agenda-view.cfm" class="btn btn-lg btn-warning">View Current Agenda</a>
				<a href="event-agenda-session-create.cfm" class="btn btn-lg btn-primary">Create New Session</a>
			</div>
			<h2 class="page-title color-02">Agenda</h2>
			<p class="page-subtitle">This section allows you to add sessions and create a schedule for your event.</p>

			<table class="table table-striped table-hover data-table tm-large">
				<thead>
					<tr>
						<th>Session Name</th>
						<th>Scheduled Date</th>
						<th>On Multiple Schedules</th>
						<th>Fee Associated</th>
						<th>Has Assets</th>
						<th>Options</th>
					</tr>
				</thead>
				<tbody>
					<cfloop from="1" to="15" index="i">
						<tr>
							<td>This is a Sample Session Name</td>
							<td>7/27/2014 12:00 AM</td>
							<td></td>
							<td><span class="glyphicon glyphicon-ok"></span></td>
							<td><span class="glyphicon glyphicon-ok"></span></td>
							<td>
								<a href="event-agenda-session.cfm"><span class="glyphicon glyphicon-edit"></span> <strong>Manage</strong> </a>&nbsp;&nbsp;
								<a href="event-agenda-session.cfm" class="text-danger"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Delete</strong> </a>
							</td>
						</tr>
					</cfloop>
				</tbody>
			</table>
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>