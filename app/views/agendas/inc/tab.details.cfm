<cfoutput>
<div class="tab-pane active" id="agenda-item-main">
	<h3 class="form-section-title">Main Details</h3>
	<form action="#buildURL('agendas.doSave')#" method="post" role="form">
		<input type="hidden" name="agenda.agenda_id" value="#rc.agenda.agenda_id#" />
		<div class="form-group">
			<label for="session" class="required">Select Session to Schedule</label>
			<select name="agenda.session_id" id="session" class="form-control">
				<option value="0">Choose Session</option>
				#rc.session_opts#
			</select>
		</div>
		<div class="form-group">
			<label for="label" class="required">Label</label>
			<input name="agenda.label" id="label" type="text" class="form-control" value="#rc.agenda.label#">
		</div>
		<div class="form-group">
			<label for="">Day of Session</label>
			<input name="agenda.date" id="date" type="text" class="form-control dateonly-datetime" value="#dateFormat( rc.agenda.start_time, 'mm/dd/yyyy' )#">
		</div>
		<div class="form-group">
			<label for="">Start Time</label>
			<input name="agenda.start_time" id="start_time" type="text" class="form-control timeonly-datetime" value="#timeFormat( rc.agenda.start_time, 'hh:mm tt' )#">
		</div>
		<div class="form-group">
			<label for="">End Time</label>
			<input name="agenda.end_time" id="end_time" type="text" class="form-control timeonly-datetime" value="#timeFormat( rc.agenda.end_time, 'hh:mm tt' )#">
		</div>
		<div class="form-group">
			<label for="location">Venue</label>
			<select name="agenda.venue_id" id="venues" class="form-control">
				<option value="0">Choose a Venue</option>
				#rc.venue_opts#
			</select>
		</div>
		<div id="locations">
			<div class="form-group">
				<label for="location">Locations</label>
				<select name="agenda.location_id" id="location" class="form-control">
					<option value="0">Choose a location</option>
					#rc.location_opts#
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
							<input name="agenda.included" id="included_yes" type="radio" value="1" #rc.checked[ rc.agenda.included eq 1]#> Yes
						</label>
					</div>
					<div class="radio pull-left">
						<label>
							<input name="agenda.included" id="included_no" type="radio" value="0" #rc.checked[ rc.agenda.included eq 0]#> No
						</label>
					</div>
				</div>
			</div>
		<div class="form-group">
			<label for="" class="required">Hide on Agenda?</label>
			<div class="cf">
				<div class="radio pull-left">
					<label for="visible_yes">
						<input name="agenda.visible" id="visible_yes" type="radio" value="0" #rc.checked[ rc.agenda.visible eq 0]#> Yes
					</label>
				</div>
				<div class="radio pull-left">
					<label for="visible_no">
						<input name="agenda.visible" id="visible_no" type="radio" value="1" #rc.checked[ rc.agenda.visible eq 1]#> No
					</label>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="">Sort Order</label>
			<input name="agenda.sort" id="sort" type="number" class="form-control" value="#val( rc.agenda.sort )#">
		</div>
		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Update Agenda Item Essentials</strong></button>
		</div>
	</form>
</div>
</cfoutput>