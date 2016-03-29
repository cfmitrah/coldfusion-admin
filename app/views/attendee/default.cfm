<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li class="active">Event Attendee List</li>
</ol>
<!--// BREAD CRUMBS END //-->
<div id="action-btns" class="pull-right">
	<a href="#buildURL('attendee.create')#" class="btn btn-lg btn-info">Create New Attendee</a>
</div>
<h2 class="page-title color-02">Event Attendee List</h2>
<p class="page-subtitle">Below are the attendees currently registered for this event. To manage their profile and registration details, use the 'manage' button in the table below.</p>
<p>
	<strong>Number of Registered:</strong>  #rc.counter.registered#</br>
	<strong>Number of Cancellations:</strong>  #rc.counter.cancelled#</br>
	<strong>Number of Pending:</strong>  #rc.counter.pending#
</p>
#view('common/Listing')#
</cfoutput>