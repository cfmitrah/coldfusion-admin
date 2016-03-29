<cfoutput>
<div class="tab-pane" id="venue-photos">
	<h3 class="form-section-title">Photos</h3>
	<p class="help-block">Venue photos are optional. If you wish to upload or select photos, a gallery will be available for use on the registration site showcasing this venue. Recommended Size is 500x500</p>
	<h4>Upload New Photos</h4>
	<p>Drag photos onto the dropzone to upload them. Once uploaded, you can edit specifics in the table below.</p>
	<div class="has_dropzone" data-company_id="#rc.company_id#" data-event_id="#rc.event_id#" data-venue_id="#rc.venue.venue_id#"></div>
	<hr />
	<p class="help-block">Click manage to change this photos label and add desired tags.</p>
	<table id="uploaded-session-photos" class="table table-striped">
		<thead>
			<tr>
				<th>Photo Preview</th>
				<th>File Name</th>
				<th>File Size</th>
				<th>Uploaded</th>
				<th>Options</th>
			</tr>
		</thead>
		<tbody>
			<cfloop from="1" to="#rc.venue.photo_cnt#" index="i">
				<tr data-media_id="#rc.venue.photos[i].media_id#">
					<td><img src="#application.config.urls.media#/#rc.venue.photos[i].thumbnail#"></td>
					<td>#rc.venue.photos[i].filename#</td>
					<td>#rc.venue.photos[i].filesize#</td>
					<td>#dateTimeFormat( rc.venue.photos[i].uploaded, "mm/dd/yyyy h:mm tt")#</td>
					<td><a href="##" class="remove btn btn-danger btn-sm">Remove</a></td>
				</tr>
			</cfloop>
		</tbody>
	</table>
</div>
</cfoutput>