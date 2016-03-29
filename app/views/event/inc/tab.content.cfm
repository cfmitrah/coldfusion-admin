<cfoutput>
<div class="tab-pane" id="event-content">
	<form action="#buildURL('event.doSaveLandingPageContent')#" role="form" method="post" enctype="multipart/form-data" data-parsley-validate>
		<input type="hidden" name="event.event_id" value="#rc.event_id#" />	
		<h3 class="form-section-title">Landing Page Content</h3>
		<div class="row">
			<div class="form-group col-md-12">
				<label for="hero_text" class="required">Lead Copy - <small>Used to welcome the user. Typically the events name. (i.e 'Get ready for the 2014 Amazing Expo!')</small></label>
				<input id="hero_text" name="landing_page_content.hero_text" type="text" class="form-control" value="#rc.event.hero.hero_text#" required>
			</div>
			<div class="form-group col-md-6">
				<label for="location">Location Copy - <small>How the location will display to users.</small></label>
				<input id="location" name="landing_page_content.location" type="text" class="form-control" value="#rc.event.hero.location#">
			</div>
			<div class="form-group col-md-6">
				<label for="dates">Dates and Times Copy - <small>How the date and time will display to users.</small></label>
				<input id="dates" name="landing_page_content.dates" type="text" class="form-control" value="#rc.event.hero.dates#">
			</div>
		</div>
		
		<hr>
		<div class="row">
			<div class="form-group col-md-12">
				<label for="event_overview">Introduction Copy</label>
				<p class="note">Below you can insert text, photos, tables, lists and more. <em>Should be the most need to know information about the event.</em></p>
				<textarea id="event_overview" name="landing_page_content.overview" rows="20" class="form-control">#rc.event.hero.overview#</textarea>
			</div>
		</div>
		<hr>
		<div class="row">
			<div class="form-group col-md-12">
				<label for="overview">Begin Registration Section Help</label>
				<p class="note">Enter messaging that will appear at the beginning of the registration.</p>
				<textarea id="begin_registration_message" name="landing_page_content.begin_registration_message" rows="10" class="form-control">#rc.event.hero.begin_registration_message#</textarea>
			</div>
		</div>
		<hr>
		<div class="row">
			<div class="form-group col-md-12">
				<label for="overview">Registration Closed Messaging</label>
				<p class="note">Enter messaging that will appear once the registration is over</p>
				<textarea id="registration_closed_message" name="landing_page_content.registration_closed_message" rows="10" class="form-control">#rc.event.hero.registration_closed_message#</textarea>
			</div>
		</div>
		<div class="row">
			<div class="form-group col-md-12">
				<label for="overview">Event Confirmation Page Text</label>
				<p class="note"></p>
				<textarea id="event_conf_page_text" name="landing_page_content.confirmation_page_text" rows="10" class="form-control">#rc.event.hero.confirmation_page_text#</textarea>
			</div>
		</div>
		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg"><strong>Save Landing Page Content</strong></button>
		</div>
	</form>	
</div>
</cfoutput>
