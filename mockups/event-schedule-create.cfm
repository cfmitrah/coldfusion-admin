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
			  <li><a href="#">Schedule</a></li>
			  <li class="active">Create Agenda Item</li>
			</ol>
			<h2 class="page-title color-02">Create New Agenda Item</h2>
			<p class="page-subtitle">To start, fill in the essential information below. You can manage specifics of an agenda item (such as fees, restrictions, etc) once it's created.</p>
			<div class="row mt-medium">
				<div class="col-md-8">
					<form role="form" class="basic-wrap">
						<div class="form-group">
							<label for="" class="required">Select Session to Schedule</label>
							<select name="" id="" class="form-control">
								<option value="">Choose Session</option>
								<option value="">Sample Session Name - Sample Session Description for extra detail</option>
								<option value="">Sample Session Name</option>
								<option value="">Sample Session Name</option>
							</select>
						</div>
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
							<button type="submit" class="btn btn-success btn-lg pull-right">Everything Look Good? <strong>Add to Schedule!</strong></button>
						</div>
					</form>
				</div>
			</div>

		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>