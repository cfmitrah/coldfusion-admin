<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<cfinclude template="shared/event-sidebar.cfm"/>

	<!--- Sidebar Ends Content Starts --->
	<div id="main-content-wrapper" class="has-sidebar">
		<div id="main-content">
			<ol class="breadcrumb">
			  <li><a href="#">Dashboard</a></li>
			  <li><a href="#">Events</a></li>
			  <li><a href="#">Event Name</a></li>
			  <li><a href="#">Agenda</a></li>
			  <li class="active">Session Name</li>
			</ol>
			<h2 class="page-title color-02">Session: This is a Sample Name</h2>
			<p class="page-subtitle">Edit specifics related to this session such as schedules, details, fees, and more.</p>
			<!-- Nav tabs -->
			<ul class="nav nav-tabs mt-medium" role="tablist">
				<li class="active"><a href="#session-main" role="tab" data-toggle="tab">Main Details</a></li>
				<li><a href="#session-schedule" role="tab" data-toggle="tab">Schedule</a></li>
				<li><a href="#session-details" role="tab" data-toggle="tab">Photos</a></li>
				<li><a href="#session-assets" role="tab" data-toggle="tab">Assets</a></li>
				<li><a href="#session-speakers" role="tab" data-toggle="tab">Speakers</a></li>
				<li><a href="#session-attendee-settings" role="tab" data-toggle="tab">Attendee Capacity Settings</a></li>
				<li><a href="#session-fees" role="tab" data-toggle="tab">Associated Fees</a></li>
			</ul>

			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane active" id="session-main">
					<form action="">
						<h3 class="form-section-title">Main Details</h3>
						<div class="form-group">
							<label for="" class="required">Session Name / Title</label>
							<input type="text" class="form-control" id="">
						</div>

						<div class="form-group">
							<label for="">Description <small>- 1 Sentence - S.E.O Purposes</small></label>
							<input type="text" class="form-control" id="">
						</div>
						<div class="form-group">
							<label for="">Summary <small>- 1 or 2 Sentences - S.E.O Purposes</small></label>
							<input type="text" class="form-control" id="">
						</div>
						<div class="form-group">
							<label for="">Overview <small>- Detailed - Viewable by End User</small></label>
							<textarea name="session-overview-text" id="session-overview-text" rows="20">
				            </textarea>
				            <script>
				            	CKEDITOR.replace( 'session-overview-text' );
				            </script>
						</div>
						
						<div class="form-group">
							<label for="" class="required">Hide on Agenda?</label>
							<div class="cf">
								<div class="radio pull-left">
									<label for="visible-yes">
										<input type="radio" name="radio-visible" /> Yes
									</label>
								</div>
								<div class="radio pull-left">
									<label for="visible-no">
										<input type="radio" name="radio-visible" id="visible-no" checked/> No
									</label>
								</div>
							</div>
						</div>
						
						<div class="cf">
							<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Save Main Details</strong></button>
						</div>
					</form>
				</div>
				
				<div class="tab-pane" id="session-schedule">
					<h3 class="form-section-title">Schedule</h3>
					<p class="attention">In the table below are the existing scheduled times for this session. Use the form below to add a new scheduled time.</p>
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Day</th>
								<th>Start Time</th>
								<th>End Time</th>
								<th>Location</th>
								<th>Options</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>7/29/2014</td>
								<td>8:00 AM</td>
								<td>9:00 AM</td>
								<td>Lobby 1A</td>
								<td><a href="event-agenda-session.cfm" class="text-danger"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Remove</strong> </a></td>
							</tr>
							<tr>
								<td>7/30/2014</td>
								<td>9:15 AM</td>
								<td>10:40 AM</td>
								<td>Lobby 2B</td>
								<td><a href="event-agenda-session.cfm" class="text-danger"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Remove</strong> </a></td>
							</tr>
						</tbody>
					</table>
					<hr>
					<h4>Adding a New Schedule</h4>
					<form action="">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label for="">Set Day</label>
									<input type="text" class="form-control dateonly-datetime">
								</div>
								<div class="form-group">
									<label for="">Start Time</label>
									<input type="text" class="form-control timeonly-datetime">
								</div>
								<div class="form-group">
									<label for="">End Time</label>
									<input type="text" class="form-control timeonly-datetime">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="">Location</label>
									<select name="" id="" class="form-control">
										<option value="">Ballroom</option>
									</select>
								</div>
								<div class="form-group">
									<label for="">Location not listed above? You can enter a new one below</label>
									<input type="text" class="form-control">
								</div>
								<div class="cf">
									<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Add New Schedule</strong></button>
								</div>
							</div>
						</div>
					</form>
				</div>

				<div class="tab-pane" id="session-details">
					<form action="">
						<h3 class="form-section-title">Photos</h3>
						
						<p class="attention">Uploading photos is optional. If you wish to upload photos, they will appear in a gallery format near the session overview.</p>
						<div class="form-group">
							<label for="">Choose File</label>
							<input type="file" class="form-control" id="">
						</div>
						<div class="alert alert-info">Recommened sizing is 500x500 px. JPG or PNG</div>
						<div class="cf">
							<button type="submit" class="btn btn-success btn-lg pull-right">Add Photo</button>
						</div>
					</form>
					<hr>
					<h4>Uploaded Photos</h4>
					<table id="uploaded-session-photos" class="table table-striped">
						<thead>
							<tr>
								<th>Photo Preview</th>
								<th>File Name</th>
								<th>File Size</th>
								<th>Options</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><img src="//placehold.it/100x100" alt=""></td>
								<td>2901-AD.jpg</td>
								<td>53KB</td>
								<td><a href="" class="text-danger"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Delete</strong> </a></td>
							</tr>
							<tr>
								<td><img src="//placehold.it/100x100" alt=""></td>
								<td>2901-AD.jpg</td>
								<td>53KB</td>
								<td><a href="" class="text-danger"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Delete</strong> </a></td>
							</tr>
							<tr>
								<td><img src="//placehold.it/100x100" alt=""></td>
								<td>2901-AD.jpg</td>
								<td>53KB</td>
								<td><a href="" class="text-danger"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Delete</strong> </a></td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="tab-pane" id="session-assets">
					<form action="">
						<h3 class="form-section-title">Assets</h3>
						
						<p class="attention">Uploading assets is optional. If you wish to upload assets, they will be available for download as a link under the session overview.</p>
						<div class="form-group">
							<label for="">Choose File</label>
							<input type="file" class="form-control" id="">
						</div>
						<p><strong class="text-warning">OR</strong></p>
						<div class="form-group">
							<label for="">Select a file from your asset library</label>
							<select name="" id="" class="form-control width-md">
								<option value="">Choose File</option>
							</select>
						</div>
						
						<div class="cf">
							<button type="submit" class="btn btn-success btn-lg pull-right">Add Asset</button>
						</div>
					</form>
					<hr>
					<h4>Uploaded Assets</h4>
					<table id="uploaded-session-photos" class="table table-striped">
						<thead>
							<tr>
								<th>Asset Name</th>
								<th>File Size</th>
								<th>Options</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>info.pdf</td>
								<td>53KB</td>
								<td><a href="" class="text-danger"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Delete</strong> </a></td>
							</tr>
							<tr>
								<td>slideshow.ppt</td>
								<td>53KB</td>
								<td><a href="" class="text-danger"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Delete</strong> </a></td>
							</tr>
							<tr>
								<td>video.mp4</td>
								<td>53KB</td>
								<td><a href="" class="text-danger"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Delete</strong> </a></td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="tab-pane" id="session-speakers">
					<h3 class="form-section-title">Speakers</h3>
					<p class="attention">To assign speakers to this session, move names from the left section to the right section by clicking them. Once you've selected the speakers press 'save presenters'.</p>
					<form action="" class="form-horizontal mt-medium">
						<div class="form-group">
							<label class="col-sm-3 control-label">Add Presenters</label>
							<div class="col-sm-6">
								<select multiple="multiple" id="session-presenters" name="session-presenters">
									<option value="userid-1" selected>Spencer Bailey</option>
									<option value="userid-2">Joe Schwinger</option>
									<option value="userid-3">Aaaron Benton</option>
									<option value="userid-4">Paul Larson</option>
							    </select>
							</div>
							
						</div>
						<div class="form-group">
							<div class="col-sm-9">
								<button type="submit" class="btn btn-success btn-lg pull-right"><span>Save Presenter(s)</span></button>
							</div>
						</div>
					</form>
				</div>

				<div class="tab-pane" id="session-attendee-settings">
					<h3 class="form-section-title">Attendee Capacity Settings</h3>
					<form action="">
						<div class="form-group">
							<label for="">Does this session have limited seating?</label>
							<div class="cf">
								<div class="radio pull-left">
									<label for="limited-yes">
										<input type="radio" name="radio-limited" id="limited-yes" class="formShowHide_ctrl" data-show-id="limited-yes-box" /> Yes
									</label>
								</div>
								<div class="radio pull-left">
									<label for="limited-no">
										<input type="radio" name="radio-limited" id="limited-no" checked  /> No
									</label>
								</div>
							</div>
						</div>
						<div id="limited-yes-box" class="hiddenbox">
							<div class="form-group">
								<label for="">Set max number of attendees allowed</label>
								<input type="number" class="form-control width-sm" id="">
							</div>
							<div class="form-group">
								<label for="">If max capacity reached, should there be a wait list?</label>
								<div class="cf">
									<div class="radio pull-left">
										<label for="waitlist-yes">
											<input type="radio" name="radio-waitlist" id="waitlist-yes" class="formShowHide_ctrl" data-show-id="waitlist-yes-box" /> Yes
										</label>
									</div>
									<div class="radio pull-left">
										<label for="waitlist-no">
											<input type="radio" name="radio-waitlist" id="waitlist-no" checked/> No
										</label>
									</div>
								</div>
							</div>
						</div>
						<div id="waitlist-yes-box" class="hiddenbox">
							<h3 class="form-section-title">Wait List Options</h3>
							<p class="attention">Below are the attendees who currently signed up for the waitlist, as well as the current seats available from cancellations. You can choose which attendees receive the now open remaining seats.</p>
							<div class="alert alert-info">
								<strong>Current Open Seat Count:</strong> 4
							</div>

							<table class="table table-striped">
								<thead>
									<tr>
										<th>First Name</th>
										<th>Last Name</th>
										<th>Email Address</th>
										<th>Date Joined Waitlist</th>
										<th>Options</th>
									</tr>
								</thead>
								<tbody>
									<cfloop from="1" to="7" index="i">
										<tr>
											<td>FirstName</td>
											<td>LastName</td>
											<td>name@emailaddress.com</td>
											<td>7/29/2014 5:00 PM</td>
											<td><a href="">Assign Seat and Send Notification Email</a></td>
										</tr>
									</cfloop>
									
								</tbody>
							</table>
						</div>
						<hr>
						<div class="cf">
							<button type="submit" class="btn btn-success btn-lg pull-right">Save Capacity Settings</button>
						</div>
					</form>
				</div>

				<div class="tab-pane" id="session-fees">
					<h3 class="form-section-title">Associated Fees</h3>
					<form action="">
						
						<div class="form-group">
							<label for="">Enter Fee Amount</label>
							<input type="number" class="form-control width-sm" id="" placeholder="ex: 500.00">
						</div>
						<div class="form-group">
							<label for="">Select which attendee types receive this fee</label>
							<div class="checkbox">
							    <label>
							    	<input type="checkbox" checked> Attendee Type One
							    </label>
							</div>
							<div class="checkbox">
							    <label>
							    	<input type="checkbox" checked> Attendee Type Two
							    </label>
							</div>
							<div class="checkbox">
							    <label>
							    	<input type="checkbox" checked> Attendee Type Three
							    </label>
							</div>
						</div>
						<div class="form-group">
							<label for="">Should this fee be tied to a certain date range only? (Used for early bird pricing, etc)</label>
							<div class="cf">
								<div class="radio pull-left">
									<label for="fee-date-yes">
										<input type="radio" name="radio-fee-date" id="fee-date-yes" class="formShowHide_ctrl" data-show-id="fee-date-yes-box" /> Yes
									</label>
								</div>
								<div class="radio pull-left">
									<label for="fee-date-no">
										<input type="radio" name="radio-fee-date" id="fee-date-no" checked  /> No
									</label>
								</div>
							</div>
						</div>
						<div class="cf">
							<button type="submit" class="btn btn-success btn-lg pull-right">Add Fee</button>
						</div>
					</form>

					<h3 class="form-section-title">Existing Fees for Session</h3>
				</div>

			</div>	
		</div>
	</div>
