<cfoutput>
<div class="tab-pane" id="event-location">
	<h3 class="form-section-title">Venue</h3>
	<p class="attention">Venues made available for this event will appear in the table below. You can choose from our existing venues, or create a new venue using the 'create new venue' button below</p>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Venue Name</th>
				<th>## Locations</th>
				<th>Options</th>
			</tr>
		</thead>
		<tbody>
			<cfloop from="1" to="#rc.event_venues.venues_cnt#" index="i">				
				<tr data-event_id="#rc.event_id#" data-venue_id="#rc.event_venues.venues[i].venue_id#">
					<td>#rc.event_venues.venues[i].venue_name#</td>
					<td>#rc.event_venues.venues[i].locations#</td>
					<td><a href="" class="text-danger remove-venue"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Remove</strong> </a></td>
				</tr>
			</cfloop>
		</tbody>
	</table>
	<hr>
	<h4>Adding a New Venue</h4>
	<form action="#buildURL('event.doSaveVenue')#" role="form" method="post">
		<input type="hidden" name="event.event_id" value="#rc.event_id#" />	
		<div class="form-group">
			<label for="venue" class="required">Select an existing venue to add</label>
			<select name="event.venue_id" id="venue" class="form-control width-md">
				#rc.venues_opts#
			</select>
		</div>
		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg"><strong>Add Selected Existing Venue</strong></button> - or - 
			<a href="#buildURL( 'venues/create' )#" class="btn btn-info btn-lg"><strong>Go Create a New Venue in Configuration</strong></a>
		</div>
	</form>
</div>
</cfoutput>