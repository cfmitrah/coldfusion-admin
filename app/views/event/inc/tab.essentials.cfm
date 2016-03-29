<cfoutput>
<div class="tab-pane active" id="event-essentials">
 	<form action="#buildURL('event.doSave')#" role="form" method="post">
		<input type="hidden" name="event.company_id" value="#rc.company_id#" />
		<input type="hidden" name="event.event_id" value="#rc.event_id#" />
		<input type="hidden" name="event.slug_id" value="#rc.event.details.slug_id#" />
		<h3 class="form-section-title">Global Settings</h3>
		<div class="row">
			<div class="form-group col-md-4">
				<label for="name" class="required">Event Name</label>
				<input type="text" class="form-control" id="name" name="event.name" value="#rc.event.details.name#">
			</div>
			<div class="form-group col-md-4">
				<label for="domain-name" class="required">Domain Name</label>
				<select name="event.domain_id" class="form-control" id="domain-name">
					#rc.domain_opts#
				</select>
			</div>
			<div class="form-group col-md-4">
				<label for="extension-input" class="required">URL extension / Event Registration Identifier</label>
				<input  name="event.slug" type="text" class="form-control" id="extension-input" value="#rc.event.details.slug#">
			</div>
		</div>
		<div class="form-group" style="margin-bottom: 0;">
			<cfset local.prefix = "https" />
			<cfif cgi.SERVER_PORT EQ 80>
				<cfset local.prefix = "http" />
			</cfif>
			<div class="row">
				<div class="col-md-6">
					<div class="alert alert-success mt-small">
						<strong>Live Registration Site Link:</strong> (Only viewable once published) <br>
						<a href="#local.prefix#://#rc.event.details.domain_name#/#rc.event.details.slug#/register/" target="_blank">
							#local.prefix#://<span id="domain-output">#rc.event.details.domain_name#</span>/<span id="slug-output">#rc.event.details.slug#</span>/register/
						</a>
					</div>
				</div>
				<div class="col-md-6">
					<div class="alert alert-info mt-small">
						<strong>Preview Registration Site Link:</strong> (Always viewable)<br>
						<a href="#local.prefix#://#rc.event.details.domain_name#/#rc.event.details.slug#/register/?preview=1" target="_blank">
							#local.prefix#://<span id="domain-output">#rc.event.details.domain_name#</span>/<span id="slug-output">#rc.event.details.slug#/register/</span>?preview=1
						</a>
					</div>
				</div>
			</div>
		</div>
		<div class="well dash-well">
			<h4>General Settings</h4>
			<div class="row">
		        <div class="form-group col-md-6 col-lg-4">
					<label for="status" class="required">Event Status</label>
					<select name="event.event_status" id="status" class="form-control">
						#rc.status_opts#
					</select>
				</div>
				<div class="form-group col-md-6 col-lg-4">
			        <cfif isDefined( "rc.event.details.settings" ) and isStruct( rc.event.details.settings ) and structKeyExists( rc.event.details.settings, "datetimeformat" )>
						<cfset selectedDateTimeFormat = rc.event.details.settings.datetimeformat>
					<cfelse>
						<cfset selectedDateTimeFormat = "">
					</cfif>
					<!---<input type="hidden" name="event.settings" value='#serializeJSON( rc.event.details.settings )#'>--->
					<label for="datetimeformat" class="required">Set Date / Time Format</label>
					<select name="event.datetimeformat" id="datetimeformat" class="form-control">
						<cfloop index="currentFormat" array="#rc.datetimeformat_opts.formats#">
							<option value="#currentFormat.format_code#" <cfif currentFormat.format_code eq selectedDateTimeFormat>selected="selected"</cfif>>#currentFormat.displayname#</option>
						</cfloop>
					</select>
				</div>

		        <cfif rc.has_ssos>
					<div class="form-group col-md-6 col-lg-4">
						<label for="sso_id">SSO <em>(Single Sign-On)</em></label>
						<select name="event.sso_id" id="sso_id" class="form-control">
							<option value="0">None</option>
							#rc.sso_opts#
						</select>
					</div>
				<cfelse>
					<input type="hidden" name="event.sso_id" value="0" />
				</cfif>

		        <div class="form-group col-md-6 col-lg-4">
					<label for="" class="required">Publish Event? <em>(Attendees can register)</em></label>
					<div class="cf">
						<div class="radio pull-left">
							<label for="published-yes">
								<input value="1" type="radio" name="event.published" class="published" id="published-yes" #rc.checked[ rc.event.details.published eq true ]#> Yes
							</label>
						</div>
						<div class="radio pull-left">
							<label for="published-no">
								<input value="0" type="radio" name="event.published" class="published" id="published-no" #rc.checked[ rc.event.details.published eq false ]#> No
							</label>
						</div>
					</div>
				</div>



		        <div class="form-group col-md-6 col-lg-4">
					<label for="" required>Enable Event Capacity?</label>
					<div class="cf">
						<div class="radio pull-left">
							<label for="enable_capacity-yes">
								<input value="1" type="radio" name="event.enable_capacity" id="enable_capacity-yes" #rc.checked[ rc.event.details.settings.enable_capacity eq true ]#> Yes
							</label>
						</div>
						<div class="radio pull-left">
							<label for="enable_capacity-no">
								<input value="0" type="radio" name="event.enable_capacity" id="enable_capacity-no" #rc.checked[ rc.event.details.settings.enable_capacity eq false ]#> No
							</label>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6 col-lg-4">
					<label for="capacity">Set Event Capacity <em>(If capacity is enabled)</em></label>
					<input type="text" class="form-control" id="capacity" name="event.capacity" value="#rc.event.details.capacity#">
				</div>




				<div class="form-group col-md-6 col-lg-4">
					<label for="" class="required">Attendees Can Only Register With an Invitation?</label>
					<div class="cf">
						<div class="radio pull-left">
							<label for="invite_only-yes">
								<input value="1" type="radio" name="event.invite_only" id="invite_only-yes" #rc.checked[ rc.event.details.settings.invite_only eq 1 ]#> Yes
							</label>
						</div>
						<div class="radio pull-left">
							<label for="invite_only-no">
								<input value="0" type="radio" name="event.invite_only" id="invite_only-no" #rc.checked[ rc.event.details.settings.invite_only eq 0 ]#> No
							</label>
						</div>
					</div>
				</div>

				<div class="form-group col-md-6 col-lg-4">
					<label for="invite_not_found_text">Invitation Not Found Messaging: (All Attendee Types)</label>
					<textarea class="form-control" name="event.invite_not_found_text" id="invite_not_found_text" style="height: 34px;">#rc.event.details.settings.invite_not_found_text#</textarea>
				</div>

				<div class="form-group col-md-6 col-lg-4">
					<label for="invite_not_found_text">Decline Invitation Message: (All Attendee Types)</label>
					<textarea class="form-control" name="event.invite_decline_message_text" id="invite_decline_message_text" style="height: 34px;">#rc.event.details.settings.invite_decline_message_text#</textarea>
				</div>

			</div>
		</div>

		<div class="well dash-well">
			<h4>Basic Attendee Settings</h4>
			<div class="row">
		        <div class="form-group col-md-6 col-lg-4">
					<label for="" class="required">Hide Cost Breakdown for Attendees? <em>(Usually hidden if event is free)</em></label>
					<div class="cf">
						<div class="radio pull-left">
							<label for="hide_attendee_cost_breakdown-yes">
								<input value="1" type="radio" name="event.hide_attendee_cost_breakdown" id="hide_attendee_cost_breakdown-yes" #rc.checked[ rc.event.details.settings.hide_attendee_cost_breakdown eq true ]#> Yes
							</label>
						</div>
						<div class="radio pull-left">
							<label for="hide_attendee_cost_breakdown-no">
								<input value="0" type="radio" name="event.hide_attendee_cost_breakdown" id="hide_attendee_cost_breakdown-no" #rc.checked[ rc.event.details.settings.hide_attendee_cost_breakdown eq false ]#> No
							</label>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6 col-lg-4">
					<label for="" class="required">Send cancellation emails upon cancelling?</label>
					<div class="cf">
						<div class="radio pull-left">
							<label for="omit_cancel_email-yes">
								<input value="1" type="radio" name="event.omit_cancel_email" id="omit_cancel_email-yes" #rc.checked[ rc.event.details.settings.omit_cancel_email eq 1 ]#> No
							</label>
						</div>
						<div class="radio pull-left">
							<label for="omit_cancel_email-no">
								<input value="0" type="radio" name="event.omit_cancel_email" id="omit_cancel_email-no" #rc.checked[ rc.event.details.settings.omit_cancel_email eq 0 ]#> Yes
							</label>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6 col-lg-4">
					<label for="" class="required">Allow attendee to edit their agenda once created?</label>
					<div class="cf">
						<div class="radio pull-left">
							<label for="attendee_dashboard_agenda_edit-yes">
								<input value="1" type="radio" name="event.attendee_dashboard_agenda_edit"
								id="attendee_dashboard_agenda_edit-yes" #rc.checked[ rc.event.details.settings.attendee_dashboard_agenda_edit eq 1 ]#> Yes
							</label>
						</div>
						<div class="radio pull-left">
							<label for="attendee_dashboard_agenda_edit-no">
								<input value="0" type="radio" name="event.attendee_dashboard_agenda_edit"
								id="attendee_dashboard_agenda_edit-no" #rc.checked[ rc.event.details.settings.attendee_dashboard_agenda_edit eq 0 ]#> No
							</label>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6 col-lg-4">
					<label for="" class="required">Allow attendee to edit their registration fields once confirmed?</label>
					<div class="cf">
						<div class="radio pull-left">
							<label for="attendee_dashboard_reg_edit-yes">
								<input value="1" type="radio" name="event.attendee_dashboard_reg_edit" id="attendee_dashboard_reg_edit-yes" #rc.checked[ rc.event.details.settings.attendee_dashboard_reg_edit eq 1 ]#> Yes
							</label>
						</div>
						<div class="radio pull-left">
							<label for="attendee_dashboard_reg_edit-no">
								<input value="0" type="radio" name="event.attendee_dashboard_reg_edit" id="attendee_dashboard_reg_edit-no" #rc.checked[ rc.event.details.settings.attendee_dashboard_reg_edit eq 0 ]#> No
							</label>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6 col-lg-4">
					<label for="" class="required">Make attendees verify their email address?</label>
					<div class="cf">
						<div class="radio pull-left">
							<label for="register_verify_email-yes">
								<input value="1" type="radio" name="event.register_verify_email" id="register_verify_email-yes" #rc.checked[ rc.event.details.settings.register_verify_email eq 1 ]#> Yes
							</label>
						</div>
						<div class="radio pull-left">
							<label for="register_verify_email-no">
								<input value="0" type="radio" name="event.register_verify_email" id="register_verify_email-no" #rc.checked[ rc.event.details.settings.register_verify_email eq 0 ]#> No
							</label>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6 col-lg-4">
					<label for="" class="required">Make attendees verify their password?</label>
					<div class="cf">
						<div class="radio pull-left">
							<label for="register_verify_password-yes">
								<input value="1" type="radio" name="event.register_verify_password" id="register_verify_password-yes" #rc.checked[ rc.event.details.settings.register_verify_password eq 1 ]#> Yes
							</label>
						</div>
						<div class="radio pull-left">
							<label for="register_verify_password-no">
								<input value="0" type="radio" name="event.register_verify_password" id="register_verify_password-no" #rc.checked[ rc.event.details.settings.register_verify_password eq 0 ]#> No
							</label>
						</div>
					</div>
				</div>

				<div class="form-group col-md-6 col-lg-4">
					<label for="" class="required">Allow attendee to view their details in dashboard?</label>
					<div class="cf">
						<div class="radio pull-left">
							<label for="register_verify_password-yes">
								<input value="1" type="radio" name="event.attendee_dashboard_show_detail" id="attendee_dashboard_show_detail-yes" #rc.checked[ rc.event.details.settings.attendee_dashboard_show_detail eq 1 ]#> Yes
							</label>
						</div>
						<div class="radio pull-left">
							<label for="register_verify_password-no">
								<input value="0" type="radio" name="event.attendee_dashboard_show_detail" id="attendee_dashboard_show_detail-no" #rc.checked[ rc.event.details.settings.attendee_dashboard_show_detail eq 0 ]#> No
							</label>
						</div>
					</div>
				</div>

				<div class="form-group col-md-6 col-lg-4">
					<label for="" class="required">Show Review Information on confirmation?</label>
					<div class="cf">
						<div class="radio pull-left">
							<label for="register_confirmation_show_review-yes">
								<input value="1" type="radio" name="event.register_confirmation_show_review" id="register_confirmation_show_review-yes" #rc.checked[ rc.event.details.settings.register_confirmation_show_review eq 1 ]#> Yes
							</label>
						</div>
						<div class="radio pull-left">
							<label for="register_confirmation_show_review-no">
								<input value="0" type="radio" name="event.register_confirmation_show_review" id="register_confirmation_show_review-no" #rc.checked[ rc.event.details.settings.register_confirmation_show_review eq 0 ]#> No
							</label>
						</div>
					</div>
				</div>

				<div class="form-group col-md-6 col-lg-4">
					<label for="" class="required">Hide Password from the Begin Registration page? <em>(If set to yes the system will randomly generate a password for the attendee. )</em></label>
					<div class="cf">
						<div class="radio pull-left">
							<label for="register_begin_hide_password-yes">
								<input value="1" type="radio" name="event.register_begin_hide_password" id="register_begin_hide_password-yes" #rc.checked[ rc.event.details.settings.register_begin_hide_password eq 1 ]#> Yes
							</label>
						</div>
						<div class="radio pull-left">
							<label for="register_begin_hide_password-no">
								<input value="0" type="radio" name="event.register_begin_hide_password" id="register_begin_hide_password-no" #rc.checked[ rc.event.details.settings.register_begin_hide_password eq 0 ]#> No
							</label>
						</div>
					</div>
				</div>

                <div class="form-group col-md-6 col-lg-4">
					<label for="" class="required">Allow Password to be sent in confirmation email? <em>(If set to yes the system will allow an admin to use the email variable @@password@@ to send an attendee their password in their confirmation email. )</em></label>
					<div class="cf">
						<div class="radio pull-left">
							<label for="register_confirmation_email_show_password-yes">
								<input value="1" type="radio" name="event.register_confirmation_email_show_password" id="register_confirmation_email_show_password-yes" #rc.checked[ rc.event.details.settings.register_confirmation_email_show_password eq 1 ]#> Yes
							</label>
						</div>
						<div class="radio pull-left">
							<label for="register_confirmation_email_show_password-no">
								<input value="0" type="radio" name="event.register_confirmation_email_show_password" id="register_confirmation_email_show_password-no" #rc.checked[ rc.event.details.settings.register_confirmation_email_show_password eq 0 ]#> No
							</label>
						</div>
					</div>
				</div>

                <div class="form-group col-md-6 col-lg-4">
					<label for="" class="required">Send Decline Response Email</label>
					<div class="cf">
						<div class="radio pull-left">
							<label for="invite_send_decline_email-yes">
								<input value="1" type="radio" name="event.invite_send_decline_email" id="invite_send_decline_email-yes" #rc.checked[ rc.event.details.settings.invite_send_decline_email eq 1 ]#> Yes
							</label>
						</div>
						<div class="radio pull-left">
							<label for="invite_send_decline_email-no">
								<input value="0" type="radio" name="event.invite_send_decline_email" id="invite_send_decline_email-no" #rc.checked[ rc.event.details.settings.invite_send_decline_email eq 0 ]#> No
							</label>
						</div>
					</div>
				</div>
                <div class="form-group col-md-6 col-lg-4">
					<label for="" class="required">Collect Decline Reason</label>
					<div class="cf">
						<div class="radio pull-left">
							<label for="invite_send_decline_email-yes">
								<input value="1" type="radio" name="event.invite_collect_decline_reason" id="invite_collect_decline_reason-yes" #rc.checked[ rc.event.details.settings.invite_collect_decline_reason eq 1 ]#> Yes
							</label>
						</div>
						<div class="radio pull-left">
							<label for="invite_send_decline_email-no">
								<input value="0" type="radio" name="event.invite_collect_decline_reason" id="invite_collect_decline_reason-no" #rc.checked[ rc.event.details.settings.invite_collect_decline_reason eq 0 ]#> No
							</label>
						</div>
					</div>
				</div>

			</div>
		</div>

		<div class="well dash-well">
			<h4>Billing and Payment Settings</h4>

			<div class="row">

				<div class="form-group col-md-6 col-lg-4">
			    	<label for="">Available Payment Types</label>
		        	<cfloop from="1" to="#rc.event.payment_types.count#" index="local.pay_type_cnt">
			    	<cfset local.pay_type = rc.event.payment_types.data[ pay_type_cnt ]/>
			    	<cfif local.pay_type.payment_type NEQ "comp" >
				        <div class="checkbox">
						  <label>
						    <input type="checkbox" name="event.payment_types" value="#local.pay_type.payment_type#" #rc.checked[ local.pay_type.in_use eq true ]#>
						    #local.pay_type.description#
						  </label>
						</div>
			    	</cfif>
		        	</cfloop>
		        </div>

		        <cfif rc.has_processors>
					<div class="form-group col-md-6 col-lg-4">
						<label for="processor_id" class="required">Event Processor</label>
						<select name="event.processor_id" id="processor_id" class="form-control">
							#rc.processor_list#
						</select>
					</div>
				</cfif>
			</div>
		</div>


		<div class="well dash-well">
			<a href="##" class="toggle-collapse-btn btn btn-default btn-sm">Toggle Section Visibility</a>
			<h4>Billing Labels <span>(Optional - Used to Overwrite Default Text)</span></h4>
			<div class="row">
				<div class="toggle-wrap">
			        <div class="form-group col-md-6 col-lg-4">
						<label for="billing_review_label">Billing Review Label</label>
						<input class="form-control" name="event.billing_review_label" id="billing_review_label" value="#rc.event.details.settings.billing_review_label#" />
					</div>
					<div class="form-group col-md-6 col-lg-4">
						<label for="billing_review_billing_label">Billing Label</label>
						<input class="form-control" name="event.billing_review_billing_label" id="billing_review_billing_label" value="#rc.event.details.settings.billing_review_billing_label#" />
					</div>
					<div class="form-group col-md-6 col-lg-4">
						<label for="billing_billing_information_label">Billing Information Label</label>
						<input class="form-control" name="event.billing_billing_information_label" id="billing_billing_information_label" value="#rc.event.details.settings.billing_billing_information_label#" />
					</div>
					<div class="form-group col-md-6 col-lg-4">
						<label for="billing_information_overview_label">Information Overview Label</label>
						<input class="form-control" name="event.billing_information_overview_label" id="billing_information_overview_label" value="#rc.event.details.settings.billing_information_overview_label#" />
					</div>
					<div class="form-group col-md-6 col-lg-4">
						<label for="billing_information_overview_sub_text">Information Overview Sub-Text</label>
						<input class="form-control" name="event.billing_information_overview_sub_text" id="billing_information_overview_sub_text" value="#rc.event.details.settings.billing_information_overview_sub_text#" />
					</div>
					<div class="form-group col-md-6 col-lg-4">
						<label for="billing_registration_review_label">Registration Review Label</label>
						<input class="form-control" name="event.billing_registration_review_label" id="billing_registration_review_label" value="#rc.event.details.settings.billing_registration_review_label#" />
					</div>
					<div class="form-group col-md-6 col-lg-4">
						<label for="billing_registration_sub_total_label">Registration Subtotal Label</label>
						<input class="form-control" name="event.billing_registration_sub_total_label" id="billing_registration_sub_total_label" value="#rc.event.details.settings.billing_registration_sub_total_label#" />
					</div>
					<div class="form-group col-md-6 col-lg-4">
						<label for="billing_registration_total_label">Registration Total Label</label>
						<input class="form-control" name="event.billing_registration_total_label" id="billing_registration_total_label" value="#rc.event.details.settings.billing_registration_total_label#" />
					</div>
					<div class="form-group col-md-6 col-lg-4">
						<label for="billing_payment_type_label">Payment Type Field Label</label>
						<input class="form-control" name="event.billing_payment_type_label" id="billing_payment_type_label" value="#rc.event.details.settings.billing_payment_type_label#" />
					</div>
			    	<div class="form-group col-md-6 col-lg-4">
						<label for="billing_agree_text">Check Field Label</label>
						<input type="text" class="form-control" name="event.pay_type_labels.pay_type_check_label" value="#rc.event.details.settings.pay_type_check_label#" >
					</div>
					<div class="form-group col-md-6 col-lg-4">
						<label for="billing_agree_text" class="required">Credit Card Field Label</label>
						<input type="text" class="form-control" name="event.pay_type_labels.pay_type_credit_card_label" value="#rc.event.details.settings.pay_type_credit_card_label#" >
					</div>
					<div class="form-group col-md-6 col-lg-4">
						<label for="billing_agree_text" class="required">Invoice Field Label</label>
						<input type="text" class="form-control" name="event.pay_type_labels.pay_type_invoice_label" value="#rc.event.details.settings.pay_type_invoice_label#" >
					</div>
					<div class="form-group col-md-6 col-lg-4">
						<label for="billing_agree_text" class="required">On-Site Field Label</label>
						<input type="text" class="form-control" name="event.pay_type_labels.pay_type_on_site_label" value="#rc.event.details.settings.pay_type_on_site_label#" >
					</div>
					<div class="form-group col-md-6 col-lg-4">
						<label for="billing_agree_text" class="required">PO Field Label</label>
						<input type="text" class="form-control" name="event.pay_type_labels.pay_type_po_label" value="#rc.event.details.settings.pay_type_po_label#" >
					</div>
					<div class="form-group col-md-6 col-lg-4">
						<label for="billing_promo_code_text" class="required">Promo Code Field Label</label>
						<input type="text" class="form-control" maxlength="250" id="billing_promo_code_text" name="event.billing_promo_code_text" value="#rc.event.details.settings.billing_promo_code_text#">
					</div>
					<div class="form-group col-md-6 col-lg-4">
						<label for="billing_agree_text" class="required">Billing Agreement Text (Next to agreement checkbox)</label>
						<input type="text" class="form-control" maxlength="250" id="billing_agree_text" name="event.billing_agree_text" value="#rc.event.details.settings.billing_agree_text#">
					</div>
				</div>


	    	</div>
		</div>

		<div class="well dash-well">
			<a href="##" class="toggle-collapse-btn btn btn-default btn-sm">Toggle Section Visibility</a>
			<h4>Miscellaneous Custom Labels <span>(Optional - Used to Overwrite Default Text)</span></h4>
			<div class="row">
				<div class="toggle-wrap misc-inputs">
					<cfloop index="current_field" array="#rc.settings_fields.data#">
						<cfif listfindnocase( "input,textarea", current_field.type ) >
						<div class="form-group col-md-6">
							<label for="#current_field.fieldname#">#current_field.label#</label>
							<cfif current_field.type is "input">
								<input class="form-control" name="event.#current_field.fieldname#" id="#current_field.fieldname#" value="#rc.event.details.settings[current_field.fieldname]#" />
							<cfelseif current_field.type is "textarea">
								<textarea class="form-control" name="event.#current_field.fieldname#" id="#current_field.fieldname#">#rc.event.details.settings[current_field.fieldname]#</textarea>
							</cfif>
						</div>
						</cfif>
					</cfloop>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-12">
				<button type="submit" class="btn btn-success btn-lg btn-block"><strong>Save Global Settings</strong></button>
			</div>
		</div>
	</form>
</div>
</cfoutput>
