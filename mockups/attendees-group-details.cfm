<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<div id="main-content-wrapper">
		<div id="main-content" class="no-sidebar">
			<ol class="breadcrumb">
			  <li><a href="index.cfm">Dashboard</a></li>
			  <li><a href="attendees-index.cfm">Attendees</a></li>
			  <li><a href="attendees-manage-groups.cfm">Groups</a></li>
			  <li class="active">View Group</li>
			</ol>
			<div id="action-btns" class="pull-right">
				<a href="" class="btn btn-lg btn-info">Send Group Communication</a>
			</div>
			<h2 class="page-title">Attendee Group</h2>
			<p class="page-subtitle"><strong>Event:</strong> Hobsons University 2014</p>
			

			<table class="table table-striped table-hover data-table">
				<thead>
					<tr>
						<th>First Name</th>
						<th>Last Name</th>
						<th>Email Address</th>
						<th>Associated Event</th>
						<th>Status</th>
						<th>Options</th>
					</tr>
				</thead>
				<tbody>
					<cfloop from="1" to="100" index="i">
						<tr>
							<td>Spencer</td>
							<td>Bailey</td>
							<td>spencer@excelaweb.com</td>
							<td>Hobsons University 2014</td>
							<td>Active</td>
							<td>
								<a href="attendee-overview.cfm" class="btn btn-sm btn-primary">Manage</a>
								<a href="" class="btn btn-sm btn-danger">Deactivate</a>
							</td>
						</tr>
					</cfloop>
				</tbody>
			</table>
			
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>