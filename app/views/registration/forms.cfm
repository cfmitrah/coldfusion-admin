<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'registration.default' )#">Registration</a></li>
  <li class="active">Create New Registration Form</li>
</ol>
<!--// BREAD CRUMBS END //-->
<div id="action-btns" class="pull-right">
	<a href="#buildURL( "registration.createAttendeeForm" )#" class="btn btn-lg btn-info">Create New Registration Form</a>
</div>
<h2 class="page-title color-03">Registration Forms</h2>
<p class="page-subtitle">In this section you can manage the registration forms and processes for each attendee type.</p>
<div class="alert alert-info"><strong>Existing registration forms will appear below once created.</strong> <br> You can duplicate a registration form for a starting point when creating a new one. Once duplicated and an attendee type is chosen, you will be able to edit it for that specific attendee type.</div>
	
<!--- Loop over forms --->
<cfloop from="1" to="#rc.forms.count#" index="local.form_idx">
	<cfset local['form'] = rc.forms.data[ local.form_idx ] />
	<cfset local['sections'] = local.form.sections />
	<cfset local['section_count'] = local.form.section_count />
	<div class="reg-path-block">						
		<h3>#local.form.registration_type#</h3>
		<a href="##" class="btn btn-info btn-expand">Expand Details</a>
		<div class="btn-group">
			<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
				Options <span class="caret"></span>
			</button>
			<ul class="dropdown-menu" role="menu">
				<li><a href="#buildURL( action="registration.createFormSections", queryString="registration_type_id=" & local.form.registration_type_id  )#">Edit</a></li>
				<li><a href="##" data-toggle="modal" data-target="##path-copy" data-duplicate="true" data-link="#buildURL( action="registration.duplicatePath", queryString="registration_type_id=" & local.form.registration_type_id  )#">Duplicate</a></li>
				<li>
					<a href="#buildURL( action="registration.assignSectionFields", queryString="registration_type_id=" & local.form.registration_type_id  )#">
						Fields
					</a>
				</li>
				<li class="divider"></li>
				<li><a href="##">Delete</a></li>
			</ul>
		</div>
		<!--- Loop over sections --->
		<div class="reg-grid-container" class="cf">
			<cfloop from="1" to="#local.section_count#" index="local.section_idx">
				<cfset local.section = local['sections'][ local.section_idx ] />
				<cfset local.fields = local.section.fields />
				<cfset local.field_count = local.section.field_count />
				<div class="form-section-summary">
					<h4>#local.section.title#</h4>
					<ul>
						<!--- Loop over fields --->
						<cfloop from="1" to="#local.field_count#" index="local.field_idx">
						<cfset local.field = local.fields[ local.field_idx ] />
						<li>#field.label#</li>
						</cfloop>
					</ul>
				</div>
			</cfloop>
				
			<div class="form-section-summary">
				<h4>Build Agenda</h4>
			</div>
			<div class="form-section-summary">
				<h4>Payment / Review / Complete</h4>
			</div>
		</div>
	</div>
</cfloop>

<div class="modal fade" id="path-copy" tabindex="-1" role="dialog" aria-labelledby="path-copy-label" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				
				<h4 class="modal-title" id="path-copy-label">Copy To: </h4>
			</div>
			<div class="modal-body">
					<input type="hidden" name="copy_form_url" id="copy_form_url" />
				<div class="row">
					<div class="col-md-6">
						<h4></h4>
						
						<div class="form-group">
							<label for="" class="required">Copy To:</label>
							<select name="registration_type_id_copy_to" id="registration_type_id_copy_to" class="form-control">
								<cfloop from="1" to="#rc.forms.count#" index="local.form_idx">
									<cfset local['form'] = rc.forms.data[ local.form_idx ] />
									<option value="#local.form.registration_type_id#">#local.form.registration_type#</option>
								</cfloop>
							</select>
						</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
				<button type="button" class="btn btn-success" id="btn_path_copy">Copy Now!</button>
			</div>
		</div>
	</div>
</div>
</cfoutput>