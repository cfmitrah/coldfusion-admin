<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<cfinclude template="shared/config-sidebar.cfm"/>
	<div id="main-content-wrapper" class="has-sidebar">
		<div id="main-content">
			<ol class="breadcrumb">
			  <li><a href="index.cfm">Dashboard</a></li>
			  <li><a href="configuration-venues.cfm">Venues</a></li>
			  <li class="active">Create venue</li>
			</ol>

			<h2 class="page-title color-06">Create a New Venue</h2>
			<p class="page-subtitle">You can add locations to a venue once the venue has been created. First fill in the information below.</p>
			
			<form action="" role="form" class="basic-wrap mt-medium">
				<div class="container-fluid">
					<h3 class="form-section-title">Venue Details</h3>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="" class="required">Venue Name</label>
								<input type="text" class="form-control">
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="">Website URL</label>
								<input type="text" class="form-control">
							</div>
						</div>
						<!--- <div class="col-md-12">
							<div class="form-group">
								<label for="" class="required">Display</label>
								<select name="" id="" class="form-control">
									<option value="">Public</option>
									<option value="">Private</option>
								</select>
								<p class="help-block">Public venues can be used by all event planners. If set to private, this venue will only be viewable and accessible by your company. <a href="">Click here for more info.</a></p>
							</div>
						</div> --->
					</div>
					<div class="row">
						<div class="form-group col-md-6">
							<label for="" class="required">Address Line 1</label>
							<input type="text" class="form-control">
						</div>
						<div class="form-group col-md-6">
							<label for="">Address Line 2</label>
							<input type="text" class="form-control">
						</div>
						<div class="form-group col-md-6">
							<label for="" class="required">City</label>
							<input type="text" class="form-control">
						</div>
						<div class="form-group col-md-6">
							<label for="" class="required">State / Region</label>
							<input type="text" class="form-control">
						</div>
						<div class="form-group col-md-6">
							<label for="" class="required">Zip / Postal</label>
							<input type="text" class="form-control">
						</div>
						<div class="form-group col-md-6">
							<label for="">Contact Number</label>
							<input type="tel" class="form-control">
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<button type="submit" class="btn btn-success btn-lg"><strong>Create Venue</strong></button>
						</div>
					</div>
				</div>
				
			</form>
			
			
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>