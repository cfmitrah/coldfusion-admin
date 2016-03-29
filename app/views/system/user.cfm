<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'system.users' )#">Users</a></li>
  <li class="active">#rc.user.label# Details</li>
</ol>
<!--// BREAD CRUMBS END //-->
<h2 class="page-title color-02">#rc.user.label#</h2>
<p class="page-subtitle">Edit specifics related to this user.</p>

<ul class="nav nav-tabs mt-medium" role="tablist">
	<li class="active"><a href="##user-details" role="tab" data-toggle="tab">Main Details</a></li>
	<cfif rc.user.user_id>
	<li><a href="##user-password" role="tab" data-toggle="tab">Password</a></li>
	<li><a href="##user-events" role="tab" data-toggle="tab" id="user_events_tab">Events</a></li>
	<!---todo: add these back in at a later date
	<li><a href="##user-addresses" role="tab" data-toggle="tab">Addresses</a></li>
	<li><a href="##user-phones" role="tab" data-toggle="tab">Phones</a></li>
	--->
	</cfif>
</ul>


<div class="tab-content">

<cfinclude template="inc/tab.user.details.cfm" />
<cfif rc.user.user_id>
	<cfinclude template="inc/tab.user.password.cfm" />
	<cfinclude template="inc/tab.user.events.cfm" />
	<!---todo: add these back in at a later date
	<cfinclude template="inc/tab.user.addresses.cfm" />
	<cfinclude template="inc/tab.user.phones.cfm" />
	--->
</cfif>
</div>
</cfoutput>
<!---
	<cfdump var="#rc.user#">
	--->