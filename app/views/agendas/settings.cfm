<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'agendas.default' )#">Agenda</a></li>
  <li class="active">Agenda Settings</li>
</ol>
<!--// BREAD CRUMBS END //-->

<h2 class="page-title color-02">Agenda Settings</h2>
<p class="page-subtitle">
	Add some extra information to the agenda section of registration as well as set which layout you would like to use for the agenda.
</p>


<form method="post" class="basic-wrap mt-medium" action="#buildURL( "agendas.saveSettings" )#">
	<input type="hidden" name="agenda_settings.agenda_setting_id" id="agenda_setting_id" value="#rc.agenda_settings.agenda_setting_id#" />
	<div class="row">
		<div class="col-md-12">
			<h3 class="form-section-title">Additional Direction</h3>
		</div>
		<div class="col-md-12">
			<div class="form-group">
				<label for="">Agenda Help</label>

				<textarea name="agenda_settings.agenda_help" id="agenda_help" rows="4" class="form-control">#rc.agenda_settings.agenda_help#</textarea>
				<p class="note">Add optional information to help users better understand your agenda.</p>
			</div>
		</div>
		<div class="col-md-12 mt-medium">
			<h3 class="form-section-title">Layout Options</h3>
		</div>
		<div class="col-md-12">
			<div class="form-group">
				<label for="">Choose how you would like the agenda section to appear</label>
				<div class="radio">
				  <label>
				    <input type="radio" name="agenda_settings.layout_type" id="layout_type_tabs" value="tabs" #rc.checked[ rc.agenda_settings.layout_type eq "tabs" ]#/>
				   	Tabbed Agenda
				  </label>
				</div>
				<div class="radio">
				  <label>
				    <input type="radio" name="agenda_settings.layout_type" id="layout_type_list" value="list" #rc.checked[ rc.agenda_settings.layout_type eq "list" ]#/>
				    List Agenda
				  </label>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<p><em>Examples of display options:</em></p>
			<img src="/assets/img/agenda-tabbed-sample.jpg" alt="" class="responsive">
		</div>
		<div class="col-md-6">
			<p>&nbsp;</p>
			<img src="/assets/img/agenda-list-sample.jpg" alt="" class="responsive">
		</div>
		<div class="col-md-12 mt-medium">
			<h3 class="form-section-title">Grouping Options</h3>
		</div>
		<div class="col-md-8">
			<div class="form-group">
				<label for="">How would you like your agenda items to be grouped?</label>
				<div class="radio">
				  <label>
				    <input type="radio" name="agenda_settings.group_by" id="group_by_date" value="date" #rc.checked[ rc.agenda_settings.group_by eq "date" ]#/>
				   	Group by Date
				  </label>
				</div>
				<div class="radio">
				  <label>
				    <input type="radio" name="agenda_settings.group_by" id="group_by_category" value="category" #rc.checked[ rc.agenda_settings.group_by eq "category" ]#/>
				    Group by Category
				  </label>
				</div>
			</div>
		</div>
		<div class="col-md-12 mt-medium">
			<h3 class="form-section-title">Sub-Grouping Options</h3>
		</div>
		<div class="col-md-8">
			<div class="form-group">
				<label for="">How would you like your agenda items to be sub-grouped?</label>
				<div class="radio">
				  <label>
				    <input type="radio" name="agenda_settings.sub_group_by" id="sub_group_by_date" value="date" #rc.checked[ rc.agenda_settings.sub_group_by eq "date" ]#/>
				   	Group by Date
				  </label>
				</div>
				<div class="radio">
				  <label>
				    <input type="radio" name="agenda_settings.sub_group_by" id="sub_group_by_category" value="category" #rc.checked[ rc.agenda_settings.sub_group_by eq "category" ]#/>
				    Group by Category
				  </label>
				</div>
			</div>
		</div>
		<div class="col-md-12 mt-medium">
			<h3 class="form-section-title">Custom Labeling</h3>
		</div>
		<div class="col-md-12">

			<div id="tab_definitions_misc">
				<div class="row mt-small">
					<label for="" class="col-md-2">Agenda Name Header</label>
					<div class="col-md-6">
						<input type="text" maxlength="50" name="agenda_settings.settings.header_labels.name" class="form-control" value="#rc.agenda_settings.settings.header_labels.name#"/>
					</div>
				</div>
				<div class="row mt-small">
					<label for="" class="col-md-2">Scheduled Time Header</label>
					<div class="col-md-6">
						<input type="text" maxlength="50" name="agenda_settings.settings.header_labels.scheduled_time" class="form-control" value="#rc.agenda_settings.settings.header_labels.scheduled_time#"/>
					</div>
				</div>
				<div class="row mt-small">
					<label for="" class="col-md-2">Associated Fee Header</label>
					<div class="col-md-6">
						<input type="text" maxlength="50" name="agenda_settings.settings.header_labels.associated_fee" class="form-control" value="#rc.agenda_settings.settings.header_labels.associated_fee#"/>
					</div>
				</div>
				<div class="row mt-small">
					<label for="" class="col-md-2">Add to Agenda Header</label>
					<div class="col-md-6">
						<input type="text" maxlength="50" name="agenda_settings.settings.header_labels.action" class="form-control" value="#rc.agenda_settings.settings.header_labels.action#"/>
					</div>
				</div>
			</div>
			<p class="help">Here you can set the custom labels for each agenda tab or heading. If you leave the fields blank, the date or category name will be used based upon your grouping options</p>
			<div id="tab_definitions_dates">
			<cfloop collection="#rc.agenda_settings.settings.tab_definitions.date_original#" item="local.key">
				<cfif structKeyExists( rc.agenda_settings.settings.tab_definitions.date, local.key ) >
					<cfset local.display = rc.agenda_settings.settings.tab_definitions.date[ local.key ] />
				<cfelse>
					<cfset local.display = rc.agenda_settings.settings.tab_definitions.date_original[ local.key ] />
				</cfif>
				
				<div class="row mt-small">
					<label for="" class="col-md-2">Override Label: #local.display#</label>
					<div class="col-md-6">
						<input type="text" name="agenda_settings.settings.tab_definitions.date.#local.key#" class="form-control" value="#local.display#"/>
					</div>
				</div>
			</cfloop>
			</div>
			<div id="tab_definitions_categories">
			<cfloop collection="#rc.agenda_settings.settings.tab_definitions.category_original#" item="local.key">
				<cfif structKeyExists( rc.agenda_settings.settings.tab_definitions.category, local.key ) >
					<cfset local.display = rc.agenda_settings.settings.tab_definitions.category[ local.key ] />
				<cfelse>
					<cfset local.display = rc.agenda_settings.settings.tab_definitions.category_original[ local.key ] />
				</cfif>
				
				<div class="row mt-small">
					<label for="" class="col-md-2">Override Label: #local.display#</label>
					<div class="col-md-6">
						<input type="text" name="agenda_settings.settings.tab_definitions.category.#local.key#" class="form-control" value="#local.display#"/>
					</div>
				</div>
			</cfloop>
			</div>
			<div id="tab_sort_categories">
				<div class="col-md-12 mt-medium">
					<h3 class="form-section-title">Category Sorting</h3>
					<p class="help">Category only applies when category is the sub-grouping and date is the grouping</p>
				</div>
			<cfset local['sort_cat'] = structSort( rc.agenda_settings.settings.tab_definitions.category_original, "textnocase","asc") />
			<cfset local['sort_cat_len'] = arrayLen( local.sort_cat ) />
			<cfloop array="#local.sort_cat#" index="local.key">
				<cfset local['current_sort_value'] = ""/>
				<cfif structKeyExists( rc.agenda_settings.settings.sort.category, local.key )>
					<cfset local['cat_key'] = rc.agenda_settings.settings.sort.category[ local.key ] />
					<cfif structKeyExists( rc.agenda_settings.settings.tab_definitions.category, local.key ) >
						<cfset local.display = rc.agenda_settings.settings.tab_definitions.category[ local.key ] />
					<cfelse>
						<cfset local.display = rc.agenda_settings.settings.tab_definitions.category_original[ local.key ] />
					</cfif>
					<cfif structKeyExists( rc.agenda_settings.settings.sort.category, local.key ) >
						<cfset local['current_sort_value'] = rc.agenda_settings.settings.sort.category[ local.key ]/>
					</cfif>
					<div class="row mt-small">
						<label for="" class="col-md-2">#local.display#</label>
						<div class="col-md-6">
							<select name="agenda_settings.settings.sort.category.#local.key#"  class="form-control">
								<cfloop from="1" to="#rc.agenda_settings.settings.tab_counts.category#" index="local.idx">
									<cfset local['opt_value'] = NumberFormat(local.idx, "009") & "_" & local.key />
									<cfset local['selected'] = "" />
									<cfif local.current_sort_value eq local.opt_value>
										<cfset local['selected'] = "selected" />	
									</cfif>
									<option value="#local.opt_value#" #local.selected# >#local.idx#</option>
								</cfloop>
							</select>
						</div>
					</div>
				</cfif>
			</cfloop>
			</div>			
		</div>

	</div>
	<div class="cf mt-medium">
		<button type="submit" class="btn btn-success btn-lg pull-right">Everything Look Good? <strong>Save It!</strong></button>
	</div>
			
</form>

</cfoutput>