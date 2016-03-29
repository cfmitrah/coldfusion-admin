<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li class="active">Company</li>
</ol>
<!--// BREAD CRUMBS END //-->

<div id="action-btns" class="pull-right">
	<a href="#buildURL('company.create')#" class="btn btn-lg btn-info">Create New Company</a>
</div>
<h2 class="page-title color-02">Companies</h2>
<p class="page-subtitle">Select a specific company below to manage it. Managing an company will let you set it's details.</p>
#view('common/Listing')#
</cfoutput>