<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'company.default' )#">Company</a></li>
  <li class="active">Media</li>
</ol>
<!--// BREAD CRUMBS END //-->
<h2 class="page-title color-02">Company Media Library</h2>
<p class="page-subtitle">Drag and drop media below.</p>
<div class="has_dropzone" data-company_id="#rc.company_id#"></div>
#view("common/listing")#
</cfoutput>