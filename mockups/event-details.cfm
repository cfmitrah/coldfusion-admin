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
			  <li class="active">Details</li>
			</ol>
			<h2 class="page-title color-02">Event Details</h2>
			<p class="page-subtitle">Set standard information pertaining to your event such as the name of it, where it's located, when it is and much more.</p>

			
			<!-- Nav tabs -->
			<ul class="nav nav-tabs mt-medium" role="tablist">
				<li class="active"><a href="#event-essentials" role="tab" data-toggle="tab">Essentials</a></li>
				<li><a href="#event-location" role="tab" data-toggle="tab">Venue</a></li>
				<li><a href="#event-dates" role="tab" data-toggle="tab">Date and Time</a></li>
				<li><a href="#event-tags" role="tab" data-toggle="tab">Tags</a></li>
			</ul>

			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane active" id="event-essentials">
					<form action="">
						<h3 class="form-section-title">Essentials</h3>
						<div class="form-group">
							<label for="" class="required">Event Name</label>
							<input type="text" class="form-control" id="" value="Sample Event Name">
						</div>
						<div class="form-group">
							<label for="" class="required">Domain Name</label>
							<select name="" class="form-control" id="domain-name" disabled>
								<option value="hobsons">hobsons</option>
								<option value="sampleone">sampleone</option>
								<option value="sampletwo">sampletwo</option>
							</select>
						</div>
						<div class="form-group">
							<label for="" class="required">URL extension / Event Registration Identifier</label>
							<input type="text" class="form-control" id="extension-input" value="2014reg" disabled>
							<div class="alert alert-info mt-small"> 
								Full Domain Name Preview: <br>
								<strong>http://<span id="domain-output">hobsons</span>.meetingplay.com/<span id="slug-output">2014reg</span></strong> <br> 
							</div>
						</div>
						<div class="form-group">
							<label for="" class="required">Visibility</label>
							<div class="cf">
								<div class="radio pull-left">
									<label for="visibility-public">
								    	<input type="radio" name="visibility" id="visibility-public">
								    	Public
								  	</label>
								</div>
								<div class="radio pull-left">
									<label for="visibility-private">
								    	<input type="radio" name="visibility" id="visibility-private" class="formShowHide_ctrl" data-show-id="private-yes-box" checked>
								    	Private
								  	</label>
								</div>
							</div>
							<div id="private-yes-box" class="hiddenbox">
								<br>
								<div class="form-group">
									<label for="">Enter Reg. Site Access Code</label>
									<input type="text" class="form-control width-sm" placeholder="Numbers and Letters A-Z are allowed">
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="" class="required">Event Status</label>
							<select name="" id="" class="form-control width-sm">
								<option value="">Current</option>
								<option value="">Published</option>
								<option value="">Cancelled</option>
								<option value="">Pending</option>
								<option value="">Archived</option>
							</select>
						</div>
						<div class="cf">
							<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Save The Essentials</strong></button>
						</div>
					</form>
				</div>

				<div class="tab-pane" id="event-location">
					<h3 class="form-section-title">Venue</h3>
					<p class="attention">Venues made available for this event will appear in the table below. You can choose from our existing venues, or create a new venue using the 'create new venue' button below</p>
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Venue Name</th>
								<th># Locations</th>
								<th>Options</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Marriott Marquis</td>
								<td>34</td>
								<td><a href="" class="text-danger"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Remove</strong> </a></td>
							</tr>
						</tbody>
					</table>
					<hr>
					<h4>Adding a New Venue</h4>
					<form action="">
						<div class="form-group">
							<label for="" class="required">Select an existing venue to add</label>
							<select name="" id="" class="form-control width-md">
								<option value="">Marriott Marquis</option>
								<option value="">Frederick Days Inn</option>
							</select>
						</div>
						<div class="cf">
							<button type="submit" class="btn btn-success btn-lg pull-right"  style="margin-right: 10px;"><strong>Add Selected Existing Venue</strong></button>
							<a href="" class="btn btn-primary btn-lg pull-right"><strong>Create New Venue in Configuration</strong></a>
						</div>
					</form>
				</div>

				<div class="tab-pane" id="event-dates">
					<h3 class="form-section-title">Date and Time</h3>
					<p class="attention">Dates and times created for this event will appear in the table. Add a new date by using the form below</p>
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Date</th>
								<th>Day Begins at</th>
								<th>Day Ends at</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>7/29/2014</td>
								<td>8:00 AM</td>
								<td>5:00 PM</td>
							</tr>
							<tr>
								<td>7/30/2014</td>
								<td>9:15 AM</td>
								<td>5:40 PM</td>
							</tr>
						</tbody>
					</table>
					<hr>
					<h4>Adding a New Event Date</h4>
					<form action="">
						<div class="form-group">
							<label for="" class="required">Set Day</label>
							<input type="text" class="form-control dateonly-datetime width-md">
						</div>
						<div class="form-group">
							<label for="" class="required">Day begins at</label>
							<input type="text" class="form-control timeonly-datetime width-md">
						</div>
						<div class="form-group">
							<label for="" class="required">Day ends at</label>
							<input type="text" class="form-control timeonly-datetime width-md">
						</div>
						<div class="cf">
							<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Add New Date</strong></button>
						</div>
			        </form>
					
				</div>

				

				<div class="tab-pane" id="event-tags">
					<h3 class="form-section-title">Tag Association</h3>
					<p class="attention">Below are the existing tags for this event. Tags are used to quickly find and sort content in the future. Create a new tag by using the form below.</p>
					<div class="alert alert-info"><strong>Existing Tags:</strong>&nbsp;&nbsp;
						<span class="label label-primary">HTML5</span>
						<span class="label label-primary">Javascript</span>
						<span class="label label-primary">Code</span>
						<span class="label label-primary">Freelance</span>
					</div>
					<hr>
					<form action="" class="form-inline">
						<h4>Adding a New Tag</h4>
						<div class="form-group">
							<label for="">New Tag &nbsp;</label>
							<input type="text" class="form-control width-md">
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-success"><strong>Add Tag</strong></button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>


<cfinclude template="shared/footer.cfm"/>