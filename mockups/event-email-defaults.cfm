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
			  <li class="active">Configure Email Defaults</li>
			</ol>
			<h2 class="page-title color-03">Configuring email defaults</h2>
			<p class="page-subtitle">The settings you provide here will carry over to each email type as a default value, until they are overwritten at the manage email level.</p>
			<form action="" class="basic-wrap mt-medium">
				<div class="container-fluid">
					<h3 class="form-section-title">Set Email Defaults</h3>
					<div class="row">
						<div class="form-group col-md-6">
							<label for="" class="required">Default From Address:</label>
							<input type="email" class="form-control">
						</div>
						<div class="form-group col-md-6">
							<label for="" class="required">Default Subject Line:</label>
							<input type="text" class="form-control">
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-6">
							<label for="" class="required">Default Email Header Image:</label>
							<input type="file" class="form-control">
							<p class="help-block">
								600 x 120 jpg or png <br>
								<span class="text-danger">Uploading a new image will remove the current one.</span>
							</p>
						</div>
						<div class="form-group col-md-6">
							<label for="" class="required">Current Default Email Header:</label><br>
							<p>No default header image on file</p>
							
						</div>
					</div>
					
					<div class="cf">
						<button type="submit" class="btn btn-success btn-lg"><strong>Save Default Settings</strong></button>
					</div>
				</div>
			</form>
		</div>
	</div>

</div>



<cfinclude template="shared/footer.cfm"/>