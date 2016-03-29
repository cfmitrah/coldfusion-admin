<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<cfinclude template="shared/config-sidebar.cfm"/>
	<div id="main-content-wrapper" class="has-sidebar">
		<div id="main-content">
			<ol class="breadcrumb">
			  <li><a href="index.cfm">Dashboard</a></li>
			  <li><a href="configuration-venues.cfm">Venues</a></li>
			  <li class="active">Edit Venue</li>
			</ol>
			<div id="action-btns" class="pull-right">
				<a href="#" data-toggle="modal" data-target="#add-location-modal" class="btn btn-lg btn-info">Add New Location to Venue</a>
			</div>

			<h2 class="page-title color-06">Manage Venue <small>- Pepsico Headquarters</small></h2>
			<p class="page-subtitle">Add new locations to this venue by clicking the button above.</p>

			<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> This venue is currently a private listing accessible by your company only. Because this venue is still private you can manage venue specific details such as the address and venue name.</div>

			<ul class="nav nav-tabs mt-medium" role="tablist">
				<li class="active"><a href="#venue-main" role="tab" data-toggle="tab">Main Details</a></li>
				<li><a href="#venue-locations" role="tab" data-toggle="tab">Location Listing</a></li>
				<li><a href="#venue-photos" role="tab" data-toggle="tab">Venue Photos</a></li>
			</ul>

			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane active" id="venue-main">
					<form action="" role="form">
						<div class="container-fluid">
							<h3 class="form-section-title">Main Details</h3>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="" class="required">Venue Name</label>
										<input type="text" class="form-control">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="">Website URL</label>
										<input type="text" class="form-control">
									</div>
								</div>
								<!--- <div class="col-md-12">
									<div class="form-group">
										<label for="" class="required">Display</label>
										<select name="" id="" class="form-control">
											<option value="">Public</option>
											<option value="">Private</option>
										</select>
										<p class="help-block">Public venues can be used by all event planners. If set to private, this venue will only be viewable and accessible by your company. <a href="">Click here for more info.</a></p>
									</div>
								</div> --->
							</div>

							<div class="row">
								<div class="form-group col-md-6">
									<label for="" class="required">Address Line 1</label>
									<input type="text" class="form-control">
								</div>
								<div class="form-group col-md-6">
									<label for="">Address Line 2</label>
									<input type="text" class="form-control">
								</div>
								<div class="form-group col-md-6">
									<label for="" class="required">City</label>
									<input type="text" class="form-control">
								</div>
								<div class="form-group col-md-6">
									<label for="" class="required">State / Region</label>
									<input type="text" class="form-control">
								</div>
								<div class="form-group col-md-6">
									<label for="" class="required">Zip / Postal</label>
									<input type="text" class="form-control">
								</div>
								<div class="form-group col-md-6">
									<label for="">Contact Number</label>
									<input type="tel" class="form-control">
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<button type="submit" class="btn btn-success btn-lg"><strong>Save Venue Details</strong></button>
								</div>
							</div>
						</div>

					</form>
				</div>

				<div class="tab-pane" id="venue-locations">
					<h3 class="form-section-title">Venue Locations</h3>
					
					<p class="help-block">To add a new location, by click the "Add New Location to Venue" button in the top right.</p>
					<div class="containter-fluid">
						<div class="row">
							<div class="col-md-12">
								<table class="table table-striped table-hover">
									<thead>
										<tr>
											<th>Location Name</th>
										</tr>
									</thead>
									<tbody>
										<cfoutput>
										<cfloop from="1" to="30" index="i">
											<tr>
												<td>West Foyer Conference Room Number #i#0A</td>
											</tr>
										</cfloop>
										</cfoutput>
									</tbody>
								</table>
							</div>
							<div class="col-md-4">
								
							</div>
						</div>
					</div>
					
				</div>
				<div class="tab-pane" id="venue-photos">
					<h3 class="form-section-title">Photos</h3>
					<p class="help-block">Venue photos are optional. If you wish to upload or select photos, a gallery will be available for use on the registration site showcasing this venue. Recommended Size is 500x500</p>

					<h4>Upload New Photos</h4>
					<p>Drag photos onto the dropzone to upload them. Once uploaded, you can edit specifics in the table below.</p>
					<div class="dropzone">
						<p>DROPZONE PLACEHOLDER</p>
					</div>

					<hr>
					<h4>Choose Existing Photos</h4>
					<p>Click the button below to launch an overlay and select existing photos from your asset library.</p>
					<a href="##" data-toggle="modal" data-target="#asset-library-modal" class="btn btn-primary">Launch Asset Library</a>
					<hr>
					<p class="help-block">Click manage to change this photos label and add desired tags.</p>
					<table id="uploaded-session-photos" class="table table-striped">
						<thead>
							<tr>
								<th>Photo Preview</th>
								<th>Photo Label</th>
								<th>File Name</th>
								<th>File Size</th>
								<th>Tags</th>
								<th>Options</th>
							</tr>
						</thead>
						<tbody>
							<cfloop from="1" to="4" index="i">
								<tr>
									<td><img src="//placehold.it/100x100" alt=""></td>
									<td>Pepsico Headquarters Ariel Shot</td>
									<td>DSC_1101.jpg</td>
									<td>54 kb</td>
									<td>
										<span class="label label-default">Photo</span>
										<span class="label label-default">Venue</span>
										<span class="label label-default">Ariel</span>
									</td>
									<td>
										<a href="" class="btn btn-danger btn-sm">Remove</a>
										<a href="" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#asset-manage-photo-modal">Manage</a>
									</td>
								</tr>
							</cfloop>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="add-location-modal" tabindex="-1" role="dialog" aria-labelledby="add-location-modal-label" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="add-location-modal-label">Add New Location to Pepsico Headquarters</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label for="">Location Name</label>
					<input type="text" class="form-control">
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
				<button type="button" class="btn btn-success">Add Location</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal For Asset Library -->
