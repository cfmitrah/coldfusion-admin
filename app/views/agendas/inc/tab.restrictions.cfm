<cfoutput>
<div class="tab-pane" id="agenda-item-restrictions">
	<h3 class="form-section-title">Set Restrictions</h3>
	<form action="#buildURL('agendas.doCreateRestrictions')#" method="post" role="form">
		<input type="hidden" name="agenda.agenda_id" value="#rc.agenda.agenda_id#" />
		<div class="form-group">
			<label for="">Limit which attendee types can see this session item on their agenda</label>
			<div class="alert alert-warning">The checked attendee types will BE able to see this session on their agenda, but the others will not.  By default all attendee types can see a session.</div>
			<cfloop from="1" to="#rc.registration_types.cnt#" index="i">
				<div class="checkbox">
				    <label>
				    	<input name="agenda.registration_type_ids" value="#rc.registration_types.opts[i].registration_type_id#" type="checkbox"
				    	#rc.checked[arrayFind( rc.agenda.restrictions.registration_type_id, rc.registration_types.opts[i].registration_type_id ) gt 0 ]#> #rc.registration_types.opts[i].registration_type#
				    </label>
				</div>
			</cfloop>
		</div>
		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg pull-right">Update Restriction Settings</button>
		</div>
	</form>
</div>
</cfoutput>