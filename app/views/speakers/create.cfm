<cfoutput>
<h2 class="page-title color-02">Create a Speaker</h2>
<p class="page-subtitle">To begin, fill in the basic information below about the speaker.</p>
<form id="speaker" action="#buildURL('speakers.doCreate')#" method="post" role="form" class="basic-wrap">
	<div class="form-group">
		<label for="first_name">First Name</label>
		<input type="text"id="first_name" name="speaker.first_name" class="form-control" maxlength="100" />
	</div>
	<div class="form-group">
		<label for="last_name">Last Name</label>
		<input type="text" id="last_name" name="speaker.last_name" class="form-control" maxlength="100" />
	</div>
	<div class="form-group">
		<label for="display_name">Display Name <small> How you want the name to display to attendees. (ex. Smith, John)</small></label>
		<input type="text" id="display_name" name="speaker.display_name" class="form-control" maxlength="200" />
	</div>
	<div class="cf">
		<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Create Speaker</strong></button>
	</div>
</form>
</cfoutput>