<cfoutput>
<div class="tab-pane" id="user-password">
	<h3 class="form-section-title">Password</h3>
	<form action="#buildURL('system.saveUserPassword')#" method="post" role="form">
		<input type="hidden" name="user.user_id" value="#val(rc.user.user_id)#" />
		<cfinclude template="tab.user.password_fields.cfm" />
		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Save</strong></button>
		</div>
	</form>
</div>
</cfoutput>