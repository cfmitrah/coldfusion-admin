<cfoutput>
<div class="tab-pane active" id="company-essentials">
	<form action="#buildURL('company.doSave')#" role="form" method="post">
		<input type="hidden" name="company.company_id" value="#rc.company_details.company_id#" />
		<h3 class="form-section-title">Essentials</h3>
		<div class="form-group">
			<label for="name" class="required">Company Name</label>
			<input type="text" class="form-control" id="name" name="company.company_name" value="#rc.company_details.company.company.data[1].company_name#">
		</div>
		<div class="form-group">
			<label for="domain-name" class="required">Domain Name</label>
			<select name="company.domain_id" class="form-control" id="domain-name">
				#rc.company_details.domain_opts#
			</select>
		</div>
		<div class="row">
			<div class="form-group col-md-6">
				<label for="address-type" class="required">Address Type:</label>
				<select name="company.address_type" class="form-control width-sm" id="address-type">
					<option value="Default">Default</option>
				</select>
			</div>
		</div>
		<div class="row">
				<input type="hidden" name="company.address_id" value="#val( rc.company_details.company.company.data[1].address_id )#">
				<div class="form-group col-md-6">
					<label for="address_1" class="required">Address Line 1</label>
					<input type="text" id="address_1" name="company.address_1" value="#rc.company_details.company.company.data[1].address_1#" class="form-control" maxlength="200" />
				</div>
				<div class="form-group col-md-6">
					<label for="address_2">Address Line 2</label>
					<input type="text" id="address_2" name="company.address_2" value="#rc.company_details.company.company.data[1].address_2#" class="form-control" maxlength="200" />
				</div>
				<div class="form-group col-md-6">
					<label for="city" class="required">City</label>
					<input type="text" id="city" name="company.city" value="#rc.company_details.company.company.data[1].city#" class="form-control" maxlength="150" />
				</div>
				<div class="form-group col-md-6">
					<label for="country_code" class="required">Country</label>
					<select class="form-control" id="country_code" name="company.country_code">#rc.company_details.countries.opts#</select>
				</div>
				<div class="form-group col-md-6">
					<label for="region_code" class="required">State / Region</label>
					<select class="form-control width-md" id="region_code" name="company.region_code">#rc.company_details.regions.opts#</select>
				</div>
				<div class="form-group col-md-6">
					<label for="postal_code" class="required">Zip / Postal</label>
					<input type="text" id="postal_code" name="company.postal_code" value="#rc.company_details.company.company.data[1].postal_code#" class="form-control" maxlength="15" />
				</div>
			</div>
			<div class="row">
			<div class="form-group col-md-6">
				<input type="hidden" name="company.phone_id" id="phone_id" value="#val( rc.company_details.company.company.data[1].phone_id )#">
				<label for="address-type" class="required">Phone Type:</label>
				<select name="company.phone_type" class="form-control width-sm" id="phone-type">
					<option value="Default">Default</option>
				</select>
			</div>
			<div class="form-group col-md-6">
					<label for="phone_number">Phone Number</label>
					<input type="tel" id="phone_number" name="company.phone_number" value="#rc.company_details.company.company.data[1].phone_number#" class="form-control" />
			</div>

		<div class="cf">
			 <button type="submit" class="btn btn-success btn-lg pull-right"><strong>Save The Essentials</strong></button>
		</div>
	 </div>
	</form>

	</div></cfoutput>