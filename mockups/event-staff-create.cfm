<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<cfinclude template="shared/event-sidebar.cfm"/>
		
	<div id="main-content-wrapper" class="has-sidebar">
		<div id="main-content">
			<ol class="breadcrumb">
			  <li><a href="#">Dashboard</a></li>
			  <li><a href="#">Events</a></li>
			  <li><a href="#">Event Name</a></li>
			  <li class="active">Create Staff Member</li>
			</ol>

			<h2 class="page-title color-02">Create New Staff Member</h2>
			<p class="page-subtitle">Upon creation an email will be sent to the new user which allows them to log in with a temporary password. The user can then change their password and additional information from their profile page.</p>
			<div class="row">
				<div class="col-md-8">
					<form action="" class="basic-wrap mt-small">
						<h3 class="form-section-title">New Staff Member Information</h3>
						<div class="form-group">
							<label for="" class="required">User Name</label>
							<input type="text" class="form-control">
						</div>
						<div class="form-group">
							<label for="" class="required">Email Address</label>
							<input type="email" class="form-control">
						</div>
						<div class="form-group">
							<label for="">First Name</label>
							<input type="text" class="form-control">
						</div>
						<div class="form-group">
							<label for="">Last Name</label>
							<input type="text" class="form-control">
						</div>
						<div class="form-group">
							<label for="">Notes</label>
							<textarea name="" id="" rows="2" class="form-control"></textarea>
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
						<br>
						<div class="form-group">
							<input type="submit" class="btn btn-lg btn-success" value="Add Staff Member to System and Send Notification Email">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>