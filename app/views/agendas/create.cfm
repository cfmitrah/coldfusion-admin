<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'agendas.default' )#">Agenda</a></li>
  <li class="active">Create Agenda</li>
</ol>
<!--// BREAD CRUMBS END //-->
<h2 class="page-title color-02">Create New Agenda Item</h2>
<p class="page-subtitle">
	To start, fill in the essential information below. You can manage specifics of an agenda item (such as fees, restrictions, etc) once it's created.
</p>
<div class="row mt-medium">
	<div class="col-md-8">
		<form role="form" class="basic-wrap" action="#buildURL('agendas.doCreate')#" method="post">
			<div class="form-group">
				<label for="session" class="required">Select Session to Schedule</label>
				<select name="agenda.session_id" id="session" class="form-control">
					<option value="0">Choose Session</option>
					#rc.session_opts#
				</select>
			</div>
			<div class="form-group">
				<label for="label" class="required">Label</label>
				<input name="agenda.label" id="label" type="text" class="form-control">
			</div>
			<div class="form-group">
				<label for="date" class="required">Set Day</label>
				<input name="agenda.date" id="date" type="text" class="form-control dateonly-datetime">
			</div>
			<div class="form-group">
				<label for="start_time" class="required">Start Time</label>
				<input name="agenda.start_time" id="start_time" type="text" class="form-control timeonly-datetime">
			</div>
			<div class="form-group">
				<label for="end_time" class="required">End Time</label>
				<input name="agenda.end_time" id="end_time" type="text" class="form-control timeonly-datetime">
			</div>
			<div class="form-group">
				<label for="location">Venue</label>
				<select name="agenda.venue_id" id="venues" class="form-control">
					<option value="0">Choose a Venue</option>
					#rc.venue_opts#
				</select>
			</div>
			<div id="locations" style="display:none">
				<div class="form-group">
					<label for="location">Locations</label>
					<select name="agenda.location_id" id="location" class="form-control">
						<option value="0">Choose a location</option>
					</select>
				</div>
				<div class="form-group">
					<label for="new_location">Location not listed above? You can enter a new one below</label>
					<input name="agenda.new_location" id="new_location" type="text" class="form-control">
				</div>
			</div>	
			<div class="form-group">
				<label for="hide_agenda" class="required">Included?</label>
				<div class="cf">
					<div class="radio pull-left">
						<label>
							<input name="agenda.included" id="included_yes" type="radio" value="1"> Yes
						</label>
					</div>
					<div class="radio pull-left">
						<label>
							<input name="agenda.included" id="included_no" type="radio" value="0" checked="checked"> No
						</label>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label for="hide_agenda" class="required">Hide on Agenda?</label>
				<div class="cf">
					<div class="radio pull-left">
						<label for="visible_yes">
							<input name="agenda.visible" id="visible_yes" type="radio" value="0"> Yes
						</label>
					</div>
					<div class="radio pull-left">
						<label for="visible_no">
							<input name="agenda.visible" id="visible_no" type="radio" value="1" checked="checked"> No
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
</cfoutput>