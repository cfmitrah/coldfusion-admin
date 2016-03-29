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
			  <li><a href="event-email-management.cfm">Email Management</a></li>
			  <li class="active">Send Emails</li>
			</ol>
			<h2 class="page-title color-03">Send Emails</h2>
			<p class="page-subtitle">By specifying your settings below you can send test emails, or send offical emails to attendees</p>
			<form action="" class="basic-wrap mt-medium">
				<div class="container-fluid">
					<!--- Basic Settings - Which Email to Send - Test or Live - If invite, show import options --->
					<h3 class="form-section-title">Send Emails</h3>
					<div class="row">
						<!--- Must Select this first --->
						<div class="form-group col-md-6 col-md-offset-3">
							<label for="">Which email do you want to send?</label>
							<select name="" id="" class="form-control formShowHide_ctrl">
								<option value="">Select Email...</option>
								<option value="" data-show-id="email-test-or-live invitation-options">Invitation Sample</option>
								<option value="" data-show-id="email-test-or-live recipient-options">Communication Sample</option>
							</select>
						</div>
						<!--- end Must select this first --->
						
						<!--- Once Selected Show this --->
						<div id="email-test-or-live" class="form-group col-md-6 col-md-offset-3 hiddenbox">
							<label for="">Will this be a test email or an official live email?</label>
							<select name="" id="" class="form-control formShowHide_ctrl">
								<option value="">Select Send Type...</option>
								<option value="" data-show-id="choose-test-addresses">TEST</option>
								<option value="" data-show-id="choose-live-settings">LIVE</option>
							</select>
						</div>
						<!--- end Once selected show this --->
						
						<!--- Show if they select test --->
						<div id="choose-test-addresses" class="form-group col-md-6 col-md-offset-3 hiddenbox">
							<label for="">Who would you like to send this test to?</label>
							<input type="text" class="form-control">
							<p class="help-block">Enter email addresses seperated by a comma</p>
							<br>
							<a href="##" id="send-test-email" class="btn btn-success btn-lg btn-block"><strong>Send Test Email</strong></a>
						</div>
						<!--- End if they select test --->
					</div>
					<!--- End Basic Settings --->
					
					<div id="choose-live-settings" class="row">
						<div class="col-md-12">
							<h3 class="form-section-title">Set Schedule</h3>
						</div>
						<div class="col-md-6 col-md-offset-3">
							<div class="form-group">
								<label for="">Date and Time to Send</label>
								<input type="text" class="std-datetime form-control">
							</div>
						</div>

						<!--- If Live AND an Invite - Show this --->
						<div id="invitation-options" style="display: none;">
							<div class="col-md-12">
								<h3 class="form-section-title">Invitation Options</h3>
							</div>
							<div class="form-group col-md-6 col-md-offset-3">
								<div class="form-group">
									<label for="">How would you like to import email addresses for invitation?</label>
									<div class="radio">
									    <label>
									    	<input type="radio" name="import-options" id="import-options-1"> Import from spreadsheet
									    </label>
									</div>
									<div class="radio">
									    <label>
									    	<input type="radio" name="import-options" id="import-options-2"> Comma Seperated Values
									    </label>
									</div>
								</div>
							</div>
						</div>
						<!--- End If LIve and invite show this --->
						
						<!--- If Live AND a Communication - Show this --->
						<div id="recipient-options" style="display: none;">
							<div class="col-md-12">
								<h3 class="form-section-title">Recipient Information</h3>
							</div>
							<div class="col-md-6 col-md-offset-3">
								<div class="form-group">
									<label class="required">Who would you like to send this to?</label>
									<div class="radio">
									    <label>
									    	<input type="radio" name="recipient-settings"> Select all attendees
									    </label>
									</div>
									<div class="radio">
									    <label>
									    	<input type="radio" name="recipient-settings" id="recipient-settings-1" class="formShowHide_ctrl" data-show-id="choose-attendee-types"> Choose specific attendee types to receive this email
									    </label>
									</div>
									<div class="radio">
									    <label>
									    	<input type="radio" name="recipient-settings" id="recipient-settings-2" class="formShowHide_ctrl" data-show-id="choose-attendees"> Select individual attendees
									    </label>
									</div>
								</div>
								<div id="choose-attendee-types" class="hiddenbox">
									<div class="form-group">
										<label for="">Check which attendee types will receive this email</label><br>
									    <div class="checkbox">
										    <label>
										    	<input type="checkbox"> Sample Attendee Type 1
										    </label>
									    </div>
									    <div class="checkbox">
										    <label>
										    	<input type="checkbox"> Sample Attendee Type 2
										    </label>
									    </div>
									    <div class="checkbox">
										    <label>
										    	<input type="checkbox"> Sample Attendee Type 3
										    </label>
									    </div>
									</div>
								</div>
							</div>

							<div class="col-md-12">
								<div id="choose-attendees" class="hiddenbox">
									<div class="alert alert-info">You can select all attendees at once by clicking the checkbox in the header row</div>
									<table id="attendee-select-table" class="table table-striped table-hover">
										<thead>
											<tr>
												<th class="text-center"><input type="checkbox" class="select-all"></th>
												<th>First Name</th>
												<th>Last Name</th>
												<th>Email Address</th>
												<th>Attendee Type</th>
												<th>Status</th>
											</tr>
										</thead>
										<tbody>
											<cfloop from="1" to="100" index="i">
												<tr>
													<td class="text-center"><input type="checkbox"></td>
													<td>Spencer</td>
													<td>Bailey</td>
													<td>spencer@excelaweb.com</td>
													<td>General</td>
													<td>Active</td>
												</tr>
											</cfloop>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<!--- End If LIve and Communication show this --->

						<div class="form-group col-md-6 col-md-offset-3">
							<div class="alert alert-danger">This email will send to the attendees listed above on the date provided. Be sure to send a test version to yourself to approve of the content before you sent to specified attendees.</div>
							
							<a href="##" id="send-live-email" class="btn btn-success btn-lg btn-block"><strong>Save Send Settings</strong></a>
						</div>
					</div>
				</div>
			</form>
				
			<div class="basic-wrap mt-large">
				<h3 class="form-section-title">Email History</h3>
				<div class="row">
					<div class="col-md-12">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Type</th>
									<th>Name</th>
									<th>Sent to</th>
									<th>Send Date</th>
									<th>Status</th>
									<th>Options</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>Invitation</td>
									<td>Save The Date</td>
									<td>All Attendees</td>
									<td>9/18/2014 12:00 PM</td>
									<td>Sent</td>
									<td></td>
								</tr>
								<tr>
									<td>Invitation</td>
									<td>Preconference Invite</td>
									<td>All Attendees</td>
									<td>9/20/2014 12:00 PM</td>
									<td>Pending</td>
									<td><a href="" class="btn btn-sm btn-danger">Cancel</a></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			
		</div>
	</div>

</div>

<script>
$(function(){
	var dTable = $('#attendee-select-table').dataTable(); 
	$('.select-all').click( function() {
	    $('input', dTable.fnGetNodes()).attr('checked',this.checked);
	} );
});
</script>


<cfinclude template="shared/footer.cfm"/>