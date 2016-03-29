<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<cfinclude template="shared/event-sidebar.cfm"/>

	<!--- Sidebar Ends Content Starts --->
	<div id="main-content-wrapper" class="has-sidebar">
		<div id="main-content">
			<ol class="breadcrumb">
			  <li><a href="#">Dashboard</a></li>
			  <li><a href="#">Events</a></li>
			  <li><a href="#">Event Name</a></li>
			  <li><a href="event-email-management.cfm">Email Management</a></li>
			  <li class="active">Create Invitation Email</li>
			</ol>
			<h2 class="page-title color-03">Create a New Invitation Email</h2>
			<p class="page-subtitle">Manage settings and content for this email below</p>
			<form action="" class="basic-wrap mt-medium">
				<div class="container-fluid">
					<h3 class="form-section-title">Basic Information</h3>
					<div class="row">
						<div class="form-group col-md-6 col-md-offset-3">
							<label for="" class="required">Email Name: <small>Used to reference later</small></label>
							<input type="email" class="form-control">
						</div>
					</div>
					<hr>
					<div class="row">
						<div class="form-group col-md-6">
							<label for="" class="required">From Address:</label>
							<input type="email" class="form-control">
						</div>
						<div class="form-group col-md-6">
							<label for="" class="required">Subject Line:</label>
							<input type="text" class="form-control">
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-6">
							<label for="" class="required">Email Header Image:</label>
							<input type="file" class="form-control">
							<p class="help-block">
								600 x 120 jpg or png <br>
								<span class="text-danger">Uploading a new image will remove the current one.</span>
							</p>
						</div>
						<div class="form-group col-md-6">
							<label for="" class="required">Current Email Header:</label><br>
							<img src="//placehold.it/600x120" class="img-responsive" alt="">
							
						</div>
					</div>
					
					<h3 class="form-section-title mt-medium">Email Content</h3>
					<div class="row">
						<div class="col-md-12">
							<textarea class="ckeditor" id="email-content-texarea" name="email-content-texarea" rows="20"></textarea>
							<ul class="mt-medium">
								<li>You can use @@firstname@@ to insert the users firstname.</li>
								<li>You can use @@lastname@@ to insert the users lastname.</li>
								<li>You can use @@email@@ to insert the users email. </li>
							</ul><br>
						</div>
					</div>
					<div class="cf">
						<button type="submit" class="btn btn-success btn-lg"><strong>Save Email Content and Settings</strong></button>
					</div>
				</div>
			</form>
		</div>
	</div>

</div>



<cfinclude template="shared/footer.cfm"/>