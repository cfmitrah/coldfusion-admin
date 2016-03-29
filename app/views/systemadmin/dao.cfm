<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'systemAdmin.default' )#">System Admin</a></li>
  <li class="active">DAO Generator</li>
</ol>
<!--// BREAD CRUMBS END //--><h2 class="page-title color-06">DAO Generator</h2>
<p class="page-subtitle">Utility to generate ColdFusion Method DAO shells based on a stored procedure.</p>
<form action="#buildURL('systemadmin.dao')#" method="post" role="form" class="basic-wrap mt-medium">
	<input type="hidden" name="venue_id" value="0" />
	<div class="container-fluid">
		<h3 class="form-section-title">DAO Generator</h3>
		<div class="row">
			<div class="col-md-12">
				<div class="form-group">
					<label for="procedure">Stored Procedures</label>
					<select class="form-control width-sm" name="procedure" id="procedure">#rc.procs.opts#</select>
				</div>
			</div>
			<div class="col-md-12">
				<div class="form-group">
					<button type="submit" class="btn btn-success btn-lg"><strong>Get Procedure</strong></button>
				</div>
			</div>
		</div>
		<cfif rc.rendered>
			<div class="row">
				<div class="col-md-12">
					<div class="form-group">
						<label for="method">Stored Procedure Definition</label>
						<textarea name="method" id="method" rows="20" class="form-control">#rc.detail.definition#</textarea>
					</div>
				</div>
				<div class="col-md-12">
					<div class="form-group">
						<label for="method">Parameters</label>
						<table class="table table-striped">
							<thead>
								<tr>
									<th>##</th>
									<th>Param</th>
									<th>Data Type</th>
									<th>Max Length</th>
									<th>Precision</th>
									<th>Scale</th>
									<th>Output</th>
									<th>Default</th>
								</tr>
							</thead>
							<tbody>
								<cfloop from="1" to="#rc.detail.parameter_cnt#" index="i">
									<tr>
										<td>#rc.detail.parameters[i].parameter_id#</td>
										<td>#rc.detail.parameters[i].param#</td>
										<td>#rc.detail.parameters[i].data_type#</td>
										<td>#rc.detail.parameters[i].max_length#</td>
										<td>#rc.detail.parameters[i].precision#</td>
										<td>#rc.detail.parameters[i].scale#</td>
										<td>#yesNoFormat( rc.detail.parameters[i].is_output )#</td>
										<td>
											<cfif rc.detail.parameters[i].has_default_value>
												#rc.detail.parameters[i].default#
											<cfelse>
												N/A
											</cfif>
										</td>
									</tr>
								</cfloop>
							</tbody>
						</table>
					</div>
				</div>
				<div class="col-md-12">
					<div class="form-group">
						<label for="method">DAO</label>
						<textarea name="method" id="method" rows="20" class="form-control">#rc.dao_method#</textarea>
					</div>
				</div>
			</div>
		</cfif>
		<div class="row">
			<div class="col-md-12">

			</div>
		</div>
	</div>
</form>
</cfoutput>