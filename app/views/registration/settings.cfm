<cfset local.active_class = { 'Yes': "active", 'No':"" } />
<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'registration.default' )#">Registration</a></li>
  <li class="active">Registration Fields</li>
</ol>
<!--// BREAD CRUMBS END //-->

<h2 class="page-title color-03">Registration Fields</h2>
<p class="page-subtitle">Use the area below to manage all attendee fields that will be available for you to choose from when building out the registration process</p>
<!-- Nav tabs -->
<ul class="nav nav-tabs mt-medium" role="tablist">
	<li class="#local.active_class[ rc.tab eq "standard-fields" ]#"><a href="##standard-fields" role="tab" data-toggle="tab">Standard Provided Fields</a></li>
	<li class="#local.active_class[ rc.tab eq "login-fields" ]#"><a href="##login-fields" role="tab" data-toggle="tab">Login Fields</a></li>
	<li class="#local.active_class[ rc.tab eq "custom-fields" ]#"><a href="##custom-fields" role="tab" data-toggle="tab">Custom Form Fields</a></li>
	<li class="#local.active_class[ rc.tab eq "hotel-fields" ]#"><a href="##hotel-fields" role="tab" data-toggle="tab">Hotel Booking Fields</a></li>
	<li class="#local.active_class[ rc.tab eq "field-dependencies" ]#"><a href="##field-dependencies" role="tab" data-toggle="tab">Field Dependencies</a></li>
</ul>

<!-- Tab panes -->
<div class="tab-content" id="registration_listing">
	<div class="tab-pane #local.active_class[ rc.tab eq "standard-fields" ]#" id="standard-fields">
		<div class="alert alert-info"><span class="glyphicon glyphicon-question-sign"></span> Clicking manage will let you edit a fields visibility, requirements, label, and more.</div>
		<h3 class="form-section-title">Standard Fields</h3>
		<table id="#( structKeyExists(rc, "standard_field_table_id") ? rc.standard_field_table_id : '' )#" class="table table-striped table-hover data-table tm-large" ></table>
	</div>
	<div class="tab-pane #local.active_class[ rc.tab eq "login-fields" ]#" id="login-fields">
		<div class="alert alert-info">
			
			<p><span class="glyphicon glyphicon-question-sign"></span> The first page of registration. Here you can:</p>
			<ul>
				<li>Change the name of the field label (click Manage to do so)</li>
				<li>Add help text for the field (click Manage to do so)</li>
				<li>Force attendees to verify their email or password (click Manage to do so)</li>
				<li>Quick assign will enable you to carry the value provided through to the rest of the form</li>
			</ul>
		</div>
		<h3 class="form-section-title">
			Login fields
		</h3>
		<table id="#( structKeyExists(rc, "login_table_id") ? rc.login_table_id : '' )#" class="table table-striped table-hover data-table tm-large" ></table>
	</div>
	<div class="tab-pane #local.active_class[ rc.tab eq "custom-fields" ]#" id="custom-fields">
		<!--- <div class="alert alert-info"><span class="glyphicon glyphicon-question-sign"></span> First time using the custom field generator? Watch a quick demo by <a href="##" data-toggle="modal" data-target="##form-training"><strong>Clicking Here</strong></a>.</div> --->
		<h3 class="form-section-title">
			Custom Fields
			<a href="" class="btn btn-lg btn-info pull-right" data-toggle="modal" data-target="##custom-field-manage" id="btn_new_custom_field">Add New Custom Field</a>
		</h3>
		<table id="#( structKeyExists(rc, "custom_field_table_id") ? rc.custom_field_table_id : '' )#" class="table table-striped table-hover data-table tm-large" ></table>
	</div>
	<div class="tab-pane #local.active_class[ rc.tab eq "hotel-fields" ]#" id="hotel-fields">
		<div class="alert alert-info">
			<span class="glyphicon glyphicon-question-sign"></span> This form section appears during registration if you have provided room space from the <a href="#buildURL( 'hotels.default' )#">Hotels and Booking</a> section of the admin.
		</div>
		<h3 class="form-section-title">Hotel Fields</h3>
		<!--- New Table For Hotel Fields --->
		<table id="#( structKeyExists(rc, "hotel_field_table_id") ? rc.hotel_field_table_id : '' )#" class="table table-striped table-hover data-table tm-large" ></table>
		
	</div>
	<div class="tab-pane #local.active_class[ rc.tab eq "field-dependencies" ]#" id="field-dependencies">
		<div class="alert alert-info"><span class="glyphicon glyphicon-question-sign"></span> Field dependencies allow a second field to be displayed only AFTER a the first field option is set.</div>
		<h3 class="form-section-title">
			Existing Dependencies
			<a href="" class="btn btn-lg btn-info pull-right" data-toggle="modal" data-target="##field-dependency-manage" id="btn_new_dependency_field">Add New Dependency</a>
		</h3>
		<table id="#( structKeyExists(rc, "dependencies_table_id") ? rc.dependencies_table_id : '' )#" class="table table-striped table-hover data-table tm-large" ></table>
	</div>
