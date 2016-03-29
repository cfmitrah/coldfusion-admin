<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<div id="main-content-wrapper">
		<div id="main-content" class="no-sidebar">
			<ol class="breadcrumb">
			  <li><a href="index.cfm">Dashboard</a></li>
			  <li><a href="">Events</a></li>
			  <li class="active">Create</li>
			</ol>

			<h2 class="page-title">Create a New Event</h2>
			<p class="page-subtitle">To start the process of creating a new event, first fill in the basic information below.</p>
			<div class="row mt-medium">
				<div class="col-md-6">
					<form role="form" class="basic-wrap">
						<div class="form-group">
							<label for="" class="required">Event Name</label>
							<input type="text" class="form-control" id="">
						</div>
						<div class="form-group">
							<label for="" class="required">Domain Name</label>
							<select name="" class="form-control" id="domain-name">
								<option value="hobsons">hobsons</option>
								<option value="sampleone">sampleone</option>
								<option value="sampletwo">sampletwo</option>
							</select>
						</div>
						<div class="form-group">
							<label for="" class="required">URL extension / Event Registration Identifier</label>
							<input type="text" class="form-control" id="extension-input">
							<div class="alert alert-info mt-medium"> 
								Full Domain Name Preview: <br>
								<strong>http://<span id="domain-output">hobsons</span>.meetingplay.com/<span id="slug-output"></span></strong> <br> 
							</div>
							<div class="alert alert-danger">
								<span class="glyphicon glyphicon-exclamation-sign"></span>Once created, the full domain name can not be changed.
							</div>
						</div>
						<!--- <div class="form-group">
							<label for="" class="required">Visibility</label>
							<div class="cf">
								<div class="radio pull-left">
									<label for="visibility-public">
								    	<input type="radio" name="visibility" id="visibility-public" checked>
								    	Public
								  	</label>
								</div>
								<div class="radio pull-left">
									<label for="visibility-private">
								    	<input type="radio" name="visibility" id="visibility-private" class="formShowHide_ctrl" data-show-id="private-yes-box">
								    	Private
								  	</label>
								</div>
							</div>

							<div id="private-yes-box" class="hiddenbox">
								<br>
								<div class="form-group">
									<label for="">Enter Reg. Site Access Code</label>
									<input type="text" class="form-control" placeholder="Numbers and Letters A-Z are allowed">
								</div>
							</div>
							<div class="alert alert-warning mt-xsmall">
								<span class="glyphicon glyphicon-exclamation-sign"></span> Private events will require an access code to view the registration site.
							</div>
						</div>
						<div class="form-group">
							<label for="" class="required">Start Date / Time</label>
			                <input type='text' class="form-control std-datetime width-md" />
			            </div>
						<div class="form-group">
							<label for="" class="required">Is this a virtual conference?</label>
							<div class="cf">
								<div class="radio pull-left">
									<label for="virtual-yes">
										<input type="radio" name="radio-virtual" id="virtual-yes" /> Yes
									</label>
								</div>
								<div class="radio pull-left">
									<label for="virtual-no">
										<input type="radio" name="radio-virtual" id="virtual-no" class="formShowHide_ctrl" data-show-id="virtual-no-box" /> No
									</label>
								</div>
							</div>
						</div>
						<div id="virtual-no-box" class="hiddenbox">
							<div class="form-group">
								<label for="">Country</label>
								<select name="" id="" class="form-control">
									<option value="">United States</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="" class="required">Primary Language</label>
							<select name="" id="" class="form-control">
								<option value="">English</option>
							</select>
						</div>
						<div class="form-group">
							<label for="" class="required">Contact Email Address</label>
							<input type="email" class="form-control" id="">
						</div> --->
						
						<div class="cf">
							<button type="submit" class="btn btn-success btn-lg pull-right">Basics Look Good? <strong>Create Event</strong></button>
						</div>

					</form>
				</div>
			</div>	
		</div>
	</div>
</div>

<script>
	$(function(){
		// Slug Preview Field
		var $slugOutput = $('#slug-output'),
			$extensionInput = $('#extension-input'),
			$domainSelect = $('#domain-name'),
			$domainOutput = $('#domain-output');

		$extensionInput.on('keyup', function(){
			$slugOutput.html( slugify($extensionInput.val() ) );
		});

		$domainSelect.on('change', function(){
			$domainOutput.html( $domainSelect.val() );
		});

	});
</script>

<cfinclude template="shared/footer.cfm"/>