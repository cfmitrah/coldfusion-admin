<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'standardReports.default' )#">Standard Reports</a></li>
  <li class="active">Financial Transactions Report</li>
</ol>
<h2 class="page-title color-06">Reporting</h2>
<p class="page-subtitle">Set the desired options for the Financial Transaction Report below then click "Generate Report"</p>
<form method="post" action="#buildURL( 'standardReports.financialTransactionsReportResults' )#" class="basic-wrap col-md-6 mt-medium validate-frm" data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden">
	<input type="hidden" id="event_id" name="report.event_id" value="#rc.event_id#" />
	<input type="hidden" name="report_type" id="report_type" value="financial_transactions" />
	<h3 class="form-section-title">Financial Transaction Report Options</h3>
	<div class="form-group">
		<label for="">Set a date range: <small>(Leave blank for all dates)</small></label>
		<div class="cf">
			<div class="col-md-3">
				<p class="form-control-static">Start Date:</p>
			</div>
			<div class="col-md-9">
				<input id="detail_date_from" type="input" name="report.detail_date_from" value="#dateFormat( now(), 'MM/DD/YYYY' )#" class="form-control datetime">
			</div>
		</div>
		<div class="cf mt-small">
			<div class="col-md-3">
				<p class="form-control-static">End Date:</p>
			</div>
			<div class="col-md-9">
				<input id="detail_date_to" type="input" name="report.detail_date_to" value="#dateFormat( now(), 'MM/DD/YYYY' )#" class="form-control datetime">
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="amount_operator">Specify Specific Amount:</label>
		<div class="cf">
			<div class="col-md-6">
				<select name="report.amount_operator" id="amount_operator" class="form-control">
					<option value="">All Amounts</option>
					<option value="<">Greater Than</option>
					<option value=">">Less Than</option>
					<option value="=">Equal To</option>
				</select>
			</div>
			<div class="col-md-6">
				<input name="report.amount" id="amount" type="text" class="form-control" placeholder="specific amount" data-parsley-type="number">
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="attendee_id">Specify Attendee ID:</label>
		<input name="report.attendee_id" id="attendee_id" type="text" class="form-control" data-parsley-type="number">
	</div>
	<div class="form-group">
		<label for="detail_type_id_list">Specify Transaction Detail Type:</label>
		<select required name="report.detail_type_id_list" id="detail_type_id_list" class="form-control" multiple="multiple">
			#rc.detail_types_opts#
		</select>
	</div>
	<div class="form-group">
		<label for="payment_type_id">Specify Payment Type:</label>
		<select name="report.payment_type_id" id="payment_type_id" class="form-control" required>
			#rc.payment_types_opts#
		</select>
	</div>
	<div class="form-group">
		<button type="submit" class="btn btn-lg btn-block btn-success">Generate Report</button>
		<a href="##" data-toggle="modal" data-target="##schedule-modal" class="btn btn-lg btn-block btn-primary">Save and Schedule for Later</a>
	</div>
</form>

<div id="report-recap" class="col-md-6">
	<h4>Financial Transaction Report Recap</h4>
	<p>The following report will generate a list of financial transactions for the event:</p>
	<ul class="mt-small">
		
		<li>Registration ID</li>
		<li>Registration Company</li>
		<li>Attendee Name</li>
		<li>Transaction Detail Type (e.g. Agenda Fee, Agenda Cancel, Discount, Payment, Refund)</li>
		<li>Transaction Date</li>
		<li>Amount</li> 
		<li>Payment Type (e.g. Credit Card, Invoice, On-Site)</li>
		<li>Transaction Description</li>

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