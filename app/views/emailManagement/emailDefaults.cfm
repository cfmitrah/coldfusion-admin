<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'emailManagement.default' )#">Email Management</a></li>
  <li class="active">Configure Email Defaults</li>
</ol>
<h2 class="page-title color-03">Configuring Email Defaults</h2>
<p class="page-subtitle">The settings you provide here will carry over to each email type as a default value, until they are overwritten at the manage email level.</p>
<form action="#buildURL( 'emailManagement.doSaveEmailDefaults' )#" class="basic-wrap mt-medium validate-frm"  method="post" enctype="multipart/form-data" data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden">
	<input type="hidden" name="email.event_id" value="#rc.event_id#" />
	<input type="hidden" name="email.header_media_id" value="#rc.email_defaults.header_media_id#" />
	<div class="container-fluid">
		<h3 class="form-section-title">Set Email Defaults</h3>
		<div class="row">
			<div class="form-group col-md-6">
				<label for="from_email" class="required">Default From Address:</label>
				<input name="email.from_email" id="from_email" type="email" class="form-control" value="#rc.email_defaults.from_email#" required>
			</div>
			<div class="form-group col-md-6">
				<label for="subject" class="required">Default Subject Line:</label>
				<input name="email.subject" id="subject" type="text" class="form-control" value="#rc.email_defaults.subject#" required>
			</div>
		</div>
		<div class="row">
			<div class="form-group col-md-6">
				<label for="" class="required">Default Email Header Image:</label>
				<input name="email.header_image" id="header_image" type="file" class="form-control">
				<p class="help-block">
					600 x 120 jpg or png <br>
					<span class="text-danger">Uploading a new image will remove the current one.</span>
				</p>
			</div>
			<div class="form-group col-md-6">
				<label for="" class="required">Current Default Email Header:</label><br>
				<Cfif rc.email_defaults.has_header>
					<img src="/assets/media/#rc.email_defaults.header_filename#" width="600" />
				<cfelse>
					<p>No default header image on file</p>
				</Cfif>
			</div>
		</div>
		
		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg"><strong>Save Default Settings</strong></button>
		</div>
	</div>
</form>
</cfoutput>
