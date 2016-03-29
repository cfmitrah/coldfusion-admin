<cfoutput>
<!---
    {"hide_group":"","show_group":"1113","dependency":1111}
--->

<!-- Add dependency item -->
<div class="modal fade" id="dependency-rule" tabindex="-1" role="dialog" aria-labelledby="dependency-rule-label" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<form action="" id="form_dependency_rule">
				<input type="hidden" name="rule.rule_type_id" id="dependency_rule_type_id" value="#rc['rule_types']['dependency']#" />
				<input type="hidden" name="rule.agenda_rule_id" id="dependency_agenda_rule_id" value="0" />
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="dependency-modal-label">Agenda Dependency</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="" class="required">Name This dependency:</label>
								<input type="text" name="rule.name" id="dependency_rule_name" class="form-control" required>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="" class="required">Parent Agenda item:</label>
								<select name="rule.definition.dependency" id="dependency_rule_dependency" class="form-control"> </select>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="" class="required">Attendee Type:</label>
								<select name="rule.registration_type_id" id="dependency_rule_registration_type_id" class="form-control">
									<cfloop from="1" to="#rc.attendee_types.recordsTotal#" index="local.aType">
										<option value="#rc.attendee_types.data[ local.aType ].registration_type_id#">#rc.attendee_types.data[ local.aType ].registration_type#</option>
									</cfloop>
								</select>
							</div>
						</div>
					</div>

					<div class="alert alert-info">
						Move agenda items from the left to the right by clicking on them. Items displaying in the right side box will be hidden unless the the parent agenda item is selected.
					</div>
					<label for="" class="required">Create Your Agenda Dependency Show Group:</label>
					<div class="alert alert-warning" id="dependency_rule_show_group_loading">Loading...</div>
					<select name="rule.definition.show_group" id="dependency_rule_show_group" multiple></select>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
					<button type="button" class="btn btn-success" id="btn_save_dependency">Save Dependency</button>
				</div>
			</form>
		</div>
	</div>
</div>
</cfoutput>