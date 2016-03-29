<cfoutput>

<div class="side-section">
	<cfif len( rc.sidebar_company_list ) >
	<select name="" id="quick-change-company-details">
		 #rc.sidebar_company_list#
	</select>
	</cfif>
</div>
<div class="side-section">
	<h2>Companies <span class="glyphicon glyphicon-home color-05"></span></h2>
	<ul>
		<li><a href="#buildURL( 'company.create' )#">Create New Company</a></li>
	</ul>
</div>

<div class="side-section">
	<h2>Users <span class="glyphicon glyphicon-user color-01"></span></h2>
	<ul>
		<li><a href="##" id="sidebar_view_all_users">View All Users</a></li>
		<li><a href="##" id="sidebar_add_new_users">Add New User</a></li>
	</ul>
</div>
<div class="side-section">
	<h2>Venues <span class="glyphicon glyphicon-map-marker color-03"></span></h2>
	<ul>
		<li><a href="#buildURL( 'venues.default' )#">View All Venues</a></li>
		<li><a href="#buildURL( 'venues.create' )#">Create New Venue</a></li>
	</ul>
</div>
<div class="side-section">
	<h2>Billing / Payment <span class="glyphicon glyphicon-lock color-04"></span></h2>
	<ul>
		<li><a href="#buildURL( 'company.billing' )#" class="">Details</a></li>
		<li><a href="#buildURL( 'company.billingContact' )#" class="">Billing Contact</a></li>
	</ul>
</div>
</cfoutput>