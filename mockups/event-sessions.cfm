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
			  <li class="active">Sessions</li>
			</ol>
			<div id="action-btns" class="pull-right">
				<a href="event-session-create.cfm" class="btn btn-lg btn-primary">Create New Session</a>
			</div>
			<h2 class="page-title color-02">Sessions</h2>
			<p class="page-subtitle">Below are the exisiting sessions in the system. To edit session information, click 'edit' in the related table row.</p>

			<table class="table table-striped table-hover data-table tm-large">
				<thead>
					<tr>
						<th>Session Name</th>
						<th>Description</th>
						<th>Summary</th>
						<th>Overview</th>
						<th>Scheduled</th>
						<th>Photos</th>
						<th>Assets</th>
						<th>Speakers</th>
						<th>Options</th>
					</tr>
				</thead>
				<tbody>
					<cfloop from="1" to="15" index="i">
						<tr>
							<td>This is a Sample Session Name</td>
							<td><span class="glyphicon glyphicon-ok"></span></td>
							<td><span class="glyphicon glyphicon-ok"></span></td>
							<td><span class="glyphicon glyphicon-ok"></span></td>
							<td><span class="glyphicon glyphicon-ok"></span></td>
							<td><span class="glyphicon glyphicon-ok"></span></td>
							<td><span class="glyphicon glyphicon-ok"></span></td>
							<td><span class="glyphicon glyphicon-ok"></span></td>
							<td>
								<a href="event-session-edit.cfm"><span class="glyphicon glyphicon-edit"></span> <strong>Edit</strong> </a>&nbsp;&nbsp;
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