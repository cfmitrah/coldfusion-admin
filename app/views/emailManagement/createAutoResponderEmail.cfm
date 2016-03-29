<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'emailManagement.default' )#">Email Management</a></li>
  <li class="active">Edit "#rc.email_details.label#" System Email</li>
</ol>
<h2 class="page-title color-03">#rc.email_details.label#</h2>
<p class="page-subtitle">Manage settings and content for this email below</p>
<form action="#buildURL( 'emailManagement.doSaveAutoResponder' )#" class="basic-wrap mt-medium"  method="post" enctype="multipart/form-data">
	<input type="hidden" name="email.event_id" value="#rc.event_id#" />
	<input type="hidden" name="email.header_media_id" value="#val( rc.email_details.header_media_id )#" />
	<input type="hidden" name="email.autoresponder_type" value="#rc.email_details.autoresponder_type#" />
	<div class="container-fluid">
		<h3 class="form-section-title">Basic Information</h3>
		<div class="row">
			<cfif rc.email_details.autoresponder_type NEQ "decline_invite" >
			<div class="form-group  col-md-6">
				<label for="registration_type_id" class="required">Attendee Type:</label>
				<select name="email.registration_type_id" id="registration_type_id" class="form-control ">
					#rc.registration_opts#
				</select>
			</div>
			<cfelse>
				<input type="hidden" name="email.registration_type_id" id="registration_type_id" value="0" />
			</cfif>
			<div class="form-group col-md-6">
				<label for="from_email" class="required">Label:</label>
				<input name="email.label" id="label" type="text" class="form-control" value="#rc.email_details.label#">
			</div>
		</div>
		<div class="row">
			<div class="form-group col-md-6">
				<label for="from_email" class="required">From Address:</label>
				<input name="email.from_email" id="from_email" type="text" class="form-control" value="#rc.email_details.from_email#">
			</div>
			<div class="form-group col-md-6">
				<label for="subject" class="required">Subject Line:</label>
				<input name="email.subject" id="subject" value="#rc.email_details.subject#" type="text" class="form-control">
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
		</div>
		<div class="row">
			<div class="form-group col-md-6">
				<label for="bcc" class="">BCC Address:</label>
				<input name="email.bcc" id="bcc" type="email" class="form-control" value="#rc.email_details.bcc#">
			</div>
		</div>
		<h3 class="form-section-title mt-small">Email Content</h3>
		<div class="row">
			<div class="col-md-12">
				<label for="before_body" class="required">Before Body Content:</label><br>
				<textarea class="ckeditor" id="before_body" name="email.before_body" rows="20" style="visibility: hidden; display: none;">#rc.email_details.before_body#</textarea>
				<ul class="mt-medium">
					<li>You can use @@firstname@@ to insert the users firstname.</li>
					<li>You can use @@lastname@@ to insert the users lastname.</li>
					<li>You can use @@email@@ to insert the users email. </li>
					<li>You can use @@include_agenda@@ to insert the event agenda. </li>
					<li>You can use @@total_cost@@ to insert the total cost. </li>
					<li>You can use @@total_credits@@ to insert the total credits. </li>
					<li>You can use @@total_due@@ to insert the total due. </li>
					<li>You can use @@total_cancels@@ to insert the total cancelled. </li>
					<li>You can use @@location@@ to insert the location.</li>
					<li>You can use @@dates@@ to insert the dates.</li>
					<li>You can use @@last_payment_type@@ to insert the last payment type.</li>
					<li>You can use @@last_payment_amount@@ to insert the last payment amount.</li>
					<li>You can use @@total_fees@@ to insert the total fees.</li>
					<li>You can use @@last_cancel_amount@@ to insert the last cancel amount.</li>
				</ul> <br>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<label for="after_body" class="required">After Body Content:</label><br>
				<textarea class="ckeditor" id="after_body" name="email.after_body" rows="20" style="visibility: hidden; display: none;">#rc.email_details.after_body#</textarea>
				<ul class="mt-medium">
					<li>You can use @@firstname@@ to insert the users firstname.</li>
					<li>You can use @@lastname@@ to insert the users lastname.</li>
					<li>You can use @@email@@ to insert the users email. </li>
					<li>You can use @@include_agenda@@ to insert the event agenda. </li>
					<li>You can use @@total_cost@@ to insert the total cost. </li>
					<li>You can use @@total_credits@@ to insert the total credits. </li>
					<li>You can use @@total_due@@ to insert the total due. </li>
					<li>You can use @@total_cancels@@ to insert the total cancelled. </li>
					<li>You can use @@location@@ to insert the location.</li>
					<li>You can use @@dates@@ to insert the dates.</li>
					<li>You can use @@last_payment_type@@ to insert the last payment type.</li>
					<li>You can use @@last_payment_amount@@ to insert the last payment amount.</li>
					<li>You can use @@total_fees@@ to insert the total fees.</li>
					<li>You can use @@last_cancel_amount@@ to insert the last cancel amount.</li>
				</ul> <br>
			</div>
		</div>
		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg"><strong>Save Email Content and Settings</strong></button>
		</div>
	</div>
</form>
</cfoutput>