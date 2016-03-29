<cfoutput>
<div class="tab-pane active" id="user-details">
	<h3 class="form-section-title">Main Details</h3>
	<form action="#buildURL('system.saveUser')#" method="post" role="form">
		<input type="hidden" name="user.user_id" value="#val(rc.user.user_id)#" />
		<cfif val(rc.user.user_id)>
			 <p class="form-control-static">#rc.user.username#</p>
		<cfelse>
			<div class="form-group">
				<label for="label" class="required">Username</label>
				<input name="user.username" id="username" type="text" class="form-control" />
			</div>
			<cfinclude template="tab.user.password_fields.cfm" />
		</cfif>
		<div class="form-group">
			<label for="" class="required">First Name</label>
			<input name="user.first_name" id="first_name" type="text" class="form-control" value="#rc.user.first_name#">
		</div>
		<div class="form-group">
			<label for="" class="required">Last Name</label>
			<input name="user.last_name" id="last_name" type="text" class="form-control" value="#rc.user.last_name#">
		</div>
		<div class="form-group">
			<label for="hide_agenda" class="required">Active?</label>
			<div class="cf">
				<div class="radio pull-left">
					<label>
						<input name="user.active" id="active_yes" type="radio" value="1" #rc.checked[ rc.user.active eq 1]#> Yes
					</label>
				</div>
				<div class="radio pull-left">
					<label>
						<input name="user.active" id="active_no" type="radio" value="0" #rc.checked[ rc.user.active eq 0]#> No
					</label>
				</div>
			</div>
		</div>

		<div class="form-group">
			<label for="" class="required">Is System Admin</label>
			<div class="cf">
				<div class="radio pull-left">
					<label for="visible_yes">
						<input name="user.is_system_admin" id="is_system_admin_yes" type="radio" value="1" #rc.checked[ rc.user.is_system_admin eq 1]#> Yes
					</label>
				</div>
				<div class="radio pull-left">
					<label for="visible_no">
						<input name="user.is_system_admin" id="is_system_admin_no" type="radio" value="0" #rc.checked[ rc.user.is_system_admin eq 0]#> No
					</label>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="" class="required">Companies</label>
			<span class="label-help">By adding companies here, users will have access to all events within the company.  If you want to restrict by event,  leave this blank and go to the events tab.</span>
			<select name="user.companies" id="user_companies" class="form-control" multiple="yes">
				<cfloop from="1" to="#rc.user.companies.count#" index="local.idx">
					<cfset local['company'] = rc.user.companies.data[ local.idx ] />
					<option value="#local.company.company_id#" #rc.selected[ local.company.is_company_user eq 1]#>#local.company.company_name#</option>
				</cfloop>
			</select>
		</div>
		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Save</strong></button>
		</div>
	</form>
</div>
</cfoutput>