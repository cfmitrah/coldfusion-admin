<cfoutput>

<h3 class="form-section-title">Assets</h3>
<div class="alert alert-info">Assets are optional. If you wish to upload or select assets, they will appear in as downloadable links near the session overview.</div>

<h4>Upload New Assets</h4>
<p>Drag files onto the dropzone to upload them. Once uploaded, you can edit specifics in the table below.</p>
<div class="has_dropzone" data-session_id="#rc.session_id#" data-session_media_type="file"></div>

<hr>
<h4>Choose Existing Assets</h4>
<p>Click the button below to launch an overlay and select existing assets from your asset library.</p>
<a href="##" data-toggle="modal" data-target="##asset-library-modal" class="btn btn-info">Launch Asset Library</a>

<hr>
<h4>Selected Session Assets</h4>
<table id="#( structKeyExists(rc, "files_table_id") ? rc.files_table_id : '' )#" class="table table-striped table-hover data-table tm-large" >
	<thead>
	<tr>
		<cfif structKeyExists(rc, "files_columns")>
			<cfset local.aCols = listToArray( rc.files_columns ) />
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