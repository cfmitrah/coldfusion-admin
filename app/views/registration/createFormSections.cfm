<cfoutput>
<div id="form-builder-step-2" class="basic-wrap block2 hide show">
	<div class="row">
		<div class="col-md-7">
			<form id="add-section">
				<input type="hidden" name="registration_type_id" id="registration_type_id" value="#rc.registration_type_id#" />
				<input type="hidden" name="section_id" id="section_id" value="0" />
				<input type="hidden" name="sort" id="sort" value="0" />
				<h3 class="form-section-title">Create New Form Section</h3>
				<div class="well">
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="title" class="required">Section Name</label>
								<input name="title" type="text" class="form-control" data-parsley-id="4188" id="title" maxlength="250" /><ul class="parsley-errors-list" id="parsley-id-4188"></ul>
								<p class="help-block">Appears at top of section. (ex. General Info)</p>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="label" class="required">Navigation Label</label>
								<input name="label" type="text" class="form-control" data-parsley-id="4188" id="label" maxlength="50" />
								<!--- <ul class="parsley-errors-list" id="parsley-id-4188"></ul> --->
								<p class="help-block">Appears in form steps (usually same as name)</p>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label for="label" class="required" id="section_type_id_label">Form Section Type</label>
								<select name="section_type_id" id="section_type_id" class="form-control">
									<!---<cfloop from="1" to="#rc.section_types.count#" index="local.idx">
										<cfset local['section_type'] = rc.section_types.data[ local.idx ] />
										<option value="#local.section_type.section_type_id#" data-number_in_use="#local.section_type.number_in_use#">#local.section_type.name# (#local.section_type.description#)</option>
									</cfloop>--->
								</select>
							</div>
						</div>
					</div>
					
					
					<div class="form-group">
						<label for="summary" >Summary <small>(Optional)</small></label>
						<textarea name="summary" class="form-control" id="summary" maxlength="1000"></textarea>
						<!--- <ul class="parsley-errors-list" id="parsley-id-4188"></ul> --->
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="layout">Section Layout</label>
								<select name="layout" id="layout" data-save_field="layout" class="form-control" data-parsley-id="0123">
									<optgroup label="Select layout...">
										<option value="1-column">1 Column</option>
										<option value="2-columns">2 Columns</option>
										
									</optgroup>
								</select>
								<p class="help-block">View the differences of each layout <a href="##layout-examples" data-toggle="modal" data-target="##layout-examples">by clicking here</a></p>
								<!--- <ul class="parsley-errors-list" id="parsley-id-0123"></ul> --->
							</div>
						</div>
						<div class="col-md-6 div-hide" >
							<div class="form-group">
								<label for="label" id="group_allowed_label">Group Allowed</label>
								<input type="checkbox" name="settings.group_allowed" id="group_allowed" class="form-control" value="1" />
								<p class="help-block">If your path allows group registration, this will determine if a group member can view this section.</p>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							<button class="btn btn-warning btn-block" id="btn-rest-section" type="reset">Cancel</button>
						</div>
						<div class="col-md-8">
							<button class="btn btn-primary btn-block" id="btn-add-section" type="submit">Save Section</button>
						</div>
					</div>
				</div>
			</form>
		</div>
		<div class="col-md-5">
			<h3 class="form-section-title">Existing Form Sections</h3>
			
			
			<div class="alert alert-info" style="padding: 7px; margin-bottom: 5px;"> <span class="glyphicon glyphicon-info-sign"></span> You can drag your custom sections to rearrange their order</div>
			<div class="form-required-section">
				<strong class="text-danger">Required Information</strong> (Always the First Section)<br>
				<small>First Name, Last Name, Email Address, Attendee Type</small>
			</div>
			<ul id="form-section-list" class="ui-sortable"></ul>
			<a href="#buildURL( action="registration.assignSectionFields", queryString="registration_type_id=#rc.registration_type_id#" )#" class="btn btn-lg btn-block btn-success next" data-current-block="2" data-next-block="3">Continue With Above Sections</a>
		</div>
	</div>
</div>
</cfoutput>

<div class="modal fade" id="layout-examples">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Layout Examples</h4>
      </div>
      <div class="modal-body">
      	<div class="row">

			<div class="col-md-12 text-center">
				<h3><strong>2 Columns</strong></h3>
				<img src="/assets/img/layout-preview-2col.jpg" alt="" class="img-responsive">
			</div>
		</div>
			
			<hr>
			
		<div class="row">
			<div class="col-md-12 text-center">
				<h3><strong>1 Column</strong></h3>
				<img src="/assets/img/layout-preview-1col.jpg" alt="" class="img-responsive">
			</div>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->