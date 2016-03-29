<cfoutput>
<div class="tab-pane" id="page-media">
	<h3 class="form-section-title">Media</h3>
	<p class="help-block">Page media is optional. If you wish to upload or select media, a gallery will be available for use on the registration site showcasing this page. Recommended Size is 500x500</p>
	<h4>Upload New media</h4>
	<p>Drag media onto the dropzone to upload them. Once uploaded, you can edit specifics in the table below.</p>
	<div class="has_dropzone" data-company_id="#rc.company_id#" data-event_id="#rc.event_id#" data-page_id="#rc.page.page_id#"></div>
	<hr />
	<p class="help-block">Click manage to change this media label and add desired tags.</p>
	<table id="uploaded-session-media" class="table table-striped">
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
			<cfloop from="1" to="#rc.page.media_cnt#" index="i">
				<tr data-media_id="#rc.page.media[i].media_id#">
					<td><img src="#application.config.urls.media#/#rc.page.media[i].thumbnail#"></td>
					<td>#rc.page.media[i].filename#</td>
					<td>#rc.page.media[i].filesize#</td>
					<td>#dateTimeFormat( rc.page.media[i].uploaded, "mm/dd/yyyy h:mm tt")#</td>
					<td><a href="##" class="remove btn btn-danger btn-sm">Remove</a></td>
				</tr>
			</cfloop>
		</tbody>
	</table>
</div>
</cfoutput>