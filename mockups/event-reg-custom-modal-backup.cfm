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
			  <li class="active">Registration Fields</li>
			</ol>
			<h2 class="page-title color-02">Registration Fields</h2>
			<p class="page-subtitle">Use the area below to manage all attendee fields that will be available for you to choose from when building out the registration process</p>
			<!-- Nav tabs -->
			<ul class="nav nav-tabs mt-medium" role="tablist">
				<li class="active"><a href="#standard-fields" role="tab" data-toggle="tab">Standard Provided Fields</a></li>
				<li><a href="#custom-fields" role="tab" data-toggle="tab">Custom Form Fields</a></li>
			</ul>

			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane active" id="standard-fields">
					<div class="alert alert-info"><span class="glyphicon glyphicon-question-sign"></span> Clicking manage will let edit a fields visibility, requirements, label, and more</div>
					<h3 class="form-section-title">Standard Fields</h3>
					<!--- start of gigantic form --->
					<table id="reg-field-table" class="table table-striped table-condensed">
						<thead>
							<tr>
								<th>Field Name</th>
								<th>Field Label</th>
								<th>Input Type</th>
								<th>Visible</th>
								<th>Required</th>
								<th>Options</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Email_Address</td>
								<td>Email Address</td>
								<td>Email</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Email_Verify</td>
								<td>Verify Email</td>
								<td>Email</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Email_Secondary</td>
								<td>Seconday Email Address</td>
								<td>Email</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Prefix</td>
								<td>Prefix (Mr., Mrs., etc.)</td>
								<td>Text</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>First_Name</td>
								<td>First Name</td>
								<td>Text</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Middle_Name</td>
								<td>Middle Name</td>
								<td>Text</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Last_Name</td>
								<td>Last Name</td>
								<td>Text</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Suffix</td>
								<td>Suffix</td>
								<td>Text</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Job_Title</td>
								<td>Job Title</td>
								<td>Text</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Company</td>
								<td>Company / Organization</td>
								<td>Text</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Country</td>
								<td>Country</td>
								<td>Select</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Address_One</td>
								<td>Address Line One</td>
								<td>Text</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Address_Two</td>
								<td>Address Line Two</td>
								<td>Text</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>City</td>
								<td>City</td>
								<td>Text</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>State_US</td>
								<td>U.S State / Canadian Province</td>
								<td>Select</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>State_Non_US</td>
								<td>State / Province / Region (Non US / Canada)</td>
								<td>Text</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Zip</td>
								<td>Zip / Postal Code</td>
								<td>Number</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Phone_Home</td>
								<td>Home Phone</td>
								<td>Tel</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Phone_Office</td>
								<td>Office Phone</td>
								<td>Tel</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Extension</td>
								<td>Office Extension</td>
								<td>Tel</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Fax</td>
								<td>Fax Number</td>
								<td>Number</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Phone_Cell</td>
								<td>Cell Phone</td>
								<td>Tel</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Date_Birth</td>
								<td>Birthday</td>
								<td>Date</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Gender</td>
								<td>Gender</td>
								<td>Radio</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Emergency_Contact_Name</td>
								<td>Emergency Contact Name</td>
								<td>Text</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Emergency_Contact_Number</td>
								<td>Emergency Contact Number</td>
								<td>Tel</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Photo</td>
								<td>Profile Photo</td>
								<td>File</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Membership_Num</td>
								<td>Membership Number</td>
								<td>Text</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Client_Num</td>
								<td>Customer / Client Number</td>
								<td>Text</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>SSN</td>
								<td>Last Four Digits of SSN</td>
								<td>Num</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Tax_Identification</td>
								<td>Tax Identification Number</td>
								<td>Number</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Private_Profile</td>
								<td>Keep App Profile Private?</td>
								<td>Radio</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
						</tbody>
					</table>

					

				</div>
				<div class="tab-pane" id="custom-fields">
					<h3 class="form-section-title">Custom Field Generator</h3>
					<div class="alert alert-info"><span class="glyphicon glyphicon-question-sign"></span> First time using the custom field generator? Watch a quick demo by <a href="##" data-toggle="modal" data-target="#form-training"><strong>Clicking Here</strong></a>.</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--- Modal For Custom Field Training Vid --->
<div class="modal fade" id="form-training" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">Custom Field Generator Training</h4>
      </div>
      <div class="modal-body">
        <p>Video Coming Soon</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!-- Sample Modal for Editing a Form Field -->
<div class="modal fade" id="standard-field-manage" tabindex="-1" role="dialog" aria-labelledby="standard-field-manage-label" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="standard-field-manage-label">Field Management: Email_Address</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="form-group col-md-6">
						<label for="" class="required">Field Name:</label>
						<input type="text" class="form-control disabled" value="Email_Address" disabled>
						<p class="help-block">Used under the hood - not visible by users. Used to define the field</p>
					</div>
					<div class="form-group col-md-6">
						<label for="" class="required">Field Label:</label>
						<input type="text" class="form-control" value="Email Address">
						<p class="help-block">Visible by the user. Will display next to the form field.</p>
					</div>
					<div class="form-group col-md-6">
						<label for="" class="required">Input Type:</label>
						<select name="" id="" class="form-control">
							<option value="">Text Input</option>
							<option value="">Text Area</option>
							<option value="">Email Address</option>
							<option value="">Telephone</option>
							<option value="">Password</option>
							<option value="">Select Dropdown</option>
							<option value="">Multi Select</option>
						</select>
						<p class="help-block">To view the details of each input type, <a href="">click here.</a></p>
					</div>
					<div class="form-group col-md-6">
						<label for="">Settings</label>
						<div class="checkbox">
							<label>
								<input type="checkbox"> Visible (Display this Field)
							</label>
						</div>
						<div class="checkbox">
							<label>
								<input type="checkbox"> Required (User must enter something for this field)
							</label>
						</div>
					</div>
					
				</div>
				<div class="row">
					<div class="form-group col-md-12">
						<label for="">Help Text:</label>
						<input type="text" class="form-control">
						<p class="help-block">Help text appears under the field input much like this text you're reading now.</p>
					</div>
				</div>

				<div id="dropdown-options">
					<!--- IF they select a select box... they'll need to add the options --->
					<h3 class="form-section-title">Set Dropdown Options</h3>
					<div class="row">
						<div class="col-md-3">
							<input type="text" class="form-control">
						</div>
						<div class="col-md-3">
							<input type="text" class="form-control">
						</div>
						<div class="col-md-3">
							<input type="text" class="form-control">
						</div>
						<div class="col-md-3">
							<input type="text" class="form-control">
						</div>
						<div class="col-md-3">
							<input type="text" class="form-control">
						</div>
						<div class="col-md-3">
							<input type="text" class="form-control">
						</div>
						<div class="col-md-3">
							<input type="text" class="form-control">
						</div>
						<div class="col-md-3">
							<input type="text" class="form-control">
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
				<button type="button" class="btn btn-success">Save Field Settings</button>
			</div>
		</div>
	</div>
</div>

<cfinclude template="shared/footer.cfm"/>