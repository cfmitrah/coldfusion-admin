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
				<li><a href="#dependencies" role="tab" data-toggle="tab">Field Dependencies</a></li>
			</ul>

			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane active" id="standard-fields">
					<div class="alert alert-info"><span class="glyphicon glyphicon-question-sign"></span> Clicking manage will let you edit a fields visibility, requirements, label, and more.</div>
					<h3 class="form-section-title">Standard Fields</h3>
					<!--- start of gigantic form --->
					<table id="reg-field-table" class="table table-striped table-condensed">
						<thead>
							<tr>
								<th>Field Name</th>
								<th>Field Label</th>
								<th>Use Field</th>
								<th>Required</th>
								<th>Options</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>email</td>
								<td>Email Address</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>verify_email</td>
								<td>Verify Email</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>secondary_email</td>
								<td>Seconday Email Address</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>password</td>
								<td>Password</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>verify_password</td>
								<td>Verify Password</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>prefix</td>
								<td>Prefix (Mr., Mrs., etc.)</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>first_name</td>
								<td>First Name</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>middle_name</td>
								<td>Middle Name</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>last_name</td>
								<td>Last Name</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>name_on_badge</td>
								<td>Name to Display on Name Badge</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>suffix</td>
								<td>Suffix</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>job_title</td>
								<td>Job Title</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>company</td>
								<td>Company / Organization</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>country</td>
								<td>Country</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>address_1</td>
								<td>Address Line One</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>address_2</td>
								<td>Address Line Two</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>City</td>
								<td>City</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>region_code</td>
								<td>State</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>postal_code</td>
								<td>Zip / Postal Code</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>home_phone</td>
								<td>Home Phone</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>work_phone</td>
								<td>Office Phone</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>extension</td>
								<td>Office Extension</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>fax_phone</td>
								<td>Fax Number</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>cell_phone</td>
								<td>Cell Phone</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>dob</td>
								<td>Birthday</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>gender</td>
								<td>Gender</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>emergency_contact_name</td>
								<td>Emergency Contact Name</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>emergency_contact_phone</td>
								<td>Emergency Contact Number</td>
								<td></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>photo</td>
								<td>Profile Photo</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>private</td>
								<td>Keep App Profile Private?</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>bio</td>
								<td>Biography</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#standard-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
						</tbody>
					</table>

					

				</div>
				<div class="tab-pane" id="custom-fields">
					<div class="alert alert-info"><span class="glyphicon glyphicon-question-sign"></span> First time using the custom field generator? Watch a quick demo by <a href="##" data-toggle="modal" data-target="#form-training"><strong>Clicking Here</strong></a>.</div>
					<h3 class="form-section-title has-btn">
						Custom Fields
						<a href="" class="btn btn-lg btn-info" data-toggle="modal" data-target="#custom-field-manage">Add New Custom Field</a>
					</h3>
					<table id="reg-field-table" class="table table-striped table-condensed">
						<thead>
							<tr>
								<th>Field Label</th>
								<th>Input Type</th>
								<th>Required</th>
								<th>Options</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Membership Number</td>
								<td>Text Box</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#custom-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
							<tr>
								<td>Last 4 Digits of SSN</td>
								<td>Number</td>
								<td><span class="glyphicon glyphicon-ok"></span></td>
								<td>
									<a href="#" class="btn btn-primary btn-sm" data-target="#custom-field-manage" data-toggle="modal">Manage</a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="tab-pane" id="dependencies">
					<div class="alert alert-info"><span class="glyphicon glyphicon-question-sign"></span>Field dependencies allow a second field to be displayed only AFTER a the first field option is set.</div>
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-12">
								<h3 class="form-section-title">Existing Dependencies</h3>
								<table class="table table-striped table-condensed">
									<thead>
										<tr>
											<th>Parent Field Name</th>
											<th>Parent Field Option</th>
											<th>Child Field Name</th>
											<th>Options</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>State</td>
											<td>Missouri</td>
											<td>Elementary School</td>
											<td><a href="##" class="btn btn-sm btn-danger">Remove Dependency</a></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<hr>
						<div class="row">
							<div class="col-md-12">
								<h3 class="form-section-title">Create New Dependency</h3>
							</div>
							<div class="col-md-6">
								<h4>Choose the First Option (Parent)</h4>
								<!--- Dropdown of the available form fields --->
								<div class="form-group">
									<label for="" class="required">Choose Parent Field:</label>
									<select name="" id="parent-field-selector" class="form-control">
										<option value=""></option>
										<!--- Right now I have this set up so if you click any option it will show the option choice div below --->
										<!--- will need real ajax logic of some sort --->
										<option value="">Sample Field Name One (Select)</option>
										<option value="">Sample Field Name Two (Radio)</option>
										<option value="">Sample Field Name Three (Checkbox)</option>
									</select>
									<!--- Remove and add real logic --->
									<script>
										$(function(){
											$('#parent-field-selector').on('change', function(){
												$('#parent-options').show();
											});
										});
									</script>
								</div>
								<!--- Then show the options for that field --->
								<div id="parent-options" class="form-group div-hide">
									<label for="" class='required'>Choose Parent Fields Option:</label>
									<p class="help-block">If this option (parent) is selected by the user, the dependent (child) field will show.</p>
									<div class="radio">
									    <label>
									    	<input type="radio" name="parent-option">Sample Field Option One
									    </label>
									</div>
									<div class="radio">
									    <label>
									    	<input type="radio" name="parent-option"> Sample Field Option Two
									    </label>
									</div>
									<div class="radio">
									    <label>
									    	<input type="radio" name="parent-option"> Sample Field Option Three
									    </label>
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<h4>Select the Dependent Field (Child Field)</h4>
								<div class="form-group">
									<label for="" class='required'>Choose Child Field:</label>

									<select name="" id="" class="form-control">
										<option value=""></option>
										<option value="">Sample Field Name One</option>
										<option value="">Sample Field Name Two</option>
										<option value="">Sample Field Name Three</option>
									</select>
									<p class="help-block">This field will ONLY display if the option on the left is clicked by the attendee</p>
								</div>
								<input type="submit" class="btn btn-lg btn-success btn-block" value="Save New Dependancy">
							</div>
						</div>
					</div>
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
						<p class="help-block">Used to define the field. Label should reflect this value</p>
					</div>
					<div class="form-group col-md-6">
						<label for="" class="required">Field Label:</label>
						<input type="text" class="form-control" value="Email Address">
						<p class="help-block">Visible by the user. Will display next to the form field.</p>
					</div>
					<div class="form-group col-md-6">
						<label for="">Settings</label>
						<div class="checkbox">
							<label>
								<input type="checkbox"> Use Field (Makes field available when setting up reg. process)
							</label>
						</div>
						<div class="checkbox">
							<label>
								<input type="checkbox"> Required (User must enter something for this field)
							</label>
						</div>
					</div>
					<div class="form-group col-md-6">
						<label for="">Help Text:</label>
						<input type="text" class="form-control">
						<p class="help-block">Help text appears under the input field much like this text.</p>
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

