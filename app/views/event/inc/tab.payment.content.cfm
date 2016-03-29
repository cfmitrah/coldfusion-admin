<cfoutput>
<div class="tab-pane" id="event-payment-content">
	<form action="#buildURL('event.doSaveBillingPageContent')#" role="form" method="post" enctype="multipart/form-data" data-parsley-validate>
		<input type="hidden" name="event.event_id" value="#rc.event_id#" />	
		<h3 class="form-section-title">Billing Page Content</h3>

		<div class="row">
			<div class="form-group col-md-12">
				<label for="mop_check_text">Check Payment Text</label>
				<p class="note"></em></p>
				<textarea id="mop_check_text" name="billing_page_content.mop_check_text" rows="20" class="form-control billing_text">#rc.event.hero['mop_check_text']#</textarea>
			</div>
		</div>
		
		<div class="row">
			<div class="form-group col-md-12">
				<label for="mop_po_text">PO Payment Text</label>
				<p class="note"></em></p>
				<textarea id="mop_po_text" name="billing_page_content.mop_po_text" rows="20" class="form-control billing_text">#rc.event.hero['mop_po_text']#</textarea>
			</div>
		</div>
		
		<div class="row">
			<div class="form-group col-md-12">
				<label for="mop_check_text">On Site Payment Text</label>
				<p class="note"></em></p>
				<textarea id="mop_on_site_text" name="billing_page_content.mop_on_site_text" rows="20" class="form-control billing_text">#rc.event.hero['mop_on_site_text']#</textarea>
			</div>
		</div>
		
		<div class="row">
			<div class="form-group col-md-12">
				<label for="mop_invoice_text">Invoice Payment Text</label>
				<p class="note"></em></p>
				<textarea id="mop_invoice_text" name="billing_page_content.mop_invoice_text" rows="20" class="form-control billing_text">#rc.event.hero['mop_invoice_text']#</textarea>
			</div>
		</div>

		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg"><strong>Save Page Content</strong></button>
		</div>
	</form>	
</div>
</cfoutput>
