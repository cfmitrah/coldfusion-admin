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
			  <li class="active">Registration Fees</li>
			</ol>

			<h2 class="page-title color-06">Reporting</h2>
			<p class="page-subtitle">Set the desired options for the Registration Fees Report below then click "Generate Report"</p>
			
			<form action="event-reporting-generate.cfm" class="basic-wrap col-md-6 mt-medium">
				<h3 class="form-section-title">Registration Fees Report Options</h3>
				<div class="form-group">
					<label for="">Specify Company</label>
					<select name="" id="" class="form-control">
						<option value="">All Companies</option>
					</select>
				</div>
				<div class="form-group">
					<label for="">Specify balance due:</label>
					<div class="cf">
						<div class="col-md-6">
							<select name="" id="" class="form-control">
								<option value="">All Amounts</option>
								<option value="">Greater Than</option>
								<option value="">Less Than</option>
								<option value="">Equal To</option>
							</select>
						</div>
						<div class="col-md-6">
							<input type="text" class="form-control" placeholder="$ sign not required">
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="">Specify number of attendees:</label>
					<div class="cf">
						<div class="col-md-6">
							<select name="" id="" class="form-control">
								<option value="">All Amounts</option>
								<option value="">Greater Than</option>
								<option value="">Less Than</option>
								<option value="">Equal To</option>
							</select>
						</div>
						<div class="col-md-6">
							<input type="text" class="form-control" placeholder="$ sign not required">
						</div>
					</div>
				</div>
				<div class="form-group">
					<button type="submit" class="btn btn-lg btn-block btn-success">Generate Report</button>
				</div>
			</form>

			<div id="report-recap" class="col-md-6">
				<h4>Registration Fees Report Recap</h4>
				<p>The following report will generate a list of Registration Fees for the event:</p>
				<ul class="mt-small">
					
					<li>Registration Company Name</li>
					<li>Total of Amount collected</li>
					<li>Total of Transaction Fees</li>
					<li>Number of Attendees registered</li>
					<li>Balance Due</li>

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