<cfoutput>

<div class="tab-pane" id="company-attendees">
	<h3 class="form-section-title">Attendees</h3>
	<p class="attention">Attendees associated with this company will appear in the table below.</p>
	<hr>
	<h4>Attendees</h4>
	<cfif  '#rc.company_details.attendees.count#' EQ  0>
		There is no attendees associated to the company
	<cfelse>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>Name</th>
					<th>Event</th>
				</tr>
			</thead>
			<tbody>

			<cfloop collection="#rc.company_details.attendees#" item="attendee_id">
				<cfif IsStruct(#rc.company_details.attendees[attendee_id]#)>
					<tr>
						<cfloop collection="#rc.company_details.attendees[attendee_id]#" item="user">
							<cfif !IsStruct(#rc.company_details.attendees[attendee_id][user]#)>
								<td>#rc.company_details.attendees[attendee_id][user]#</td>
							<cfelse>
								<cfset eventsNames ="">
								<cfloop collection="#rc.company_details.attendees[attendee_id][user]#" item="key">
									<cfset eventsNames = #rc.company_details.attendees[attendee_id][user][key]# & "," & #eventsNames#>
								</cfloop>
							</cfif>
						</cfloop>
						<td data-event_name="#eventsNames#"><button class="btn btn-sm btn-primary see-attendee"> See Events </button></td>
					</tr>
				</cfif>
			</cfloop>
			</tbody>
		</table>
	</cfif>


	<hr>
</div>
</cfoutput>