<div class="modal fade" id="asset-library-modal" tabindex="-1" role="dialog" aria-labelledby="asset-library-modal-label" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="asset-library-modal-label">Asset Library</h4>
			</div>
			<div class="modal-body">
				<p class="attention">Click any asset to mark it for upload. Tagged assets can be search for using the field below.</p>
				<input type="text" id='quick-asset-search' class="form-control" placeholder="Filter assets by tags...">
				<p style="font-weight: bold; padding-top: 10px;"><span id="filter-count"></span></p>
				<cfloop from="1" to="40" index="i">
					<div class="asset-item">
						<img src="//placehold.it/80x80" alt="" class="thumb">
						<h4>This is a sample asset label</h4>
						<p><strong>File Type:</strong> .jpg</p>
						<p><strong>Tags:</strong> <span class="label label-default">Sample Tag One</span> <span class="label label-default">Sample Tag Two</span></p>
						<span class="glyphicon glyphicon-ok"></span>
					</div>
				</cfloop>
					<div class="asset-item">
						<img src="//placehold.it/80x80" alt="" class="thumb">
						<h4>Testing the Filter Outside the Loop</h4>
						<p><strong>File Type:</strong> .jpg</p>
						<p><strong>Tags:</strong> <span class="label label-default">Dog</span> <span class="label label-default">Cat</span></p>
						<span class="glyphicon glyphicon-ok"></span>
					</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
				<button type="button" class="btn btn-success">Use Selected Assets</button>
			</div>
		</div>
	</div>
</div>

<!--- Modal for Managing Photo Asset --->
<div class="modal fade" id="asset-manage-photo-modal" tabindex="-1" role="dialog" aria-labelledby="asset-manage-photo-modal-label" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="asset-manage-photo-modal-label">Photo Management</h4>
			</div>
			<div class="modal-body">
				<p class="attention">Manage this photos details below</p>
				<div class="form-group">
					<label for="">Photo Label:</label>
					<input type="text" class="form-control">
				</div>
				<div class="form-group">
					<label for="">Photo Tags:</label>
					<input type="text" class="form-control">
					<p class="help-block">Seperate multiple tags with a comma. (ex. tag1,tag2,tag3)</p>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
				<button type="button" class="btn btn-success">Save Asset Details</button>
			</div>
		</div>
	</div>
</div>
<script>
$(function(){
	// asset library selected item state
	$('.asset-item').on('click', function(){
		$(this).toggleClass('selected');
	});
	// asset search
	$("#quick-asset-search").keyup(function(){
 
        // Retrieve the input field text and reset the count to zero
        var filter = $(this).val(), count = 0;
 
        // Loop through the comment list
        $(".asset-item").each(function(){
 
            // If the list item does not contain the text phrase fade it out
            if ($(this).text().search(new RegExp(filter, "i")) < 0) {
                $(this).fadeOut();
 
            // Show the list item if the phrase matches and increase the count by 1
            } else {
                $(this).show();
                count++;
            }
        });
 
        // Update the count
        var numberItems = count;
        $("#filter-count").text("Number of Results = "+count);
    });
});
</script>

<cfinclude template="shared/footer.cfm"/>
