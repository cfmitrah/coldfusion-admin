<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li class="active">Venues</li>
</ol>
<!--// BREAD CRUMBS END //-->

<div id="action-btns" class="pull-right">
	<a href="#buildURL('venues.create')#" class="btn btn-lg btn-info">Create New Venue</a>
</div>
<h2 class="page-title color-03">Venues</h2>
<p class="page-subtitle">In this section you can add venues and sub locations to choose from when setting up events and scheduling sessions.</p>
<div class="alert alert-info">Venues, typically hotels, are the locations in which an event can be hosted.</div>
#view("common/listing")#
</cfoutput>