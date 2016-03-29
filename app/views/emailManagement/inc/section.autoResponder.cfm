<cfoutput>
<h3 class="form-section-title mt-large">System Generated Emails
	<a href="#buildURL( 'emailManagement.selectAutoResponderTypes' )#" class="btn btn-lg btn-info pull-right">Create New System Generated Email</a>
</h3>
<table id="#rc.auto_responder_listing_config.table_id#" class="table table-striped table-hover data-table tm-large" >
	<thead>
	<tr>
		<cfset local.aCols = listToArray( rc.auto_responder_listing_config.columns ) />
		<cfloop array="#local.aCols#" index="local.col_name">
			<th class="">#local.col_name#</th>
		</cfloop>
	</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</cfoutput>