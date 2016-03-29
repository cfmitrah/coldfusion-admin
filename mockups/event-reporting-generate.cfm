<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<div id="main-content-wrapper">
		<div id="main-content" class="no-sidebar">
			<ol class="breadcrumb">
			  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
			  <li><a href="">Events</a></li>
			  <li><a href="">Event Name</a></li>
			  <li><a href="event-reporting.cfm">Reporting</a></li>
			  <li class="active">Registration List</li>
			</ol>
			<div id="action-btns" class="pull-right">
				<a href="" class="btn btn-lg btn-default">Print View</a>
				<a href="" class="btn btn-lg btn-info">Export to Excel</a>
				<a href="" class="btn btn-lg btn-warning">Export to PDF</a>
			</div>

			<h2 class="page-title color-06">Registration List Report</h2>
			
			<p><strong>Registration Types included:</strong> General, Sponsor, V.I.P</p>
			<p><strong>Account Balance Preferences:</strong> Show all attendees</p>
			<p><strong>Registration Date Range:</strong> All dates</p>
			<div class="alert alert-danger">Dev Note: Dynamic data table based on options would be generated here. We would show the options based on which report it is above like the sample provided</div>
			

			
			
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>