</div>


<!--- standard field modal --->
<div class="modal fade in" id="standard-field-manage" tabindex="-1" role="dialog" aria-labelledby="standard-field-manage-label">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="standard-field-manage-label">Field Management: <span id="standard_field_name_display"></span></h4>
			</div>
			<div class="modal-body">
				<input type="hidden" id="standard_field_id" />
				<input type="hidden" id="standard_field_type" />
				<input type="hidden" id="standard_field" />
				<input type="hidden" id="standard_field_max_length" />

				<div class="row">
					<div class="form-group col-md-6">
						<label for="" class="required">Field Name:</label>
						<input type="text" class="form-control disabled" value="" id="standard_field_name" disabled="" maxlength="150">
						<p class="help-block">Used to define the field. Label should reflect this value</p>
					</div>
					<div class="form-group col-md-6">
						<label for="" class="required">Field Label:</label>
						<input type="text" class="form-control" value="" id="standard_field_label" maxlength="150">
						<p class="help-block">Visible by the user. Will display next to the form field.</p>
						<div class="checkbox">
							<label>
								<input type="checkbox" id="standard_field_hide_on_review"> Hide field on the review and confirmation page.
							</label>
						</div>
					</div>
					<div class="form-group col-md-6">
						<label for="">Settings</label>
						<div class="checkbox">
							<label>
								<input type="checkbox" id="standard_field_required"> Required (User must enter something for this field)
							</label>
						</div>
						<div class="checkbox">
							<label>
								<input type="checkbox" id="standard_field_reg_view_only"> Registration View Only Field (If checked this field will be visible but not editable to the Attendee, but editable to the Admin)
							</label>
						</div>
						<div class="checkbox" id="hotel_field_hide_wrapper">
							<label>
								<input type="checkbox" id="hotel_field_hide" value="1"> Hide, if there is only one option.
							</label>
						</div>
						<div class="row" id="hotel_number_rooms_wrapper">
							<div class="form-group col-md-12">
								<div class="checkbox">
									<label>
										<input type="checkbox" id="standard_field_admin_only"> Admin Only Field (If checked this field will only be visible in the Attendee Dashboard in the Admin)
									</label>
								</div>
							</div>
							<div class="form-group col-md-6">
								<label for="">Minimum number of rooms per guest:</label>
								<input type="number" class="form-control" value="" id="hotel_min_number_rooms" />
								<p class="help-block">This will also act as adefaut value.</p>
							</div>
							<div class="form-group col-md-6">
								<label for="">Maximum number of rooms per guest:</label>
								<input type="number" class="form-control" value="" id="hotel_max_number_rooms" />
							</div>
						</div>
					</div>
					<div class="form-group col-md-6">
						<label for="">Help Text:</label>
						<input type="text" class="form-control" id="standard_field_help">
						<p class="help-block">Help text appears under the input field much like this text.</p>
					</div>

					<div class="form-group col-md-6 div-hide" id="field-region-options">
						<label for="">Region</label>
						<select name="" id="standard_region_code" class="form-control">
							<cfset local.cnt = arrayLen( rc.country_codes ) />
							<cfloop from="1" to="#local.cnt#" index="local.i">
								<option value="#rc.country_codes[local.i].country_code#" >#rc.country_codes[local.i].country_code#</option>
							</cfloop>
						</select>
					</div>

					<div id="standard-field-choices" class="form-group col-md-12 div-hide">

						<h3 class="form-section-title">Set Input Choices <small>These items will appear as choices for the selected input type</small></h3>
						<div class="row">
							<div id="standard-form-options-inputs-wrap"></div>
						</div>

						<a href="##" id="standard-additional-options-btn" class="btn btn-primary btn-sm">Add Choices</a>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
				<button type="button" class="btn btn-success" id="btn_save_standard_field">Save Field Settings</button>
			</div>
		</div>
	</div>
