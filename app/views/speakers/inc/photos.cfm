<cfoutput>
<h3 class="form-section-title">Photos</h3>
<div class="alert alert-info">Session photos are optional. If you wish to upload or select photos, they will appear in a gallery format near the session overview. Recommended size 500x500 px.</div>

<h4>Upload New Photos</h4>
<p>Drag photos onto the dropzone to upload them. Once uploaded, you can edit specifics in the table below.</p>
<div class="has_dropzone" data-session_id="#rc.session_id#" data-session_media_type="image" ></div>

<hr>
<h4>Choose Existing Photos</h4>
<p>Click the button below to launch an overlay and select existing photos from your asset library.</p>
<a href="##" data-toggle="modal" data-target="##asset-library-modal" class="btn btn-primary">Launch Asset Library</a>

<hr>
<h4>Selected Session Photos</h4>
<table id="#( structKeyExists(rc, "photos_table_id") ? rc.photos_table_id : '' )#" class="table table-striped table-hover data-table tm-large" >
	<thead>
	<tr>
		<cfif structKeyExists(rc, "photos_columns")>
			<cfset local.aCols = listToArray( rc.photos_columns ) />
			<cfloop array="#local.aCols#" index="local.col_name">
				<th class="">#local.col_name#</th>
			</cfloop>
		</cfif>		
	</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</cfoutput>