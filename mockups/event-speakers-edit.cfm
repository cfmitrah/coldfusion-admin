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
			  <li><a href="#">Speakers</a></li>
			  <li class="active">Edit</li>
			</ol>
			<h2 class="page-title color-02">FirstName LastName</h2>

			<h4>Sessions Speaker is Assigned to</h4>
			<table class="table table-striped">
				<thead>
					<tr>
						<th>Session Name</th>
						<th>Options</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>This is a sample session name</td>
						<td><a href="" class="text-danger"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Remove</strong> </a></td>
					</tr>
					<tr>
						<td>This is a sample session name</td>
						<td><a href="" class="text-danger"><span class="glyphicon glyphicon-remove-circle"></span> <strong>Remove</strong> </a></td>
					</tr>
				</tbody>
			</table>
			<a href="#" data-toggle="modal" data-target="#speaker-assign" class="btn btn-primary">Create New Session Assignment</a>
			<br><hr>
			<h4>Manage this speakers information using the form below.</h4>
			
			<hr>
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
						<div class="form-group">
							<label for="">Display Name <small> How you want the name to display to attendees. (ex. Smith, John)</small></label>
							<input type="text" class="form-control">
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label for="">Title</label>
							<input type="text" class="form-control">
						</div>
						<div class="form-group">
							<label for="">Company</label>
							<input type="text" class="form-control">
						</div>
						<div class="form-group">
							<label for="">Email Address</label>
							<input type="text" class="form-control">
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="">Summary <small>1000 Character Max - Used for Preview</small></label>
					<textarea name="" id="" rows="4" class='form-control'></textarea>
				</div>
				<div class="form-group">
					<label for="">Biography</label>
					<textarea name="speaker-bio-text" id="speaker-bio-text" rows="8"></textarea>
		            <script>
		            	CKEDITOR.replace( 'speaker-bio-text' );
		            </script>
				</div>
				<div class="row">
					<div class="col-md-10">
						<div class="form-group">
							<label for="">Photo</label>
							<input type="file" class="form-control">
							<p class="help-block">Recommended Upload size is 500x500. <br>Uploading a new photo will erase the existing one</p>
						</div>
						
					</div>
					<div class="col-md-2">
						<div class="form-group">
							<label for="">Current Photo</label><br>
							<img src="//placehold.it/100x100" width="100" height="100" alt="">
							<a href="#" class="btn btn-small btn-danger" style="margin-top: -60px;"><span class="glyphicon glyphicon-remove"></span></a>
						</div>
					</div>
					
				</div>
				
				
				<div class="cf">
					<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Save Speaker Information</strong></button>
				</div>
			</form>

		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="speaker-assign" tabindex="-1" role="dialog" aria-labelledby="speaker-assign-label" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="speaker-assign-label">Speaker Assignment</h4>
			</div>
			<div class="modal-body">
				<p class="attention">Choose which session you'd like to associate this speaker to below</p>
				<select name="" id="" class="form-control">
					<option value="">Choose Session...</option>
				</select>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
				<button type="button" class="btn btn-primary">Add Selected Session</button>
			</div>
		</div>
	</div>
</div>

<cfinclude template="shared/footer.cfm"/>