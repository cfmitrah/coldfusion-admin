<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li class="active">Payment Processors</li>
</ol>
<!--// BREAD CRUMBS END //-->

<div id="action-btns" class="pull-right">
	<a href="#buildURL('company.create')#" class="btn btn-lg btn-info">Create New Payment Processor</a>
</div>
<h2 class="page-title color-02">Payment Processors</h2>
<p class="page-subtitle">Select a specific processor below to manage it. Managing an payment processor will let you set it's details.</p>
#view('common/Listing')#
</cfoutput>