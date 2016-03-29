<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'emailManagement.default' )#">Email Management</a></li>
  <li class="active">Email Reminders</li>
</ol>
</cfoutput>
<cfoutput>
<h2 class="page-title color-03">Open Invitations for #rc.invites.invite_label#</h2>
<p class="page-subtitle">Below you will find the open invitations for #rc.invites.invite_label#.</p>
	<div class="container-fluid basic-wrap mt-medium">
		<form id="resubmit" action="#buildURL( 'emailManagement.doGetInvitation' )#" method="post" class="">
			<input type="hidden" name="email.company_id" value="#rc.company_id#" />
			<input type="hidden" name="email.event_id" value="#rc.event_id#" />
			<div class="row">
				<div id="email-test-or-live" class="form-group col-md-6 col-md-offset-3 hiddenbox">
					<label for="invitation_id">Please select the invitation:</label>
					<select name="email.invitation_id" id="invitation_id" class="form-control">
						<option value="none">Select An Invitation</option>
						#rc.email_label_opts#
					</select>
				</div>
			</div>	
		</form>	
		<table id="open_invitations" class="table table-striped table-hover data-table tm-large" >
			<thead>
			<tr>
				<th>Invite First Name</th>
				<th>Invite Last Name</th>
				<th>Invite Email</th>
			</tr>
			</thead>
			<tbody>
				<cfloop from="1" to="#rc.invites.open_invites_cnt#" index="local.i">	
					<tr>
						<td>#rc.invites.open_invites[ local.i ].first_name#</td>
						<td>#rc.invites.open_invites[ local.i ].last_name#</td>
						<td>#rc.invites.open_invites[ local.i ].email#</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
		
		<form action="#buildURL( 'emailManagement.doSendReminders' )#" method="post" class="">
			<input type="hidden" name="email.company_id" value="#rc.company_id#" />
			<input type="hidden" name="email.event_id" value="#rc.event_id#" />
			<input type="hidden" name="email.invitation_id" value="#rc.invitation_id#" />
			<div class="row">
				<div id="email-test-or-live" class="form-group col-md-6 col-md-offset-3 hiddenbox">
					<label for="invitation_id">Choose which email you would like to send out as a reminder:</label>
					<select name="email.new_invitation_id" id="send_type" class="form-control">
						#rc.email_label_opts#
					</select>
				</div>
			</div>	
			<div class="cf">
				<button type="submit" class="btn btn-success btn-lg"><strong>Send Reminders Now</strong></button>
			</div>
		</form>
	</div>	
</cfoutput>