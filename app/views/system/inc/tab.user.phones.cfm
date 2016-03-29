<cfoutput>
<div class="tab-pane" id="user-phones">
	<h3 class="form-section-title">Phones</h3>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Phone Number</th>
				<th>Type</th>
				<th>Ext.</th>
				<th>Options</th>
			</tr>
		</thead>
		<tbody>
		<cfloop from="1" to="#rc.user.phone_numbers.count#" index="local.idx">
			<cfset local['phone'] = rc.user.phone_numbers.data[ local.idx ] />
			<tr>
				<td>#local.phone.phone_number#</td>
				<td>#local.phone.phone_type#</td>
				<td>#local.phone.extension#</td>
				<td>
					<a href="#local.phone.phone_id#" class="btn btn-danger"><span class="glyphicon glyphicon-remove-circle"></span> Remove</a>
					<a href="#local.phone.phone_id#" class="btn btn-primary">Manage</a>
				</td>
			</tr>
		</tbody>
		</cfloop>
	</table>
</div>
</cfoutput>