<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li class="active">Account</li>
</ol>
<!--// BREAD CRUMBS END //-->
<p class="page-subtitle">Account Information</p>
<cfoutput>
	<p>First name: #rc.user.getFirstName()#</p>
	<p>Last name: #rc.user.getLastName()#</p>
	<p>Username: #rc.user.getUserName()#</p>
	<form action="#buildURL('account.changePassword')#" role="form" method="get">
		<div class="cf">
			 <button type="submit" class="btn btn-success btn-lg pull-right"><strong>Change Password</strong></button>
		</div>
	</form>
</cfoutput>