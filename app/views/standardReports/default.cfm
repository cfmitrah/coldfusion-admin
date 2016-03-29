<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li class="active">Standard Reports</li>
</ol>
<!---
<div id="action-btns" class="pull-right">
	<a href="#buildURL( 'standardReports.AttendeeRegistrationsFieldsReport' )#" class="btn btn-lg btn-info">Export All Question Fields</a>
</div>
--->
<div id="action-btns" class="pull-right">
	<a href="#buildURL( 'scheduledReports' )#" class="btn btn-lg btn-warning">View Scheduled Reporting</a>
</div>

<h2 class="page-title color-01">Reporting</h2>

<p class="page-subtitle">Choose which report you would like to configure below.</p>

<div class="well">
	<h3 class="form-section-title">Standard Reporting Options</h3>
	<div id="groups-tile-wrap" class="cf reporting-tiles">
		<div class="tile tile-primary">
			<div class="tile-header">Registration List</div>
			<div class="tile-content">
				<p><strong>Listing of all registered attendees</strong></p>
				<ul>
					<li>Attendee ID</li>
					<li>Name</li>
					<li>Company</li>
					<li>Registration Type</li>
					<!--- <li>Registration Status</li> --->
					<li>Total Charges</li>
					<li>Balance Due</li>
					<li>Date Registered</li>
				</ul>
			</div>
			<div class="tile-footer">
				<a href="#buildURL( 'standardReports.registeredAttendeesReport' )#" class="btn btn-block btn-success">Select Report and Set Options</a>
			</div>
		</div>
		<div class="tile tile-primary">
			<div class="tile-header">Agenda Participants</div>
			<div class="tile-content">
				<p><strong>Listing of participants grouped for each agenda item.</strong></p>
				<ul>
					<li>Agenda Label</li>
					<li>Agenda Location</li>
					<li>Session Label</li>
					<li>Session Category</li>
					<li>Attendee ID</li>
					<li>Name</li>
					<li>Company</li>
					<li>Registration Type</li>
					<li>Attendee Email</li>
					<li>Attendee phone</li>
					<li>Date Registered</li>
					
				</ul>
			</div>
			<div class="tile-footer">
				<a href="#buildURL( 'standardReports.agendaParticipantsReport' )#" class="btn btn-block btn-success">Select Report and Set Options</a>
			</div>
		</div>
		<div class="tile tile-primary">
			<div class="tile-header">Financial Transaction Detail</div>
			<div class="tile-content">
				<p><strong>Listing of financial transactions for an event </strong></p>
				<ul>
					<li>Registration Company</li>
					<li>Attendee Name</li>
					<li>Transaction Type (e.g. Fee, Cancel, Discount, Refund, etc)</li>
					<li>Transaction Date</li>
					<li>Amount</li>
					<li>Payment Type (e.g. Credit Card, Invoice, On-Site)</li>
					<li>Transaction Description</li>
				</ul>
			</div>
			<div class="tile-footer">
				<a href="#buildURL( 'standardReports.financialTransactionsReport' )#" class="btn btn-block btn-success">Select Report and Set Options</a>
			</div>
		</div>
		<div class="tile tile-primary">
			<div class="tile-header">Registration Fees</div>
			<div class="tile-content">
				<p><strong>Summary of registration fees</strong></p>
				<ul>
					    <li>Registration Company Name</li>
						<li>Total of Amount collected</li>
						<li>Total of Transaction Fees</li>
						<li>Number of Attendees registered</li>
						<li>Balance Due</li>
				</ul>
			</div>
			<div class="tile-footer">
				<a href="#buildURL( 'standardReports.registrationSummaryReport' )#" class="btn btn-block btn-success">Select Report and Set Options</a>
			</div>
		</div>
	</div>
	<div id="groups-tile-wrap" class="cf reporting-tiles">
		<div class="tile tile-primary">
			<div class="tile-header">Invitation Status</div>
			<div class="tile-content">
				<p><strong>Summary of invitation status report</strong></p>
				<ul>
					    <li>Registration Company Name</li>
						<li>Invitation Label</li>
						<li>Event Name</li>
						<li>First Name/Last Name</li>
						<li>Email Address</li>
						<li>Viewed Status</li>
						<li>Registered Status</li>
						<li>Send Date</li>
				</ul>
			</div>
			<div class="tile-footer">
				<a href="#buildURL( 'standardReports.invitationStatusReport' )#" class="btn btn-block btn-success">Select Report and Set Options</a>
			</div>
		</div>
		<div class="tile tile-primary">
			<div class="tile-header">All Fields Export</div>
			<div class="tile-content">
				<p><strong>All custom fields for the event will be displayed</strong></p>
			</div>
			<div class="tile-footer">
				<a href="#buildURL( 'standardReports.allFieldsExportReport' )#" class="btn btn-block btn-success">Select Report and Set Options</a>
			</div>
		</div>
		<div class="tile tile-primary">
			<div class="tile-header">Coupon Codes</div>
			<div class="tile-content">
				<p><strong>Displays coupon code information per attendee</strong></p>
				<ul>
				    <li>Attendee Name</li>
					<li>Attendee Email</li>
					<li>Coupon Code Used</li>
					<li>Coupon Code Amount Applied</li>
					<li>Total Cost Before Coupon</li>
					<li>Total Cost After Coupon</li>
				</ul>
			</div>
			<div class="tile-footer">
				<a href="#buildURL( 'standardReports.couponReport' )#" class="btn btn-block btn-success">Select Report and Set Options</a>
			</div>
		</div>
		<div class="tile tile-primary">
			<div class="tile-header">Hotel Reservations</div>
			<div class="tile-content">
				<p><strong>Displays hotel reservation information per attendee</strong></p>
				<ul>
					<li>Attendee Name</li>
					<li>Hotel Name</li>
					<li>Check-In Date</li>
					<li>Check-Out Date</li>
					<li>Number of Rooms Reserved</li>
					<li>Room Type</li>
					<li>Reservation Name</li>
					<li>Reservation Number</li>
					<li>Reservation Email</li>
				</ul>
			</div>
			<div class="tile-footer">
				<a href="#buildURL( 'standardReports.hotelReservationsReport' )#" class="btn btn-block btn-success">Select Report and Set Options</a>

			</div>
		</div>
	</div>	
</div>

</cfoutput>