<cfoutput>
<form action="#buildURL( 'emailManagement.doSendTestEmail' )#" method="post" class="test-frm">
	<input type="hidden" name="email.email_type" id="test_email_type" value="" />
	<input type="hidden" name="email.email_id" id="test_email_id" value="" />
	<div id="choose-test-addresses" class="form-group col-md-6 col-md-offset-3 hiddenbox" style="display: none;">
		<label for="send_to">Who would you like to send this test to?</label>
		<input name="email.send_to" id="send_to" type="text" class="form-control">
		<p class="help-block">Enter email addresses separated by a comma</p>
		<br>
		<button type="submit" class="btn btn-success btn-lg"><strong>Send Test Email</strong></button>
	</div>
</form>
</cfoutput>
