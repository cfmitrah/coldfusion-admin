<cfoutput>
<div class="tab-pane" id="event-tags">
	<h3 class="form-section-title">Tag Association</h3>
	<p class="attention">Below are the existing tags for this event. Tags are used to quickly find and sort content in the future. Create a new tag by using the form below.</p>
	<div class="alert alert-info"><strong>Existing Tags:</strong>&nbsp;&nbsp;
		<cfloop from="1" to="#rc.event_tags.tags_cnt#" index="i">				
			<span class="label label-primary">#rc.event_tags.tags[i].tag#</span>
		</cfloop>	
	</div>
	<hr>
	<form action="#buildURL('event.doSaveTag')#" role="form" method="post">
		<input type="hidden" name="event.event_id" value="#rc.event_id#" />	
		<input type="hidden" name="event.tags_list" value="#rc.event_tags.tags_list#" />
		<h4>Adding a New Tag</h4>
		<div class="form-group">
			<label for="tags">New Tag &nbsp;</label>
			<input id="tags" name="event.tags" type="text" class="form-control width-md">
		</div>
		<div class="form-group">
			<button type="submit" class="btn btn-success"><strong>Add Tag</strong></button>
		</div>
	</form>
</div>
</cfoutput>