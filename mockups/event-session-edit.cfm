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
			  <li><a href="#">Sessions</a></li>
			  <li class="active">Session Name</li>
			</ol>
			<h2 class="page-title color-02">This is a sample session name</h2>
			<p class="page-subtitle">Edit specifics related to this session such as details, photos, assets, and more.</p>
			<!-- Nav tabs -->
			<ul class="nav nav-tabs mt-medium" role="tablist">
				<li class="active"><a href="#session-main" role="tab" data-toggle="tab">Main Details</a></li>
				<li><a href="#session-photos" role="tab" data-toggle="tab">Photos</a></li>
				<li><a href="#session-assets" role="tab" data-toggle="tab">Assets</a></li>
			</ul>

			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane active" id="session-main">
					<form action="">
						<h3 class="form-section-title">Main Details</h3>
						<div class="form-group">
							<label for="" class="required">Session Name / Title</label>
							<input type="text" class="form-control" id="">
						</div>

						<div class="form-group">
							<label for="">Description <small>- 250 Characters Max - High Level Summary</small></label>
							<input type="text" class="form-control" id="">
						</div>
						<div class="form-group">
							<label for="">Summary <small>- 1000 Characters Max - S.E.O Purposes</small></label>
							<textarea name="" id="" rows="4" class="form-control"></textarea>
						</div>
						<div class="form-group">
							<label for="">Overview <small>- Details - Viewable by End User</small></label>
							<textarea name="session-overview-text" id="session-overview-text" rows="20">
				            </textarea>
				            <script>
				            	CKEDITOR.replace( 'session-overview-text' );
				            </script>
						</div>
						
						<div class="cf">
							<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Save Main Details</strong></button>
						</div>
					</form>
				</div>
				

				<div class="tab-pane" id="session-photos">
					
					<h3 class="form-section-title">Photos</h3>
					<div class="alert alert-info">Session photos are optional. If you wish to upload or select photos, they will appear in a gallery format near the session overview. Recommended size 500x500 px.</div>

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
					<h4>Selected Session Photos</h4>
					<p>Click manage to change this photos label and add desired tags.</p>
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
									<td>Hotel at Dusk</td>
									<td>DSC_1101.jpg</td>
									<td>54 kb</td>
									<td>
										<span class="label label-default">Photo</span>
										<span class="label label-default">Hotel</span>
										<span class="label label-default">Scenery</span>
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

				<div class="tab-pane" id="session-assets">
					
					<h3 class="form-section-title">Assets</h3>
					<div class="alert alert-info">Assets are optional. If you wish to upload or select assets, they will appear in as downloadable links near the session overview.</div>

					<h4>Upload New Assets</h4>
					<p>Drag files onto the dropzone to upload them. Once uploaded, you can edit specifics in the table below.</p>
					<div class="dropzone">
						<p>DROPZONE PLACEHOLDER</p>
					</div>

					<hr>
					<h4>Choose Existing Assets</h4>
					<p>Click the button below to launch an overlay and select existing assets from your asset library.</p>
					<a href="##" data-toggle="modal" data-target="#asset-library-modal" class="btn btn-primary">Launch Asset Library</a>
					
					<hr>
					<h4>Selected Session Assets</h4>
					<p>Click manage to change this assets label add desired tags, set publish / expiration dates, and more.</p>
					<table id="uploaded-session-assets" class="table table-striped">
						<thead>
							<tr>
								<th>Preview</th>
								<th>Label</th>
								<th>File Type</th>
								<th>Date Uploaded</th>
								<th>Publish Date</th>
								<th>Expiration Date</th>
								<th>Needs Password</th>
								<th>Tags</th>
								<th>Options</th>
							</tr>
						</thead>
						<tbody>
							<cfloop from="1" to="4" index="i">
								<tr>
									<td><img src="//placehold.it/80x80" alt=""></td>
									<td>2014 White Page</td>
									<td>.pdf</td>
									<td>7/30/2014 1:00 PM</td>
									<td class="text-center">
										<span class="glyphicon glyphicon-ok"></span>
									</td>
									<td class="text-center">
										<span class="glyphicon glyphicon-ok"></span>
									</td>
									<td class="text-center">
										<span class="glyphicon glyphicon-ok"></span>
									</td>
									<td>
										<span class="label label-default">New Year</span>
										<span class="label label-default">Important</span>
										<span class="label label-default">Monetize</span>
									</td>
									<td>
										<a href="" class="btn btn-danger btn-sm">Remove</a>
										<a href="" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#asset-manage-modal">Manage</a>
									</td>
								</tr>
							</cfloop>
						</tbody>
					</table>
				</div>

				<div class="tab-pane" id="session-speakers">
					<h3 class="form-section-title">Speakers</h3>
					<h4>Currently Assigned Speakers</h4>
					<table id="speakers-table" class="table table-striped">
						<thead>
							<tr>
								<th>First Name</th>
								<th>Last Name</th>
								<th>Title</th>
								<th>Company</th>
								<th>Email Address</th>
								<th>Options</th>
							</tr>
						</thead>
						<tbody>
							<cfloop from="1" to="2" index="i">
								<tr>
									<td>SampleFirst</td>
									<td>SampleLast</td>
									<td>Web Developer</td>
									<td>MeetingPlay</td>
									<td>info@meetingplay.com</td>
									<td><a href="" class="text-danger"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Remove</strong> </a></td>
								</tr>
							</cfloop>
							
						</tbody>
					</table>
					<hr>
					<h4>Create a New Speaker</h4>
					<p class="attention">If a speaker is not yet in the system, you can create a basic profile for them below.</p>
					<form action="">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label for="">First Name</label>
									<input type="text" class="form-control">
								</div>
								<div class="form-group">
									<label for="">Last Name</label>
									<input type="text" class="form-control">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="">Title</label>
									<input type="text" class="form-control">
								</div>
								<div class="form-group">
									<label for="">Email Address</label>
									<input type="text" class="form-control">
								</div>
							</div>
						</div>
						<div class="cf">
							<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Save New Speaker</strong></button>
						</div>
					</form>
					<hr>

					<h4>Assign an Existing Speaker</h4>
					<p class="attention">Assign an existing speaker to this session by checking their related box in the table below. Once Speaker(s) are selected, click 'save'.</p>
					<form action="">
					<table id="speakers-table" class="table table-striped data-table">
						<thead>
							<tr>
								<th>First Name</th>
								<th>Last Name</th>
								<th>Title</th>
								<th>Company</th>
								<th>Email Address</th>
								<th>Assign</th>
							</tr>
						</thead>
						<tbody>
							<cfloop from="1" to="15" index="i">
								<tr>
									<td>SampleFirst</td>
									<td>SampleLast</td>
									<td>Web Developer</td>
									<td>MeetingPlay</td>
									<td>info@meetingplay.com</td>
									<td class="text-center">
										<input type="checkbox" class="form-control">
									</td>
								</tr>
							</cfloop>
							
						</tbody>
					</table>
					<div class="cf">
							<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Save Marked Speakers</strong></button>
						</div>
					</form>
				</div>

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

