<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<div id="sidebar">
		<div class="side-section">
			<!--- When a link in a section is active - the following active-caret div should display --->
			<div class="active-caret"></div>
			<h2>Section Name <span class="glyphicon glyphicon-cog color-01"></span></h2>
			<ul>
				<li><a href="">Sample Link One</a></li>
				<li><a href="">Sample Link Two</a></li>
			</ul>
		</div>
		<div class="side-section">
			<h2>Section Name <span class="glyphicon glyphicon-cog color-02"></span></h2>
			<ul>
				<li><a href="">Sample Link One</a></li>
				<li><a href="">Sample Link Two</a></li>
			</ul>
		</div>
		<div class="side-section">
			<h2>Section Name <span class="glyphicon glyphicon-cog color-03"></span></h2>
			<ul>
				<li><a href="">Sample Link One</a></li>
				<li><a href="">Sample Link Two</a></li>
			</ul>
		</div>
		<div class="side-section">
			<h2>Section Name <span class="glyphicon glyphicon-cog color-04"></span></h2>
			<ul>
				<li><a href="">Sample Link One</a></li>
				<li><a href="">Sample Link Two</a></li>
			</ul>
		</div>
		<div class="side-section">
			<h2>Section Name <span class="glyphicon glyphicon-cog color-05"></span></h2>
			<ul>
				<li><a href="">Sample Link One</a></li>
				<li><a href="">Sample Link Two</a></li>
			</ul>
		</div>
	</div>

	<!--- Sidebar Ends Content Starts --->
	<div id="main-content-wrapper" class="has-sidebar">
		<div id="main-content">
			<ol class="breadcrumb">
			  <li><a href="#">Link One</a></li>
			  <li><a href="#">Link Two</a></li>
			  <li class="active">Active Page</li>
			</ol>
			<h2 class="page-title">Page Name</h2>
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>