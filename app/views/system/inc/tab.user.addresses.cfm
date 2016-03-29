<cfoutput>
<div class="tab-pane" id="user-addresses">
	<h3 class="form-section-title">Addresses</h3>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Aaddress Line 1</th>
				<th>City</th>
				<th>Postal Code</th>
				<th>Options</th>
			</tr>
		</thead>
		<tbody>
		<cfloop from="1" to="#rc.user.addresses.count#" index="local.idx">
			<cfset local['address'] = rc.user.addresses.data[ local.idx ] />
			<tr>
				<td>#local.address.address_1#</td>
				<td>#local.address.city#</td>
				<td>#local.address.postal_code#</td>
				<td><a href="" class="btn btn-danger"><span class="glyphicon glyphicon-remove-circle"></span> Remove</a></td>
			</tr>
		</tbody>
		</cfloop>
	</table>
	<!---
		ADDRESS_1	ADDRESS_2	ADDRESS_ID	ADDRESS_TYPE	CITY	COUNTRY_CODE	LATITUDE	LONGITUDE	POSTAL_CODE	REGION_CODE	VERIFIED
	--->
</div>
</cfoutput>