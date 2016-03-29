<cfoutput>
<div class="modal fade" id="custom-schedule-modal" >
	<div class="modal-dialog" style="position:relative;">
		<div class="whiteout" style="height:100%;width:600px;background:##fff;opacity:.5; position:absolute;border-radius:5px;z-index:99;"></div>
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">Save and Schedule for Later</h4>
			</div>
			<form method="post" action="#buildURL( 'scheduledReports.doSaveCustomSchedule' )#" class="form-horizontal validate-frm"  data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden">
			<input type="hidden" id="report_schedule_id" name="report.report_schedule_id" value="0" />
			<input type="hidden" name="report.event_id" value="#rc.event_id#" />
			<input type="hidden" id="report" name="report.report" value="" />
			<input type="hidden" id="report_settings" name="report.report_settings" value="" />

			<div class="modal-body">
				<h3 class="form-section-title">Settings</h3>
					<div class="form-group">
						<label for="custom_report_id" class="control-label col-md-4">Custom Report:</label>
						<div class="col-md-8">
							<select name="report.custom_report_id" id="custom_report_id" class="form-control">
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="" class="control-label col-md-4">From:</label>
						<div class="col-md-8">
							<input name="report.from_email" id="scheduled_from" type="email" class="form-control" value="reporting@meetingplay.com" required>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="control-label col-md-4">To:</label>
						<div class="col-md-8">
							<input id="scheduled_to" name="report.to_email" type="text" class="form-control" required>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="control-label col-md-4">Subject / Name:</label>
						<div class="col-md-8">
							<input id="scheduled_subject" name="report.subject" type="text" class="form-control" required>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="control-label col-md-4">Frequency:</label>
						<div class="col-md-4">
							<select name="report.frequency"  id="weekly-or-daily" class="form-control" required>
								<option value="daily">Daily</option>
								<option value="weekly">Weekly</option>
							</select>
						</div>
						<div class="col-md-4">
							<select name="report.day" id="day-picker" class="form-control" disabled>
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
							<input id="scheduled_startdate" name="report.begin_on" type="text" class="form-control datetime" required>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="control-label col-md-4">Stop Sending On:</label>
						<div class="col-md-8">
							<input id="scheduled_enddate" name="report.end_on" type="text" class="form-control datetime" required>
						</div>
					</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button id="save_custom_schedule" type="submit" class="btn btn-success">Save and Schedule</button>
			</div>
		</form>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</cfoutput>
