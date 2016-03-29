<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'pages.default' )#">Registration Site Content</a></li>
  <li class="active">#rc.page.title# Details</li>
</ol>
<!--// BREAD CRUMBS END //--><h2 class="page-title color-03">Manage Page <small>- #rc.page.title#</small></h2>
<ul class="nav nav-tabs mt-medium" role="tablist">
	<li class="active"><a href="##page-main" role="tab" data-toggle="tab">Page Details</a></li>
	<li><a href="##page-body" role="tab" data-toggle="tab">Page Body</a></li>
	<!---<li><a href="##page-media" role="tab" data-toggle="tab">Page Media</a></li>--->
</ul>
<form action="#buildURL('pages.doSave')#" method="post" role="form">
	<input type="hidden" name="page.page_id" value="#rc.page.page_id#" />
	<div id="page" class="tab-content" data-page_id="#rc.page.page_id#">
		<!--- start of details tab --->
		<cfinclude template="inc/tab.details.cfm" />
		<!--- end of details --->
		<!--- start of details tab --->
		<cfinclude template="inc/tab.content.cfm" />
		<!--- end of details --->
		<!--- start of photos --->
		<!---<cfinclude template="inc/tab.media.cfm" />--->
		<!--- end of photos --->
	</div>
</form>
</cfoutput>