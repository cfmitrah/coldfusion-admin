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
			  <li class="active">Registration Forms</li>
			</ol>
			<div id="action-btns" class="pull-right">
				<a href="event-registration-process-create.cfm" class="btn btn-lg btn-primary">Create New Registration Form</a>
			</div>
			<h2 class="page-title color-02">Registration Forms</h2>
			<p class="page-subtitle">In this section you can manage the registration forms and processes for each attendee type.</p>
			<div class="well">
				<div class="alert alert-info"><strong>Existing registration forms will appear below once created.</strong> <br> You can duplicate a registration form for a starting point when creating a new one. Once duplicated and an attendee type is chosen, you will be able to edit it for that specific attendee type.</div>
				<div class="cf">
					<div class="reg-path-block">
						<!--- Show the Attendee Type this path is for --->
						<h3>Basic Attendee</h3>
						<div class="btn-group">
							<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
								Options <span class="caret"></span>
							</button>
							<ul class="dropdown-menu" role="menu">
								<li><a href="#">Edit</a></li>
								<li><a href="#" data-toggle="modal" data-target="#duplicate-form-modal">Duplicate</a></li>
								<li class="divider"></li>
								<li><a href="#">Delete</a></li>
							</ul>
						</div>
						<!--- Show the sections they created --->
						<div class="form-section-summary">
							<h4>Required Information</h4>
							<ul>
								<li>Email Address</li>
								<li>First Name</li>
								<li>Last Name</li>
								<li>Attendee Type</li>
							</ul>
						</div>
						<div class="form-section-summary">
							<h4>General Information</h4>
							<ul>
								<li>Company Name</li>
								<li>Job Title</li>
							</ul>
						</div>
						<div class="form-section-summary">
							<h4>Contact Information</h4>
							<ul>
								<li>Home Phone</li>
								<li>Office Phone</li>
								<li>Extension</li>
								<li>Emergency Contact Name</li>
								<li>Emergency Contact Number</li>
							</ul>
						</div>
						<div class="form-section-summary">
							<h4>Additional Information</h4>
							<ul>
								<li>Favorite Color</li>
								<li>Favorite Type of Music</li>
							</ul>
						</div>
						<div class="form-section-summary">
							<h4>Build Agenda</h4>
						</div>
						<div class="form-section-summary">
							<h4>Payment / Review / Complete</h4>
						</div>
					</div>

					<div class="reg-path-block">
						<!--- Show the Attendee Type this path is for --->
						<h3>Sponsor</h3>
						<div class="btn-group">
							<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
								Options <span class="caret"></span>
							</button>
							<ul class="dropdown-menu" role="menu">
								<li><a href="#">Edit</a></li>
								<li><a href="#" data-toggle="modal" data-target="#duplicate-form-modal">Duplicate</a></li>
								<li class="divider"></li>
								<li><a href="#">Delete</a></li>
							</ul>
						</div>
						<!--- Show the sections they created --->
						<div class="form-section-summary">
							<h4>Required Information</h4>
							<ul>
								<li>Email Address</li>
								<li>First Name</li>
								<li>Last Name</li>
								<li>Attendee Type</li>
							</ul>
						</div>
						<div class="form-section-summary">
							<h4>General Information</h4>
							<ul>
								<li>Email Address</li>
								<li>First Name</li>
								<li>Last Name</li>
								<li>Sponsor Tier</li>
							</ul>
						</div>
						<div class="form-section-summary">
							<h4>Marketplace Specifics</h4>
							<ul>
								<li>How many attendees can be in your booth at once?</li>
								<li>How many representatives will you have on site?</li>
							</ul>
						</div>
						<div class="form-section-summary">
							<h4>Payment / Review / Complete</h4>
						</div>
					</div>


				</div> <!--- ends block wrap / clearfix --->
			</div>
		</div>
	</div>
</div>

<!-- Sample Modal for Duplicating a Registration Form-->
<div class="modal fade" id="duplicate-form-modal" tabindex="-1" role="dialog" aria-labelledby="duplicate-form-modal-label" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="duplicate-form-modal-label">Duplicate Registration Form</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="form-group col-md-12">
						<label for="" class="required">Attendee Type</label>
						<select name="" id="" class="form-control">
							<option value="">Choose attendee type...</option>
							<option value="">Class B Attendee</option>
							<option value="">Class C Attendee</option>
						</select>
						<p class="help-block">This determines the attendee type the new registration form will be associated to. Only attendee types which don't already have a form associated with them will appear in the dropdown above. You can create new attendee types under <strong>Event > Construct > Attendee Settings</strong>.</p>
					</div>
				</div>
				
			</div>
			
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
				<button type="button" class="btn btn-success">Create Registration Form</button>
			</div>
		</div>
	</div>
</div>


<cfinclude template="shared/footer.cfm"/>