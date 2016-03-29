<cfoutput>
<form id="reg-path-form" action="#buildURL('registration.createFormSections')#" method="post">
	<div id="form-builder-step-1" class="basic-wrap block1">
		<div class="row">
			<div class="form-group col-md-6 col-md-offset-3">
				<label for="">Select Attendee Type</label>
				<select name="registration_type_id" id="choose-attendee" class="form-control parsley-success" data-parsley-group="block1" required="" data-parsley-id="9930">
					<option value="">Choose attendee type...</option>
					<cfloop from="1" to="#rc.Registration_Types.recordsTotal#" index="local.i">
						<option value="#rc.Registration_Types.data[ local.i ].registration_type_id#">#rc.Registration_Types.data[ local.i ].registration_type#</option>
					</cfloop>					
				</select><ul class="parsley-errors-list" id="parsley-id-9930"></ul>
				<p class="help-block">This determines the attendee type the new registration form will be associated to. Only attendee types which don't already have a form associated with them will appear in the dropdown above. You can create new attendee types <strong><a href="#buildURL('attendeeSettings.default')#">by clicking here</a></strong>.</p>
			</div>
		</div>
		<div class="row">
			<div class="form-group col-md-6 col-md-offset-3">
				<button  class="btn btn-lg btn-block btn-success">Continue</button>
			</div>
		</div>
	</div>
</form>
</cfoutput>