<cfoutput>

<div class="tab-pane active" id="page-main">
	<div class="container-fluid">
		<h3 class="form-section-title">General Page Settings</h3>
		<div class="row">
			<div class="form-group col-md-6">
				<label for="title">Page Name / Title <small>(150 Max Char)</small></label>
				<input type="text" id="title" name="page.title" class="form-control" value="#rc.page.title#" maxlength="150" />
				<p class="help-block">The page name will appear at the top of the created page and as the navigation link.</p>
			</div>
			<div class="form-group col-md-6">
				<label for="slug">Page URL Identifier</label>
				<input type="text" class="form-control disabled" id="slug" name="slug" value="#rc.page.slug#" disabled="disabled" />
				<p class="help-block">The URL Identifier is generated from a slug of the page name</p>
			</div>
			<div class="form-group col-md-12">
				<label for="publish_on">Publish On <small>(optional)</small></label>
				<input type="text" class="form-control" id="publish_on" name="page.publish_on" value="#dateTimeFormat(rc.page.publish_on, 'mm/dd/yyyy h:mm tt')#" />
			</div>
			<div class="form-group col-md-12">
				<label for="expire_on">Expire On <small>(optional)</small></label>
				<input type="text" class="form-control" id="expire_on" name="page.expire_on" value="#dateTimeFormat(rc.page.expire_on, 'mm/dd/yyyy h:mm tt')#" />
			</div>
			<div class="form-group col-md-12">
				<label for="description">Description <small>(250 Max Char)</small></label>
				<input type="text" class="form-control" id="description" name="page.description" maxlength="250" value="#rc.page.description#" />
			</div>
		</div>
		<div class="form-group">
			<label for="active_yes">Active?</label>
			<div class="cf">
				<div class="radio pull-left">
					<label>
						<input name="page.active" id="active_yes" type="radio" value="1" #rc.checked[ rc.page.active eq 1]#> Yes
					</label>
				</div>
				<div class="radio pull-left">
					<label>
						<input name="page.active" type="radio" value="0" #rc.checked[ rc.page.active eq 0]#> No
					</label>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="summary">Summary <small>(1000 Max Char)</small></label>
			<textarea rows="3" cols="50" id="summary" class="form-control" name="page.summary" maxlength="1000">#rc.page.summary#</textarea>
		</div>
		<div class="form-group">
			<label for="tags">Tags <small>Comma-delimited list</small></label>
			<textarea name="page.tags" id="tags" rows="4" class="form-control" maxlength="1000">#rc.page.tag_list#</textarea>
		</div>
		<div class="form-group">
			<label for="active_yes">Hero Graphic</label>
			<div class="cf">
				#rc.page.hero_filename#<span id="hero_graphic_change_to_label"></span>
				<br/>
				<input type="hidden" name="page.hero_graphic_id" id="hero_graphic_id" value="0" />
				<a href="##" data-toggle="modal" data-target="##asset-library-modal" class="btn btn-info">Change Hero Graphic</a>
			</div>
		</div>
		<div class="cf">
			<button type="submit" class="btn btn-success btn-lg"><strong>Save Page</strong></button>
			
		</div>
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
				<div id="media_library_modal" data-single_asset_select="true"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
				<button type="button" class="btn btn-primary" id="btn_use_selected_assets" >Use Selected Asset</button>
			</div>
		</div>
	</div>
</div>
</cfoutput>