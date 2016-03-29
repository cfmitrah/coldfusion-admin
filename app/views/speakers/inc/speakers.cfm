<h3 class="form-section-title">Speakers</h3>
<p class="attention">
	To assign speakers to this session, move names from the left section to the right section by clicking them. Once you've selected the speakers press 'save presenters'
</p>

<table id="uploaded-session-photos" class="table table-striped">
	<thead>
		<tr>
			<th>Company</th>
			<th>Name</th>
			<th>Title</th>
			<th>Options</th>
		</tr>
	</thead>
	<tbody>
		<cfset local.speakers = rc.session_details.speakers />
		<cfloop from="1" to="#local.speakers.recordCount#" index="local.speaker_row">
		<tr>
			<td>#local.speakers.company[local.speaker_row]#</td>
			<td>#local.speakers.display_name[local.speaker_row]#</td>
			<td>#local.speakers.title[local.speaker_row]#</td>
			<td><a href="" class="text-danger"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Delete</strong> </a></td>
		</tr>
		</cfloop>
	</tbody>
</table>