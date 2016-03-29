<cfoutput>
<h2 class="page-title color-03">#rc.email_details.page_title#</h2>
<p class="page-subtitle">Manage settings and content for this email below</p>
<form action="#buildURL( 'emailManagement.doSaveInvitationEmail' )#" method="post" enctype="multipart/form-data" class="basic-wrap mt-medium validate-frm" data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden">
	<input type="hidden" name="email.event_id" value="#rc.event_id#" />
	<Cfif len( rc.email_details.invitation_id )>
		<input type="hidden" name="email.invitation_id" value="#rc.email_details.invitation_id#" />
		<input type="hidden" name="email.header_media_id" value="#rc.email_details.header_media_id#" />
	</Cfif>
	<div class="container-fluid">
		<h3 class="form-section-title">Basic Information</h3>
		<div class="row">
			<div class="form-group col-md-12">
				<label for="label" class="required">Email Name: <small>Used to reference later</small></label>
				<input name="email.label" id="label" type="text" class="form-control" value="#rc.email_details.label#" required>
			</div>
		</div>
		<hr> 
		<div class="row">
			<div class="form-group col-md-6">
				<label for="from_email" class="required">From Address:</label>
				<input name="email.from_email" id="from_email" type="text" class="form-control" value="#rc.email_details.from_email#" required>
			</div>
			<div class="form-group col-md-6">
				<label for="subject" class="required">Subject Line:</label>
				<input name="email.subject" id="subject" type="text" class="form-control" value="#rc.email_details.subject#" required>
			</div>
		</div>
		<div class="row">
			<div class="form-group col-md-6">
				<label for="header_image" class="required">Email Header Image:</label>
				<input name="email.header_image" id="header_image" type="file" class="form-control">
				<p class="help-block">
					600 x 120 jpg or png <br>
					<span class="text-danger">Uploading a new image will remove the current one.</span>
				</p>
			</div>
			<div class="form-group col-md-6">
				<label for="" class="required">Current Email Header:</label><br>
				<Cfif len( rc.email_details.header_filename )>
					<img src="/assets/media/#rc.email_details.header_filename#" class="img-responsive" alt="" width="600">
				<cfelse>
					<img src="//placehold.it/600x120&text=No+Current+Image" class="img-responsive" alt="">
				</Cfif>
			</div>
		</div>
		<div class="row">
			<div class="form-group col-md-6">
				<label>Remove Current Email Header Image</label>
				<div class="cf">
					<div class="radio pull-left">
						<label for="remove-yes">
							<input value="1" type="radio" name="email.remove_image" class="remove" id="remove-yes"> Yes
						</label>
					</div>
					<div class="radio pull-left">
						<label for="remove-no">
							<input value="0" type="radio" name="email.remove_image" class="remove" id="remove-no" checked="checked"> No
						</label>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<label>Display Accept/Decline Buttons</label>
				<div class="cf">
					<div class="radio pull-left">
						<label for="remove-yes">
							<input value="1" type="radio" name="email.response" class="remove" id="remove-yes"  #rc.checked[ rc.has_response eq true ]#> Yes
						</label>
					</div>
					<div class="radio pull-left">
						<label for="remove-no">
							<input value="0" type="radio" name="email.response" class="remove" id="remove-no" #rc.checked[ rc.has_response eq false ]#> No
						</label>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="form-group col-md-6">
				<label for="bcc" class="">BCC Address:</label>
				<input name="email.bcc" id="bcc" type="email" class="form-control" value="#rc.email_details.bcc#">
			</div>
			<div class="form-group col-md-6">
				<label for="registration_type">Registration Type</label>
				<select class="form-control" name="email.registration_type_id">
					<option value="0">-- Let Attende Choose Path --</option>
					#rc.registration_opts#
				</select>
			</div>
		</div>
		<h3 class="form-section-title">Button Styling</h3>
		<div class="row">
			<div class="form-group col-md-6">
				<label for="settings_accept_button_text" class="required">"Accept" Button Text:</label>
				<input name="email.settings.accept.btn_text" id="settings_accept_button_text" type="text" class="form-control" value="#rc.email_details.settings.accept.btn_text#" required>
			</div>
			<div class="form-group col-md-6">
				<label for="settings_accept_button_color" class="required">"Accept" Button Color:</label>
				<input name="email.settings.accept.btn_color" id="settings_accept_button_color" type="text" class="form-control  color-input" value="#rc.email_details.settings.accept.btn_color#" required>
			</div>
		</div>
		<div class="row">
			<div class="form-group col-md-6">
				<label for="from_email" class="required">"Decline" Button Text:</label>
				<input name="email.settings.decline.btn_text" id="settings_decline_button_text" type="text" class="form-control" value="#rc.email_details.settings.decline.btn_text#" required>
			</div>
			<div class="form-group col-md-6">
				<label for="settings_accept_button_color" class="required">"Decline" Button Color:</label>
				<input name="email.settings.decline.btn_color" id="settings_decline_button_color" type="text" class="form-control color-input" value="#rc.email_details.settings.decline.btn_color#" required>
			</div>
		</div>
		
		<h3 class="form-section-title mt-medium">Email Content</h3>
		<div class="row">
			<div class="col-md-12">
				<textarea required class="ckeditor" id="email_content" name="email.body" rows="20" style="visibility: hidden; display: none;">#rc.email_details.body#</textarea>
				<ul class="mt-medium">
					<li>You can use @@firstname@@ to insert the users firstname.</li>
					<li>You can use @@lastname@@ to insert the users lastname.</li>
					<li>You can use @@email@@ to insert the users email. </li>
				</ul><br>
			</div>
		</div>
		<h3 class="form-section-title mt-medium">Email Footer</h3>
		<div class="row">
			<div class="col-md-12">
				<textarea required class="ckeditor" id="email_Footer" name="email.Footer" rows="20" style="visibility: hidden; display: none;">#rc.email_details.Footer#</textarea>
				<ul class="mt-medium">
					<li>You can use @@firstname@@ to insert the users firstname.</li>
					<li>You can use @@lastname@@ to insert the users lastname.</li>
					<li>You can use @@email@@ to insert the users email. </li>
				</ul><br>
			</div>
		</div>
		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg"><strong>Save Email Content and Settings</strong></button>
		</div>
	</div>
</form>
</cfoutput>