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
			  <li class="active">Email Management</li>
			</ol>
			<div id="action-btns" class="pull-right">
				<a href="event-email-defaults.cfm" class="btn btn-lg btn-default">Configure Defaults</a>
				<a href="event-email-send.cfm" class="btn btn-lg btn-warning">Email Sending Tool</a>
			</div>
			<h2 class="page-title color-03">Email Management</h2>
			<p class="page-subtitle">In this section, manage email content for your event. Choose when to send emails, who to send them to, and much more.</p>
			<h3 class="form-section-title mt-large">
				Invitation Emails
				<a href="event-email-create-invitation.cfm" class="btn btn-lg btn-info pull-right">Create New Invitation</a>
			</h3>
				<table id="attendee-select-table" class="table table-striped table-hover">
					<thead>
						<tr>
							<th style="width: 30%;">Email Name</th>
							<th style="width: 60%;">Subject</th>
							<th style="width: 10%;">Options</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Save the Date</td>
							<td>Lorem ipsum dolor sit amet, consectetur adipisicing elit!!</td>
							<td>
								<a href="event-email-save-date.cfm" class="btn btn-sm btn-primary">Set Content</a>
							</td>
						</tr>
						<tr>
							<td>Preconference Invite</td>
							<td>Lorem ipsum dolor sit amet, consectetur adipisicing elit!!</td>
							<td>
								<a href="event-email-preconf.cfm" class="btn btn-sm btn-primary">Set Content</a>
							</td>
						</tr>
						<tr>
							<td>Managers Custom Preconference Email</td>
							<td>Lorem ipsum dolor sit amet, consectetur adipisicing elit!!</td>
							<td>
								<a href="event-email-custom-01.cfm" class="btn btn-sm btn-primary">Set Content</a>
							</td>
						</tr>
					</tbody>
				</table>
				<h3 class="form-section-title mt-large">System Generated Emails</h3>
				<table id="attendee-select-table" class="table table-striped table-hover">
					<thead>
						<tr>
							<th style="width: 30%;">Email Name</th>
							<th style="width: 60%;">Subject</th>
							<th style="width: 10%;">Options</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>System Generated</td>
							<td>Registration Confirmation</td>
							<td>
								<a href="event-email-reg-confirm.cfm" class="btn btn-sm btn-primary">Set Content</a>
							</td>
						</tr>
						<tr>
							<td>System Generated</td>
							<td>Substitution Confirmation</td>
							<td>
								<a href="event-email-sub-confirm.cfm" class="btn btn-sm btn-primary">Set Content</a>
							</td>
						</tr>
						<tr>
							<td>System Generated</td>
							<td>Cancellation Confirmation</td>
							<td>
								<a href="event-email-canc-confirm.cfm" class="btn btn-sm btn-primary">Set Content</a>
							</td>
						</tr>
						<tr>
							<td>System Generated</td>
							<td>Payment Reminder</td>
							<td>
								<a href="event-email-payment-reminder.cfm" class="btn btn-sm btn-primary">Set Content</a>
							</td>
						</tr>
					</tbody>
				</table>
				<h3 class="form-section-title mt-large">
					Communications
					<a href="" class="btn btn-lg btn-info pull-right">Create New Communication</a>
				</h3>
				<table id="attendee-select-table" class="table table-striped table-hover">
					<thead>
						<tr>
							<th style="width: 30%;">Email Name</th>
							<th style="width: 60%;">Subject</th>
							<th style="width: 10%;">Options</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Communication</td>
							<td>Organizer Summary</td>
							<td>
								<a href="event-email-organizer-summary.cfm" class="btn btn-sm btn-primary">Set Content</a>
							</td>
						</tr>
						
					</tbody>
				</table>
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>