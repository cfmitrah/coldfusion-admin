<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<div id="main-content-wrapper">
		<div id="main-content" class="no-sidebar">
			<ol class="breadcrumb">
			  <li><a href="index.cfm">Dashboard</a></li>
			  <li class="active">Attendees</li>
			</ol>
			<div id="action-btns" class="pull-right">
				<a href="attendees-create-step-01.cfm" class="btn btn-lg btn-primary">Create New Attendee</a>
				<a href="attendees-manage-groups.cfm" class="btn btn-lg btn-info">View Groups</a>
				<a href="attendees-import.cfm" class="btn btn-lg btn-default">Import Attendees</a>
			</div>

			<h2 class="page-title">Attendees</h2>
			<p class="page-subtitle">Search for a specific attendee below to manage their account details</p>

			<!--- <hr>
				<div class="row">
					<div class="col-md-6">
						<h4>Classic Search</h4>
						<form action="" class="basic-wrap">
							<div class="form-group">
								<label for="">First Name</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group">
								<label for="">Last Name</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group">
								<label for="">Email Address</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group">
								<input type="submit" class="btn btn-success" value="Perform Search">
							</div>
						</form>
					</div>
					<div class="col-md-6">
						<h4>Alphabetical Search</h4>
						<p class="attention">View all attendees with first names of the corresponding letter</p>
						<div id="name-search-letters" class="cf">
							<a href="#" class="btn btn-success btn-sm">A</a>
							<a href="#" class="btn btn-success btn-sm">B</a>
							<a href="#" class="btn btn-success btn-sm">C</a>
							<a href="#" class="btn btn-success btn-sm">D</a>
							<a href="#" class="btn btn-success btn-sm">E</a>
							<a href="#" class="btn btn-success btn-sm">F</a>
							<a href="#" class="btn btn-success btn-sm">G</a>
							<a href="#" class="btn btn-success btn-sm">H</a>
							<a href="#" class="btn btn-success btn-sm">I</a>
							<a href="#" class="btn btn-success btn-sm">J</a>
							<a href="#" class="btn btn-success btn-sm">K</a>
							<a href="#" class="btn btn-success btn-sm">L</a>
							<a href="#" class="btn btn-success btn-sm">M</a>
							<a href="#" class="btn btn-success btn-sm">N</a>
							<a href="#" class="btn btn-success btn-sm">O</a>
							<a href="#" class="btn btn-success btn-sm">P</a>
							<a href="#" class="btn btn-success btn-sm">Q</a>
							<a href="#" class="btn btn-success btn-sm">R</a>
							<a href="#" class="btn btn-success btn-sm">S</a>
							<a href="#" class="btn btn-success btn-sm">T</a>
							<a href="#" class="btn btn-success btn-sm">U</a>
							<a href="#" class="btn btn-success btn-sm">V</a>
							<a href="#" class="btn btn-success btn-sm">W</a>
							<a href="#" class="btn btn-success btn-sm">X</a>
							<a href="#" class="btn btn-success btn-sm">Y</a>
							<a href="#" class="btn btn-success btn-sm">Z</a>

                        </div>
					</div>
				</div>
			
			<br><br>
			<h3 class="form-section-title">The Last 100 Attendees that were added to the system</h3>
			<div class="alert alert-info" style="margin-bottom: -20px;">We do not show all attendees initially for a quicker loading time. If you wish to find a specific attendee, use the search filter in the section above.</div> --->

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