<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'systemAdmin.default' )#">System Admin</a></li>
  <li class="active">Cache Management</li>
</ol>
<!--// BREAD CRUMBS END //--><h2 class="page-title color-06">Cache Management</h2>
<p class="page-subtitle">Select an Event to manage its caches.  Note that only events that contain an active cache are shown.</p>
<form id="cache" action="#buildURL('systemadmin.cache')#" method="post" role="form" class="basic-wrap mt-medium">
	<div class="container-fluid">
		<h3 class="form-section-title">Events w/ Cache</h3>
		<div class="row">
			<div class="col-md-12">
				<div class="form-group">
					<label for="event_cache_key">Events</label>
					<select class="form-control width-sm" name="event_cache_key" id="event_cache_key"><option value="">[ Select a Cache ]</option>#rc.event_caches#</select>
				</div>
			</div>
			<div class="col-md-12">
				<div class="form-group">
					<button type="submit" class="btn btn-success btn-lg"><strong>Get Cache</strong></button>
				</div>
			</div>
		</div>
		<cfif rc.looked_up>
			<div class="row">
				<div class="col-md-12">
					<div class="form-group wrapper">
						<label for="method">Caches</label>
						<cfif rc.event_cache.key_cnt>
							<table class="table table-striped" style="font-size: .8em;">
								<thead>
									<tr>
										<th>&nbsp;</th>
										<th>Key</th>
										<th>Created</th>
										<th>Hits</th>
										<th>Misses</th>
										<th>Size</th>
										<th>TTL</th>
										<th>Expires</th>
										<th>View</th>
									</tr>
								</thead>
								<tbody>
									<cfloop from="1" to="#rc.event_cache.key_cnt#" index="i">
										<tr>
											<td><a class="remove" href="##" data-key="#rc.event_cache.keys[i].key#"><i class="fa fa-trash-o"></i></td>
											<td align="left">#rc.event_cache.keys[i].key#</td>
											<td>#rc.event_cache.keys[i].createdtime#</td>
											<td>#rc.event_cache.keys[i].hitcount#</td>
											<td>#rc.event_cache.keys[i].cache_misscount#</td>
											<td>#numberFormat(rc.event_cache.keys[i].size)# bytes</td>
											<td>#rc.event_cache.keys[i].timespan# min</td>
											<td>#rc.event_cache.keys[i].expires#</td>
											<td><a href="#buildURL('systemadmin.viewCache?cache_key=' & rc.event_cache.keys[i].key)#" target="_blank">View</a></td>
										</tr>
									</cfloop>
								</tbody>
							</table>
						<cfelse>
							<p class="alert alert-warning"><i class="fa fa-exclamation-triangle"></i> The selected event Cache is currently empty. <button type="button" class="close" data-dismiss="alert">x</button></p>
						</cfif>
					</div>
					<a class="purge btn btn-danger" href="##" data-key="#rc.event_cache_key#">Purge All Event Keys</a>
				</div>
			</div>
		</cfif>
	</div>
</form>
</cfoutput>