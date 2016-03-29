<cfoutput>
<div class="login-wrapper">
	<div class="well ">
		<form action="#buildURL('security.doLogin')#" name="frmLogin" id="frmLogin" method="post" novalidate="novalidate">
			<fieldset>
				<h2 class="page-title color-01">Please Login</h2>

				<div class="form-group">
					<div class="input-group">
					  <span class="input-group-addon"><i class="fa fa-user"></i></span>
					  <input type="text" class="form-control" name="login.username" type="text" id="username" value="" placeholder="Username" autofocus />
					</div>
				</div>

				<div class="form-group">
					<div class="input-group">
					  <span class="input-group-addon"><i class="fa fa-key"></i></span>
					  <input type="password" class="form-control" name="login.password" id="password" value="" placeholder="Password">
					</div>
				</div>


	            <div class="form-actions">
					<button type="submit" class="btn btn-primary pull-right"><i class="fa fa-sign-in"></i> Sign in</button>
	            </div>
			</fieldset>
		</form>
	</div>

	<div class="well login-wrapper">
		<form action="#buildURL('security.doResetPassword')#" name="frmResetPassword" id="frmResetPassword" method="POST" class="form-inline">
			<fieldset>
				<h3 class="page-title color-01">Forget Your Password?</h3>
				<p>Enter your E-mail and we'll send a new password to you.</p>
				<div class="form-group">
	            	<div class="input-group">
						<span class="input-group-addon"><i class="fa fa-envelope"></i></span>
						<input name="user.email" type="text" id="email" value="" class="form-control" placeholder="Email Address">
					</div>
	            </div>

	            <button type="submit" class="btn btn-info">Submit</button>

			</fieldset>
		</form>
	</div>
</div>
</cfoutput>