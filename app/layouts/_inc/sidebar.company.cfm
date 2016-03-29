<cfoutput>
	<div class="side-section">
	<h2>Companies <span class="glyphicon glyphicon-home color-06"></span></h2>
	<ul>
		<li><a href="#buildURL( 'company.create' )#">Create New Company</a></li>
	</ul>
</div>
<div class="side-section">
	<h2>Users <span class="glyphicon glyphicon-user color-01"></span></h2>
	<ul>
		<li><a href="#buildURL( 'company.details/manage_company_id/' & rc.company_id & '/view_all_users' )#">View All Users</a></li>
		<li><a href="#buildURL( 'company.details/manage_company_id/' & rc.company_id & '/add_new_user' )#">Add New User</a></li>
	</ul>
</div>
<div class="side-section">
	<h2>Media <span class="glyphicon glyphicon-upload color-02"></span></h2>
	<ul>
		<li><a href="#buildURL( 'company.media' )#">View Media Library</a></li>
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