<div class="form-group">
	<label for="label" class="required">Password</label>
	<input name="user.password" id="password" type="password" class="form-control" required />
</div>
<div class="form-group">
	<label for="" class="required">Confirm Password</label>
	<input name="user.confirm_password" id="confirm_password" type="password" class="form-control" required data-parsley-equalto="#password" />
</div>