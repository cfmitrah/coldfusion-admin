<cfoutput>
<ol class="breadcrumb">
  <li><a href="/">Dashboard</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'standardReports.default' )#">Standard Reports</a></li>
  <li class="active">Hotel Reservations Report</li>
</ol>
<h2 class="page-title color-06">Reporting</h2>
<p class="page-subtitle">Set the desired options for the Hotel Reservations Report below then click "Generate Report"</p>
<br>
<div class="row">
	<div class="col-md-6">
		<div class="basic-wrap">
			<form method="post" action="#buildURL( 'standardReports.hotelReservationsReportResults' )#" class="mt-medium validate-frm" data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden">
			<input type="hidden" id="event_id" name="report.event_id" value="#rc.event_id#" />
			<input type="hidden" name="report_type" id="report_type" value="hotel_reservations" />
			<h3 class="form-section-title">Hotel Reservations Report Options</h3>
				<div class="form-group">
					<label for="coupon_code_list" class="required">Hotel Name</label>
					<div class="form-group">
						<select name="report.hotel_id" id="hotel_id" class="form-control chosen-select" multiple data-placeholder="Select One or More Hotel Names" required>
							<cfloop from="1" to="#rc.filter_options.hotels.count#" index="local.index">
								<cfset local['hotel'] = rc.filter_options.hotels.data[ local.index ] />
								<option value="#local.hotel.hotel_id#">#local.hotel.hotel_name#</option>
							</cfloop>
						</select>
					</div>
				</div>
				<cfif isdate( rc.filter_options.dates.max ) && isdate( rc.filter_options.dates.min )>
				<div class="form-group">
					<label for="coupon_code_list">Filter by Check In Date <small>(optional)</small></label>
					<div class="form-group">
						<cfset local['days_count'] = dateDiff("d", rc.filter_options.dates.min, rc.filter_options.dates.max ) />

						<select name="report.checkin_date" id="checkin_date" class="form-control chosen-select" multiple data-placeholder="Select One or More Check-In Dates">
							<cfset local['current_date'] = rc.filter_options.dates.min />
							<cfloop from="1" to="#local.days_count#" index="local.index">
								<option value="#dateformat(local.current_date,"mm/dd/yyyy")#">#dateformat(local.current_date,"mm/dd/yyyy")#</option>
								<cfset local['current_date'] = dateAdd( "d", 1, local.current_date ) />
							</cfloop>
						</select>
					</div>
				</div>
				</cfif>
				<div class="form-group">
					<label for="coupon_code_list">Filter by Room Type <small>(optional)</small></label>
					<div class="form-group">
						<select name="report.room_type_id" id="room_type_id" class="form-control chosen-select" multiple data-placeholder="Select One or More Room Types">
							<cfloop from="1" to="#rc.filter_options.room_types.count#" index="local.index">
								<cfset local['room_type'] = rc.filter_options.room_types.data[ local.index ] />
								<option value="#local.room_type.room_type_id#">#local.room_type.room_type#</option>
							</cfloop>
						</select>
					</div>
				</div>
				
				<div class="form-group">
					<button type="submit" class="btn btn-lg btn-block btn-success">Generate Report</button>
					<a href="##" data-toggle="modal" data-target="##schedule-modal" class="btn btn-lg btn-block btn-primary">Save and Schedule for Later</a>
				</div>
			</form>
		</div>
	</div>

	<!--- Results table columns should be:
			Attendee Name
			Hotel Name
			Check-In Date
			Check-Out Date
			Number of Rooms Reserved
			Room Type
			Reservation Name
			Reservation Number
			Reservation Email --->

	<div id="report-recap" class="col-md-6">
		<h4>Coupon Codes Report Recap</h4>
		<p>The following report will generate a list of attendees who used coupon codes</p>
		<ul class="mt-small">
			<li>Attendee Name</li>
			<li>Hotel Name</li>
			<li>Check-In Date</li>
			<li>Check-Out Date</li>
			<li>Number of Rooms Reserved</li>
			<li>Room Type</li>
			<li>Reservation Contact Name</li>
			<li>Reservation Contact Phone Number</li>
			<li>Reservation Contact Email</li>
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