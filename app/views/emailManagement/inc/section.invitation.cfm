<cfoutput>
<h3 class="form-section-title mt-large">
	Invitation Emails
	<a href="#buildURL( 'emailManagement.createInvitationEmail' )#" class="btn btn-lg btn-info pull-right">Create New Invitation</a>
</h3>
<table id="#rc.invitation_listing_config.table_id#" class="table table-striped table-hover data-table tm-large" >
	<thead>
	<tr>
		<cfset local.aCols = listToArray( rc.invitation_listing_config.columns ) />
		<cfloop array="#local.aCols#" index="local.col_name">
			<th class="">#local.col_name#</th>
		</cfloop>
	</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</cfoutput>