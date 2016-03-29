<cfoutput>

<div class="tab-pane" id="company-managers">
	<h3 class="form-section-title">Account Managers</h3>
	<p class="attention">Account Managers associated with this company will appear in the table below. You can choose from existing company users to add as managers by using the 'Make Selected User an Account Manager' button below.</p>
	<hr>
	<h4>Account Managers</h4>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Name</th>
				<th>Username</th>
				<th>Options</th>
			</tr>
		</thead>
		<tbody>
			<cfloop from="1" to="#rc.company_details.accountmanagers.count#" index="i">
				<tr data-company_id="#rc.company_details.company_id#" data-user_id="#rc.company_details.accountmanagers.managers.user_id[i]#">
					<td>#rc.company_details.accountmanagers.managers.last_name[i]#, #rc.company_details.accountmanagers.managers.first_name[i]#</td>
					<td>#rc.company_details.accountmanagers.managers.username[i]#</td>
					<td><a href="" class="text-danger remove-accountmanager"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Remove</strong> </a></td>
				</tr>
			</cfloop>
		</tbody>
	</table>
	<hr>
	<h4>Adding a New Account Manager</h4>
	<form action="#buildURL( 'company.doSaveManager' )#" role="form" method="post">
		<input type="hidden" name="company.company_id" value="#rc.company_details.company_id#" />
		<div class="form-group">
			<label for="manager" class="required">Select an existing user to add as an account manager</label>
			<select name="accountmanager.user_id" id="accountmanager" class="form-control width-md">
				#rc.company_details.amusers_options#
			</select>
		</div>
		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg"><strong>Make Selected User an Account Manager</strong></button>
		</div>
	</form>
</div>
</cfoutput>