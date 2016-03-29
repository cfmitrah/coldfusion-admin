<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li class="active">Events</li>
</ol>
<!--// BREAD CRUMBS END //--><div id="action-btns" class="pull-right">
	<!--- <a href="" class="btn btn-lg btn-warning">Advanced Search</a> --->
	<cfif !rc.sessionmanageuserfacade.isEventStaff()>
	<a href="#buildURL('event.create')#" class="btn btn-lg btn-info">Create New Event</a>
	</cfif>
</div>
<h2 class="page-title color-02">Events</h2>
<p class="page-subtitle">Select a specific event below to manage it. Managing an event will let you set it's details, edit it's agenda, set attendee specifications and much more.</p>
#view('common/Listing')#
</cfoutput>