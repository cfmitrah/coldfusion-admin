<cfoutput>
<div class="tab-pane" id="company-hotels">
	<h3 class="form-section-title">Hotels/Venues</h3>
	<p class="attention">Hotels and Venues associated with this company will appear in the table below. You can create a new hotel or venue by using the appropriate 'create' button below.</p>
	<hr>
	<h4>Hotels</h4>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Hotel Name</th>
				<th>Options</th>
			</tr>
		</thead>
		<tbody>
			<cfloop from="1" to="#rc.company_details.hotels.count#" index="i">
				<tr data-event_id="#rc.company_details.company_id#" data-venue_id="#rc.company_details.hotels.hotels.hotel_id[i]#">
					<td>#rc.company_details.hotels.hotels.name[i]#</td>
					<td><a href="" class="text-danger edit-hotel"><span class="glyphicon glyphicon-edit"></span> <strong>Edit</strong></a> </td>
				</tr>
			</cfloop>
		</tbody>
	</table>
	<hr>
	<h4>Venues</h4>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Venue Name</th>
				<th>Options</th>
			</tr>
		</thead>
		<tbody>
			<cfloop from="1" to="#rc.company_details.venues.count#" index="i">
				<tr data-event_id="#rc.company_details.company_id#" data-venue_id="#rc.company_details.venues.venues.venue_id[i]#">
					<td>#rc.company_details.venues.venues.venue_name[i]#</td>
					<td><a href="/venues/details/venue_id/#rc.company_details.venues.venues.venue_id[i]#" class="text-danger edit-venue"><span class="glyphicon glyphicon-edit"></span> <strong>Edit</strong></a></td>
				</tr>
			</cfloop>
		</tbody>
	</table>
</div>
</cfoutput>