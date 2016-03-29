<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li class="active">Attendee Settings</li>
</ol>
<!--// BREAD CRUMBS END //-->
<h2 class="page-title color-02">Attendee Settings</h2>
<p class="page-subtitle">Create attendee settings specific to this event. These settings include attendee types, Max number of attendees, group settings, and more.</p>
<!-- Nav tabs -->
<ul class="nav nav-tabs mt-medium" role="tablist">
	<li class="active"><a href="##attendee-types" role="tab" data-toggle="tab">Attendee Types</a></li>
	<!---// JG - This is hidden for now per Lisa //--->
	<li style="display:none;"><a href="##registrant-settings" role="tab" data-toggle="tab">Registrant Settings</a></li>
</ul>

<!-- Tab panes -->
<div class="tab-content">
	<div class="tab-pane active" id="attendee-types">#view( "attendeeSettings/inc/attendee_types" )#</div>
	<div class="tab-pane" id="registrant-settings">#view( "attendeeSettings/inc/registrant_settings" )#</div>
</div>
</cfoutput>