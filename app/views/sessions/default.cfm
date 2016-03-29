<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li class="active">Sessions</li>
</ol>
<!--// BREAD CRUMBS END //--><div id="action-btns" class="pull-right">
	<a href="#buildURL('agendas.default')#" class="btn btn-lg btn-warning">View Current Agenda</a>
	<a href="#buildURL('event.sessions')#/create" class="btn btn-lg btn-primary">Create New Session</a>
</div>
<h2 class="page-title color-02">Sessions</h2>
<p class="page-subtitle">This section allows you to add sessions and create a schedule for your event.</p>
	#view('common/Listing')#
</cfoutput>