</div>

<!--- Modal For Additional Schedule Slots --->
<div class="modal fade" id="additional-time" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">Add Another Scheduled Time</h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
			<label for="" class="required">Start Date / Time</label>
            <input type='text' class="form-control std-datetime width-md" />
        </div>
		<div class="form-group">
			<label for="" class="required">Is this an all day event?</label>
			<div class="cf">
				<div class="radio pull-left">
					<label for="allday-yes-additional">
						<input type="radio" name="radio-allday-additional" id="allday-yes-additional" /> Yes
					</label>
				</div>
				<div class="radio pull-left">
					<label for="allday-no-additional">
						<input type="radio" name="radio-allday-additional" id="allday-no-additional" class="formShowHide_ctrl" data-show-id="allday-no-additional-box" /> No
					</label>
				</div>
			</div>
		</div>
		<div id="allday-no-additional-box" class="hiddenbox">
			<div class="form-group">
				<label for="">End Date / Time</label>
                <input type='text' class="form-control std-datetime width-md" />
            </div>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-success">Save</button>
      </div>
    </div>
  </div>
</div>
<script>
$(function(){
	// Multiselect for speakers tab
	$('#session-presenters').multiSelect({
	  selectableHeader: "Available Speakers: <br><input type='text' class='form-control' style='margin-bottom: 10px;'  autocomplete='off' placeholder='Filter entries...'>",
	  selectionHeader: "Selected Speakers: <br><input type='text' class='form-control' style='margin-bottom: 10px;' autocomplete='off' placeholder='Filter entries...'>",
	  afterInit: function(ms){
	    var that = this,
	        $selectableSearch = that.$selectableUl.prev(),
	        $selectionSearch = that.$selectionUl.prev(),
	        selectableSearchString = '#'+that.$container.attr('id')+' .ms-elem-selectable:not(.ms-selected)',
	        selectionSearchString = '#'+that.$container.attr('id')+' .ms-elem-selection.ms-selected';

	    that.qs1 = $selectableSearch.quicksearch(selectableSearchString)
	    .on('keydown', function(e){
	      if (e.which === 40){
	        that.$selectableUl.focus();
	        return false;
	      }
	    });

	    that.qs2 = $selectionSearch.quicksearch(selectionSearchString)
	    .on('keydown', function(e){
	      if (e.which == 40){
	        that.$selectionUl.focus();
	        return false;
	      }
	    });
	  },
	  afterSelect: function(){
	    this.qs1.cache();
	    this.qs2.cache();
	  },
	  afterDeselect: function(){
	    this.qs1.cache();
	    this.qs2.cache();
	  }
	  });
});
</script>
<cfinclude template="shared/footer.cfm"/>