<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'standardReports.default' )#">Standard Reports</a></li>
  <li class="active">Agenda Participants Report</li>
</ol>
<h2 class="page-title color-06">Reporting</h2>
<p class="page-subtitle">Set the desired options for the agenda participants report below then click "Generate Report"</p>
<form method="post" action="#buildURL( 'standardReports.agendaParticipantsReportResults' )#" class="basic-wrap col-md-6 mt-medium validate-frm" data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden">
	<input type="hidden" id="event_id" name="report.event_id" value="#rc.event_id#" />
	<input type="hidden" id="report_type" name="report_type" value="agenda_participants" />
	<h3 class="form-section-title">Agenda Participants Report Options</h3>
	<div class="form-group">
		<label for="">Select which participants to display:</label>
		<div class="radio">
		  <label>
		    <input class="report_type" type="radio" name="report.report_type" value="1" checked>
		    Confirmed Attendees
		  </label>
		</div>
		<div class="radio">
		  <label>
		    <input class="report_type" type="radio" name="report.report_type" value="0" />
		    Waitlisted Attendees
		  </label>
		</div>
	</div>
	<div class="form-group">
		<label for="">Agenda Items to display: <small>(Can select multiple items)</small></label>
		<!--- Dev note: will need to use the chosen.js multiselect we've been using on this dropdown . Make sure first option is ALL --->
		<select name="report.agenda_id_list" id="agenda_id_list" required class="form-control" multiple="multiple">
			#rc.agenda_items_opts#
		</select>
	</div>
	<div class="form-group">
		<label for="">Show agenda items starting at: <small>(Leave empty for all dates)</small></label>
		<div class="cf">
			<div class="col-md-3">
				<p class="form-control-static">Start Date:</p>
			</div>
			<div class="col-md-9">
				<input type="input" id="agenda_start_date_from" name="report.agenda_start_date_from" value="#dateFormat( now(), 'MM/DD/YYYY' )#" class="form-control datetime">
			</div>
		</div>
		<div class="cf">
			<div class="col-md-3">
				<p class="form-control-static">End Date:</p>
			</div>
			<div class="col-md-9">
				<input type="input" id="agenda_start_date_to" name="report.agenda_start_date_to" value="#dateFormat( now(), 'MM/DD/YYYY' )#" class="form-control datetime">
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="">Specific Agenda Location: <small>(Defaults to all locations)</small></label>
		<select name="report.location_id" id="location_id" class="form-control">
			<option value="0">All Agenda Locations</option>
			#rc.location_opts#
		</select>
	</div>
	<div class="form-group">
		<label for="">Specific Session Category: <small>(Defaults to all categories)</small></label>
		<select name="report.category_id" id="category_id" class="form-control">
			<option value="0">All Session Categories</option>
			#rc.categories_opts#
		</select>
	</div>
	<div class="form-group">
		<button type="submit" class="btn btn-lg btn-block btn-success">Generate Report</button>
		<a href="##" data-toggle="modal" data-target="##schedule-modal" class="btn btn-lg btn-block btn-primary">Save and Schedule for Later</a>
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


<cfinclude template="_inc/modal.schedule_report.cfm" />


</cfoutput>