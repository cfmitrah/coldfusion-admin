<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'sessions.default' )#">Sessions</a></li>
  <li class="active">#rc.session_details.details.title# Details</li>
</ol>
<!--// BREAD CRUMBS END //-->
<h2 class="page-title color-02">Session: #rc.session_details.details.title#</h2>
<p class="page-subtitle">Edit specifics related to this session such as schedules, details, fees, and more.</p>
<!-- Nav tabs -->
<ul class="nav nav-tabs mt-medium" role="tablist">
	<li class="active"><a href="##session-main" role="tab" data-toggle="tab">Main Details</a></li>
	<li class=""><a href="##session-details" role="tab" data-toggle="tab">Photos</a></li>
	<li class=""><a href="##session-assets" role="tab" data-toggle="tab">Assets</a></li>
	<li class=""><a href="##session-speakers" role="tab" data-toggle="tab">Speakers</a></li>
</ul>
<!-- Tab panes -->
<div class="tab-content">
	<div class="tab-pane active" id="session-main">
		<cfinclude template="inc/main.cfm" >
	</div>

	<div class="tab-pane" id="session-details">
		<cfinclude template="inc/photos.cfm" >
	</div>

	<div class="tab-pane" id="session-assets">
		<cfinclude template="inc/assets.cfm" >
	</div>

	<div class="tab-pane" id="session-speakers">
		<cfinclude template="inc/speakers.cfm" >
	</div>

</div>
<!--- start of asset library modal --->
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
				<div id="media_library_modal"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
				<button type="button" class="btn btn-primary" id="btn_use_selected_assets" data-session_id="#rc.session_id#" >Use Selected Assets</button>
			</div>
		</div>
	</div>
</div>
<!--- start of asset library modal --->
<!--- start of asset modal --->
<div class="modal fade" id="asset-manage-modal" tabindex="-1" role="dialog" aria-labelledby="asset-manage-modal-label" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="asset-manage-modal-label">Asset Management</h4>
			</div>
			<div class="modal-body">
				<input type="hidden" id="asset_media_id" />
				<p class="attention">Manage this assets details below</p>
				<div class="form-group">
					<label for="">Asset Label</label>
					<input type="text" class="form-control" id="asset_label" maxlength="200" />
				</div>
				<div class="form-group">
					<label for="">Set date to Publish</label>
					<input type="text" class="form-control dateonly-datetime" id="asset_publish" />
					<p class="help-block">If you set this field, the asset will not be released to users until the provided date.</p>
				</div>
				<div class="form-group">
					<label for="">Set date to Expire</label>
					<input type="text" class="form-control dateonly-datetime" id="asset_expire" />
					<p class="help-block">If you set this field, the asset will not be available past the provided date.</p>
				</div>
				<div class="form-group">
					<label for="">Tags</label>
					<input type="text" class="form-control" id="asset_tags" />
					<p class="help-block">Seperate multiple tags with a comma. (ex. tag1,tag2,tag3)</p>
				</div>
				 <div class="form-group">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox"  id="asset_downloadable" value="1" />  <strong>Make Asset Downloadable</strong>
                        </label>
                    </div>
                </div>
				<div class="form-group">
					<label for="">Set Password</label>
					<input type="password" class="form-control" id="asset_password" />
					<p class="help-block">If you set this field, a password will be required to download the asset.</p>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
				<button type="button" class="btn btn-success" id="btn_save_media">Save Asset Details</button>
			</div>
		</div>
	</div>
</div>
<!--- end of asset modal --->
</cfoutput>