
<div class="modal fade" id="schedule-modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">Save and Schedule for Later</h4>
			</div>
			<div class="modal-body">
				<h3 class="form-section-title">Settings</h3>
				<form action="" class="form-horizontal">
					<div class="form-group">
						<label for="" class="control-label col-md-4">From:</label>
						<div class="col-md-8">
							<input name="from" id="scheduled_from" type="email" class="form-control" value="reporting@meetingplay.com">
						</div>
					</div>
					<div class="form-group">
						<label for="" class="control-label col-md-4">To:</label>
						<div class="col-md-8">
							<input id="scheduled_to" name="scheduled_to" type="email" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label for="" class="control-label col-md-4">Subject / Name:</label>
						<div class="col-md-8">
							<input id="scheduled_subject" name="scheduled_subject" type="text" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label for="" class="control-label col-md-4">Frequency:</label>
						<div class="col-md-4">
							<select name="scheduled_frequency"  id="weekly-or-daily" class="form-control">
								<option value="daily">Daily</option>
								<option value="weekly">Weekly</option>
							</select>
						</div>
						<div class="col-md-4">
							<select name="day" id="day-picker" class="form-control" disabled>
								<option value="2">On Monday</option>
								<option value="3">On Tuesday</option>
								<option value="4">On Wednesday</option>
								<option value="5">On Thursday</option>
								<option value="6">On Friday</option>
								<option value="7">On Saturday</option>
								<option value="1">On Sunday</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="control-label col-md-4">Begin Sending On:</label>
						<div class="col-md-8">
							<input id="scheduled_startdate" name="scheduled_startdate" type="text" class="form-control datetime">
						</div>
					</div>
					<div class="form-group">
						<label for="" class="control-label col-md-4">Stop Sending On:</label>
						<div class="col-md-8">
							<input id="scheduled_enddate" name="scheduled_enddate" type="text" class="form-control datetime">
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button id="save_schedule" type="button" class="btn btn-success"  data-dismiss="modal">Save and Schedule</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
