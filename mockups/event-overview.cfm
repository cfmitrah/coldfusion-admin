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
			  <li class="active">Event Name</li>
			</ol>
			<h2 class="page-title color-01">Overview</h2>
			<p class="page-subtitle">Below is a high level glance at the progress that's been made during this event. To manage any section use the navigation on the left.</p>
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>