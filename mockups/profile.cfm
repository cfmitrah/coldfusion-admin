<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<div id="main-content-wrapper">
		<div id="main-content" class="no-sidebar">
			<ol class="breadcrumb">
			  <li><a href="index.cfm">Dashboard</a></li>
			  <li class="active">Profile</li>
			</ol>

			<h2 class="page-title color-02">My Profile</h2>
			<p class="page-subtitle">Manage your personal information and password by using the form below.</p>
			
			<!-- Nav tabs -->
			<ul class="nav nav-tabs mt-medium" role="tablist">
				<li class="active"><a href="#profile-details" role="tab" data-toggle="tab">User Information</a></li>
				<li><a href="#profile-password" role="tab" data-toggle="tab">Reset Password</a></li>
			</ul>

			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane active" id="profile-details">
					<form action="">
						<h3 class="form-section-title">User Information</h3>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label for="" class="required">First Name</label>
									<input type="text" class="form-control width-lg">
								</div>
								<div class="form-group">
									<label for="" class="required">Last Name</label>
									<input type="text" class="form-control width-lg">
								</div>
								<div class="form-group">
									<label for="" class="required">Username</label>
									<input type="text" class="form-control width-md">
								</div>
								<div class="form-group">
									<label for="" class="required">Email Address</label>
									<input type="email" class="form-control width-md">
								</div>
								<div class="form-group">
									<label for="">Phone</label>
									<input type="text" class="form-control width-sm">
								</div>
								<div class="form-group">
									<label for="" class="required">Country</label>
									<select name="" id="" class="form-control width-md">
										<option value="">Choose Country</option>
									</select>
								</div>
							</div>
							<div class="col-md-6">
								
								<div class="form-group">
									<label for="" class="required">Address Line 1</label>
									<input type="text" class="form-control">
								</div>
								<div class="form-group">
									<label for="">Address Line 2</label>
									<input type="text" class="form-control">
								</div>
								<div class="form-group">
									<label for="" class="required">City</label>
									<input type="text" class="form-control width-md">
								</div>
								<div class="form-group">
									<label for="" class="required">Region / State</label>
									<select name="" id="" class="form-control width-md">
										<option value="">Choose State</option>
									</select>
								</div>
								<div class="form-group">
									<label for="" class="required">Postal / Zip</label>
									<input type="text" class="form-control width-sm">
								</div>
							</div>
						</div>
						<input type="submit" class="btn btn-lg btn-success" value="Save User Information">
					</form>
				</div>

				<div class="tab-pane" id="profile-password">
					<form action="">
						<h3 class="form-section-title">Reset Password</h3>
						<div class="form-group">
							<label for="">Current Password:</label>
							<input type="password" class="form-control width-sm">
						</div>
						<div class="form-group">
							<label for="">New Password:</label>
							<input type="password" class="form-control width-sm">
						</div>
						<div class="form-group">
							<label for="">Confirm New Password:</label>
							<input type="password" class="form-control width-sm">
						</div>
						<input type="submit" class="btn btn-lg btn-success" value="Save New Password">
					</form>
				</div>
			</div>
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>