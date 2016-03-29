<cfoutput>
	<div class="tab-pane" id="agenda-item-waitlist">
		<h3 class="form-section-title">Attendee Capacity Settings</h3>
		<form action="#buildURL('agendas.doCreateCapacity')#" method="post" role="form">
			<input type="hidden" name="agenda.agenda_id" value="#rc.agenda.agenda_id#" />
			<div class="form-group">
				<label for="">Does this session have limited seating?</label>
				<div class="cf">
					<div class="radio pull-left">
						<label for="limited-yes">
							<input data-hidden_div="limited-yes-box" value="1"  type="radio" name="attendance_limit" class="attendance_limit" id="limited-yes" #rc.checked[ rc.agenda.attendance_limit gt 0 ]#> Yes
						</label>
					</div>
					<div class="radio pull-left">
						<label for="limited-no">
							<input data-hidden_div="limited-yes-box" value="0"  type="radio" name="attendance_limit" class="attendance_limit" id="limited-no" #rc.checked[ rc.agenda.attendance_limit eq 0 ]#> No
						</label>
					</div>
				</div>
			</div>
			<div id="limited-yes-box" class="hiddenbox" style="display: #rc.display_limited_seating#;">
				<div class="form-group">
					<label for="">Set max number of attendees allowed</label>
					<input type="number" name="agenda.attendance_limit" class="form-control width-sm" id="attendance_limit" value="#rc.agenda.attendance_limit#">
				</div>
				<!--- <div class="form-group">
					<label for="">If max capacity reached, should there be a wait list?</label>
					<div class="cf">
						<div class="radio pull-left">
							<label for="waitlist-yes">
								<input data-hidden_div="waitlist-yes-box" value="1" type="radio" name="agenda.waitlist" id="waitlist-yes" #rc.checked[ rc.agenda.waitlist eq 1 ]#> Yes
							</label>
						</div>
						<div class="radio pull-left">
							<label for="waitlist-no">
								<input data-hidden_div="waitlist-yes-box" value="0" type="radio" name="agenda.waitlist" id="waitlist-no" #rc.checked[ rc.agenda.waitlist eq 0 ]#> No
							</label>
						</div>
					</div>
				</div> --->
			</div>
			<!--- <div id="waitlist-yes-box" class="hiddenbox" style="display: #rc.display_waitlist#;">
				<h3 class="form-section-title">Wait List Options</h3>
				<p class="attention">Below are the attendees who currently signed up for the waitlist, as well as the current seats available from cancellations. You can choose which attendees receive the now open remaining seats.</p>
				<div class="alert alert-info">
					<strong>Current Open Seat Count:</strong> #rc.agenda.open_seats#
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
						<cfloop from="1" to="#rc.wait_list.wait_list_cnt#" index="i">
							<tr>
								<td>#rc.wait_list.wait_list[i].first_name#</td>
								<td>#rc.wait_list.wait_list[i].last_name#</td>
								<td>#rc.wait_list.wait_list[i].email#</td>
								<td>#dateFormat( rc.wait_list.wait_list[i].waitlisted_on, "mm/dd/yyyy" )# #timeFormat( rc.wait_list.wait_list[i].waitlisted_on, "h:mm tt" )#</td>
								<td><a href="##">Assign Seat and Send Notification Email</a></td>
							</tr>
						</cfloop>	
					</tbody>
				</table>
			</div> --->
			<hr>
			<div class="cf">
				<button type="submit" class="btn btn-success btn-lg pull-right">Update Capacity Settings</button>
			</div>
		</form>
	</div>
</cfoutput>