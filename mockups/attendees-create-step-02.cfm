<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<div id="main-content-wrapper">
		<div id="main-content" class="no-sidebar">
			<ol class="breadcrumb">
			  <li><a href="index.cfm">Dashboard</a></li>
			  <li><a href="attendees-index.cfm">Attendees</a></li>
			  <li class="active">Create New Attendee</li>
			</ol>

			<h2 class="page-title">Create New Attendee</h2>
			<p class="page-subtitle">Fill in the following form to create this attendee.</p>
			<div class="alert alert-info"><strong>Note:</strong> The inputs and options appearing below are unique to the registration settings for the event the attendee is associated to.</div>
			
			<div class="form-group">
				<label for="">Which event will this attendee be associated with?</label>
				<select name="" id="" class="form-control" disabled>
					<option value="">Hobsons University 2014</option>
				</select>
			</div>

			
			<!-- Nav tabs -->
			<ul class="nav nav-tabs mt-medium" role="tablist">
				<li class="active"><a href="#tab-general" role="tab" data-toggle="tab">Genearl Information</a></li>
				<li><a href="#tab-contact" role="tab" data-toggle="tab">Contact Information</a></li>
				<li><a href="#tab-custom" role="tab" data-toggle="tab">Miscellaneous Information / Custom Form Fields</a></li>
				<li><a href="#tab-bio" role="tab" data-toggle="tab">Biography</a></li>
			</ul>

			<form action="">

				<!-- Tab panes -->
				<div class="tab-content">
					<div class="tab-pane active" id="tab-general">
						<h3 class="form-section-title">General Information</h3>
						<div class="row">
							<div class="form-group col-md-6">
								<label for="">Email Address</label>
								<input type="email" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Verify Email Address</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Secondary Email Address</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Prefix (Mr. Mrs. etc.)</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">First Name</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Middle Name</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Suffix</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Company / Organization</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Job Title</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Date of Birth</label>
								<input type="date" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Gender</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Emergency Contact Name</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Emergency Contact Phone</label>
								<input type="tel" class="form-control">
							</div>
						</div>
					</div>

					<div class="tab-pane" id="tab-contact">
						<h3 class="form-section-title">Contact Information</h3>
						<div class="row">
							<div class="form-group col-md-6">
								<label for="">Country</label>
								<select name="" id="" class="form-control">
									<option value="">Choose Country...</option>
								</select>
							</div>
							<div class="form-group col-md-6">
								<label for="">Address Line 1</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Address Line 2</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">City</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">State / Region</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Zip / Postal</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Home Phone</label>
								<input type="tel" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Work Phone</label>
								<input type="tel" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Extension</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Fax</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Cell Phone</label>
								<input type="tel" class="form-control">
							</div>
						</div>
					</div>

					<div class="tab-pane" id="tab-custom">
						<h3 class="form-section-title">Miscellaneous Information / Custom Form Fields</h3>
						<div class="row">
							<div class="form-group col-md-6">
								<label for="">Membership Number</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Customer / Client Number</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Keep Profile Private (For in app experience)</label>
								<div class="checkbox">
								    <label>
								      <input type="checkbox"> Yes - Hide this profile from public view
								    </label>
								</div>
							</div>
							<div class="form-group col-md-6">
								<label for="">Last 4 of SSN</label>
								<input type="text" class="form-control">
							</div>
							<div class="form-group col-md-6">
								<label for="">Tax Identifiaction Number</label>
								<input type="text" class="form-control">
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="">Current Photo</label><br>
									<img src="//placehold.it/100x100" width="100" height="100" alt="">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="">Photo</label>
									<input type="file" class="form-control">
									<p class="help-block">Recommended Upload size is 500x500. <br>Uploading a new photo will erase the existing one</p>
								</div>
							</div>
						</div>
					</div>

					<div class="tab-pane" id="tab-bio">
						<div class="form-group">
							<label for="">Biography</label>
							<textarea name="speaker-bio-text" id="speaker-bio-text" rows="8"></textarea>
				            <script>
				            	CKEDITOR.replace( 'speaker-bio-text' );
				            </script>
						</div>
					</div>
				</div>
			</form>
			<br>
			<input type="submit" class="btn btn-lg btn-success" value="Save Attendee Details - All Tabs">
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>