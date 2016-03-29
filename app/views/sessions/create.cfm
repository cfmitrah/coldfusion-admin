<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'sessions.default' )#">Sessions</a></li>
  <li class="active">Create Session</li>
</ol>
<!--// BREAD CRUMBS END //--><h2 class="page-title color-02">Create a Session</h2>
<p class="page-subtitle">To get things going, first fill in the basic information below.</p>
<div class="row mt-medium">
	<div class="col-md-8">
		<form role="form" class="basic-wrap" action="#buildURL("sessions.doCreate")#" method="post">
			<div class="form-group">
				<label for="" class="required">Session Name / Title</label>
				<input type="text" name="event_session.title" class="form-control" id="">
			</div>

			<div class="form-group">
				<label for="">Description <small>- 1 Sentence - S.E.O Purposes</small></label>
				<input type="text" class="form-control" id="" name="event_session.description">
			</div>
			<div class="form-group">
				<label for="">Summary <small>- 1 or 2 Sentences - S.E.O Purposes</small></label>
				<input type="text" class="form-control" id="" name="event_session.summary">
			</div>
			<div class="form-group">
				<label for="">Overview <small>- Detailed - Viewable by End User</small></label>
				<textarea name="event_session.overview" id="session-overview-text" rows="20"></textarea>
			</div>
			<div class="cf">
				<button type="submit" class="btn btn-success btn-lg pull-right">Everything Look Good? <strong>Create Session!</strong></button>
			</div>
		</form>
	</div>
</div>
</cfoutput>