<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<div id="sidebar">
		<div class="side-section">
			<!--- When a link in a section is active - the following active-caret div should display --->
			<div class="active-caret"></div>
			<h2>Overview <span class="glyphicon glyphicon-dashboard color-01"></span></h2>
			<ul>
				<li><a href="account-index.cfm" >Overview</a></li>
			</ul>
		</div>
		<div class="side-section">
			<h2>Users <span class="glyphicon glyphicon-user color-02"></span></h2>
			<ul>
				<li><a href="account-users.cfm">View All</a></li>
				<li><a href="account-users-create.cfm" class="active">Create New</a></li>
			</ul>
		</div>
		<div class="side-section">
			<h2>Packages <span class="glyphicon glyphicon-briefcase color-03"></span></h2>
			<ul>
				<li><a href="account-packages.cfm">Overview</a></li>
			</ul>
		</div>
		<div class="side-section">
			<h2>Billing <span class="glyphicon glyphicon-usd color-04"></span></h2>
			<ul>
				<li><a href="account-billing.cfm">Overview</a></li>
			</ul>
		</div>
	</div>
		
	<div id="main-content-wrapper" class="has-sidebar">
		<div id="main-content">
			<ol class="breadcrumb">
			  <li><a href="index.cfm">Dashboard</a></li>
			  <li><a href="account-index.cfm">Company</a></li>
			  <li class="active">Create New User</li>
			</ol>

			<h2 class="page-title color-02">Create New Adminstrative User</h2>
			<p class="page-subtitle">Upon creation an email will be sent to the new user which allows them to log in with a temporary password. The user can then change their password and additional information from their profile page.</p>
			<div class="row">
				<div class="col-md-6">
					<form action="" class="basic-wrap mt-small">
						<h3 class="form-section-title">New User Information</h3>
						<div class="form-group">
							<label for="">First Name</label>
							<input type="text" class="form-control">
						</div>
						<div class="form-group">
							<label for="">Last Name</label>
							<input type="text" class="form-control">
						</div>
						<div class="form-group">
							<label for="">User Name</label>
							<input type="text" class="form-control">
						</div>
						<div class="form-group">
							<label for="">Email Address</label>
							<input type="email" class="form-control">
						</div>
						<div class="form-group">
							<input type="submit" class="btn btn-lg btn-success" value="Add User to System and Send Notification Email">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>