<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<div id="main-content-wrapper">
		<div id="main-content" class="no-sidebar">
			<ol class="breadcrumb">
			  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
			  <li><a href="">Events</a></li>
			  <li><a href="">Event Name</a></li>
			  <li><a href="event-reporting.cfm">Reporting</a></li>
			  <li class="active">Agenda Participants</li>
			</ol>

			<h2 class="page-title color-06">Reporting</h2>
			<p class="page-subtitle">Set the desired options for the agenda participants report below then click "Generate Report"</p>
			
			<form action="event-reporting-generate.cfm" class="basic-wrap col-md-6 mt-medium">
				<h3 class="form-section-title">Agenda Participants Report Options</h3>
				<div class="form-group">
					<label for="">Select which participants to display:</label>
					<div class="radio">
					  <label>
					    <input type="radio" name="confirmed-radio" value="" checked>
					    Confirmed Attendees
					  </label>
					</div>
					<div class="radio">
					  <label>
					    <input type="radio" name="confirmed-radio" value="">
					    Waitlisted Attendees
					  </label>
					</div>
				</div>
				<div class="form-group">
					<label for="">Agenda Items to display: <small>(Can select multiple items)</small></label>
					<!--- Dev note: will need to use the chosen.js multiselect we've been using on this dropdown . Make sure first option is ALL --->
					<select name="" id="" class="form-control">
						<option value="">All Agenda Items</option>
					</select>
				</div>
				<div class="form-group">
					<label for="">Show agenda items starting at: <small>(Leave empty for all dates)</small></label>
					<div class="cf">
						<!--- Best to install the date time pickers here --->
						<div class="col-md-3">
							<p class="form-control-static">Date / Time:</p>
						</div>
						<div class="col-md-9">
							<input type="datetime-local" class="form-control">
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="">Specific Agenda Location: <small>(Defaults to all locations)</small></label>
					<select name="" id="" class="form-control">
						<option value="">All Agenda Locations</option>
					</select>
				</div>
				<div class="form-group">
					<label for="">Specific Session Category: <small>(Defaults to all categories)</small></label>
					<select name="" id="" class="form-control">
						<option value="">All Session Categories</option>
					</select>
				</div>
				<div class="form-group">
					<button type="submit" class="btn btn-lg btn-block btn-success">Generate Report</button>
				</div>
			</form>

			<div id="report-recap" class="col-md-6">
				<h4>Agenda Participants Report Recap</h4>
				<p>The following report will generate a list of participants grouped for each agenda item. Results will include:</p>
				<ul class="mt-small">
					<li>Agenda Label - Groups by this and lists each participant</li>
					<li>Agenda Location</li>
					<li>Session Label</li>
					<li>Session Category</li>
					<li>Attendee ID</li>
					<li>Name</li>
					<li>Company</li>
					<li>Registration Type</li>
					<li>Attendee Email</li>
					<li>Attendee Phone</li>
					<li>Date Registered</li>
				</ul>
				<hr>
				<h4>Export Options</h4>
				<p>Once generated you will be able to export a report using the buttons which appear in the top right of the page. Currently you can export reports to:</p>
				<ul class="mt-small">
					<li>Adobe PDF</li>
					<li>Microsoft Excel</li>
					<li>Print View</li>
				</ul>
			</div>
			
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>