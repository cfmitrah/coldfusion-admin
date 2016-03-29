<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'standardReports.default' )#">Standard Reports</a></li>
  <li class="active">Registration Fees Report</li>
</ol>
<h2 class="page-title color-06">Reporting</h2>
<p class="page-subtitle">Set the desired options for the Registration Fees Report below then click "Generate Report"</p>
<form method="post" action="#buildURL( 'standardReports.registrationSummaryReportResults' )#" class="basic-wrap col-md-6 mt-medium validate-frm" data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden">
	<input type="hidden" id="event_id" name="report.event_id" value="#rc.event_id#" />
	<input type="hidden" name="report_type" id="report_type" value="registration_fees" />
	<h3 class="form-section-title">Registration Fees Report Options</h3>
	<div class="form-group">
		<label for="company">Specify Company</label>
		<select name="report.company" id="company" class="form-control">
			<option value="">All Companies</option>
			#rc.company_opts#			
		</select>
	</div>
	<div class="form-group">
		<label for="balance_due_operator">Specify balance due:</label>
		<div class="cf">
			<div class="col-md-6">
				<select name="report.balance_due_operator" id="balance_due_operator" class="form-control">
					<option value="">All Amounts</option>
					<option value=">">Greater Than</option>
					<option value="<">Less Than</option>
					<option value="=">Equal To</option>
				</select>
			</div>
			<div class="col-md-6">
				<input name="report.balance_due" id="balance_due" type="text" class="form-control" placeholder="numbers only" required data-parsley-type="number">
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="attendee_count_operator">Specify number of attendees:</label>
		<div class="cf">
			<div class="col-md-6">
				<select name="report.attendee_count_operator" id="attendee_count_operator" class="form-control">
					<option value="">All Amounts</option>
					<option value=">">Greater Than</option>
					<option value="<">Less Than</option>
					<option value="=">Equal To</option>
				</select>
			</div>
			<div class="col-md-6">
				<input name="report.attendee_count" id="attendee_count" type="text" class="form-control" placeholder="numbers only" required data-parsley-type="number">
			</div>
		</div>
	</div>
	<div class="form-group">
		<button type="submit" class="btn btn-lg btn-block btn-success">Generate Report</button>
		<a href="##" data-toggle="modal" data-target="##schedule-modal" class="btn btn-lg btn-block btn-primary">Save and Schedule for Later</a>
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

<cfinclude template="_inc/modal.schedule_report.cfm" />


</cfoutput>