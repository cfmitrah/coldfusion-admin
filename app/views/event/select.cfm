<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li class="active">Select Event</li>
</ol>
<!--// BREAD CRUMBS END //--><div class="row mt-medium">
	<div class="col-md-6">
		<form role="form" class="basic-wrap" method="post" action="#buildURL('event.doSelect')#">
			<div class="form-group">
				<label for="">Events</label>
				<select name="event_select" id="event_select" class="form-control">
					#rc.event_opts#
				</select>
			</div>
			<div class="cf">
				<button type="submit" class="btn btn-info btn-lg pull-right">Select!</button>
			</div>
		</form>
	</div>
</div>
</cfoutput>