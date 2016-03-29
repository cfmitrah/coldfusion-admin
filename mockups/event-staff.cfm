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
			  <li class="active">Staff</li>
			</ol>
			<div id="action-btns" class="pull-right">
				<a href="event-staff-create.cfm" class="btn btn-lg btn-primary">Create New Staff Member</a>
			</div>
			<h2 class="page-title color-02">Event Staff</h2>
			<p class="page-subtitle">Keep track of who's doing what at your event. You can also allow event staff members to access certain levels of the admin.</p>
			<table id="speakers-table" class="table table-striped data-table">
				<thead>
					<tr>
						<th>First Name</th>
						<th>Last Name</th>
						<th>Username</th>
						<th>Email Address</th>
						<th>Phone</th>
						<th>Active</th>
						<th>Options</th>
					</tr>
				</thead>
				<tbody>
					<cfloop from="1" to="4" index="i">
						<tr>
							<td>Spencer</td>
							<td>Bailey</td>
							<td>sbaileydev</td>
							<td>spencer@excelaweb.com</td>
							<td>+1 (618) 946-1881</td>
							<td>yes</td>
							<td class="text-center">
								<a href="" data-toggle="modal" data-target="#staff-manage" class="btn btn-warning btn-sm">Manage</a>
							</td>
							
						</tr>
					</cfloop>
					
				</tbody>
			</table>
			

		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="staff-manage" tabindex="-1" role="dialog" aria-labelledby="staff-manage-label" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="staff-manage-label">Manage Staff Member: Firstname Lastname</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<div class="form-group">
						<label for="">Notes</label>
						<textarea name="" id="" rows="2" class="form-control"></textarea>
					</div>
				</div>
				<div class="form-group">
					<label for="">Assign Access Levels <small>Check those which apply</small></label>
					<div class="checkbox">
					    <label>
					    	<input type="checkbox"> Can edit event details (Venue, Dates, Tags)
					    </label>
					</div>
					<div class="checkbox">
					    <label>
					    	<input type="checkbox"> Can edit event attendee settings (Types, Capacity, Group Registration Settings, General Settings)
					    </label>
					</div>
					<div class="checkbox">
					    <label>
					    	<input type="checkbox"> Can edit pre conference registration form (Required Fields, Custom Fields)
					    </label>
					</div>
					<div class="checkbox">
					    <label>
					    	<input type="checkbox" checked> Can add and edit sessions
					    </label>
					</div>
					<div class="checkbox">
					    <label>
					    	<input type="checkbox" checked> Can add and edit speakers
					    </label>
					</div>
					<div class="checkbox">
					    <label>
					    	<input type="checkbox" checked> Can create and edit agenda items
					    </label>
					</div>
					<div class="checkbox">
					    <label>
					    	<input type="checkbox"> Can manage marketing (Social media links, Emails, Site Content)
					    </label>
					</div>
					<div class="checkbox">
					    <label>
					    	<input type="checkbox" checked> Can access reporting
					    </label>
					</div>
					<div class="checkbox">
					    <label>
					    	<input type="checkbox" checked> Can access on site functions such as printing name badges and overviewing session check in's
					    </label>
					</div>
				</div>
				<div class="form-group">
					<label for="">Staff Member Status</label>
					<div class="radio">
					    <label>
					    	<input type="radio" name="staff-status" checked> Active
					    </label>
					</div>
					<div class="radio">
					    <label>
					    	<input type="radio" name="staff-status"> Not Active
					    </label>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
				<button type="button" class="btn btn-success">Save Settings</button>
			</div>
		</div>
	</div>
</div>

<cfinclude template="shared/footer.cfm"/>