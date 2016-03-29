<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'company.default' )#">Company</a></li>
  <li class="active">Select Company</li>
</ol>
<!--// BREAD CRUMBS END //-->
<div class="row mt-medium">
	<div class="col-md-6">
		<form role="form" class="basic-wrap" method="post" action="#buildURL("company.doSelect")#">
			<div class="form-group">
				<label for="">Companies</label>
				<select name="company.select" id="company_select" class="form-control chosen-select">
					<cfloop from="1" to="#rc.user_companies.count#" index="local.i">
						<option value="#rc.user_companies.companies[local.i].company_id#">#rc.user_companies.companies[local.i].company_name#</option>
					</cfloop>
				</select>
			</div>
			<div class="cf">
				<button type="submit" class="btn btn-info btn-lg pull-right">Select!</button>
			</div>
		</form>
	</div>
</div>
</cfoutput>
