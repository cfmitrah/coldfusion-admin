<cfscript>
	local['boolean_value'] = {
		'Yes':true,	
		'No':false
	};
</cfscript>
<cfoutput>
<div id="form-builder-step-3" class="basic-wrap block3">
	<div class="alert alert-info"> 
		<span class="glyphicon glyphicon-info-sign"></span> 
		Drag the form fields you created from the available fields bank to the desired form section. 
	</div> 
	<div class="alert alert-warning">
		<strong>Note:</strong> Billing and agenda sections are generated automatically based on their respective settings.
	</div>
	<div class="row">
		<div class="col-md-4">
			<h3 class="form-section-title">Standard / Custom Fields</h3>
			<ul id="form-field-bank" class="reg-form-list field-bank cf ui-sortable">
				<cfloop from="1" to="#rc.fields.count#" index="local.field_idx">
					<cfset local.field = rc.fields.data[local.field_idx]/>
					<cfif local.field.standard_field NEQ 3 >
					<li class="ui-sortable-handle" data-field_id="#local.field.field_id#" data-is_hotel_field="false" id="#local.field.field_id#">#local.field.label#</li>
					</cfif>
				</cfloop>
			</ul>
		</div>
		<div class="col-md-8">
			<h3 class="form-section-title">Assign to a Standard Form Section</h3>
			<div class="panel-wrap cf">
				<cfloop from="1" to="#rc.sections.count#" index="idx">
					<cfset local.section = rc.sections.data[ idx ] />
					<cfif local.section.section_type EQ "standard">
						<div class="custom-panel">
							<h3 class="custom-panel-header" id="header-section-#local.section.section_id#" >#local.section.title#</h3>
							<div class="custom-panel-content">
								<ul id="section-#local.section.section_id#" data-section_id="#local.section.section_id#" class="section-field-list reg-form-list ui-sortable">
									<cfset local.fields = local.section.fields />
									<cfset local.field_count = local.section.field_count />
									<!--- Loop over fields --->
									<cfloop from="1" to="#local.field_count#" index="local.field_idx">
									<cfset local.field = local.fields[ local.field_idx ] />
									<li class="ui-sortable-handle" data-field_id="#local.field.field_id#" data-is_hotel_field="false" id="#local.field.field_id#">#local.field.label#</li>
									</cfloop>
								</ul>
							</div>
						</div>
					</cfif>
				</cfloop>
			</div>
		</div>
	</div>

	<!--- If there is a hotel form section....... --->
	<!--- New Hotel Fields Section --->
	<div class="row mt-small">
		<div class="col-md-4">
			<h3 class="form-section-title">Hotel Reservation Fields</h3>
			<ul id="hotel-form-field-bank" class="reg-form-list field-bank cf ui-sortable">
				<cfloop from="1" to="#rc.fields.count#" index="local.field_idx">
					<cfset local.field = rc.fields.data[local.field_idx]/>
					<cfif local.field.standard_field EQ 3 >
						<li class="ui-sortable-handle" data-field_id="#local.field.field_id#" data-is_hotel_field="true" id="#local.field.field_id#">#local.field.label#</li>
					</cfif>
				</cfloop>
			</ul>
		</div>
		<div class="col-md-8">
			<h3 class="form-section-title">Assign to Hotel Form Section</h3>
			<div class="panel-wrap cf">
				<cfloop from="1" to="#rc.sections.count#" index="idx">
					<cfset local.section = rc.sections.data[ idx ] />
					<cfif local.section.section_type EQ "hotel">
						<div class="custom-panel">
							<h3 class="custom-panel-header" id="header-section-#local.section.section_id#" >#local.section.title#</h3>
							<div class="custom-panel-content">
								<ul id="section-#local.section.section_id#" data-section_id="#local.section.section_id#" class="section-field-list hotel-form-list ui-sortable">
									<cfset local.fields = local.section.fields />
									<cfset local.field_count = local.section.field_count />
									<!--- Loop over fields --->
									<cfloop from="1" to="#local.field_count#" index="local.field_idx">
									<cfset local.field = local.fields[ local.field_idx ] />
									<li class="ui-sortable-handle" data-field_id="#local.field.field_id#" data-is_hotel_field="#local.boolean_value[local.field.standard_field eq 3]#" id="#local.field.field_id#">#local.field.label#</li>
									</cfloop>
								</ul>
							</div>
						</div>
					</cfif>
				</cfloop>
			</div>

		</div>
	</div>
	<!--- End New Hotels Section --->

	
</div>
</cfoutput>
