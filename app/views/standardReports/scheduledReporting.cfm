<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'standardReports.default' )#">Standard Reports</a></li>
  <li class="active">Scheduled Reports</li>
</ol>

<h2 class="page-title color-01">Scheduled Reports</h2>

<p class="page-subtitle">Reports you have saved and scheduled will appear below</p>
<br>
<div class="panel">
	<div class="panel-body">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>Subject / Name</th>
					<th>Send To</th>
					<th>Frequency</th>
					<th>Begin Sending On</th>
					<th>Stop Sending On</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>Spencers Test Report</td>
					<td>spencer@excelaweb.com</td>
					<td>Daily - On Monday</td>
					<td>2/4/2015</td>
					<td>2/5/2015</td>
					<td>
						<a href="##" data-toggle="modal" data-target="##edit-scheduled-report-modal" class="btn btn-sm btn-info">Edit</a>
						<a href="" class="btn btn-sm btn-danger">Delete</a>
					</td>
				</tr>
				<tr>
					<td>Spencers Test Report 2</td>
					<td>spencer@excelaweb.com</td>
					<td>Weekly</td>
					<td>2/4/2015</td>
					<td>3/1/2015</td>
					<td>
						<a href="##" data-toggle="modal" data-target="##edit-scheduled-report-modal" class="btn btn-sm btn-info">Edit</a>
						<a href="" class="btn btn-sm btn-danger">Delete</a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
</cfoutput>

<div class="modal fade" id="edit-scheduled-report-modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">Edit Scheduled Report</h4>
			</div>
			<div class="modal-body">
				<h3 class="form-section-title">Settings</h3>
				<form action="" class="form-horizontal">
					<div class="form-group">
						<label for="" class="control-label col-md-4">From:</label>
						<div class="col-md-8">
							<input type="email" class="form-control" value="reporting@meetingplay.com">
						</div>
					</div>
					<div class="form-group">
						<label for="" class="control-label col-md-4">To:</label>
						<div class="col-md-8">
							<input type="email" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label for="" class="control-label col-md-4">Subject / Name:</label>
						<div class="col-md-8">
							<input type="text" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label for="" class="control-label col-md-4">Frequency:</label>
						<div class="col-md-4">
							<select name="" id="weekly-or-daily" class="form-control">
								<option value="daily">Daily</option>
								<option value="weekly">Weekly</option>
							</select>
						</div>
						<div class="col-md-4">
							<select name="" id="day-picker" class="form-control" disabled>
								<option value="">On Monday</option>
								<option value="">On Tuesday</option>
								<option value="">On Wednesday</option>
								<option value="">On Thursday</option>
								<option value="">On Friday</option>
								<option value="">On Saturday</option>
								<option value="">On Sunday</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="control-label col-md-4">Begin Sending On:</label>
						<div class="col-md-8">
							<input type="text" class="form-control datetime">
						</div>
					</div>
					<div class="form-group">
						<label for="" class="control-label col-md-4">Stop Sending On:</label>
						<div class="col-md-8">
							<input type="text" class="form-control datetime">
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-success">Save Settings</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->