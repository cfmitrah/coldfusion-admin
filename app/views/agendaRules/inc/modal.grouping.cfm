<cfoutput>
<!-- Add Grouping item -->
<div class="modal fade" id="grouping-rule" tabindex="-1" role="dialog" aria-labelledby="grouping-rule-label" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<form action="" id="form_group_rule">
				<input type="hidden" name="rule.rule_type_id" id="group_rule_type_id" value="#rc['rule_types']['required_group']#" />
				<input type="hidden" name="rule.agenda_rule_id" id="group_agenda_rule_id" value="0" />
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="group-modal-label">Agenda Grouping</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="" class="required">Name This Group:</label>
								<input type="text" name="rule.name" id="group_rule_name" class="form-control" required>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="" class="required">Minimum Number of Selections Required:</label>
								<select name="rule.definition.minimum" id="group_rule_definition_minimum" class="form-control">
									<cfoutput>
										<cfloop from="1" to="10" index="i">
											<option value="#i#">#i#</option>
										</cfloop>
									</cfoutput>
								</select>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="" class="required">Attendee Type:</label>
								<select name="rule.registration_type_id" id="group_rule_registration_type_id" class="form-control">
									<cfloop from="1" to="#rc.attendee_types.recordsTotal#" index="local.aType">
										<option value="#rc.attendee_types.data[ local.aType ].registration_type_id#">#rc.attendee_types.data[ local.aType ].registration_type#</option>
									</cfloop>
								</select>
							</div>
						</div>
					</div>

					<div class="alert alert-info">
						Move agenda items from the left to the right by clicking on them. Items displaying in the right side box will be grouped together.
					</div>
					<label for="" class="required">Create Your Agenda Group:</label>
					<div class="alert alert-warning" id="group_rule_definition_group_loading">
						Loading...
					</div>
					<select name="rule.definition.group" id="group_rule_definition_group" multiple>
						<cfoutput>
							<option value="a" selected>Sample agenda item test</option>
						<cfloop from="1" to="20" index="i">
							<option value="#i#">Sample agenda item #i#</option>
						</cfloop>
						</cfoutput>
					</select>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
					<button type="button" class="btn btn-success" id="btn_save_grouping">Save Grouping Rule</button>
				</div>
			</form>
		</div>
	</div>
</div>
</cfoutput>