</div>
<!--- // standard field modal --->

<!-- Custom Form modal -->
<div class="modal fade" id="custom-field-manage" tabindex="-1" role="dialog" aria-labelledby="custom-field-manage-label" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>

				<h4 class="modal-title" id="custom-field-manage-label">Custom Form Field: <span id="custom_field_name_display"></span></h4>
			</div>
			<div class="modal-body">
				<input type="hidden" id="custom_field_id" />
				<div class="row">
					<div class="form-group col-md-6">
						<label for="" class="required">Field Label:</label>
						<input type="text" class="form-control" id="custom_field_label" maxlength="150" />
						<p class="help-block">Visible by the user. Will display next to the form field.</p>
						<div class="checkbox">
							<label>
								<input type="checkbox" id="custom_field_hide_on_review"> Hide field on the review and confirmation page.
							</label>
						</div>
					</div>
					<div class="form-group col-md-6" id="required_wrapper">
						<label for="">Settings</label>
						<div class="checkbox">
							<label>
								<input type="checkbox" id="custom_field_required"> Required (User must enter something for this field)
							</label>
						</div>
						<div class="checkbox">
							<label>
								<input type="checkbox" id="custom_field_admin_only"> Admin Only Field (If checked this field will only be visible in the Attendee Dashboard in the Admin)
							</label>
						</div>
						<div class="checkbox">
							<label>
								<input type="checkbox" id="custom_field_reg_view_only"> Registration View Only Field (If checked this field will be visible but not editable to the Attendee, but editable to the Admin)
							</label>
						</div>
						
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-12" id="narrative_wrapper">
						<label for="">Narrative:</label>
						<textarea class="form-control" id="custom_field_narrative" maxlength="1000"></textarea>
						<p class="help-block">Field Labels are limited in size.  If you have more information you need to share or ask your attendees, please use the narrative section which will show below the field label.</p>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-6" id="help_text_wrapper">
						<label for="">Help Text:</label>
						<input type="text" class="form-control" id="custom_field_help">
						<p class="help-block">Help text appears under the input field much like this text.</p>
					</div>
					<div class="form-group col-md-6">
						<label for="" class="required">Input Type:</label>
						<select name="" id="custom_field_type"  class="form-control">
							<cfloop from="1" to="#rc.field_types.cnt#" index="i">
								<option value="#rc.field_types.types[i].field_type#"
									data-allow_dependency="#rc.field_types.types[i].allow_dependency#"
									data-allow_options="#rc.field_types.types[i].allow_options#">#rc.field_types.types[i].field_type_name#</option>
							</cfloop>
						</select>
					</div>
					<div class="form-group col-md-6 div-hide" id="confirm-field-wrapper">
						<label for="">Field to Confirm:</label>
						<select name="" id="confirm_field" class="form-control"></select>
					</div>
				</div>

				<div id="field-choices" class="div-hide">

					<h3 class="form-section-title">Set Input Choices <small>These items will appear as choices for the selected input type</small></h3>
					<div class="row">
						<div id="form-options-inputs-wrap"></div>
					</div>

					<a href="##" id="additional-options-btn" class="btn btn-primary btn-sm">Add Choices</a>
				</div>

				<div id="field-options" class="div-hide">
					<h3 class="form-section-title">Set Text Area Options</h3>
					<div class="form-group">
						<label for="">Set Max Num. Characters</label>
						<input type="number" class="form-control"  id="custom_field_max_length">
					</div>
				</div>

				<div id="field-choice-options" class="div-hide">
					<div class="form-group">
						<label for="">Has Other?</label>
						<div class="checkbox">
							<label>
								<input type="checkbox" id="custom_field_has_other"> Would you like to add an "Other" option as a choice for your attendees?
							</label>
						</div>
					</div>
				</div>
				<div id="field-options-date-range" class="div-hide">
				    <div class="row">
				        <div class="col-md-12">
				            <h3 class="form-section-title">Limit selectable date range</h3>
				        </div>
				    </div>
				    <div class="row">
				        <div class="col-md-6">
				            <div class="form-group">
				                <label for="">Date must start on or after:</label>
				                <input type="text" class="form-control dateonly-datetime"  id="custom_field_date_range_start">
				            </div>
				        </div>
				        <div class="col-md-6">
				            <div class="form-group">
				                <label for="">Date must end on or before:</label>
				                <input type="text" class="form-control dateonly-datetime"  id="custom_field_date_range_end">
				            </div>
				        </div>
				    </div>
				    <div class="row">
				        <div class="col-md-6">
				            <div class="form-group">
				                <label for="">Default Date Picker Start Date:</label>
				                <input type="text" class="form-control dateonly-datetime"  id="custom_field_date_default">
				            </div>
				        </div>
				    </div>
				</div>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
				<button type="button" class="btn btn-success" id="btn_save_custom_field">Save Field Settings</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="field-dependency-manage" tabindex="-1" role="dialog" aria-labelledby="field-dependency-manage-label" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>

				<h4 class="modal-title" id="custom-field-manage-label">Field Dependency: </h4>
			</div>
			<div class="modal-body">
				<form name="dependency_form" id="dependency_form">
				<input type="hidden" name="field_dependency_id" id="field_dependency_id" />
				<div class="row">
					<div class="col-md-6">
						<h4>Choose the First Option (Parent)</h4>

						<div class="form-group">
							<label for="" class="required">Choose Parent Field:</label>
							<select name="field_id" id="dependency_parent_field" class="form-control">

							</select>
						</div>

						<div id="parent_options_wrapper" class="form-group div-hide">
							<label for="" class="required">Choose Parent Fields Option:</label>
							<p class="help-block">If this option (parent) is selected by the user, the dependent (child) field will show.</p>
							<div id="parent_options_inner_wrapper"></div>
						</div>
						<div id="parent_value_wrapper" class="form-group div-hide">
							<div class="row" id="parent_value_sub_wrapper">
								<div class="form-group col-md-12">
									<label for="" class="required">Enter the Parent Value:</label>
									<input type="text" class="form-control" id="parent_value">
									<p class="help-block">If this (parent) value is entered by the user, the dependent (child) field will show.</p>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<h4>Select the Dependent Field (Child Field)</h4>
						<div class="form-group">
							<label for="" class="required">Choose Child Field:</label>
							<select name="dependency" id="dependency_child_field" class="form-control">
								<option value=""></option>
							</select>
							<p class="help-block">This field will ONLY display if the option on the left is clicked by the attendee</p>
						</div>
					</div>
				</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
				<button type="button" class="btn btn-success" id="btn_save_dependency_field">Save Field Settings</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="field-duplicate-manage" tabindex="-1" role="dialog" aria-labelledby="field-duplicate-manage-label" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>

				<h4 class="modal-title" id="Duplicate-field-manage-label">Duplicate Field: </h4>
			</div>
			<div class="modal-body">
				<form name="duplicate_form" id="duplicate_form">
				<input type="hidden" name="duplicate_field.field_id" id="duplicate_field_id" />
				<div class="row">
					<div class="form-group col-md-12">
						<label for="" class="required">Field Label:</label>
						<input type="text" name="duplicate_field.label" class="form-control" id="duplicate_field_label" maxlength="150" />
						<p class="help-block">Visible by the user. Will display next to the form field.</p>
					</div>	
				</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
				<button type="button" class="btn btn-success" id="btn_save_duplicate_field">Save Field</button>
			</div>
		</div>
	</div>
</div>
<!-- //Custom Form modal -->
</cfoutput>
