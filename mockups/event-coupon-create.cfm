<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>
<div id="page">
	<cfinclude template="shared/event-sidebar.cfm"/>
	<!--- Sidebar Ends Content Starts --->
	<div id="main-content-wrapper" class="has-sidebar">
		<div id="main-content">
			<ol class="breadcrumb">
				<li><a href="#">Dashboard</a></li>
				<li><a href="#">Events</a></li>
				<li><a href="#">Event Name</a></li>
				<li><a href="#">Discount</a></li>
				<li class="active">Create Discount</li>
			</ol>
			<h2 class="page-title color-02">Create Discount</h2>
			<p class="page-subtitle">Enter the details for this specific discount below</p>
			<form action="" class="basic-wrap mt-medium">
				<div class="container-fluid">
					<h3 class="form-section-title">General Information</h3>
					<div class="row">
						<div class="form-group col-md-6 col-md-offset-3">
							<label for="" class="required">Discount Code:</label>
							<input type="text" class="form-control">
							<p class="help-block">The code which attendees will enter to apply the discount</p>
						</div>
						<div class="form-group col-md-6 col-md-offset-3">
							<label for="">Description:</label>
							<input type="text" class="form-control">
							<p class="help-block">Brief description of the coupon that will show during confirmation</p>
						</div>
						<div class="form-group col-md-6 col-md-offset-3">
							<label for="" class="required">Type:</label>
							<div class="radio">
								<label>
									<input type="radio" name="discount-types" class="formShowHide_ctrl" data-show-id="flat-choice"> <strong>Flat Fee</strong> - the dollar amount the attendee will pay no matter the conference cost.
								</label>
							</div>
							<div class="radio">
								<label>
									<input type="radio" name="discount-types" class="formShowHide_ctrl" data-show-id="deduction-choice"> <strong>Deduction</strong> - the dollar amount subtracted from the total cost.
								</label>
							</div>
							<div class="radio">
								<label>
									<input type="radio" name="discount-types" class="formShowHide_ctrl" data-show-id="percent-choice"> <strong>Percentage Discount</strong> - a percentage subtracted from total cost.
								</label>
							</div>
							<div class="radio">
								<label>
									<input type="radio" name="discount-types"> <strong>No charge</strong> - Equivilant to a discount of 100%, an attendee with this code will not have to pay anything, and will not be presented with the billing page.
								</label>
							</div>
						</div>
						<div id="flat-choice" class="form-group col-md-6 col-md-offset-3">
							<label for="">What would you like the flat fee to be?</label>
							<input type="text" class="form-control" placeholder="You do not need to insert the $ sign">
						</div>
						<div id="deduction-choice" class="form-group col-md-6 col-md-offset-3">
							<label for="">What would you like amount subtracted from the total to be?</label>
							<input type="text" class="form-control" placeholder="You do not need to insert the $ sign">
						</div>
						<div id="percent-choice" class="form-group col-md-6 col-md-offset-3">
							<label for="">What is the percent you'd like to be discount from the total?</label>
							<input type="text" class="form-control" placeholder="You do not need to insert the % sign">
						</div>
					</div>
					<h3 class="form-section-title">Constraints and Settings</h3>
					<div class="row">
						<div class="form-group col-md-6 col-md-offset-3">
							<label for="">Start Date:</label>
							<input type="text" class="form-control std-datetime">
						</div>
						<div class="form-group col-md-6 col-md-offset-3">
							<label for="">End Date:</label>
							<input type="text" class="form-control std-datetime">
						</div>
						<div class="form-group col-md-6 col-md-offset-3">
							<label for="">Limit uses to number:</label>
							<input type="number" class="form-control">
						</div>
						<div class="form-group col-md-6 col-md-offset-3">
							<label for="" class="required">Status:</label>
							<div class="radio">
								<label>
									<input type="radio" name="discount-status"> Active
								</label>
							</div>
							<div class="radio">
								<label>
									<input type="radio" name="discount-status"> Inactive
								</label>
							</div>
						</div>
					</div>
					<h3 class="form-section-title">Attendee Specifications</h3>
					<div class="row">
						<div class="form-group col-md-6 col-md-offset-3">
							<label for="">Limit Discount Code to certain attendee types:</label>
							<div class="checkbox">
								<label>
									<input type="checkbox" name="discount-attendee-type"> Type One Sample
								</label>
							</div>
							<div class="checkbox">
								<label>
									<input type="checkbox" name="discount-attendee-type"> Type Two Sample
								</label>
							</div>
							<p class="help-block">By default ALL attendee types will be able to use this discount code. If you limit to a specific attendee type by checking a box above, other attendee types will not be able to use the code.</p>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-6 col-md-offset-3">
							<input type="submit" class="btn btn-success btn-block btn-lg" value="Create Discount">
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<cfinclude template="shared/footer.cfm"/>