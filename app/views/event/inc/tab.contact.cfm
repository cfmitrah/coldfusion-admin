<cfoutput>
<div class="tab-pane" id="event-contact">
	<form action="#buildURL( "event.doSaveEventContactContent" )#" role="form" method="post" enctype="multipart/form-data" data-parsley-validate>
		<input type="hidden" name="event.event_id" value="#rc.event_id#" />	
		<h3 class="form-section-title">Registration Contact Information</h3>
		
		<div class="row">
			<div class="form-group col-md-12">
				<label for="event_contact_email">
					If you wish to have a contact page available to registrants, provide an email address below. If an email address is provided a contact page will be automatically generated.
				</label>
				<input id="event_contact_email" name="event_contact_content.event_contact_email" type="email" class="form-control" value="#rc.event.hero.event_contact_email#" />
			</div>
			<div class="form-group col-md-12">
				<label for="contact_page_overview">Additional information to display on contact page:</label>
				<textarea id="contact_page_overview" name="event_contact_content.contact_page_overview" rows="20" class="form-control">#rc.event.hero.contact_page_overview#</textarea>
			</div>
		</div>
		
		
		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg"><strong>Save Contact Information</strong></button>
		</div>
	</form>	
</div>
</cfoutput>