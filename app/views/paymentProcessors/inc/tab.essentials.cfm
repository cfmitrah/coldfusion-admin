<cfoutput>
<div class="tab-pane active" id="paymentprocessor-essentials">
	<form action="#buildURL('paymentProcessors.doSave')#" role="form" method="post">
		<input type="hidden" name="payment_processor.processor_id" value="#rc.processor_id#" />
		<h3 class="form-section-title">Essentials</h3>
		<div class="form-group">
			<label for="name" class="required">Processor Name</label>
			<input type="text" class="form-control" id="name" name="payment_processor.processor_name" value="#rc.payment_processor.processor_name#">
		</div>
		<div class="form-group">
			<label for="api-url">API URL</label>
			<input type="text" class="form-control" id="api_url" name="payment_processor.api_url" value="#rc.payment_processor.api_url#">
		</div>
		<div class="form-group">
			<label for="documentation-url">Documentation URL</label>
			<input type="text" class="form-control" id="docs_url" name="payment_processor.docs_url" value="#rc.payment_processor.docs_url#">
		</div>
		<div class="form-group">
			<label for="api-url" class="required">Active</label>
			<select name="payment_processor.active" class="form-control" id="active">
				<option value="1" #rc.selected[2]#>True</option>
				<option value="0" #rc.selected[1]#>False</option>
			</select>
		</div>
		<div class="cf">
			 <button type="submit" class="btn btn-success btn-lg pull-right"><strong>Save The Essentials</strong></button>
		</div>
	</form>

	</div></cfoutput>