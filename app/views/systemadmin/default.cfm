<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'systemAdmin.default' )#">System Admin</a></li>
  <li class="active">Create New System Admin</li>
</ol>
<!--// BREAD CRUMBS END //-->
<div id="action-btns" class="pull-right">
	<a href="#buildURL('systemadmin.create')#" class="btn btn-lg btn-primary">Create New System Admin</a>
</div>
<h2 class="page-title">System Admin</h2>
<p class="page-subtitle"></p>
#view('common/Listing')#
</cfoutput>