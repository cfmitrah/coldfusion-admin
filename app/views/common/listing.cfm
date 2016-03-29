<cfoutput>
<table id="#( structKeyExists(rc, "table_id") ? rc.table_id : '' )#" class="table table-striped table-hover data-table tm-large" >
	<thead>
	<tr>
		<cfif structKeyExists(rc, "columns")>
			<cfset local.aCols = listToArray( rc.columns ) />
			<cfloop array="#local.aCols#" index="local.col_name">
				<th class="">#local.col_name#</th>
			</cfloop>
		</cfif>		
	</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</cfoutput>