<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="/index.cfm">Account</a></li>
  <li class="active">Change Password</li>
</ol>
<!--// BREAD CRUMBS END //-->
<h2 class="page-title color-02">Change Password</h2>
<p class="page-subtitle">To change your password, enter the new password here and click "Change Password".</p>
<cfoutput>
	<form action="#buildURL('account.doChangePassword')#" role="form" method="post">
		<div class="form-group col-md-3">
			<label for="name" class="required">Current Password:</label>
			<input type="password" class="form-control" id="currentpassword" name="password.current" value="">
			<label for="name" class="required">New Password:</label>
			<input type="password" class="form-control" id="newpassword" name="password.new" value="">
			<label for="name" class="required">Confirm New Password:</label>
			<input type="password" class="form-control" id="newpasswordconfirmation" name="password.confirmation">
		</div>
		<div class="cf">
			 <button type="submit" class="btn btn-success btn-lg pull-right"><strong>Change Password</strong></button>
		</div>
	</form>
</cfoutput>
