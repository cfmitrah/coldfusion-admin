<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'venues.default' )#">Venues</a></li>
  <li class="active">#rc.venue.venue_name# Details</li>
</ol>
<!--// BREAD CRUMBS END //-->
<div id="action-btns" class="pull-right">
	<a href="##" data-toggle="modal" data-target="##add-location-modal" class="btn btn-lg btn-info">Add New Location to Venue</a>
</div>
<h2 class="page-title color-03">Manage Venue <small>- #rc.venue.venue_name#</small></h2>
<p class="page-subtitle">Add new locations to this venue by clicking the button above.</p>
<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> This venue is currently a private listing accessible by your company only. Because this venue is still private you can manage venue specific details such as the address and venue name.</div>
<ul class="nav nav-tabs mt-medium" role="tablist">
	<li class="active"><a href="##venue-main" role="tab" data-toggle="tab">Main Details</a></li>
	<li><a href="##venue-locations" role="tab" data-toggle="tab">Location Listing</a></li>
	<li><a href="##venue-photos" role="tab" data-toggle="tab">Venue Photos</a></li>
</ul>
<div id="venue" class="tab-content" data-venue_id="#rc.venue.venue_id#">
	<!--- start of details tab --->
	<cfinclude template="inc/tab.details.cfm" />
	<!--- end of details --->
	<!--- start of locations --->
	<cfinclude template="inc/tab.locations.cfm" />
	<!--- end of locations --->
	<!--- start of photos --->
	<cfinclude template="inc/tab.photos.cfm" />
	<!--- end of photos --->
</div>
<!--- start of add venue modal --->
<cfinclude template="inc/modal.location.cfm" />
<!--- end of add venue modal --->
</cfoutput>