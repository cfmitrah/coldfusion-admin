<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li class="active">System User</li>
</ol>
<!--// BREAD CRUMBS END //-->
<div id="action-btns" class="pull-right">	
	<a href="#buildURL('system.user')#" class="btn btn-lg btn-info">Create New User</a>
</div>
<h2 class="page-title color-02">System Users</h2>
<p class="page-subtitle">Select a specific user below to manage it.</p>

<table id="users" class="table table-striped table-hover data-table tm-large" ></table>
</cfoutput>