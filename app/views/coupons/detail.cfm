<cfoutput>
<ol class="breadcrumb">
	<li><a href="#buildURL( 'dashboard' )#">Dashboard</a></li>
	<li><a href="#buildURL( 'event' )#">Events</a></li>
	<li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
	<li><a href="#buildURL( 'coupons' )#">Coupons</a></li>
	<li class="active">Coupon Detail</li>
</ol>
<h2 class="page-title color-02">#rc.coupon.mode# Coupon</h2>
<p class="page-subtitle">Enter the details for this specific discount below</p>
<form id="coupon" name="coupon" action="#buildURL( 'coupons.doSave' )#" method="post" class="basic-wrap mt-medium" data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden">
	<div class="container-fluid">
		<h3 class="form-section-title">General Information</h3>
		<div class="row">
			<div class="form-group col-md-6 col-md-offset-3">
				<label for="code" class="required">Discount Code:</label>
				<input type="text" class="form-control" id="code" name="coupon.code" value="#rc.coupon.code#" maxlength="25" />
				<p class="help-block">The code which attendees will enter to apply the discount</p>
				<input type="hidden" name="coupon.coupon_id" value="#rc.coupon.coupon_id#" />
			</div>
			<div class="form-group col-md-6 col-md-offset-3">
				<label for="description">Description:</label>
				<input type="text" class="form-control" id="description" name="coupon.description" value="#rc.coupon.description#" maxlength="300" />
				<p class="help-block">Brief description of the coupon that will show during confirmation</p>
			</div>
			<div class="form-group col-md-6 col-md-offset-3">
				<label for="" class="required">Type:</label>
				<div class="radio">
					<label>
						<input type="radio" name="coupon.coupon_type" value="flat" class="formShowHide_ctrl" data-show_id="flat-choice" #rc.checked[rc.coupon.coupon_type eq 'Flat']# /> <strong>Reg. Fee Discount</strong> - the dollar amount subtracted from the Registration cost.
					</label>
				</div>
				<div class="radio">
					<label>
						<input type="radio" name="coupon.coupon_type" value="discount" class="formShowHide_ctrl" data-show_id="discount-choice" #rc.checked[rc.coupon.coupon_type eq 'Discount']# /> <strong>Discount</strong> - the dollar amount subtracted from the total cost.
					</label>
				</div>
				<div class="radio">
					<label>
						<input type="radio" name="coupon.coupon_type" value="percent" class="formShowHide_ctrl" data-show_id="percentage-choice" #rc.checked[rc.coupon.coupon_type eq 'percent']# /> <strong>Percentage Discount</strong> - a percentage subtracted from total cost.
					</label>
				</div>
			</div>
			<div id="value-wrapper" class="form-group col-md-6 col-md-offset-3">
				<label for="flat" id="flat-choice" class="types">What would you like the flat fee to be?</label>
				<label for="discount" id="discount-choice" class="types">What would you like amount subtracted from the total to be?</label>
				<label for="percentage" id="percentage-choice" class="types">What is the percent you'd like to be discount from the total?</label>
				<input type="number" class="form-control" id="coupon_value" name="coupon.value" value="#rc.coupon.value#" required Min="1" placeholder="You do not need to insert the $ sign" />
			</div>
		</div>
		<h3 class="form-section-title">Constraints and Settings</h3>
		<div class="row">
			<div class="form-group col-md-6 col-md-offset-3">
				<label for="start_on">Start Date:</label>
				<input type="text" class="form-control std-datetime" id="start_on" name="coupon.start_on" value="#dateTimeFormat(rc.coupon.start_on, 'mm/dd/yyyy h:mm tt')#" />
			</div>
			<div class="form-group col-md-6 col-md-offset-3">
				<label for="end_on">End Date:</label>
				<input type="text" class="form-control std-datetime" id="end_on" name="coupon.end_on" value="#dateTimeFormat(rc.coupon.end_on, 'mm/dd/yyyy h:mm tt')#" />
			</div>
			<div class="form-group col-md-6 col-md-offset-3">
				<label for="limit">Limit uses to number:</label>
				<input type="number" class="form-control" id="limit" name="coupon.limit" value="#rc.coupon.limit#" />
			</div>
			<div class="form-group col-md-6 col-md-offset-3">
				<label for="active" class="required">Status:</label>
				<div class="radio">
					<label>
						<input type="radio" id="active" name="coupon.active" #rc.checked[!!rc.coupon.active]# value="1" /> Active
					</label>
				</div>
				<div class="radio">
					<label>
						<input type="radio" name="coupon.active" #rc.checked[!rc.coupon.active]# value="0" /> Inactive
					</label>
				</div>
			</div>
		</div>
		<h3 class="form-section-title">Attendee Specifications</h3>
		<div class="row">
			<div class="form-group col-md-6 col-md-offset-3">
				<label>Limit Discount Code to certain attendee types:</label>
				<input type="hidden" name="coupon.registration_type_ids" value="" />
				<cfloop from="1" to="#rc.coupon.restriction_cnt#" index="i">
					<div class="checkbox">
						<label>
							<input type="checkbox" name="coupon.registration_type_ids" value="#rc.coupon.restrictions[i].registration_type_id#" #rc.checked[rc.coupon.restrictions[i].restricted eq 1]# /> #rc.coupon.restrictions[i].registration_type#
						</label>
					</div>
				</cfloop>
				<p class="help-block">Restrict Discount Code from being used by these attendee types (by default all attendee types are able to use the code) <br> By default ALL attendee types will be able to use this discount code. Only the attendee types you check above will not be able to use the code.</p>
			</div>
		</div>
		<div class="row">
			<div class="form-group col-md-6 col-md-offset-3">
				<input type="submit" class="btn btn-success btn-block btn-lg" value="#rc.coupon.mode# Coupon">
			</div>
		</div>
	</div>
</form>
</cfoutput>