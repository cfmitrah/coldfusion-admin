<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<div id="main-content-wrapper">
		<div id="main-content" class="no-sidebar">
			<ol class="breadcrumb">
			  <li><a href="index.cfm">Dashboard</a></li>
			  <li class="active">Events</li>
			</ol>
			<div id="action-btns" class="pull-right">
				<a href="" class="btn btn-lg btn-warning">Advanced Search</a>
				<a href="event-create.cfm" class="btn btn-lg btn-primary">Create New Event</a>
			</div>

			<h2 class="page-title">Events</h2>
			<p class="page-subtitle">Select a specific event below to manage it. Managing an event will let you set it's details, edit it's agenda, set attendee specifications and much more.</p>

			<table class="table table-striped table-hover data-table tm-large">
				<thead>
					<tr>
						<th>Name</th>
						<th>Status</th>
						<th>Visibility</th>
						<th>Venue</th>
						<th>Start Date</th>
						<th>End Date</th>
						<th>Options</th>
					</tr>
				</thead>
				<tbody>
					<cfloop from="1" to="15" index="i">
						<tr>
							<td>2014 Sample Conference Name</td>
							<td><span class="label label-success">Current</span></td>
							<td>Public</td>
							<td>Marriott Marquis</td>
							<td>July 18, 2014</td>
							<td>July 20, 2014</td>
							<td><a href="event-overview.cfm"><strong>Manage Event</strong> <span class="glyphicon glyphicon-arrow-right"></span></a></td>
						</tr>
					</cfloop>
				</tbody>
			</table>
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>