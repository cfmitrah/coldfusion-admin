<cfoutput>
<!--- start of modal --->
<div id="user_events" class="modal fade events_modal" tabindex="-1" role="dialog" aria-labelledby="assign-user-label" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="speaker-assign-label">User Events - <span class="uevents_user_name"></span></h4>
			</div>
			<div class="modal-body">
				<p>
			        Choose from existing company's events and add to its staff the current user.
				</p>
				<form action="" class="form-horizontal" id="add_event_restriction_form">
					<div class="form-group">
						<label for="" class="control-label col-md-3" id="events_label">Select Event</label>
						<div class="col-md-6">
							<select data-placeholder="Select..." style="width:100%;" class="uevents_event_select form-control" multiple="true"></select>
						</div>
						<div class="col-md-3">
							<a href="" class="btn btn-success btn-block uevents_add_selected">Add Selected Events</a>
						</div>
					</div>
		        </form>
		        <hr>
		        <p>
			        Events of the current company associated with the selected user will appear in the table below.
				</p>
		        <h4>Events</h4>
				<table class="table table-striped uevents_table">
					<thead>
						<tr>
							<th>Event</th>
							<th>Role</th>
							<th>Options</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!--- end of modal --->
</cfoutput>