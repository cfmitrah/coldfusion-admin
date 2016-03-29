<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<cfinclude template="shared/event-sidebar.cfm"/>

	<!--- Sidebar Ends Content Starts --->
	<div id="main-content-wrapper" class="has-sidebar">
		<div id="main-content">
			<ol class="breadcrumb">
			  <li><a href="#">Dashboard</a></li>
			  <li><a href="#">Events</a></li>
			  <li><a href="#">Event Name</a></li>
			  <li class="active">Attendee Settings</li>
			</ol>
			<h2 class="page-title color-02">Attendee Settings</h2>
			<p class="page-subtitle">Create attendee settings specific to this event. These settings include attendee types, Max number of attendees, group settings, and more.</p>
			<!-- Nav tabs -->
			<ul class="nav nav-tabs mt-medium" role="tablist">
				<li class="active"><a href="#attendee-types" role="tab" data-toggle="tab">Attendee Types</a></li>
				<li><a href="#capacity-settings" role="tab" data-toggle="tab">Capacity Settings</a></li>
				<li><a href="#group-registration" role="tab" data-toggle="tab">Group Registration</a></li>
				<li><a href="#registrant-settings" role="tab" data-toggle="tab">Registrant Settings</a></li>
			</ul>

			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane active" id="attendee-types">...</div>
				<div class="tab-pane" id="capacity-settings">...</div>
				<div class="tab-pane" id="group-registration">...</div>
				<div class="tab-pane" id="registrant-settings">...</div>
			</div>
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>