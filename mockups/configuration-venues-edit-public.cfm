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
				<a href="#" data-toggle="modal" data-target="#add-location-modal" class="btn btn-lg btn-primary">Add New Location to Venue</a>
			</div>

			<h2 class="page-title color-06">Manage Venue - <small>Staples Center</small></h2>
			<p class="page-subtitle">Add new locations to this venue by clicking the button above.</p>

			<div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> You are viewing a public venue. Because this venue is public you can not manage it's specific details, you can however add locations to it for you to use when scheduling sessions. New locations you add will be available for public use once they've been approved by a moderator.</div>
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-4">
						<h3>Staples Center</h3>
						<h5><a href=""><strong>staplescenter.com</strong></a></h5>
						<p>1111 S. Figueroa Street - Los Angeles, CA 90015</p>
						<p>(914) 253-2000</p>
						<p><span class="label label-success">Public Venue</span></p>
					</div>
					<div class="col-md-8">
						<div class="basic-wrap">
							<h3 class="form-section-title" style="margin-bottom: -15px">Venue Locations</h3>
							<table class="table table-striped table-hover data-table">
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
					</div>
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
				<h4 class="modal-title" id="add-location-modal-label">Add New Location to Staples Center</h4>
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

<cfinclude template="shared/footer.cfm"/>