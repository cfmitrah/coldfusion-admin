<h3 class="form-section-title">Group </h3>
<cfoutput>
<cfif rc.attendee.group.count>
<table class="table">
    <thead>
	    <th>Parent Record</th>
        <th>Email</th>
        <th>Name</th>
        <th>Name</th>
        <th>Total fees</th>
        <th>Total Paid</th>
        <th>Total Discounts</th>
        <th>Total Due</th>
        
        <th>Options</th>
    </thead>
    <tbody>
        <cfloop from="1" to="#rc.attendee.group.count#" index="local.idx">
            <cfset local['attendee'] = rc.attendee.group.data[ local.idx ] />
        <tr class="#( rc.attendee.attendee_id eq local.attendee.attendee_id ? "info":"")#">
	        <td>#yesnoformat( rc.attendee.parent_attendee_id eq local.attendee.attendee_id )#</td>
	        <td>#local.attendee.Email#</td>
	        <td>#local.attendee.first_name# #local.attendee.last_name#</td>
	        <td>#local.attendee.attendee_status#</td>
	        <td>#dollarFormat(local.attendee.total_fees_cancels)#</td>
	        <td>#dollarFormat(local.attendee.total_credits)#</td>
	        <td>#dollarFormat(local.attendee.total_discounts)#</td>
	        <td>#dollarFormat(local.attendee.total_due)#</td>
	        
	        <td>
		        <a href="#buildURL(action:'attendee.manage', queryString:"attendee_id=" & local.attendee.attendee_id)#" class="btn btn-default" >Manage</a>
	        </td>
        </tr>
        </cfloop>
    </tbody>
</table>
</cfif>
</cfoutput>
