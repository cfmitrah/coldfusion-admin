<cfoutput>

<div class="tab-pane" id="company-users">
	<h3 class="form-section-title">Users</h3>
	<p class="attention">Users associated with this company will appear in the table below. You can choose from existing users to add as users for this company by using the 'add company user' button below.</p>
	<hr>
	<h4>Users</h4>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Name</th>
				<th>Username</th>
				<th>Options</th>
			</tr>
		</thead>
		<tbody>
			<cfloop from="1" to="#rc.company_details.companyusers.count#" index="i">
				<tr data-company_id="#rc.company_details.company_id#" data-user_id="#rc.company_details.companyusers.users.user_id[i]#" data-displayname="#rc.company_details.companyusers.users.displayname[i]#">
					<td>#rc.company_details.companyusers.users.last_name[i]#, #rc.company_details.companyusers.users.first_name[i]#</td>
					<td>#rc.company_details.companyusers.users.username[i]#</td>
					<td>
						<a href="" class="btn btn-sm btn-primary user-events"><strong>Events</strong></a>
						<a href="" class="btn btn-sm btn-danger remove-user"><strong>Remove</strong></a>
					</td>
				</tr>
			</cfloop>
		</tbody>
	</table>
	<a href="##" data-toggle="modal" data-target="##assign-user" class="btn btn-primary add_existing">Add Existing User to Company</a>
	<a href="##" data-toggle="modal" data-target="##assign-user" class="btn btn-primary add_new">Create New User to Company</a>

	<!--- start of modal --->
	<div class="modal fade" id="assign-user" tabindex="-1" role="dialog" aria-labelledby="assign-user-label" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="speaker-assign-label">Add Company User</h4>
				</div>
				<div class="modal-body">
					<div class="existing_div">
						<label for="user_id" class="required">Select an existing user to add as a user for this company.</label>
						<select name="user_id" id="user_id" class="form-control">
							<cfloop from="1" to="#rc.missing_users_cnt#" index="s">
								<option class="user_option" value="#rc.missing_users[s].user_id#">#rc.missing_users[s].displayname#</option>
							</cfloop>
						</select>
					</div>
					<div class="new_div">
						<cfinclude template="tab.user.details.cfm" />
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
					<button id="submit_add_form" type="button" autocomplete="off" data-loading-text="Saving..." class="btn btn-primary">Add User</button>
				</div>
			</div>
		</div>
	</div>
	<!--- end of modal --->
	<cfinclude template="modal.user_events.cfm" />
</div>
</cfoutput>