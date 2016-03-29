<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li class="active">Registration Site Content</li>
</ol>
<!--// BREAD CRUMBS END //--><div id="action-btns" class="pull-right">
	<a href="#buildURL('pages.create')#" class="btn btn-lg btn-info">Create New Page</a>
</div>
<h2 class="page-title color-03">Registration Site Content</h2>
<p class="page-subtitle">Here you can manage the landing page of your registration website, as well as add and edit sub pages.</p>
#view("common/listing")#
</cfoutput>