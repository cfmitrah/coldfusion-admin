<cfoutput>
<form id="refund_form" data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden">
	<input type="hidden" name="refund_info.attendee_id" value="#rc.attendee.attendee_id#" >
	<input type="hidden" name="refund_info.registration_id" value="#rc.attendee.registration_id#" >
	<input type="hidden" name="refund_info.tx_last_4" id="refund_info_tx_last_4" value="" >
	<input type="hidden" name="refund_info.tx_x_date" id="refund_info_tx_x_date" value="" >
	<input type="hidden" name="refund_info.action" id="refund_info_action" value="refund" >
	<input type="hidden" name="refund_info.item_id" id="refund_info_item_id" value="0" >
	<input type="hidden" name="refund_info.payment_type" id="refund_payment_type" value="" >
	<div class="div-hide" id="refund_notification"></div>
	<div class="row">
		<div class="col-md-12">
			<div class="form-group">
				<label for="" class="required">Payments:</label>
				<select name="refund_info.processor_tx_id" 
					id="refund_info_processor_tx_id" 
					class="form-control" >
				</select>
			</div>
		</div>
		<div class="col-md-6">
			<div class="form-group">
				<label for="" class="required">Amount:</label>
				<input type="number" name="refund_info.amount" class="form-control" required min="1" id="refund_info_amount" />
			</div>
		</div>
		<div class="col-md-6">
			<div class="form-group">
				<label class="required">Notes:</label>
				<textarea class="form-control" rows="3" name="refund_info.notes" id="refund_info_notes" required></textarea>
				<p class="help-block">Notes help...</p>
			</div>
		</div>
	</div>
</form>
</cfoutput>