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
			  <li class="active">Speakers</li>
			</ol>
			<div id="action-btns" class="pull-right">
				<a href="event-speakers-create.cfm" class="btn btn-lg btn-primary">Create New Speaker</a>
			</div>
			<h2 class="page-title color-02">Speakers</h2>
			<p class="page-subtitle">Assign a speaker to a session by clicking the 'manage' link in the related table row below.</p>
			<table id="speakers-table" class="table table-striped data-table">
				<thead>
					<tr>
						<th>First Name</th>
						<th>Last Name</th>
						<th>Title</th>
						<th>Company</th>
						<th>Email Address</th>
						<th>Summary</th>
						<th>Bio</th>
						<th>Photo</th>
						<th>Manage</th>
					</tr>
				</thead>
				<tbody>
					<cfloop from="1" to="28" index="i">
						<tr>
							<td>Spencer</td>
							<td>Bailey</td>
							<td>Web Developer</td>
							<td>Meeting Play</td>
							<td>spencer@excelaweb.com</td>
							<td><span class="glyphicon glyphicon-ok"></span></td>
							<td><span class="glyphicon glyphicon-ok"></span></td>
							<td><span class="glyphicon glyphicon-ok"></span></td>
							<td class="text-center">
								<a href="event-speakers-edit.cfm"><span class="glyphicon glyphicon-edit"></span> <strong>Manage</strong> </a>&nbsp;&nbsp;
								<a href="" class="text-danger"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Delete</strong> </a>
							</td>
							
						</tr>
					</cfloop>
					
				</tbody>
			</table>
			<!--- <hr>
			<h4>Create a New Speaker</h4>
			<p class="attention">If a speaker is not yet in the system, you can create a basic profile for them below.</p>
			<form action="">
				<div class="row">
					<div class="col-md-6">
						<div class="form-group">
							<label for="">First Name</label>
							<input type="text" class="form-control">
						</div>
						<div class="form-group">
							<label for="">Last Name</label>
							<input type="text" class="form-control">
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label for="">Title</label>
							<input type="text" class="form-control">
						</div>
						<div class="form-group">
							<label for="">Email Address</label>
							<input type="text" class="form-control">
						</div>
					</div>
				</div>
				<div class="cf">
					<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Save New Speaker</strong></button>
				</div>
			</form> --->

		</div>
	</div>
</div>

<cfinclude template="shared/footer.cfm"/>