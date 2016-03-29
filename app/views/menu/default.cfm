<cfoutput>
<script type="text/javascript" src="http://devmaps.meetingplay.com/assets/js/jquery-1.11.0.min.js?v=1"></script>
<script type="text/javascript" src="http://devmaps.meetingplay.com/assets/js/jqueryui-1.10.3.min.js?v=1"></script>
<ol class="breadcrumb">
	<li><a href="#buildURL( 'dashboard' )#">Dashboard</a></li>
	<li><a href="#buildURL( 'event' )#">Events</a></li>
	<li><a href="#buildURL( action='event.details', queryString='event_id=' & rc.event_id)#">#rc.event_name#</a></li>
	<li class="active">Navigation Preferences</li>
</ol>
<h2 class="page-title color-02">Website Navigation</h2>
<p class="page-subtitle">Manage the order of navigation items for the registration website. You can also specify if you'd like certain pages to be nested in drop downs.</p>
<form id="menus" action="##" class="basic-wrap mt-large">
	<div class="container-fluid">

		<h3 class="form-section-title">Set the Navigation Order and Nesting Preferences</h3>
		<p class="attention"></p>
		<div class="alert alert-info">
					For your sub page to appear on the registration website, you must have it's status set to active and assign it to a link below
				</div>
		<div class="row">
			<div class="col-md-4">
				<ol class="list listsort">
					<!--- You should only be able to remove any external links that were added --->
					<cfloop from="1" to="#rc.menu_cnt#" index="i">
						<cfif rc.menus[i].is_parent>
							<li>
								<div class="clearfix" data-menu_id="#rc.menus[i].menu_id#" data-label="#rc.menus[i].label#" data-link="#rc.menus[i].link#" data-target="#rc.menus[i].target#">
									#rc.menus[i].label#
									<a class="remove pull-right" href="##" ><i class="fa fa-trash-o"></i></a>
									<a class="edit pull-right" href="##" ><i class="fa fa-edit"></i></a>
								</div>
								<ol>
						<cfelse>
							<li>
								<div class="clearfix" data-menu_id="#rc.menus[i].menu_id#" data-label="#rc.menus[i].label#" data-link="#rc.menus[i].link#" data-target="#rc.menus[i].target#">
									#rc.menus[i].label#
									<a class="remove pull-right" href="##" ><i class="fa fa-trash-o"></i></a>
									<a class="edit pull-right" href="##" ><i class="fa fa-edit"></i></a>
								</div>
							</li>
						</cfif>
						<cfif (i + 1 lte rc.menu_cnt and rc.menus[i + 1].is_parent) or i eq rc.menu_cnt>
								</ol>
							</li>
						</cfif>
					</cfloop>
				</ol>
				<a class="save-order btn btn-success btn-block mt-small" href="##">Save Menu Order</a>
			</div>
			<div class="col-md-8">
				<p class="attention"><strong>Using the Navigation Ordering Tool</strong></p>
				<ul class="std-list">
					<li>- Click and hold the navigation item to drag and drop them into the desired order</li>
					<li>- To create a nested navigation item, move it slightly to the right before dropping it in place</li>
					<li>- Nested items will appear indented once placed</li>
					<li>- Nested items will appear as children of the first non-indented link above them</li>
					<li>- Once you are done, press save!</li>
				</ul>

			</div>
		</div>

		<div class="row mt-large">
			<div class="col-md-12">
				<h3 class="form-section-title">Create a New Link</h3>
				
				<input type="hidden" id="menu_id" name="menu.menu_id" value="0" />
				<div class="row">
					<div class="col-md-6">
						<div class="form-group">
							<label for="label">Page Name:</label>
							<input type="text" class="form-control" id="label" name="menu.label" value="" maxlength="300" />
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label for="linkchoice">Choose Page Link:</label>
							<select name="menu.linkchoice" id="linkchoice" class="form-control">
								<option label="Label" value="(no link)">Label</option>
								<option label="External Link" value="external">External Link</option>
								<optgroup label="Internally Created Pages">
									<cfloop from="1" to="#rc.pages_cnt#" index="i">
										<option label="#rc.pages[i].title#" value="#rc.pages[i].slug#">#rc.pages[i].title#</option>
									</cfloop>
								</optgroup>
							</select>
							<input type="hidden" id="internalpagebase" value="http://#rc.event_uri#/pages/">
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-md-6">
						<div class="form-group">
							<label for="link">Link:</label>
							<input type="text" class="form-control" id="link" name="menu.link" value="(no link)" maxlength="500" disabled="disabled"/>
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label for="target">Target:</label>
							<select id="target" name="menu.target" class="form-control">
								<option value="_self">Same Window</option>
								<option value="_blank">New Window</option>
							</select>
						</div>
					</div>
				</div>
				
				
				

				
				<div class="form-group">
					<button type="submit" class="btn btn-success btn-block btn-lg">Add Menu Item</button>
					<button type="reset" class="btn btn-cancel btn-block btn-lg">Cancel</button>
				</div>
				</div>
			</div>
		</div>

	</div>
</form>
<script src="/assets/js/plugins/UI/jquery-ui.js"></script>
</cfoutput>