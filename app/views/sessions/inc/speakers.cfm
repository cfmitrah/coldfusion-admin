<cfoutput>
<div id="session_speakers" data-session_id="#rc.session_details.details.session_id#">
	<h3 class="form-section-title">Speakers</h3>
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
			<tr data-speaker_id="#local.speakers.speaker_id[local.speaker_row]#">
				<td>#local.speakers.company[local.speaker_row]#</td>
				<td>#local.speakers.display_name[local.speaker_row]#</td>
				<td>#local.speakers.title[local.speaker_row]#</td>
				<td><a href="##" class="btn btn-sm btn-danger remove" data-loading-text="Removing..." data-speaker_id="#local.speakers.speaker_id[local.speaker_row]#"><strong>Remove</strong> </a></td>
			</tr>
			</cfloop>
		</tbody>
	</table>
	<a href="##" data-toggle="modal" data-target="##assign-speaker" class="btn btn-primary">Create New Speaker Assignment</a>

	<!--- start of modal --->
	<div class="modal fade" id="assign-speaker" tabindex="-1" role="dialog" aria-labelledby="assign-speaker-label" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="speaker-assign-label">Speaker Assignment</h4>
				</div>
				<div class="modal-body">
					<p class="attention">Choose which speaker you'd like to associate this session to below</p>
					<select name="speaker_id" id="speaker_id" class="form-control">
						<option value="0">Choose Speaker...</option>
						<cfloop from="1" to="#rc.event_speakers_cnt#" index="s">
							<option class="speaker_option" value="#rc.event_speakers[s].speaker_id#" data-company="#rc.event_speakers[s].company#" data-title="#rc.event_speakers[s].title#">#rc.event_speakers[s].display_name#</option>
						</cfloop>
					</select>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
					<button type="button" autocomplete="off" data-loading-text="Saving..." class="btn btn-primary add">Add Selected Speaker</button>
				</div>
			</div>
		</div>
	</div>
	<!--- end of modal --->
</div>
</cfoutput>