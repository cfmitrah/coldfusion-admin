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
			  <li class="active">Session Check In's</li>
			</ol>
			<h2 class="page-title color-05">Session Checkin's</h2>
			<p class="page-subtitle">View which attendees have checked into any specific session by clicking a session in the table below</p>
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>