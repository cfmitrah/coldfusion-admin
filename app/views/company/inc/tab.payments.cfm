<cfoutput>

<div class="tab-pane" id="company-payments">
	<h3 class="form-section-title">Payments</h3>
	<p class="attention">Payment Processors associated with this company will appear in the table below. You can choose from our existing payment processors, or create a new processor using the 'create new processor' button below.  You will also see a list of credit cards you can choose NOT to accept.  You can remove a card from the list, or choose a card to add to the list.</p>
	<hr>
	<h4>Payment Processors</h4>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Payment Processor</th>
				<th>Options</th>
			</tr>
		</thead>
		<tbody>
			<cfloop from="1" to="#rc.company_details.payments.processorscount#" index="i">
				<tr data-event_id="#rc.company_details.company_id#" data-processor_id="#rc.company_details.payments.processors.company_processor_id[i]#">
					<td>#rc.company_details.payments.processors.processor_name[i]#</td>
					<td><a href="" class="text-danger remove-processor"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Remove</strong> </a></td>
				</tr>
			</cfloop>
		</tbody>
	</table>
	<hr>
	<h4>Adding a New Processor</h4>
	<div class="cf">
			<a href="#buildURL( 'paymentprocessors/create' )#" class="btn btn-info btn-lg"><strong>Go Create a New Payment Processor in Configuration</strong></a>
		</div>
	<hr>
	<h4>Excluded Credit Cards</h4>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Credit Card</th>
				<th>Options</th>
			</tr>
		</thead>
		<tbody>
			<cfloop from="1" to="#rc.company_details.payments.creditcardsexcludedcount#" index="i">
				<cfset creditcardindex = ArrayFind(rc.company_details.creditcard_list.credit_card_id, rc.company_details.payments.creditcardsexcluded.credit_card_id[i])>
				<tr data-company_id="#rc.company_details.company_id#" data-credit_card_id="#rc.company_details.payments.creditcardsexcluded.credit_card_id[i]#">
					<td>#rc.company_details.creditcard_list.vendor[creditcardindex]#</td>
					<td><a href="" class="text-danger remove-excludedcreditcard"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Remove</strong> </a></td>
				</tr>
			</cfloop>
		</tbody>
	</table>
	<hr>
	<h4>Adding an Excluded Card</h4>
	<form action="#buildURL( 'company.doSaveExcludedCard' )#" role="form" method="post">
		<input type="hidden" name="company.company_id" value="#rc.company_details.company_id#" />
		<div class="form-group">
			<label for="processor" class="required">Select a credit card to exclude</label>
			<select name="payment.credit_card_id" id="creditcard" class="form-control width-md">
				#rc.company_details.creditcard_options#
			</select>
		</div>
		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg"><strong>Exlcude Selected Credit Card</strong></button>
		</div>
	</form>
</div>
</cfoutput>