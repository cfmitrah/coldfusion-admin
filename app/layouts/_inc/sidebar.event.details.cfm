<cfoutput>
<div class="side-section">
	<cfif len( rc.sidebar_companies ) >
	<select name="" id="quick-change-company">
		 #rc.sidebar_companies#
	</select>
	</cfif>
	<select name="" id="quick-change-event">
		#rc.company_event_opts#
	</select>

	<!--- <cfset local.prefix = "https" />
	<cfif cgi.SERVER_PORT EQ 80>
		<cfset local.prefix = "http" />
	</cfif>
	<a href="#local.prefix#://#rc.event.details.domain_name#/#rc.event.details.slug#/register/" target="_blank" class="btn btn-block btn-success" style="margin: 5px 0 0 0">View Live Site</a> --->

</div>
<div class="side-section">
	<h2>Construct Event <span class="glyphicon glyphicon-wrench color-02"></span></h2>
	<ul>
		<cfif structkeyexists( rc, 'event_id' )>
			<li><a href=" #buildURL( 'event.details?event_id=' & rc.event_id )#">Main Details</a></li>
		</cfif>
		<li><a href="#buildURL( 'attendee' )#" class="">Attendee List</a></li>
		<li><a href="#buildURL( 'attendeesettings.default' )#">Attendee Settings</a></li>
		<li><a href="#buildURL( 'sessions.default' )#">Sessions</a></li>
		<li><a href="#buildURL( 'speakers.default' )#">Speakers</a></li>
		<li><a href="#buildURL( 'agendas.default' )#">Agenda</a></li>
		<li><a href="#buildURL( 'coupons.default' )#">Coupons</a></li>
		<!--- <li><a href="##">Staff</a></li> --->
	</ul>
</div>
<div class="side-section">
	<h2>Construct Reg. Website <span class="glyphicon glyphicon-tasks color-03"></span></h2>
	<ul>
		<li><a href="#buildURL( 'registration.settings' )#">Standard Form Fields</a></li>
		<li><a href="#buildURL( 'registration.settings?tab=login-fields' )#">Login Fields</a></li>
		<li><a href="#buildURL( 'registration.settings?tab=custom-fields' )#">Custom Form Fields</a></li>
		<li><a href="#buildURL( 'registration.settings?tab=hotel-fields' )#">Hotel Reservation Fields</a></li>
		<li><a href="#buildURL( 'registration.settings?tab=field-dependencies' )#" class="">Field Dependencies</a></li>
		<li><a href="#buildURL( 'hotels.default' )#">Hotel Reservations</a></li>
		<li><a href="#buildURL( 'registration.forms' )#">Forms and Form Sections</a></li>
		<li><a href="#buildURL( 'pages.default' )#">Sub Pages</a></li>
		<li><a href="#buildURL( 'menu.default' )#">Sub Pages Navigation</a></li>
		<li><a href="#buildURL( 'websiteThemes.default' )#">Theme</a></li>
		<li><a href="#buildURL( 'websiteLayout.default' )#">Layout</a></li>
	</ul>
</div>
<div class="side-section">
	<h2>Email Management <span class="glyphicon glyphicon-envelope color-04"></span></h2>
	<ul>
		<li><a href="#buildURL( 'emailManagement.default' )#" class="">View All Emails</a></li>
		<!--- <li><a href="#buildURL( 'emailManagement.emailDefaults' )#" class="">Configure Defaults</a></li> --->
		<li><a href="#buildURL( 'emailManagement.emailTool' )#" class="">Sending Tool</a></li>
		<li><a href="#buildURL( 'emailManagement.emailReminders' )#" class="">Email Reminders</a></li>
	</ul>
</div>
<div class="side-section">
	<h2>Reporting <span class="glyphicon glyphicon-signal color-01"></span></h2>
	<ul>
		<li><a href=" #buildURL( 'dashboard.default' )#">At a Glance</a></li>
		<li><a href="#buildURL( 'standardReports.default' )#" class="">Standard Reporting</a></li>
		<li><a href="#buildURL( 'customReports.default' )#" class="">Custom Reporting</a></li>
		<li><a href="#buildURL( 'scheduledReports.default' )#" class="">Scheduled Reporting</a></li>
		<li><a href="#buildURL( 'clientReports.default' )#" class="">Client Reporting</a></li>
	</ul>
</div>
<div class="side-section">
	<h2>Miscellaneous <span class="glyphicon glyphicon-th color-05"></span></h2>
	<ul>
		<li><a href="#buildURL( 'company.media' )#" class="">Media Library</a></li>
		<li><a href="#buildURL( 'event.copy' )#" class="">Copy Event</a></li>
	</ul>
</div>
</cfoutput>