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
			  <li class="active">Site Content</li>
			</ol>
			<div id="action-btns" class="pull-right">
				<a href="event-registration-site-nav-builder.cfm" class="btn btn-lg btn-default">Site Navigation Builder</a>
				<a href="event-registration-site-content-create.cfm" class="btn btn-lg btn-info">Create New Sub Page</a>
			</div>
			<h2 class="page-title color-02">Registration Site Content</h2>
			<p class="page-subtitle">Here you can manage the landing page of your registration website, as well as add and edit sub pages.</p>
			<table id="speakers-table" class="table table-striped">
				<thead>
					<tr>
						<th style="width: 20%">Page Name</th>
						<th style="width: 20%">Status</th>
						<th style="width: 20%">Publish Date</th>
						<th style="width: 20%">Expiration Date</th>
						<th style="width: 29%">Options</th>
					</tr>
				</thead>
				<tbody>
					<!--- can't edit delete the main page --->
					<tr class="success">
						<td><strong>Main Page - Registration</strong></td>
						<td>Published</td>
						<td>n/a</td>
						<td>n/a</td>
						<td>
							<a href="event-registration-site-content-manage-main.cfm" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-edit"></span> <strong>Manage</strong> </a>
						</td>	
					</tr>
					<tr>
						<td>Hotel Information</td>
						<td>Published</td>
						<td>9/3/2014 12:00 AM</td>
						<td>9/7/2014 12:00 AM</td>
						<td>
							<a href="event-registration-site-content-manage.cfm" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-edit"></span> <strong>Manage</strong> </a>&nbsp;&nbsp;
							<a href="##" class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Delete</strong> </a>
						</td>	
					</tr>
					
				</tbody>
			</table>
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>