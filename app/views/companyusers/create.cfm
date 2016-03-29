<cfoutput>
	<!--// BREAD CRUMBS START //-->
	<ol class="breadcrumb">
	  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
	  <li><a href="#buildURL( 'companyUsers.default' )#">Company Users</a></li>
	  <li class="active">Create Company User</li>
	</ol>
	<!--// BREAD CRUMBS END //-->
	<h2 class="page-title color-02">Create New Adminstrative User</h2>
	<p class="page-subtitle">Upon creation an email will be sent to the new user which allows them to log in with a temporary password. The user can then change their password and additional information from their profile page.</p>
	<div class="row">
		<div class="col-md-6">
			
			<form action="#buildURL('companyusers.create')#" method="post" class="basic-wrap mt-small">
				<h3 class="form-section-title">New User Information</h3>
				
				<cfif rc.flag_error>
				<div class="alert alert-danger">
					<span class="glyphicon glyphicon-exclamation-sign"></span>#rc.flag_message#
				</div>
				<cfelseif len(rc.flag_message)>
				<div class="alert alert-success">
					<span class="glyphicon glyphicon-exclamation-sign"></span>#rc.flag_message#
				</div>					
				</cfif>
				
				<div class="form-group">
					<label for="">First Name</label>
					<input type="text" id="first_name" name="first_name" value="#rc.first_name#" class="form-control">
				</div>
				<div class="form-group">
					<label for="">Last Name</label>
					<input type="text" id="last_name" name="last_name" value="#rc.last_name#" class="form-control">
				</div>
				<div class="form-group">
					<label for="">User Name</label>
					<input type="text" id="username" name="username" value="#rc.username#" class="form-control">
				</div>
				<div class="form-group">
					<label for="">Email Address</label>
					<input type="email" id="email" name="email" value="#rc.email#" class="form-control">
				</div>
				<div class="form-group">
					<input type="submit" class="btn btn-lg btn-success" value="Add User to System and Send Notification Email">
				</div>
			</form>
		</div>
	</div>
</div>
</cfoutput>