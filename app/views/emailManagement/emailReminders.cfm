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
<h2 class="page-title color-03">Email Reminders</h2>
<p class="page-subtitle">Send email reminders to invites that have not accepted the invitation</p>
<form action="#buildURL( 'emailManagement.doGetInvitation' )#" method="post" class="basic-wrap mt-medium validate-frm">
	<div class="container-fluid">
		<h3 class="form-section-title">Basic Information</h3>
		<div class="row">
			<div id="email-test-or-live" class="form-group col-md-6 col-md-offset-3 hiddenbox">
				<label for="invitation_id">Please select the invitation</label>
				<select name="email.invitation_id" id="send_type" class="form-control">
					#rc.email_label_opts#
				</select>
			</div>
		</div>	
		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg"><strong>Get Open Invitations</strong></button>
		</div>
	</div>	
</form>
</cfoutput>