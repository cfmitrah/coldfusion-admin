<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<cfinclude template="shared/event-sidebar.cfm"/>

	<!--- Sidebar Ends Content Starts --->
	<div id="main-content-wrapper" class="has-sidebar">
		<div id="main-content">
			<ol class="breadcrumb">
			  <li><a href="#">Dashboard</a></li>
			  <li><a href="#">Events</a></li>
			  <li><a href="#">Event Name</a></li>
			  <li><a href="#">Site Content</a></li>
			  <li class="active">Create New Page</li>
			</ol>
			<h2 class="page-title color-02">Create New Page</h2>
			<p class="page-subtitle">Fill in the content below to create the page</p>
			<form action="" class="basic-wrap">
				<div class="container-fluid">
					<h3 class="form-section-title">General Page Settings</h3>
					<div class="row">
						<div class="form-group col-md-6">
							<label for="">Page Name <small>(25 Max Char)</small></label>
							<input type="text" id="page-name" class="form-control">
							<p class="help-block">The page name will appear at the top of the created page and as the navigation link.</p>
						</div>
						<div class="form-group col-md-6">
							<label for="">Page URL Identifier</label>
							<input type="text" class="form-control disabled" id="extension-output" disabled>
							<p class="help-block">The URL Identifier is generated from a slug of the page name</p>
						</div>
						<div class="form-group col-md-12">
							<label for="">Page Description <small>(250 Max Char)</small></label>
							<input type="text" class="form-control">
							<p class="help-block">Optional copy that will appear underneath the page name. </p>
						</div>
					</div>
					<h3 class="form-section-title">Page Content</h3>
					<div class="row">
						<div class="form-group col-md-12">
							<label for="">Below you can insert text, photos, tables, lists and more.</label>
							<textarea class="ckeditor" id="page-content-texarea" name="page-content-texarea" rows="20"></textarea>
						</div>
					</div>
					<div class="cf">
						<button type="submit" class="btn btn-success btn-lg"><strong>Create Page</strong></button>
					</div>
				</div>
				
				
				
				
			</form>
		</div>
	</div>

</div>

<script>
	$(function(){
		// Slug Preview Field
		var $pageName = $('#page-name'),
			$domainOutput = $('#extension-output');

		$pageName.on('keyup', function(){
			$domainOutput.val( slugify($pageName.val() ) );
		});

		CKEDITOR.replace("page-content-texarea",
		{
		     height: 500
		});
		

	});
</script>

<cfinclude template="shared/footer.cfm"/>