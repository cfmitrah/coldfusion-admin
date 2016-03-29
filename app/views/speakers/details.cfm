<cfoutput>
<div id="speaker" data-speaker_id="#rc.speaker.speaker_id#">
	<h2 class="page-title color-02">#rc.speaker.first_name# #rc.speaker.last_name#</h2>
	<br />
	<h3 class="form-section-title">Existing Session Assignments</h3>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Session Name</th>
				<th>Options</th>
			</tr>
		</thead>
		<tbody>
			<cfloop from="1" to="#rc.speaker.session_cnt#" index="i">
				<tr data-session_id="#rc.speaker.sessions[i].session_id#">
					<td>#rc.speaker.sessions[i].title#</td>
					<td><a href="##" class="remove text-danger"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Remove</strong> </a></td>
				</tr>
			</cfloop>
		</tbody>
	</table>
	<a href="##" data-toggle="modal" data-target="##speaker-assign" class="btn btn-primary">Create New Session Assignment</a>
	<br><hr>
	<h3 class='form-section-title'>Speaker Details</h3>
	<hr>
	<form name="speaker" action="#buildURL('speakers.doSave')#" method="post" enctype="multipart/form-data" class="basic-wrap">
		<input type="hidden" name="speaker.speaker_id" value="#rc.speaker.speaker_id#" />
		<div class="row">
			<div class="col-md-6">
				<div class="form-group">
					<label for="first_name">First Name</label>
					<input type="text" class="form-control" id="first_name" name="speaker.first_name" value="#rc.speaker.first_name#" maxlength="100" />
				</div>
				<div class="form-group">
					<label for="last_name">Last Name</label>
					<input type="text" class="form-control" id="last_name" name="speaker.last_name" value="#rc.speaker.last_name#" maxlength="100" />
				</div>
				<div class="form-group">
					<label for="display_name">Display Name <small> How you want the name to display to attendees. (ex. Smith, John)</small></label>
					<input type="text" class="form-control" id="display_name" name="speaker.display_name" value="#rc.speaker.display_name#" maxlength="200" />
				</div>
			</div>
			<div class="col-md-6">
				<div class="form-group">
					<label for="title">Title</label>
					<input type="text" class="form-control" id="title" name="speaker.title" value="#rc.speaker.title#" maxlength="150" />
				</div>
				<div class="form-group">
					<label for="">company</label>
					<input type="text" class="form-control" id="company" name="speaker.company" value="#rc.speaker.company#" maxlength="150" />
				</div>
				<div class="form-group">
					<label for="email">Email Address</label>
					<input type="email" class="form-control" id="email" name="speaker.email" value="#rc.speaker.email#" maxlength="300" />
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="tags">Tags <small>Comma-delimited list</small></label>
			<textarea name="speaker.tags" id="tags" rows="4" class="form-control" maxlength="1000">#rc.speaker.tag_list#</textarea>
		</div>
		<div class="form-group">
			<label for="summary">Summary <small>1000 Character Max - Used for Preview</small></label>
			<textarea name="speaker.summary" id="summary" rows="4" class="form-control" maxlength="1000">#rc.speaker.summary#</textarea>
		</div>
		<div class="form-group">
			<label for="bio">Biography</label>
			<textarea name="speaker.bio" id="speaker-bio-text" rows="8">#rc.speaker.bio#</textarea>
		</div>
		<div class="row">
			<div class="col-md-10">
				<div class="form-group">
					<label for="photo">Photo</label>
					<input type="file" id="photo" name="speaker.photo" class="form-control" />
					<p class="help-block">Recommended Upload size is 500x500. <br />Uploading a new photo will erase the existing one</p>
				</div>
			</div>
			<div class="col-md-2">
				<div class="form-group">
					<label>Current Photo</label><br />
					<cfif rc.speaker.media_id>
						<img src="#application.config.urls.media##rc.speaker.thumbnail#" data-nophoto="#application.config.urls.img#no-photo.png" width="100" height="100" alt="#rc.speaker.label#" />
						<a class="remove-photo btn btn-small btn-danger" href="#buildURL('speakers.removePhoto?speaker_id=' & rc.speaker.speaker_id)#" style="margin-top: -60px;"><span class="glyphicon glyphicon-remove"></span></a>
					<cfelse>
						<img src="#application.config.urls.img#no-photo.png" width="100" height="100" alt="No Photo Available" />
					</cfif>
				</div>
			</div>
		</div>
		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Save Speaker Information</strong></button>
		</div>
	</form>
</div>
<!--- start of modal --->
<div class="modal fade" id="speaker-assign" tabindex="-1" role="dialog" aria-labelledby="speaker-assign-label" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="speaker-assign-label">Speaker Assignment</h4>
			</div>
			<div class="modal-body">
				<p class="attention">Choose which session you'd like to associate this speaker to below</p>
				<select name="session_id" id="session_id" class="form-control">
					<option value="0">Choose Session...</option>
					<cfloop from="1" to="#rc.session_cnt#" index="s">
						<option value="#rc.sessions[s].session_id#">#rc.sessions[s].title#</option>
					</cfloop>
				</select>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
				<button type="button" class="btn btn-primary add">Add Selected Session</button>
			</div>
		</div>
	</div>
</div>
<!--- end of modal --->
</cfoutput>