<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'emailManagement.default' )#">Email Management</a></li>
  <li class="active">Create System Generated Email</li>
</ol>
<h2 class="page-title color-03">Create System Generated Email</h2>
<p class="page-subtitle">Select the type of system generated email that you would like to create</p>
<form action="#buildURL( 'emailManagement.createAutoResponderEmail' )#" class="basic-wrap mt-medium"  method="post">
	<div class="container-fluid">
		<h3 class="form-section-title">Choose The System Type</h3>
		<div class="row">
			<div class="form-group  col-md-6 col-md-offset-3 hiddenbox">
				<label for="autoresponder_type" class="required">System Type:</label>
				<select name="email.autoresponder_type" id="autoresponder_type" class="form-control" style="text-transform: capitalize">
					#rc.auto_responder_types_opts#
				</select>
			</div>
		</div>
		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg"><strong>Choose System Generated Type</strong></button>
		</div>
	</div>	
</form>
</cfoutput>
