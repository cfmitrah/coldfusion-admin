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
			  <li class="active">Financial Transaction</li>
			</ol>

			<h2 class="page-title color-06">Reporting</h2>
			<p class="page-subtitle">Set the desired options for the Financial Transaction Report below then click "Generate Report"</p>
			
			<form action="event-reporting-generate.cfm" class="basic-wrap col-md-6 mt-medium">
				<h3 class="form-section-title">Financial Transaction Report Options</h3>
				<div class="form-group">
					<label for="">Set a date range: <small>(Leave blank for all dates)</small></label>
					<div class="cf">
						<div class="col-md-3">
							<p class="form-control-static">Start Date:</p>
						</div>
						<div class="col-md-9">
							<input type="date" class="form-control">
						</div>
					</div>
					<div class="cf mt-small">
						<div class="col-md-3">
							<p class="form-control-static">End Date:</p>
						</div>
						<div class="col-md-9">
							<input type="date" class="form-control">
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="">Specify Specific Amount:</label>
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
					<label for="">Specify Attendee ID or Name:</label>
					<input type="text" class="form-control">
				</div>
				<div class="form-group">
					<label for="">Specify Transaction Detail Type:</label>
					<select name="" id="" class="form-control">
						<option value="">All Transaction Types</option>
						<option value="">Agenda Fee</option>
						<option value="">Agenda Cancellation</option>
						<option value="">Discount</option>
						<option value="">Payment</option>
						<option value="">Refund</option>
					</select>
				</div>
				<div class="form-group">
					<label for="">Specify Payment Type:</label>
					<select name="" id="" class="form-control">
						<option value="">All Payment Types</option>
						<option value="">Credit Card</option>
						<option value="">Invoice</option>
						<option value="">On Site</option>
					</select>
				</div>
				<div class="form-group">
					<button type="submit" class="btn btn-lg btn-block btn-success">Generate Report</button>
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
			
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>