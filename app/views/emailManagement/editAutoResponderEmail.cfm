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
	<input type="hidden" name="email.autoresponder_id" value="#rc.email_details.autoresponder_id#" />
	<input type="hidden" name="email.event_id" value="#rc.event_id#" />
	<input type="hidden" name="email.header_media_id" value="#rc.email_details.header_media_id#" />
	<input type="hidden" name="email.autoresponder_type" value="#rc.email_details.autoresponder_type#" />
	<input type="hidden" name="email.registration_type_id" value="#val( rc.email_details.registration_type_id )#" />
	<div class="container-fluid">
		<h3 class="form-section-title">Basic Information</h3>
		<div class="row">
			<div class="form-group col-md-6">
				<label for="from_email" class="required">Email Name:</label>
				<input name="email.label" id="label" type="text" class="form-control" value="#rc.email_details.label#">
			</div>
		</div>
		<div class="row">
			<div class="col-md-6">
				<div class="form-group">
					<label for="from_email" class="required">From Address:</label>
					<input name="email.from_email" id="from_email" type="text" class="form-control" value="#rc.email_details.from_email#">
				</div>
				<div class="form-group">
					<label for="subject" class="required">Subject Line:</label>
					<input name="email.subject" id="subject" value="#rc.email_details.subject#" type="text" class="form-control">
				</div>
				<div class="form-group">
					<label for="bcc" class="">BCC Address:</label>
					<input name="email.bcc" id="bcc" type="email" class="form-control" value="#rc.email_details.bcc#">
				</div>
				<div class="form-group">
					<label>Active?</label>
					<div class="cf">
						<div class="radio pull-left">
							<label for="remove-yes">
								<input value="1" type="radio" name="email.active" class="remove" id="remove-yes" #rc.disabled[ ! len( rc.email_details.registration_type ) ]# #rc.checked[ rc.email_details.active eq true ]#> Yes
							</label>
						</div>
						<div class="radio pull-left">
							<label for="remove-no">
								<input value="0" type="radio" name="email.active" class="remove" id="remove-no" #rc.disabled[ ! len( rc.email_details.registration_type ) ]# #rc.checked[ rc.email_details.active eq false ]#> No
							</label>
						</div>
						<Cfif ! len( rc.email_details.registration_type )>
							<p class="help-block">
								<br>
								<span class="text-danger">The default system email can not be disabled.</span>
							</p>
						</Cfif>	
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="form-group">
					<label for="header_image" class="required">Email Header Image:</label>
					<input name="email.header_image" id="header_image" type="file" class="form-control">
					<p class="help-block">
						600 x 120 jpg or png <br>
						<span class="text-danger">Uploading a new image will remove the current one.</span>
					</p>
				</div>
				<div class="form-group">
					<label for="" class="required">Current Email Header:</label><br>
					<Cfif len( rc.email_details.header_filename )>
						<img src="/assets/media/#rc.email_details.header_filename#" class="img-responsive" alt="" width="600">
					<cfelse>
						<img src="//placehold.it/600x120&text=No+Current+Image" class="img-responsive" alt="">
					</Cfif>
				</div>
				<div class="form-group">
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
		</div>
		
		<h3 class="form-section-title mt-small">Email Output Reference</h3>
		<p class="help-block">By inputing any of the available variables the email will output the associated text.</p>
		<div class="row">
			<div class="col-md-6">
				<table class="table table-condensed table-bordered">
					<thead>
						<tr>
							<th>Variable Input</th>
							<th>Text Output</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>@@firstname@@</td>
							<td>Attendees First Name</td>
						</tr>
						<tr>
							<td>@@lastname@@</td>
							<td>Attendees Last Name</td>
						</tr>
						<tr>
							<td>@@email@@</td>
							<td>Attendees Email Address</td>
						</tr>
						
						<tr>
							<td>@@total_cost@@</td>
							<td>Attendees Total Cost</td>
						</tr>
						<tr>
							<td>@@total_credits@@</td>
							<td>Attendees Credited Amount</td>
						</tr>
						<tr>
							<td>@@total_due@@</td>
							<td>Attendees Total Due</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="col-md-6">
				<table class="table table-condensed table-bordered">
					<thead>
						<tr>
							<th>Variable Input</th>
							<th>Text Output</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>@@total_cancels@@</td>
							<td>Total Cancelled Amount</td>
						</tr>
						<!--- <tr>
							<td>@@location@@</td>
							<td>Event Location</td>
						</tr> --->
						<!--- <tr>
							<td>@@dates@@</td>
							<td>Event Dates</td>
						</tr> --->
						<tr>
							<td>@@last_payment_type@@</td>
							<td>Last Payment Type</td>
						</tr>
						<tr>
							<td>@@last_payment_amount@@</td>
							<td>Last Payment Amount</td>
						</tr>
						<tr>
							<td>@@total_fees@@</td>
							<td>Total Fees</td>
						</tr>
						<tr>
							<td>@@last_cancel_amount@@</td>
							<td>Last Cancellation Amount</td>
						</tr>
						<tr>
							<td>@@include_agenda@@</td>
							<td>Event Agenda</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<h3 class="form-section-title mt-small">Email Content</h3>
		<div class="row">
			<div class="col-md-12">
				<label for="before_body" class="required">Before Body Content:</label><br>
				<textarea class="ckeditor" id="before_body" name="email.before_body" rows="20" style="visibility: hidden; display: none;">#rc.email_details.before_body#</textarea>
				
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<label for="after_body" class="required">After Body Content:</label><br>
				<textarea class="ckeditor" id="after_body" name="email.after_body" rows="20" style="visibility: hidden; display: none;">#rc.email_details.after_body#</textarea>
				
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<label for="footer" class="required">Footer Content:</label><br>
				<textarea class="ckeditor" id="footer" name="email.footer" rows="10" >#rc.email_details.footer#</textarea>
				
			</div>
		</div>
		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg"><strong>Save Email Content and Settings</strong></button>
		</div>
	</div>
</form>
</cfoutput>