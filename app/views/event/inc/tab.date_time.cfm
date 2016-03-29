<cfparam name="rc.datetimeformat_current.datemask" default="m/dd/yyyy">
<cfparam name="rc.datetimeformat_current.timemask" default="h:mm tt">

<cfoutput>
<div class="tab-pane" id="event-dates">
	<h3 class="form-section-title">Date and Time</h3>
	<p class="attention">Dates and times created for this event will appear in the table. Add a new date by using the form below</p>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Date</th>
				<th>Day Begins at</th>
				<th>Day Ends at</th>
				<th>Options</th>
			</tr>
		</thead>
		<tbody>
			<cfloop from="1" to="#rc.event.date_time_cnt#" index="i">
			<tr data-event_id="#rc.event_id#" data-day_id="#rc.event.date_time[i].day_id#">
				<td>#dateFormat( rc.event.date_time[i].start_time, rc.datetimeformat_current.datemask )#</td>
				<td>#timeFormat( rc.event.date_time[i].start_time, rc.datetimeformat_current.timemask )#</td>
				<td>#timeFormat( rc.event.date_time[i].end_time, rc.datetimeformat_current.timemask )#</td>
				<td><a href="" class="text-danger remove-day"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Remove</strong> </a></td>
			</cfloop>
		</tbody>
	</table>
	<hr>
	<h4>Adding a New Event Date</h4>
	<form action="#buildURL('event.doSaveEventDate')#" role="form" method="post">
		<input type="hidden" name="event.event_id" value="#rc.event_id#" />
		<div class="form-group">
			<label for="date" class="required">Set Day</label>
			<input type="text" id="date" name="event.date" class="form-control dateonly-datetime width-md">
		</div>
		<div class="form-group">
			<label for="start_date" class="required">Day begins at</label>
			<input type="text" id="start_date" name="event.start_time" class="form-control timeonly-datetime width-md">
		</div>
		<div class="form-group">
			<label for="end_date" class="required">Day ends at</label>
			<input type="text" id="end_date" name="event.end_time" class="form-control timeonly-datetime width-md">
		</div>
		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Add New Date</strong></button>
		</div>
    </form>
</div>
</cfoutput>
