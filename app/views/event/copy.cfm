<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li class="active">Copy an Event</li>
</ol>
<!--// BREAD CRUMBS END //-->
<form role="form" class="basic-wrap" method="post" action="#buildURL('event.doCopy')#" data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden">
<div class="row mt-medium">
	<div class="col-md-6">
		<div class="form-group">
			<label for="">Source Event</label>
			<select name="event.copy_event_id" id="copy_event_id" class="form-control">
				#rc.event_opts#
			</select>
		</div>
		<div class="form-group">
			<label for="name" class="required">Event Name</label>
			<input type="text" class="form-control" id="event_name" name="event.event_name" value="" />
		</div>
		<div class="form-group">
			<label for="slug" class="required">URL extension / Event Registration Identifier</label>
			<input  name="event.slug" type="text" class="form-control" id="slug" value="" />
		</div>
		<div class="cf">
			<button type="submit" class="btn btn-info btn-lg pull-right">Copy</button>
		</div>
	</div>
</div>
</form>
</cfoutput>