<cfoutput>
<form action="#buildURL( 'emailManagement.doScheduleCommunicationEmail' )#"  enctype="multipart/form-data" method="post" class="validate-frm" data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden">
	<input type="hidden" name="email.email_type" id="communication_email_type" value="" />
	<input type="hidden" name="email.email_id" id="communication_email_id" value="" />
	<input type="hidden" name="email.event_id" id="event_id" value="#rc.event_id#" />
	<div id="communications-live-settings" class="row email-options" style="display: none;">
		<div class="col-md-12">
			<h3 class="form-section-title">Set Schedule</h3>
		</div>
		<div class="col-md-6 col-md-offset-3">
			<div class="form-group">
				<label for="send_time">Date and Time to Send</label>
				<input name="email.send_time" id="send_time" type="text" class="std-datetime form-control datetime" value="#dateformat( now(), 'MM/DD/YYYY' )# #timeFormat( now(), 'HH:MM tt' )#" required>
			</div>
		</div>

		<div class="col-md-12">
			<h3 class="form-section-title">Recipient Information</h3>
		</div>
		<!--// CHOOSE WHO TO SEND TOO //-->
		<div class="col-md-6 col-md-offset-3">
			<div class="form-group">
				<label class="required">Who would you like to send this to?</label>
				<div class="radio">
				    <label>
				    	<input type="radio" name="email.recipient_settings" id="all-attendees" value="all_attendees" required> Select all attendees
				    </label>
				</div>
				<div class="radio">
				    <label>
				    	<input type="radio" name="email.recipient_settings" required value="registration_type_id" id="registration_types" class="formShowHide_ctrl" data-show-id="choose-attendee-types"> Choose specific attendee types to receive this email
				    </label>
				</div>
				<div class="radio">
				    <label>
				    	<input type="radio" name="email.recipient_settings" required value="attendee_id" id="individuals" class="formShowHide_ctrl" data-show-id="choose-attendees"> Select individual attendees
				    </label>
				</div>
			</div>
			<!--// CHOOSE REGISTRATION TYPES //-->
			<div id="choose-attendee-types" class="send-option" style="display:hidden">
				<div class="form-group">
					<label for="">Check which attendee types will receive this email</label><br>
					<cfloop from="1" to="#arrayLen( rc.registration_types )#" index="local.i">
					    <div class="checkbox">
						    <label>
						    	<input type="checkbox" name="email.value_list" checked="checked" value="#rc.registration_types[ local.i ].registration_type_id#"> #rc.registration_types[ local.i ].registration_type#
						    </label>
					    </div>
					</cfloop>
				</div>
			</div>
		</div>	
		<div id="individuals-listing" class="col-md-12 send-option" style="display:none">
			<div id="choose-attendees" class="hiddenbox">
				<table id="#rc.attendee_listing.table_id#" class="table table-striped table-hover data-table tm-large" >
					<thead>
					<tr>
						<cfset local.aCols = listToArray( rc.attendee_listing.columns ) />
						<cfloop array="#local.aCols#" index="local.col_name">
							<th class="">#local.col_name#</th>
						</cfloop>
					</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>		
		<!--- End If LIve and Communication show this --->
		<div class="form-group col-md-6 col-md-offset-3">
			<div class="alert alert-danger">This email will send to the attendees listed above on the date provided. Be sure to send a test version to yourself to approve of the content before you sent to specified attendees.</div>
			<button type="submit" class="btn btn-success btn-lg"><strong>Save Send Settings</strong></button>
		</div>

	</div>	
</form>	
</cfoutput>