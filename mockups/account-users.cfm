<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<div id="sidebar">
		<div class="side-section">
			<!--- When a link in a section is active - the following active-caret div should display --->
			<div class="active-caret"></div>
			<h2>Overview <span class="glyphicon glyphicon-dashboard color-01"></span></h2>
			<ul>
				<li><a href="account-index.cfm" >Overview</a></li>
			</ul>
		</div>
		<div class="side-section">
			<h2>Users <span class="glyphicon glyphicon-user color-02"></span></h2>
			<ul>
				<li><a href="account-users.cfm" class="active">View All</a></li>
				<li><a href="account-users-create.cfm">Create New</a></li>
			</ul>
		</div>
		<div class="side-section">
			<h2>Packages <span class="glyphicon glyphicon-briefcase color-03"></span></h2>
			<ul>
				<li><a href="account-packages.cfm">Overview</a></li>
			</ul>
		</div>
		<div class="side-section">
			<h2>Billing <span class="glyphicon glyphicon-usd color-04"></span></h2>
			<ul>
				<li><a href="account-billing.cfm">Overview</a></li>
			</ul>
		</div>
	</div>
		
	<div id="main-content-wrapper" class="has-sidebar">
		<div id="main-content">
			<ol class="breadcrumb">
			  <li><a href="index.cfm">Dashboard</a></li>
			  <li><a href="account-index.cfm">Company</a></li>
			  <li class="active">Users</li>
			</ol>
			<div id="action-btns" class="pull-right">
				<a href="account-users-create.cfm" class="btn btn-lg btn-primary">Create New User</a>
			</div>

			<h2 class="page-title color-02">Administrative Users</h2>
			<p class="page-subtitle">Administrative Users are the top level users which have access to the entirety of the admin, including billing details, events, attendees, reports and configuration settings.</p>
			<br>
			<table class="table table-striped">
				<thead>
					<tr>
						<th>First Name</th>
						<th>Last Name</th>
						<th>Username</th>
						<th>Email Address(es)</th>
						<th>Phone Number</th>
						<th>Active</th>
						<th>Options</th>
					</tr>
				</thead>
				<tbody>
					<cfoutput>
					<cfloop from="1" to="6" index="i">
						<tr>
							<td>Spencer</td>
							<td>Bailey</td>
							<td>sbaileydev</td>
							<td>spencer@excelaweb.com</td>
							<td>618 946 1881</td>
							<td>yes</td>
							<td><a href="##" class="btn btn-sm btn-danger">Deactivate User</a></td>
						</tr>
					</cfloop>
					</cfoutput>
				</tbody>
			</table>
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>