<!--- Modal for Managing Normal Asset --->
<div class="modal fade" id="asset-manage-modal" tabindex="-1" role="dialog" aria-labelledby="asset-manage-modal-label" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="asset-manage-modal-label">Asset Management</h4>
			</div>
			<div class="modal-body">
				<p class="attention">Manage this assets details below</p>
				<div class="form-group">
					<label for="">Asset Label</label>
					<input type="text" class="form-control">
				</div>
				<div class="form-group">
					<label for="">Set date to Publish</label>
					<input type="text" class="form-control dateonly-datetime" id="asset_publish">
					<p class="help-block">If you set this field, the asset will not be released to users until the provided date.</p>
				</div>
				<div class="form-group">
					<label for="">Set date to Expire</label>
					<input type="text" class="form-control dateonly-datetime" id="asset_expire">
					<p class="help-block">If you set this field, the asset will not be available past the provided date.</p>
				</div>
				<div class="form-group">
					<label for="">Set Password</label>
					<input type="password" class="form-control">
					<p class="help-block">If you set this field, a password will be required to download the asset.</p>
				</div>
				<div class="form-group">
					<label for="">Photo Tags</label>
					<input type="text" class="form-control">
					<p class="help-block">Seperate multiple tags with a comma. (ex. tag1,tag2,tag3)</p>
				</div>
				<div class="form-group">
					<div class="checkbox">
						<label>
							<input type="checkbox"> <strong>Make Asset Downloadable</strong>
						</label>
					</div>
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