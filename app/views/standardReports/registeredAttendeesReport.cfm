<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'standardReports.default' )#">Standard Reports</a></li>
  <li class="active">Registration List Report</li>
</ol>
<h2 class="page-title color-06">Reporting</h2>
<p class="page-subtitle">Set the desired options for the registration list report below then click "Generate Report"</p>
<form method="post" action="#buildURL( 'standardReports.registeredAttendeesReportResults' )#" class="basic-wrap col-md-6 mt-medium validate-frm" data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden">
	<input type="hidden" id="event_id" name="report.event_id" value="#rc.event_id#" />
	<h3 class="form-section-title">Registration List Report Options</h3>
	<div class="form-group">
		<label for="">Select Registration Types to display:</label>
		<input type="hidden" name="report_type" id="report_type" value="registration_list" />		
		<cfloop from="1" to="#arrayLen( rc.registration_types )#" index="local.i">
			<div class="checkbox">
			  <label>
			    <input class="registration_type_id_list" type="checkbox" name="report.registration_type_id_list" value="#rc.registration_types[ local.i ].registration_type_id#" checked data-parsley-mincheck="1">
			    #rc.registration_types[ local.i ].registration_type#
			  </label>
			</div>
		</cfloop>
	</div>
	<div class="form-group">
		<label for="">Account Balance Preferences:</label>
		<div class="radio">
		  <label>
		    <input class="balance_opts balance_due_operator" type="radio" name="report.balance_due_operator" value=">" checked required>
		    Show all attendees
		  </label>
		</div>
		<div class="radio">
		  <label>
		    <input class="balance_opts balance_due_operator" type="radio" name="report.balance_due_operator" value=">" data-showbalance="1" required>
		    Only show attendees who have a balance due
		  </label>
		</div>
		<div id="balance_due_input" class="cf" style="display: none;">
			<div class="col-md-3">
				<p class="form-control-static">Balance Due:</p>
			</div>
			<div class="col-md-9">
				<input type="input" name="report.balance_due" value="0" class="form-control balance_due">
			</div>
		</div>

		<div class="radio">
		  <label>
		    <input class="balance_opts balance_due_operator" type="radio" name="report.balance_due_operator" value="<=" required>
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
				<input class="registration_date_from" type="input" name="report.registration_date_from" value="#dateFormat( now(), 'MM/DD/YYYY' )#" class="form-control datetime">
			</div>
		</div>
		<div class="cf">
			<div class="col-md-3">
				<p class="form-control-static">End Date:</p>
			</div>
			<div class="col-md-9">
				<input class="registration_date_to" type="input" name="report.registration_date_to" value="#dateFormat( now(), 'MM/DD/YYYY' )#" class="form-control datetime">
			</div>
		</div>
	</div>
	<div class="form-group">
		<button type="submit" class="btn btn-lg btn-block btn-success">Generate Report</button>
		<a href="##" data-toggle="modal" data-target="##schedule-modal" class="btn btn-lg btn-block btn-primary">Save and Schedule for Later</a>
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
<cfinclude template="_inc/modal.schedule_report.cfm" />
	
</cfoutput>