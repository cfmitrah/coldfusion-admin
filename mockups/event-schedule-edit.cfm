<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<cfinclude template="shared/event-sidebar.cfm"/>

	<!--- Sidebar Ends Content Starts --->
	<div id="main-content-wrapper" class="has-sidebar">
		<div id="main-content">
			<ol class="breadcrumb">
			  <li><a href="#">Dashboard</a></li>
			  <li><a href="#">Events</a></li>
			  <li><a href="#">Event Name</a></li>
			  <li><a href="#">Schedule</a></li>
			  <li class="active">Edit Agenda Item</li>
			</ol>
			<h2 class="page-title color-02">Sample Session Name</h2>
			<p class="page-subtitle">Edit specifics related to this agenda item such as time, fees, restrictions and more.</p>
			<!-- Nav tabs -->
			<ul class="nav nav-tabs mt-medium" role="tablist">
				<li class="active"><a href="#agenda-item-main" role="tab" data-toggle="tab">Main Details</a></li>
				<li><a href="#agenda-item-fees" role="tab" data-toggle="tab">Associated Fees</a></li>
				<li><a href="#agenda-item-waitlist" role="tab" data-toggle="tab">Attendee Capacity Settings</a></li>
				<li><a href="#agenda-item-restrictions" role="tab" data-toggle="tab">Restrictions</a></li>
			</ul>

			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane active" id="agenda-item-main">
					<h3 class="form-section-title">Main Details</h3>
					<form action="">
						<div class="form-group">
							<label for="">Day of Session</label>
							<input type="text" class="form-control dateonly-datetime">
						</div>
						<div class="form-group">
							<label for="">Start Time</label>
							<input type="text" class="form-control timeonly-datetime">
						</div>
						<div class="form-group">
							<label for="">End Time</label>
							<input type="text" class="form-control timeonly-datetime">
						</div>
						<div class="form-group">
							<label for="">Location</label>
							<select name="" id="" class="form-control">
								<option value="">Ballroom</option>
							</select>
						</div>
						<div class="form-group">
							<label for="">Location not listed above? You can enter a new one below</label>
							<input type="text" class="form-control">
						</div>
						<div class="form-group">
							<label for="" class="required">Hide on Agenda?</label>
							<div class="cf">
								<div class="radio pull-left">
									<label for="visible-yes">
										<input type="radio" name="radio-visible" /> Yes
									</label>
								</div>
								<div class="radio pull-left">
									<label for="visible-no">
										<input type="radio" name="radio-visible" id="visible-no" checked/> No
									</label>
								</div>
							</div>
						</div>
						<div class="cf">
							<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Update Agenda Item Essentials</strong></button>
						</div>
					</form>
				</div>
				
				<div class="tab-pane" id="agenda-item-fees">
					<h3 class="form-section-title">Existing Fees for Session</h3>
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Fee Name</th>
								<th>Fee Amount</th>
								<th>Attendees to Receive</th>
								<th>Start Date</th>
								<th>End Date</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Early Bird Registration</td>
								<td>$120.00</td>
								<td>
									<span class="label label-success">Attendee Type One</span>
									<span class="label label-success">Attendee Type Two</span>
								</td>
								<td>7/31/2014</td>
								<td>8/2/2014</td>
								<td><a href="#" class="btn btn-sm btn-danger">Remove Fee</a></td>
							</tr>
						</tbody>
					</table>
					<hr>
					<h3 class="form-section-title">Add New Fee</h3>
					<p class="attention">Use the form below to assign a new fee to this session. Existing fees can be viewed in the table below.</p>
					<form action="">
						<div class="form-group">
							<label for="">Fee Name</label>
							<input type="text" class="form-control width-md" id="">
						</div>
						<div class="form-group">
							<label for="">Enter Fee Amount</label>
							<input type="number" class="form-control width-sm" id="" placeholder="ex: 500.00">
						</div>
						<div class="form-group">
							<label for="">Select which attendee types should receive this fee</label>
							<div class="checkbox">
							    <label>
							    	<input type="checkbox" checked> Attendee Type One
							    </label>
							</div>
							<div class="checkbox">
							    <label>
							    	<input type="checkbox" checked> Attendee Type Two
							    </label>
							</div>
							<div class="checkbox">
							    <label>
							    	<input type="checkbox" checked> Attendee Type Three
							    </label>
							</div>
							<div class="checkbox">
							    <label>
							    	<input type="checkbox" checked> Attendee Type Four
							    </label>
							</div>
						</div>
						<div class="form-group">
							<label for="">Should this fee be tied to a certain date range only? (Used for early bird pricing, late registrations, etc)</label>
							<div class="cf">
								<div class="radio pull-left">
									<label for="fee-date-yes">
										<input type="radio" name="radio-fee-date" id="fee-date-yes" class="formShowHide_ctrl" data-show-id="fee-date-yes-box" /> Yes
									</label>
								</div>
								<div class="radio pull-left">
									<label for="fee-date-no">
										<input type="radio" name="radio-fee-date" id="fee-date-no" checked  /> No
									</label>
								</div>
							</div>
						</div>
						<div id="fee-date-yes-box" class="hiddenbox">
							<div class="form-group">
								<label for="">Fee Start Date</label>
								<input type="text" class="form-control  std-datetime width-sm">
							</div>
							<div class="form-group">
								<label for="">Fee End Date</label>
								<input type="text" class="form-control  std-datetime width-sm">
							</div>
						</div>
						<div class="cf">
							<button type="submit" class="btn btn-success btn-lg pull-right">Add Fee</button>
						</div>
					</form>
					
				</div>

				<div class="tab-pane" id="agenda-item-waitlist">
					<h3 class="form-section-title">Attendee Capacity Settings</h3>
					<form action="">
						<div class="form-group">
							<label for="">Does this session have limited seating?</label>
							<div class="cf">
								<div class="radio pull-left">
									<label for="limited-yes">
										<input type="radio" name="radio-limited" id="limited-yes" class="formShowHide_ctrl" data-show-id="limited-yes-box" /> Yes
									</label>
								</div>
								<div class="radio pull-left">
									<label for="limited-no">
										<input type="radio" name="radio-limited" id="limited-no" checked  /> No
									</label>
								</div>
							</div>
						</div>
						<div id="limited-yes-box" class="hiddenbox">
							<div class="form-group">
								<label for="">Set max number of attendees allowed</label>
								<input type="number" class="form-control width-sm" id="">
							</div>
							<div class="form-group">
								<label for="">If max capacity reached, should there be a wait list?</label>
								<div class="cf">
									<div class="radio pull-left">
										<label for="waitlist-yes">
											<input type="radio" name="radio-waitlist" id="waitlist-yes" class="formShowHide_ctrl" data-show-id="waitlist-yes-box" /> Yes
										</label>
									</div>
									<div class="radio pull-left">
										<label for="waitlist-no">
											<input type="radio" name="radio-waitlist" id="waitlist-no" checked/> No
										</label>
									</div>
								</div>
							</div>
						</div>
						<div id="waitlist-yes-box" class="hiddenbox">
							<h3 class="form-section-title">Wait List Options</h3>
							<p class="attention">Below are the attendees who currently signed up for the waitlist, as well as the current seats available from cancellations. You can choose which attendees receive the now open remaining seats.</p>
							<div class="alert alert-info">
								<strong>Current Open Seat Count:</strong> 4
							</div>

							<table class="table table-striped">
								<thead>
									<tr>
										<th>First Name</th>
										<th>Last Name</th>
										<th>Email Address</th>
										<th>Date Joined Waitlist</th>
										<th>Options</th>
									</tr>
								</thead>
								<tbody>
									<cfloop from="1" to="7" index="i">
										<tr>
											<td>FirstName</td>
											<td>LastName</td>
											<td>name@emailaddress.com</td>
											<td>7/29/2014 5:00 PM</td>
											<td><a href="">Assign Seat and Send Notification Email</a></td>
										</tr>
									</cfloop>
									
								</tbody>
							</table>
						</div>
						<hr>
						<div class="cf">
							<button type="submit" class="btn btn-success btn-lg pull-right">Update Capacity Settings</button>
						</div>
					</form>
				</div>

				<div class="tab-pane" id="agenda-item-restrictions">
					<h3 class="form-section-title">Set Restrictions</h3>
					<form action="">
						<div class="form-group">
							<label for="">Limit which attendee types can see this session item on their agenda</label>
							<div class="alert alert-warning">The checked attendee types will NOT be able to see this session on their agenda. By default all attendee types can see a session.</div>
							<div class="checkbox">
							    <label>
							    	<input type="checkbox"> Attendee Type One
							    </label>
							</div>
							<div class="checkbox">
							    <label>
							    	<input type="checkbox"> Attendee Type Two
							    </label>
							</div>
							<div class="checkbox">
							    <label>
							    	<input type="checkbox"> Attendee Type Three
							    </label>
							</div>
							<div class="checkbox">
							    <label>
							    	<input type="checkbox"> Attendee Type Four
							    </label>
							</div>
						</div>
						<div class="cf">
							<button type="submit" class="btn btn-success btn-lg pull-right">Update Restriction Settings</button>
						</div>
					</form>
				</div>

				

				

			</div>	
		</div>
	</div>
</div>


<cfinclude template="shared/footer.cfm"/>