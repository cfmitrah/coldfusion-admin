<cfoutput>
<!---// choose the type of email //--->
<div class="form-group col-md-6 col-md-offset-3">
	<label for="email_type">Which email do you want to send?</label>
	<select name="email.email_type" id="email_type" class="form-control formShowHide_ctrl">
		<option value="none">Select Email...</option>
		<cfloop from="1" to="#arraylen( rc.email_labels )#" index="local.i">
			<option value="#rc.email_labels[local.i].email_id#" data-type="#rc.email_labels[local.i].type#">#uCase(rc.email_labels[local.i].type)# - #rc.email_labels[local.i].label#</option>
		</cfloop>
	</select>
</div>
<!---// END //--->
<!---// choose if the email should be live or test  //--->
<div id="email-test-or-live" class="form-group col-md-6 col-md-offset-3 hiddenbox" style="display: none;">
	<label for="send_type">Will this be a test email or an official live email?</label>
	<select name="email.send_type" id="send_type" class="form-control formShowHide_ctrl">
		<option value="none">Select Send Type...</option>
		<option value="test" data-show-id="choose-test-addresses">TEST</option>
		<option value="live" data-show-id="choose-live-settings">LIVE</option>
	</select>
</div>
<!---// end //--->
</cfoutput>