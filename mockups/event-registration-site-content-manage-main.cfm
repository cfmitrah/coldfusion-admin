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
			  <li class="active">Manage Page</li>
			</ol>
			<div id="action-btns" class="pull-right">
				<a href="##" class="btn btn-lg btn-info">Preview Saved Changes</a>
			</div>
			<h2 class="page-title color-02">Manage Registration Landing Page</h2>
			<p class="page-subtitle">The first page of your registration website viewable to the public which will contain the registration form and essential event details.</p>
			<form action="" class="basic-wrap mt-medium">
				<div class="container-fluid">
					<h3 class="form-section-title">General Page Settings</h3>
					<div class="row">
						<!--- Dev Callout: Hero Graphic Text / Location / Dates / Time should be prepopulated from the construct events details section --->
						<div class="form-group col-md-12">
							<label for="">Hero Graphic - <small>A 1000 x 300 graphic which captures the attendees attention. (Typically the resort or location an event is being hosted at) </small></label>
							<input type="file" class="form-control">
							<p class="help-block"><strong>No image on file.</strong> <span class="text-danger"><em>Uploading a new image will remove the current one.</em></span></p>
						</div>
						<div class="form-group col-md-12">
							<label for="">Hero Graphic Text - <small>Text will overlay the bottom of the header graphic. (Typically '2014 Your Conference Name Registration')</small></label>
							<input type="text" class="form-control">
						</div>
						<div class="form-group col-md-6">
							<label for="">Location Copy - <small>Appears under hero graphic on registration site.</small></label>
							<input type="text" class="form-control">
						</div>
						<div class="form-group col-md-6">
							<label for="">Dates and Times Copy - <small>Appears under hero graphic on registration site.</small></label>
							<input type="text" class="form-control">
						</div>
						
					</div>

					<h3 class="form-section-title">Event Overview</h3>
					<div class="row">
						<div class="form-group col-md-12">
							<label for="">Below you can insert text, photos, tables, lists and more. <small>Should be the most need to know information about the event.</small></label>
							<textarea class="ckeditor" id="page-content-texarea" name="page-content-texarea" rows="20"></textarea>
						</div>
					</div>
					<div class="cf">
						<button type="submit" class="btn btn-success btn-lg"><strong>Save Page</strong></button>
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