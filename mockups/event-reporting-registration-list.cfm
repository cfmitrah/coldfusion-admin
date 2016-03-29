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
			  <li class="active">Registration List</li>
			</ol>

			<h2 class="page-title color-06">Reporting</h2>
			<p class="page-subtitle">Set the desired options for the registration list report below then click "Generate Report"</p>
			
			<form action="event-reporting-generate.cfm" class="basic-wrap col-md-6 mt-medium">
				<h3 class="form-section-title">Registration List Report Options</h3>
				<div class="form-group">
					<label for="">Select Registration Types to display:</label>
					<!--- initially have them all checked --->
					<div class="checkbox">
					  <label>
					    <input type="checkbox" value="" checked>
					    General
					  </label>
					</div>
					<div class="checkbox">
					  <label>
					    <input type="checkbox" value="" checked>
					    Sponsor
					  </label>
					</div>
					<div class="checkbox">
					  <label>
					    <input type="checkbox" value="" checked>
					    V.I.P
					  </label>
					</div>
				</div>
				<div class="form-group">
					<label for="">Account Balance Preferences:</label>
					<div class="radio">
					  <label>
					    <input type="radio" name="balance-radio" value="" checked>
					    Show all attendees
					  </label>
					</div>
					<div class="radio">
					  <label>
					    <input type="radio" name="balance-radio" value="">
					    Only show attendees who have a balance due
					  </label>
					</div>
					<div class="radio">
					  <label>
					    <input type="radio" name="balance-radio" value="">
					    Only show attendees who do NOT have a balance due
					  </label>
					</div>
				</div>
				<div class="form-group">
					<label for="">Show attendees who registered on: <small>(Leave empty for all dates)</small></label>
					<div class="cf">
						<div class="col-md-3">
							<p class="form-control-static">Start Date:</p>
						</div>
						<div class="col-md-9">
							<input type="date" class="form-control">
						</div>
					</div>
				</div>
				<div class="form-group">
					<button type="submit" class="btn btn-lg btn-block btn-success">Generate Report</button>
				</div>
			</form>

			<div id="report-recap" class="col-md-6">
				<h4>Registration List Report Recap</h4>
				<p>The following report will generate a list of all registered attendees consisting of the following data:</p>
				<ul class="mt-small">
					<li>Attendee ID</li>
					<li>Name</li>
					<li>Company</li>
					<li>Registration Type</li>
					<li>Total Charges</li>
					<li>Balance Due</li>
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