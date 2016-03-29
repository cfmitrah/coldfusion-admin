<cfoutput>
<div class="tab-pane" id="venue-locations">
	<h3 class="form-section-title">Venue Locations</h3>
	<p class="help-block">To add a new location, by click the "Add New Location to Venue" button in the top right.</p>
	<div class="containter-fluid">
		<div class="row">
			<div class="col-md-12">
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th>Location Name</th>
							<th>Remove</th>
						</tr>
					</thead>
					<tbody>
						<cfloop from="1" to="#rc.venue.location_cnt#" index="i">
							<tr data-location_id="#rc.venue.locations[i].location_id#">
								<td>#rc.venue.locations[i].location_name#</td>
								<td><a href="##" class="remove btn btn-danger btn-sm">Remove</a></td>
							</tr>
						</cfloop>
					</tbody>
				</table>
			</div>
			<div class="col-md-4">
			</div>
		</div>
	</div>
</div>
</cfoutput>