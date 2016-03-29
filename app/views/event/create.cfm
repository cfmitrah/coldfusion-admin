<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li class="active">Create</li>
</ol>
<!--// BREAD CRUMBS END //-->
<h2 class="page-title">Create a New Event</h2>
<p class="page-subtitle">To start the process of creating a new event, first fill in the basic information below.</p>
<div class="row mt-medium">
	<div class="col-md-6">
		<form action="#buildURL('event.doCreate')#" role="form" class="basic-wrap" method="post">
			<input type="hidden" name="event.company_id" value="#rc.company_id#" />
			<div class="form-group">
				<label for="" class="required">Event Name</label>
				<input type="text" name="event.name" class="form-control" id="name">
			</div>
			<div class="form-group">
				<label for="domain-name" class="required">Domain Name</label>
				
				<select name="event.domain_id" class="form-control" id="domain-name">
					<option value="0">Select A Domain</option>
					#rc.domain_opts#
				</select>
			</div>
			<div class="form-group">
				<label for="extension-input" class="required">URL extension / Event Registration Identifier</label>
				<input type="text" name="event.slug" class="form-control" id="extension-input" disabled="disabled">
				<div class="alert alert-info mt-medium"> 
					Full Domain Name Preview: <br>
					<strong>http://<span id="domain-output"></span>/<span id="slug-output"></span></strong> <br> 
				</div>
				<div class="alert alert-danger">
					<span class="glyphicon glyphicon-exclamation-sign"></span>Once created, the full domain name can not be changed.
				</div>
			</div>
			
			<div class="cf">
				<button type="submit" class="btn btn-success btn-lg pull-right">Basics Look Good? <strong>Create Event</strong></button>
			</div>

		</form>
	</div>
</div>	
</cfoutput>