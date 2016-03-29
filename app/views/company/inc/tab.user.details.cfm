<cfoutput>
<div class="tab-pane active" id="user-details">
	<form role="form" data-parsley-validate>
		<div class="form-group">
			<label for="label" class="required">Username</label>
			<input name="user.username" id="username" type="text" class="form-control" required />
		</div>
		<cfinclude template="tab.user.password_fields.cfm" />
		<div class="form-group">
			<label for="" class="required">First Name</label>
			<input name="user.first_name" id="first_name" type="text" class="form-control" required>
		</div>
		<div class="form-group">
			<label for="" class="required">Last Name</label>
			<input name="user.last_name" id="last_name" type="text" class="form-control" required>
		</div>
		<div class="form-group">
			<label for="hide_agenda" class="required">Active?</label>
			<div class="cf">
				<div class="radio pull-left">
					<label>
						<input name="user.active" id="active_yes" type="radio" value="1"> Yes
					</label>
				</div>
				<div class="radio pull-left">
					<label>
						<input name="user.active" id="active_no" type="radio" value="0" checked> No
					</label>
				</div>
			</div>
		</div>

		<div class="form-group">
			<label for="" class="required">Is System Admin</label>
			<div class="cf">
				<div class="radio pull-left">
					<label for="visible_yes">
						<input name="user.is_system_admin" id="is_system_admin_yes" type="radio" value="1"> Yes
					</label>
				</div>
				<div class="radio pull-left">
					<label for="visible_no">
						<input name="user.is_system_admin" id="is_system_admin_no" type="radio" value="0" checked> No
					</label>
				</div>
			</div>
		</div>
	</form>
</div>
</cfoutput>