<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'pages.default' )#">Registration Site Content</a></li>
  <li class="active">Create Page</li>
</ol>
<!--// BREAD CRUMBS END //--><h2 class="page-title color-03">Create a Page</h2>
<p class="page-subtitle">To begin, fill in the basic information below about the page.</p>
<form id="page" action="#buildURL('pages.doCreate')#" method="post" role="form" class="basic-wrap">
	<div class="row">
		<div class="form-group col-md-6">
			<label for="title">Page Name / Title <small>(150 Max Char)</small></label>
			<input type="text" id="title" name="page.title" class="form-control" maxlength="150" />
			<p class="help-block">The page name will appear at the top of the created page and as the navigation link.</p>
		</div>
		<div class="form-group col-md-6">
			<label for="slug">Page URL Identifier</label>
			<input type="text" class="form-control disabled" id="slug" name="slug" disabled="disabled" />
			<p class="help-block">The URL Identifier is generated from a slug of the page name</p>
		</div>
	</div>
	<div class="cf">
		<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Create Page</strong></button>
	</div>
</form>
</cfoutput>