<!-- Sample Modal for Creating a Custom Form Field -->
<div class="modal fade" id="custom-field-manage" tabindex="-1" role="dialog" aria-labelledby="custom-field-manage-label" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<!--- Change text based on whether they are creating or editing? --->
				<h4 class="modal-title" id="custom-field-manage-label">New Custom Form Field</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="form-group col-md-6">
						<label for="" class="required">Field Label:</label>
						<input type="text" class="form-control" value="Email Address">
						<p class="help-block">Visible by the user. Will display next to the form field.</p>
					</div>
					<div class="form-group col-md-6">
						<label for="">Settings</label>
						<div class="checkbox">
							<label>
								<input type="checkbox"> Required (User must enter something for this field)
							</label>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-6">
						<label for="">Help Text:</label>
						<input type="text" class="form-control">
						<p class="help-block">Help text appears under the input field much like this text.</p>
					</div>
					<div class="form-group col-md-6">
						<label for="" class="required">Input Type:</label>
						<select name="" id="input-type-select" class="form-control">
							<option value="">Text Input</option>
							<option value="" class="show-textarea-options">Text Area</option>
							<option value="">Email Address</option>
							<option value="">Telephone</option>
							<option value="">Password</option>
							<option value="" class="show-options">Radio</option>
							<option value="" class="show-options">Checkbox</option>
							<option value="" class="show-options">Select Dropdown</option>
							<option value="" class="show-options">Multi Select Dropdown</option>
						</select>
						<p class="help-block">To view the details of each input type, <a href="">click here.</a></p>
					</div>
				</div>
				<!--- If they are editing a custom field that has associated field options already set - be sure to remove div-hide, needs conditional logic --->
				<div id="field-options" class="div-hide">
					<!--- IF they select a checkbox/select/radio... they'll need to add the options --->
					<h3 class="form-section-title">Set Input Choices <small>These items will appear as choices for the selected input type</small></h3>
					<div class="row">
						<div id="form-options-inputs-wrap">
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
						
					<a href="#" id="additional-options-btn" class="btn btn-primary btn-sm">Add Additional Choices</a>
				</div>
				<!--- If they are editing a text area that has options already set - be sure to remove div-hide, needs conditional logic --->
				<div id="textarea-options" class="div-hide">
					<h3 class="form-section-title">Set Text Area Options</h3>
					<div class="form-group">
						<label for="">Set Max Num. Characters</label>
						<input type="number" class="form-control">
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

<script>
$(function(){
	$('#input-type-select').on('change', function() {
		if( $("option:selected", this).hasClass("show-options") ) {
			$('#field-options').show();
			$('#textarea-options').hide();
		} else if( $("option:selected", this).hasClass("show-textarea-options") ) {
			$('#textarea-options').show();
			$('#field-options').hide();
		} else {
			$('#field-options').hide();
			$('#textarea-options').hide();
		}
	});

	$('#additional-options-btn').on('click', function(e){
		e.preventDefault();
		var additional_input = '<div class="col-md-3"><input type="text" class="form-control"></div>' +
		'<div class="col-md-3"><input type="text" class="form-control"></div>' +
		'<div class="col-md-3"><input type="text" class="form-control"></div>'+
		'<div class="col-md-3"><input type="text" class="form-control"></div>';

		$('#form-options-inputs-wrap').append(additional_input);
	});
});
</script>

<cfinclude template="shared/footer.cfm"/>