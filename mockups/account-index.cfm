<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<div id="sidebar">
		<div class="side-section">
			<!--- When a link in a section is active - the following active-caret div should display --->
			<div class="active-caret"></div>
			<h2>Overview <span class="glyphicon glyphicon-dashboard color-01"></span></h2>
			<ul>
				<li><a href="account-index.cfm" class="active">Overview</a></li>
			</ul>
		</div>
		<div class="side-section">
			<h2>Users <span class="glyphicon glyphicon-user color-02"></span></h2>
			<ul>
				<li><a href="account-users.cfm">View All</a></li>
				<li><a href="account-users-create.cfm">Create New</a></li>
			</ul>
		</div>
		<div class="side-section">
			<h2>Packages <span class="glyphicon glyphicon-briefcase color-03"></span></h2>
			<ul>
				<li><a href="account-packages.cfm">Overview</a></li>
			</ul>
		</div>
		<div class="side-section">
			<h2>Billing <span class="glyphicon glyphicon-usd color-04"></span></h2>
			<ul>
				<li><a href="account-billing.cfm">Overview</a></li>
			</ul>
		</div>
	</div>
		
	</div>
	<div id="main-content-wrapper" class="has-sidebar">
		<div id="main-content">
			<ol class="breadcrumb">
			  <li><a href="index.cfm">Dashboard</a></li>
			  <li class="active">Company</li>
			</ol>

			<h2 class="page-title color-01">Company Overview</h2>
			<!--- <p class="page-subtitle">Account Management</p> --->
			
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>