<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<cfinclude template="shared/config-sidebar.cfm"/>
	<div id="main-content-wrapper" class="has-sidebar">
		<div id="main-content">
			<ol class="breadcrumb">
			  <li><a href="index.cfm">Dashboard</a></li>
			  <li class="active">Configuration</li>
			</ol>
			<div id="action-btns" class="pull-right">
				<a href="configuration-url-management.cfm" class="btn btn-lg btn-primary">Manage URL's</a>
			</div>

			<h2 class="page-title color-01">Configuration Overview</h2>
			<p class="page-subtitle">Here is where you can manage global settings for your events such as layouts, themes, and more.</p>
			
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>