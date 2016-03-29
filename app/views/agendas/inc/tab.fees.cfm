<cfoutput>
	<div class="tab-pane" id="agenda-item-fees">
		<h3 class="form-section-title">Existing Fees for Session</h3>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>Fee Name</th>
					<th>Fee Amount</th>
					<th>Attendees to Receive</th>
					<th>Start Date</th>
					<th>End Date</th>
					<th><!---//actions//---></th>
				</tr>
			</thead>
			<tbody>
				<cfloop from="1" to="#rc.agenda.pricing_cnt#" index="i">				
					<tr data-agenda_id="#rc.agenda.agenda_id#" data-agenda_price_id="#rc.agenda.pricing[i].agenda_price_id#">
						<td>#rc.agenda.pricing[i].label#</td>
						<td>#dollarFormat( rc.agenda.pricing[i].price )#</td>
						<td>
							<span class="label label-success">#rc.agenda.pricing[i].registration_type#</span>
						</td>
						<td>#dateFormat( rc.agenda.pricing[i].valid_from, 'mm/dd/yyy' )#</td>
						<td>#dateFormat( rc.agenda.pricing[i].valid_to, 'mm/dd/yyyy' )#</td>
						<td><a href="##" class="remove btn btn-danger btn-sm remove-fee">Remove</a></td>
					</tr>
				</cfloop>
			</tbody>
		</table>
		<hr>
		<h3 class="form-section-title">Add New Fee</h3>
		<p class="attention">Use the form below to assign a new fee to this session. Existing fees can be viewed in the table below.</p>
		<form action="#buildURL('agendas.doCreateFee')#" method="post" role="form">
			<input type="hidden" name="agenda.agenda_id" value="#rc.agenda.agenda_id#" />
			<div class="form-group">
				<label for="fee_name" class="required">Fee Name</label>
				<input name="agenda.label" id="label" type="text" class="form-control width-md" required>
			</div>
			<div class="form-group">
				<label for="price" class="required">Enter Fee Amount</label>
				<input name="agenda.price" id="price"  type="number" class="form-control width-sm" placeholder="ex: 500.00" required>
			</div>
			<div class="form-group">
				<label for="registration_type" class="required">Select which attendee types should receive this fee</label>
				<select multiple name="agenda.registration_type_ids" id="registration_type" class="form-control width-md" required>
					#rc.registration_opts#
				</select>
			</div>
			<div class="form-group">
				<label for="" class="required">Should this fee be tied to a certain date range only? (Used for early bird pricing, late registrations, etc)</label>
				<div class="cf">
					<div class="radio pull-left">
						<label for="fee-date-yes">
							<input data-hidden_div="fee-date-yes-box" type="radio" name="agenda.has_date_range" id="fee-date-yes" class="formShowHide_ctrl date-range" data-show-id="fee-date-yes-box" value="1"> Yes
						</label>
					</div>
					<div class="radio pull-left">
						<label for="fee-date-no">
							<input data-hidden_div="fee-date-yes-box" type="radio" name="agenda.has_date_range" id="fee-date-no" class="date-range" checked="" value="0"> No
						</label>
					</div>
				</div>
			</div>
			<div id="fee-date-yes-box" class="hiddenbox" style="display: none;">
				<div class="form-group">
					<label for="valid_from">Fee Start Date</label>
					<input name="agenda.valid_from" id="valid_from"  type="text" class="form-control  std-datetime width-sm  dateonly-datetime">
				</div>
				<div class="form-group">
					<label for="">Fee End Date</label>
					<input name="agenda.valid_to" id="valid_to"  type="text" class="form-control  std-datetime width-sm  dateonly-datetime">
				</div>
			</div>
			<div class="cf">
				<button type="submit" class="btn btn-success btn-lg pull-right">Add Fee</button>
			</div>
		</form>
	</div>
</cfoutput>