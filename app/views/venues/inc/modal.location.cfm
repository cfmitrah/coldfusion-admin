<cfoutput>
<div class="modal fade" id="add-location-modal" tabindex="-1" role="dialog" aria-labelledby="add-location-modal-label" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="add-location-modal-label">Add New Location to #rc.venue.venue_name#</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label for="location_name">Location Name</label>
					<input type="text" id="location_name" name="location_name" class="form-control" maxlength="150" />
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
				<button type="button" class="add btn btn-success">Add Location</button>
			</div>
		</div>
	</div>
</div>
</cfoutput>