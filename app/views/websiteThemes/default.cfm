<cfoutput>
	<!--// BREAD CRUMBS START //-->
	<ol class="breadcrumb">
	  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
	  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
	  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
	  <li class="active">Site Theme</li>
	</ol>
	<!--// BREAD CRUMBS END //-->
	<div id="action-btns" class="pull-right">
		<a href="http://#rc.event_details.domain_name#/#rc.event_details.slug#/register/?preview=1" target="_blank" class="btn btn-warning btn-lg">View Live Site</a>
		<a href="##" id="preview-theme-btn" class="btn btn-info btn-lg"><strong>Preview Your Theme Here</strong></a>
	</div>
	<h2 class="page-title color-02">Registration Site Theme</h2>
	<p class="page-subtitle">Here you can manage the colors and images of your registration website.</p>
	<div class="row">
		<div class="col-md-6">
			<div class="alert alert-info"><strong>Click the button above to preview your theme as you build!</strong></div>
		</div>
		<div class="col-md-6">
			<div class="alert alert-danger"><strong>Don't forget to save by clicking the green button at the bottom!</strong></div>
		</div>
	</div>
	

	<!--- <div class="alert alert-info">
		Once you save a theme you can view it at: <br>
		<a href="http://#rc.event_details.domain_name#/#rc.event_details.slug#/register/?preview=1" target="_blank">
			<strong>http://<span id="domain-output">#rc.event_details.domain_name#</span>/<span id="slug-output">#rc.event_details.slug#/register/</span>?preview=1</strong>
		</a> 
	</div> --->
	<!--- <ul class="nav nav-tabs mt-medium" role="tablist" id="theme-tabs">
		<li class="#rc.active_class[ rc.tab eq "themes" ]#"><a href="##themes" role="tab" data-toggle="tab">Theme Roller</a></li>
		<li class="#rc.active_class[ rc.tab eq "edit-theme" ]#"><a href="##edit-theme" role="tab" data-toggle="tab">Edit Current Theme</a></li> --->
		<!--- <li class="#rc.active_class[ rc.tab eq "css-upload" ]#"><a href="##css-upload" role="tab" data-toggle="tab">Upload Custom CSS</a></li> --->
	<!--- </ul> --->
	
	<!--- <div class="tab-content" id="theme-wrapper">
		<div class="tab-pane #rc.active_class[ rc.tab eq "themes" ]#" id="themes">
			<cfinclude template="inc/themes.cfm" />
		</div>
		<div class="tab-pane #rc.active_class[ rc.tab eq "edit-theme" ]#" id="edit-theme"> --->
			<cfinclude template="inc/edit.cfm" />
		<!--- </div> --->
		<!--- 
		<div class="tab-pane #rc.active_class[ rc.tab eq "css-upload" ]#" id="css-upload">
			<form action="#buildURL("websiteThemes.doCSSUpload")#" method="post">
				<div class="row">
					<div class="form-group col-md-6">
						<label for="">Developer CSS upload</label>
						<input name="css_file_upload" id="css_file_upload" type="file" class="form-control" />
						<p class="help-block"></p>
					</div>
				</div>
			</form>
		</div>
		 --->
	</div>

	<cfinclude template="inc/modals.cfm" />
</cfoutput>