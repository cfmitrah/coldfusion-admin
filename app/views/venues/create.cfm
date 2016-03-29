<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'venues.default' )#">Venues</a></li>
  <li class="active">Create Venue</li>
</ol>
<!--// BREAD CRUMBS END //-->
<h2 class="page-title color-03">Create a New Venue</h2>
<p class="page-subtitle">You can add locations to a venue once the venue has been created. First fill in the information below.</p>
<form action="#buildURL('venues.doCreate')#" method="post" role="form" class="basic-wrap mt-medium">
	<input type="hidden" name="venue_id" value="0" />
	<div class="container-fluid">
		<h3 class="form-section-title">Venue Details</h3>
		<div class="row">
			<div class="col-md-6">
				<div class="form-group">
					<label for="venue_name" class="required">Venue Name</label>
					<input type="text" id="venue_name" name="venue.venue_name" class="form-control" maxlength="150" />
				</div>
			</div>
			<div class="col-md-6">
				<div class="form-group">
					<label for="url">Website URL</label>
					<input type="url" id="url" name="venue.url" class="form-control" maxlength="300" />
				</div>
			</div>
		</div>
		<div class="row">
			<div class="form-group col-md-6">
				<label for="address_1" class="required">Address Line 1</label>
				<input type="text" id="address_1" name="venue.address_1" class="form-control" maxlength="200" />
			</div>
			<div class="form-group col-md-6">
				<label for="address_2">Address Line 2</label>
				<input type="text" id="address_2" name="venue.address_2" class="form-control" maxlength="200" />
			</div>
			<div class="form-group col-md-6">
				<label for="city" class="required">City</label>
				<input type="text" id="city" name="venue.city" class="form-control" maxlength="150" />
			</div>
			<div class="form-group col-md-6">
				<label for="country_code" class="required">Country</label>
				<select class="form-control" id="country_code" name="venue.country_code">#rc.countries.opts#</select>
			</div>
			<div class="form-group col-md-6">
				<label for="region_code" class="required">State / Region</label>
				<select class="form-control width-sm" id="region_code" name="venue.region_code">#rc.regions.opts#</select>
			</div>
			<div class="form-group col-md-6">
				<label for="postal_code" class="required">Zip / Postal</label>
				<input type="text" id="postal_code" name="venue.postal_code" class="form-control" maxlength="15" />
			</div>
			<div class="form-group col-md-6">
				<label for="phone_number">Contact Number</label>
				<input type="tel" id="phone_number" name="venue.phone_number" class="form-control" />
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<button type="submit"  id="create_button" class="btn btn-success btn-lg"><strong>Create Venue</strong></button>
			</div>
		</div>
	</div>
</form>
<!--- start of company user remove modal --->
	<cfinclude template="inc/modal.error_name.cfm" />
</cfoutput>