<cfoutput>
<form id="payment_form" data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden">
	<input type="hidden" name="account_info.country" value="#rc.country_code#" >
	<input type="hidden" name="attendee_id" value="#rc.attendee.attendee_id#" >
	<input type="hidden" name="registration_id" value="#rc.attendee.registration_id#" >
	<div class="div-hide" id="notification"></div>
	<div class="row">
		<div class="col-md-3">
			<div class="form-group">
				<label for="" class="required">Payment Type:</label>
				<select name="account_info.payment_type" id="account_info_payment_type" class="form-control">
					<cfloop from="1" to="#rc.payment_types.count#" index="local.idx">
						<cfset local.pay_type = rc.payment_types.data[ local.idx ] />
						<cfif local.pay_type.payment_type NEQ "invoice">
						<option value="#local.pay_type.payment_type#">#local.pay_type.description#</option>
						</cfif>
					</cfloop>
					<!--- <option value="other">Other</option> --->
				</select>
			</div>
		</div>
		<div class="col-md-3">
			<div class="form-group">
				<label for="" class="required">Amount:</label>
				<input type="number" name="account_info.amount" class="form-control" min="1" id="account_info_amount" required />
			</div>
		</div>
		<div class="col-md-6">
			<div class="form-group">
				<label class="required">Notes:</label>
				<textarea class="form-control" rows="3" name="account_info.notes" id="account_info_notes" required></textarea>
				<p class="help-block">Notes help...</p>
			</div>
		</div>
	</div>
	<div class="row" id="credit_card_info">
	            
		<div class="col-md-6">
		    <div class="form-group">
		        <label for="" class="required">Name on Card</label>
		        <input type="text" class="form-control" name="account_info.name_on_card" id="account_info_name_on_card" value="#rc.attendee.formatted_name#" required />
		    </div>
		</div>
		<div class="col-md-6">
		    <div class="form-group">
		        <label for="" class="required">Address</label>
		        <input type="text" class="form-control" name="account_info.address" id="account_info_address" value="#rc.attendee.address_1#" required />
		    </div>
		</div>
        <div class="col-md-6">
		    <div class="form-group">
		        <label for="" class="required">City</label>
		        <input type="text" class="form-control" name="account_info.city" id="account_info_city" value="#rc.attendee.city#" required />
		    </div>
		</div>
		<div class="col-md-6">
            <div class="form-group">
                <label for="">State</label>
                <select name="account_info.region" id="account_info_region" class="form-control" required />
                    #rc.region_options#
                </select>
            </div>
        </div>
		<div class="col-md-6">
		    <div class="form-group">
		        <label for="" class="required">Postal Code</label>
		        <input type="text" class="form-control" name="account_info.postal_code" id="account_info_postal_code" value="#rc.attendee.postal_code#" required />
		    </div>
		</div>
		<div class="col-md-6">
		    <div class="form-group">
		        <label for="" class="required">Card Type</label>
		        <select name="account_info.credit_card_type" id="account_info_credit_card_type" class="form-control">
		           	<cfloop from="1" to="#rc.processor_credit_cards.credit_card_types.count#" index="local.idx">
	                <cfset local.card_type = rc.processor_credit_cards.credit_card_types.data[ local.idx ] />
	                <option value="#local.card_type.vendor#" 
	                		data-card_digits="#local.card_type.card_digits#" 
	                		data-card_pattern="#local.card_type.pattern#" 
	                		data-cvv_digits="#local.card_type.cvv_digits#">
	                	#local.card_type.vendor#
	                </option>
	                </cfloop>
		        </select>
		    </div>
		</div>
		<div class="col-md-6">
		    <div class="form-group">
		        <label for="" class="required">Credit Card Number</label>
		        <input type="text" name="account_info.account_number" id="account_info_account_number" class="form-control" required data-parsley-pattern="" maxlength="15">
		    </div>
		</div>
		<div class="col-md-6">
		    <div class="form-group">
		        <label for="" class="required">Expiration</label>
		        <div class="row">
		            <div class="col-md-6">
		                <select name="account_info.month" id="account_info_month" class="form-control" required >
		                	#rc.expiration_month_opts#
		                </select>
		            </div>
		            <div class="col-md-6">
		                <select name="account_info.year" id="account_info_year" class="form-control" required >
							#rc.expiration_year_opts#
		                </select>
		            </div>
		        </div>
		    </div>
		</div>
		<div class="col-md-6">
		    <div class="form-group">
		        <label for="" class="required">CVV Code</label>
		        <input type="text" class="form-control" name="account_info.cvv" id="account_info_cvv" maxlength="4" required />
		    </div>
		</div>
	</div>
</form>
</cfoutput>
