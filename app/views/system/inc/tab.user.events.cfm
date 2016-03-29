<cfoutput>
<div class="tab-pane" id="user-events">
	<div class="row">
		<div class="col-md-10">
			<h3 class="form-section-title">Events</h3>
		</div>
		<div class="col-md-2">
			<a href="##" data-toggle="modal" data-target="##new-event-restriction-modal" class="btn btn-lg btn-block btn-info">Add New Event</a>
		</div>
	</div>
	<!--- start grid of all associated events --->
	<div id="event-grid">
		<div class="row">
			<!--- Sample output
				<div class="col-md-3">
					<div class="well text-center">
						<h4>This is a sample event name</h4>
						<p>1/23/2015 - 1/26/2015</p>
						<div class="alert alert-success">Has Access</div>
						<a href="" class="btn btn-block btn-default" data-remove_event_access="true">Remove Access</a>
					</div>
				</div>
			--->
		</div>
	</div>
	<!--- End grid of all associated events --->
</div>


<div id="new-event-restriction-modal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Add a New Restriction Event</h4>
      </div>
      <div class="modal-body" style="height:300px;">
        <form action="" class="form-horizontal" id="add_event_restriction_form">
	        <input type="hidden" value="#rc.user_id#" name="user_id" id="user_id" />
        	<div class="form-group">
				<label for="" class="control-label col-md-3">Filter by Company:</label>
				<div class="col-md-9">
					<select name="er_company_id" id="er_company_id" class="form-control">
						<cfloop from="1" to="#rc.companies.count#" index="local.idx">
						<cfset local.company = rc.companies.companies[local.idx] />
						<option value="#local.company['company_id']#">#local.company['company_name']#</option>
						</cfloop>
					</select>
				</div>
			</div>
        	<br>
			<div class="form-group">
				<label for="" class="control-label col-md-3" id="events_label">Select Event</label>
				<div class="col-md-9">
					<select name="er_event_id" id="er_event_id" multiple="true" class="form-control"></select>
				</div>
			</div>
			<br>
			<br>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="btn_add_event_restriction">Add Event(s)</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</cfoutput>