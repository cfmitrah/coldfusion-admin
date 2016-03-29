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
			  <li><a href="event-registration-process.cfm">Registration Forms</a></li>
			  <li class="active">Create Registration Form</li>
			</ol>
			<h2 class="page-title color-02">Create New Registration Form</h2>
			<p class="page-subtitle">Follow the form builder below to create a registration form unique to an attendee type</p>
			<br>
			<div id="form-builder-navbar" class="cf">
				<a href="#" class="blocknav1 active">1. Choose Attendee Type</a>
				<a href="#" class="blocknav2">2. Create Form Sections</a>
				<a href="#" class="blocknav3">3. Assign Fields to Sections</a>
			</div>
			<br>
			<!--- Begin Reg path Form --->
			<form id="reg-path-form" data-parsley-validate>
			<div id="form-builder-step-1" class="basic-wrap block1 show">
				<div class="row">
					<div class="form-group col-md-6 col-md-offset-3">
						<label for="">Select Attendee Type</label>
						<select name="" id="choose-attendee" class="form-control" data-parsley-group="block1" required>
							<option value="">Choose attendee type...</option>
							<option value="sponsor">Sponsor</option>
							<option value="guest">Guest</option>
						</select>
						<p class="help-block">This determines the attendee type the new registration form will be associated to. Only attendee types which don't already have a form associated with them will appear in the dropdown above. You can create new attendee types under <strong>Event > Construct > Attendee Settings</strong>.</p>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-6 col-md-offset-3">
						<a href="#" class="btn btn-lg btn-block btn-success next" data-current-block="1" data-next-block="2">Continue</a>
					</div>
				</div>
			</div>
			
			<div id="form-builder-step-2" class="basic-wrap block2 hide">
				<div class="row">
					<div class="col-md-7">
						<h3 class="form-section-title">Create New Form Section</h3>
						<div class="well">
						<div class="form-group">
							<label for="">Section Name</label>
							<input type="text" class="form-control">
							<p class="help-block">The section name will appear at the top of the form section. Examples include 'General Information', 'Personal Information', etc</p>
						</div>
						<div class="form-group">
							<label for="">Section Layout</label>
							<select name="" id="" class="form-control">
								<option value="">Select layout...</option>
								<option value="2">2 Columns</option>
								<option value="1">1 Column</option>
							</select>
							<p class="help-block">A sample of each layout type can be seen <a href="#">by clicking here</a></p>
						</div>
						<div class="form-group">
							<a href="#" class="btn btn-primary">Add Section</a>
						</div>
						</div>
					</div>
					<div class="col-md-5">
						<h3 class="form-section-title">Existing Form Sections</h3>
						<div class="alert alert-info" style="padding: 7px; margin-bottom: 5px;"> <span class="glyphicon glyphicon-info-sign"></span> You can drag sections to rearrange their order</div>
						<!--- <div class="alert alert-danger" style="padding: 7px; margin-bottom: 5px;"> <span class="glyphicon glyphicon-exclamation-sign"></span> Clicking 'x' will remove the section and unassociate any fields tied to it</div> --->
						<h4 style="margin-top: 15px;">Existing Sections for: Basic Attendee</h4>
						<div class="form-required-section">
							<strong class="text-danger">Required Information</strong> (Always the First Section)<br>
							<small>First Name, Last Name, Email Address, Attendee Type</small>
						</div>
						<ul id="form-section-list">
							<li><a href="#"><span class="glyphicon glyphicon-remove-circle"></span></a> <strong>General Information</strong> - 2 Column Layout</li>
							<li><a href="#"><span class="glyphicon glyphicon-remove-circle"></span></a> <strong>Contact Information</strong> - 1 Column Layout</li>
							<li><a href="#"><span class="glyphicon glyphicon-remove-circle"></span></a> <strong>Personal Information</strong> - 2 Column Layout</li>
						</ul>
						<a href="#" class="btn btn-lg btn-block btn-success next" data-current-block="2" data-next-block="3">Continue With Above Sections</a>
					</div>
				</div>
			</div>

			
			<div id="form-builder-step-3" class="basic-wrap block3 hide">
				<div class="alert alert-info"> 
					<span class="glyphicon glyphicon-info-sign"></span> 
					Drag the form fields you created from the available fields bank to the desired form section. <strong>Once they are placed in the desired order / location, press 'Save Registraion Form'.</strong>
				</div> 
				<div class="alert alert-warning">
					<strong>Note:</strong> Billing will always be the last section of the registration process. If you specified for attendees to build out their agenda during registration (Construct > Attendee Settings > Registrant Settings) they will do so in an automated step before billing.
				</div>
				<div class="row">
					<div class="col-md-12">
						<h3 class="form-section-title">Available Fields</h3>
						<ul id="form-field-bank" class="reg-form-list field-bank cf">
							
							<li>Secondary Email Address</li>
							<li>Prefix</li>
							
							<li>Password</li>
							<li>Confirm Password</li>
							<li>Name to Display on Badge</li>
							<li>Job Title</li>
							<li>Company</li>
							<li>Country</li>
							<li>Address Line One</li>
							<li>Address Line Two</li>
							<li>City</li>
							<li>State</li>
							<li>Zip</li>
							<li>Home Phone</li>
							<li>Date of Birth</li>
							<li>Profile Photo</li>
							<li>Biography</li>
						</ul>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col-md-12">
						<h3 class="form-section-title">Form Sections for: Basic Attendee</h3>
						<!--- The created sections would display here - 3 samples below--->
						<div class="panel-wrap cf">
							<div class="custom-panel">
								<h3 class="custom-panel-header">General Information</h3>
								<div class="custom-panel-content">
									<ul id="section-1" class="section-field-list reg-form-list">

									</ul>
								</div>
							</div>
							<div class="custom-panel">
								<h3 class="custom-panel-header">Personal Information</h3>
								<div class="custom-panel-content">
									<ul id="section-2" class="section-field-list reg-form-list">

									</ul>
								</div>
							</div>
							<div class="custom-panel">
								<h3 class="custom-panel-header">Contact Information</h3>
								<div class="custom-panel-content">
									<ul id="section-3" class="section-field-list reg-form-list">

									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="form-group col-md-6 col-md-offset-3">
						<br>
						<a href="#" class="btn btn-lg btn-block btn-success">Save Registration Form</a>
					</div>
				</div>
			</div>
			</form>
			<!--- End Reg Path Form --->
		</div>
	</div>
</div>

<script>
$(function(){
	// This is for organizing the sections once they are created
	$( "#form-section-list" ).sortable();

	// This is for organizing the fields into the sections on the third step. Need a unique ID for each div
	$( "#form-field-bank,#section-1,#section-2,#section-3" ).sortable({
	  connectWith: ".reg-form-list"
	}).disableSelection();

	// Form Step Validation
	 $('.next').on('click', function () {
		var current = $(this).data('currentBlock'),
		    next = $(this).data('nextBlock');

		// only validate going forward. If current group is invalid, do not go further
		// .parsley().validate() returns validation result AND show errors
		if (next > current)
		  if (false === $('#reg-path-form').parsley().validate('block' + current))
		    return;

		// validation was ok. We can go on next step.
		$('.block' + current)
		  .removeClass('show')
		  .addClass('hidden');

		$('.block' + next)
		  .removeClass('hidden')
		  .addClass('show');

		$('#form-builder-navbar a').removeClass('active');
		$('.blocknav' + next).addClass('active');

	});


});
</script>


<cfinclude template="shared/footer.cfm"/>