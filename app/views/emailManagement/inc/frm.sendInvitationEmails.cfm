<cfoutput>
<form class="validate-frm" action="#buildURL( 'emailManagement.doScheduleInvitationEmail' )#"  enctype="multipart/form-data" method="post" data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden">
	<input type="hidden" name="email.email_type" id="invitation_email_type" value="" />
	<input type="hidden" name="email.email_id" id="invitation_email_id" value="" />
	<input type="hidden" name="email.event_id" id="event_id" value="#rc.event_id#" />
	<div id="invitation-live-settings" class="row email-options" style="display: none;">
		<div class="col-md-12">
			<h3 class="form-section-title">Invite Set Schedule</h3>
		</div>
		<div class="col-md-6 col-md-offset-3">
			<div class="form-group">
				<label for="send_time">Date and Time to Send</label>
				<input name="email.send_time" id="send_time" type="text" class="std-datetime form-control datetime" value="#dateformat( now(), 'MM/DD/YYYY' )# #timeFormat( now(), 'HH:MM tt' )#" required>
			</div>
		</div>

		
		<div id="invitation-options">
			<div class="col-md-12">
				<h3 class="form-section-title">Invitation Options</h3>
			</div>
			<div class="form-group col-md-6 col-md-offset-3">
				<div class="form-group">
					<label for="">How would you like to import email addresses for invitation?</label>
					<div class="radio">
					    <label>
					    	<input value="file" type="radio" name="email.import_type" id="import-options-1" class="import_type" required> Import from spreadsheet
					    </label>
					</div>
					<div class="radio">
					    <label>
					    	<input value="list" type="radio" name="email.import_type" id="import-options-2" class="import_type" required> Comma Seperated Values
					    </label>
					</div>
				</div>
			</div>
		</div>
		
		<div id="choose-addresses" class="form-group col-md-6 col-md-offset-3 hiddenbox file-box" style="display: none;">
			<label for="send_to">Who would you like to send this test to?</label>
			<input name="email.send_to" id="send_to" type="text" class="form-control">
			<p class="help-block">Enter email addresses separated by a comma</p>
		</div>

		<div id="choose-file" class="form-group col-md-6 col-md-offset-3 hiddenbox file-box" style="display: none;">
			<label for="import_file">Who would you like to send this test to?</label>
			<input name="email.import_file" id="import_file" type="file" class="form-control">
			<p class="help-block">
				Upload a .csv, .xls, or .xlsx file<br />
				<ul>
					<li>For .csv, please be sure that in your file, the email address is listed in column A, the first name is listed in column B and the last name is listed in column C. The worksheet CANNOT have any headers and must be named Book 1.</li>
					<li>For .xls and .xlsx, please be sure that in your file, the email address is listed in column A, the first name is listed in column B and the last name is listed in column C. The worksheet CANNOT have any headers and must be named Sheet 1.</li>
					<li><a href="/assets/files/MP_Registration_Excel_Import_Example.xlsx">XLS Template File</a></li>
				</ul>	
			</p>
		</div>
		<div class="form-group col-md-6 col-md-offset-3">
			<div class="alert alert-danger">This email will send to the attendees listed above on the date provided. Be sure to send a test version to yourself to approve of the content before you sent to specified attendees.</div>
			<button type="submit" class="btn btn-success btn-lg"><strong>Save Send Settings</strong></button>
		</div>
	</div>	
</form>	
</cfoutput>