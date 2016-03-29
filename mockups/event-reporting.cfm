<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<div id="main-content-wrapper">
		<div id="main-content" class="no-sidebar">
			<ol class="breadcrumb">
			  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
			  <li><a href="">Events</a></li>
			  <li><a href="">Event Name</a></li>
			  <li class="active">Reporting</li>
			</ol>
			<!--- No custom reporting for now
			<div id="action-btns" class="pull-right">
				<a href="event-create.cfm" class="btn btn-lg btn-primary">Create Custom Report</a>
			</div> --->

			<h2 class="page-title color-06">Reporting</h2>
			<p class="page-subtitle">Choose which report you would like to configure below.</p>
			
			<div class="well">
				<h3 class="form-section-title">Standard Reporting Options</h3>
				<div id="groups-tile-wrap" class="cf reporting-tiles">
					<div class="tile tile-primary">
						<div class="tile-header">Registration List Report</div>
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
							<a href="event-reporting-registration-list.cfm" class="btn btn-block btn-success">Choose report and Set Options</a>
						</div>
					</div>
					<div class="tile tile-primary">
						<div class="tile-header">Agenda Participants Report</div>
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
							<a href="event-reporting-agenda-participants.cfm" class="btn btn-block btn-success">Choose Reporting and Set Options</a>
						</div>
					</div>
					<div class="tile tile-primary">
						<div class="tile-header">Financial Transaction Detail Report</div>
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
							<a href="event-reporting-financial-transaction.cfm" class="btn btn-block btn-success">Choose Reporting and Set Options</a>
						</div>
					</div>
					<div class="tile tile-primary">
						<div class="tile-header">Registration Fees Report</div>
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
							<a href="event-reporting-registration-fees.cfm" class="btn btn-block btn-success">Choose Reporting and Set Options</a>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>