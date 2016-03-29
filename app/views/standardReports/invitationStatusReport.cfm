<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'standardReports.default' )#">Standard Reports</a></li>
  <li class="active">Invitation Status Report</li>
</ol>
<h2 class="page-title color-06">Reporting</h2>
<p class="page-subtitle">Set the desired options for the Invitation Status Report below then click "Generate Report"</p>
<form method="post" action="#buildURL( 'standardReports.invitationStatusReportResults' )#" class="basic-wrap col-md-6 mt-medium validate-frm" data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden">
	<input type="hidden" id="event_id" name="report.event_id" value="#rc.event_id#" />
	<input type="hidden" id="company_id" name="report.company_id" value="#rc.company_id#" />
	<input type="hidden" name="report_type" id="report_type" value="invitation_status" />
	<h3 class="form-section-title">Invitation Status Report Options</h3>
	<div class="form-group">
		<label for="invitation_id">Invitation Email</label>
		<select name="report.invitation_id" id="invitation_id" class="form-control">
			<option value="0">All</option>
			#rc.invitation_email_opts#
		</select>
	</div>
	<div class="form-group">
		<label for="invitation_start_date">Show invitations starting at: <small>(Leave empty for all dates)</small></label>
		<div class="cf">
			<div class="col-md-3">
				<p class="form-control-static">Start Date:</p>
			</div>
			<div class="col-md-9">
				<input type="input" name="report.sent_date_from" id="sent_date_from" value="#dateFormat( now(), 'MM/DD/YYYY' )#" class="form-control datetime">
			</div>
		</div>
		<div class="cf">
			<div class="col-md-3">
				<p class="form-control-static">End Date:</p>
			</div>
			<div class="col-md-9">
				<input type="input" name="report.sent_date_to" id="sent_date_to" value="#dateFormat( now(), 'MM/DD/YYYY' )#" class="form-control datetime">
			</div>
		</div>
	</div>
	<div class="form-group">
		<button type="submit" class="btn btn-lg btn-block btn-success">Generate Report</button>
		<a href="##" data-toggle="modal" data-target="##schedule-modal" class="btn btn-lg btn-block btn-primary">Save and Schedule for Later</a>
	</div>
</form>

<div id="report-recap" class="col-md-6">
	<h4>Invitation Status Report Recap</h4>
	<p>The following report will generate a list of Invitation Status for the event:</p>
	<ul class="mt-small">
		<li>Registration Company Name</li>
		<li>Invitation Label</li>
		<li>Event Name</li>
		<li>First Name/Last Name</li>
		<li>Email Address</li>
		<li>Viewed Status</li>
		<li>Registered Status</li>
		<li>Send Date</li>
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