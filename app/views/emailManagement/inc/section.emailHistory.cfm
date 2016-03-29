<cfoutput>
<table id="#rc.email_history_listing.table_id#" class="table table-striped table-hover data-table tm-large" >
	<thead>
	<tr>
		<cfset local.aCols = listToArray( rc.email_history_listing.columns ) />
		<cfloop array="#local.aCols#" index="local.col_name">
			<th class="">#local.col_name#</th>
		</cfloop>
	</tr>
	</thead>
	<tbody>
	</tbody>
</table>

</cfoutput>