<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'standardReports.default' )#">Standard Reports</a></li>
  <li class="active">Coupon Codes Report</li>
</ol>
<h2 class="page-title color-06">Reporting</h2>
<p class="page-subtitle">Set the desired options for the Coupon Codes Report below then click "Generate Report"</p>
<br>
<div class="row">

	<form method="post" action="#buildURL( 'standardReports.couponReportResults' )#" class="basic-wrap col-md-6 mt-medium validate-frm" data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden">
	<input type="hidden" id="event_id" name="report.event_id" value="#rc.event_id#" />
	<input type="hidden" name="report_type" id="report_type" value="coupons" />
		<h3 class="form-section-title">Coupon Codes Report Options</h3>
		<div class="form-group">
			<label for="coupon_code_list">Filter by coupon code: <small>(optional)</small></label>
			<div class="form-group">
				<select name="report.coupon_code_list" id="coupon_code_list" class="form-control chosen-select" multiple data-placeholder="Select One or More Coupon Codes">
					#rc.coupon_opts#
				</select>
			</div>
		</div>
		<div class="form-group">
			<label for="">Filter by coupon type: <small>(optional)</small></label>
			<div class="form-group">
				<select name="" id="" class="form-control chosen-select" multiple data-placeholder="Select One or More Coupon Types">
					<option value="">Flat Fee</option>
					<option value="">Discount</option>
					<option value="">Percentage</option>
				</select>
			</div>
		</div>
		
		<div class="form-group">
			<button type="submit" class="btn btn-lg btn-block btn-success">Generate Report</button>
			<a href="##" data-toggle="modal" data-target="##schedule-modal" class="btn btn-lg btn-block btn-primary">Save and Schedule for Later</a>
		</div>
	</form>

	<!--- Results table columns should be:
	- Attendee Name
	- Attendee Email
	- Code Used
	- Code Type
	- Amount Applied
	- Total before coupon
	- Total After Coupon --->

	<div id="report-recap" class="col-md-6">
		<h4>Coupon Codes Report Recap</h4>
		<p>The following report will generate a list of attendees who used coupon codes</p>
		<ul class="mt-small">
			<li>Attendee Name</li>
			<li>Attendee Email</li>
			<li>Coupon Code Used</li>
			<li>Coupon Code Type</li>
			<li>Coupon Code Amount Applied</li>
			<li>Total Cost Before Coupon</li>
			<li>Total Cost After Coupon</li>
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
<cfinclude template="_inc/modal.schedule_report.cfm" />
</cfoutput>
