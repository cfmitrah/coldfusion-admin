<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Event</a></li>
  <li class="active">#rc.event.details.name# Details</li>
</ol>
<!--// BREAD CRUMBS END //-->
</cfoutput>
<h2 class="page-title color-02">Event Details</h2>
<p class="page-subtitle">Set standard information pertaining to your event such as the name of it, where it's located, when it is and much more.</p>
<!--// the tabs //-->
<ul class="nav nav-tabs mt-medium" role="tablist">
	<li class="active"><a href="#event-essentials" role="tab" data-toggle="tab">Global Settings</a></li>
	<li><a href="#event-location" role="tab" data-toggle="tab">Venue</a></li>
	<li><a href="#event-dates" role="tab" data-toggle="tab">Date and Time</a></li>
	<li><a href="#event-content" role="tab" data-toggle="tab">Landing Page Content</a></li>
	<li><a href="#event-payment-content" role="tab" data-toggle="tab">Payment Page Content</a></li>
	<li><a href="#event-tags" role="tab" data-toggle="tab">Tags</a></li>
	<li><a href="#event-contact" role="tab" data-toggle="tab">Contact Information</a></li>
</ul>

<div class="tab-content">
<!--- start of event essentials --->
<cfinclude template="inc/tab.essentials.cfm" />
<!--- end of event essentials --->
<!--- start of event venue--->
<cfinclude template="inc/tab.venue.cfm" />
<!--- end of event venue --->
<!--- start of event date time --->
<cfinclude template="inc/tab.date_time.cfm" />
<!--- end of event date time --->
<!--- start of event content --->
<cfinclude template="inc/tab.content.cfm" />
<!--- end of event content --->
<!--- start of event content --->
<cfinclude template="inc/tab.payment.content.cfm" />
<!--- end of event content --->
<!--- start of event tags --->
<cfinclude template="inc/tab.tag.cfm" />
<!--- end of event tags --->
<cfinclude template="inc/tab.contact.cfm" />


<!--- start of event modal delete venue --->
<cfinclude template="inc/modal.delete_venue.cfm" />
<!--- end of event modal delete venue --->
<!--- start of event modal delete day --->
<cfinclude template="inc/modal.delete_day.cfm" />
<!--- end of event modal delete day --->

</div>			