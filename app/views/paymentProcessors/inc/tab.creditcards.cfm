<cfoutput>
<div class="tab-pane" id="paymentprocessor-creditcards">
	<h3 class="form-section-title">Credit Cards</h3>
	<p class="attention">Credit cards processed by this payment processor will appear in the table below. You can add or remove a credit card.</p>
	<hr>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Credit Card</th>
				<th>Options</th>
			</tr>
		</thead>
		<tbody>
			<cfloop from="1" to="#rc.payment_processor.card_count#" index="local.idx">
				<cfset local.card = rc.payment_processor.cards[ local.idx ] />
				<tr data-processor_id="#rc.processor_id#" data-credit_card_id = #local.card.credit_card_id#>
					<td>#local.card.vendor#</td>
					<td><a href="" class="text-danger remove-creditcard"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Remove</strong></a> </td>
				</tr>
			</cfloop>
		</tbody>
	</table>
	<hr>
	<h4>Add a Credit Card</h4>
	<form action="#buildURL( 'paymentprocessors.doSaveCard' )#" role="form" method="post">
		<input type="hidden" name="payment_processor.processor_id" value="#rc.processor_id#" />
		<div class="form-group">
			<label for="processor" class="required">Select a credit card to add</label>
			<select name="payment_processor.credit_card_id" id="creditcard" class="form-control width-md">
				#rc.creditcard_options#
			</select>
		</div>
		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg"><strong>Add Credit Card</strong></button>
		</div>
	</form>
</div>
</cfoutput>