<cfoutput>
<form action="#buildURL('sessions.doSave')#" method="post">
	<input type="hidden" name="event_session.session_id" value="#rc.session_details.details.session_id#" />
	<h3 class="form-section-title">Main Details</h3>
	<div class="form-group">
		<label for="session_title" class="required">Session Name / Title</label>
		<input type="text" class="form-control" id="session_title" name="event_session.title" value="#rc.session_details.details.title#">
	</div>
	<div class="form-group">
		<label for="category">Category</label>
		<input type="text" class="form-control" id="category" name="event_session.category" value="#rc.session_details.details.category#">
	</div>
	<div class="form-group">
		<label for="session_description">Description <small>- 1 Sentence - S.E.O Purposes</small></label>
		<input type="text" class="form-control" id="session_description" name="event_session.description" value="#rc.session_details.details.description#">
	</div>
	<div class="form-group">
		<label for="session_summary">Summary <small>- 1 or 2 Sentences - S.E.O Purposes</small></label>
		<input type="text" class="form-control" id="session_summary" name="event_session.summary" value="#rc.session_details.details.summary#">
	</div>
	<div class="form-group">
		<label for="session_overview">Overview <small>- Detailed - Viewable by End User</small></label>
		<textarea  id="session_overview" name="event_session.overview" rows="20">#rc.session_details.details.overview#</textarea>
	</div>

	<!--- Not sure how this works
		<div class="form-group">
			<label for="" class="required">Hide on Agenda?</label>
			<div class="cf">
				<div class="radio pull-left">
					<label for="visible-yes">
						<input type="radio" name="radio-visible"> Yes
					</label>
				</div>
				<div class="radio pull-left">
					<label for="visible-no">
						<input type="radio" name="radio-visible" id="visible-no" checked=""> No
					</label>
				</div>
			</div>
		</div> --->

	<div class="cf">
		<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Save Main Details</strong></button>
	</div>
</form>
</cfoutput>