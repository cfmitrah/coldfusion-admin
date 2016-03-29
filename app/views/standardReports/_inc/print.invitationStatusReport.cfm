
<!DOCTYPE html>
<html>
<head>
<title></title>
<style type="text/css">
    *{
        font-family: verdana, arial, sans-serif ;
        font-size: 12px ;
	    
    }
    body {
        font-family: verdana, arial, sans-serif ;
        font-size: 12px ;
        }

    th,
    td {
        padding: 4px 4px 4px 4px ;
        text-align: center ;
        }

    th {
        border-bottom: 2px solid #333333 ;
        }

    td {
        border-bottom: 1px dotted #999999 ;
        }

    tfoot td {
        border-bottom-width: 0px ;
        border-top: 2px solid #333333 ;
        padding-top: 20px ;
        }

</style>
</head>
<cfoutput>
<body>
	<div>
		<table            
			cellspacing="0"
            summary="">

			<thead>
				<tr>
					<th>Company</th>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Email</th>
					<th>Viewed</th>
					<th>Status</th>
					<th>Event Name</th>
					<th>Invitation Label</th>
					<th>Sent Date</th>
				</tr>	
			</thead>
			<tbody>
				<cfloop from="1" to="#rc.report_cnt#" index="local.i">
					<tr>
						<td>#rc.report[ local.i ].company_name#</td>
						<td>#rc.report[ local.i ].first_name#</td>
						<td>#rc.report[ local.i ].last_name#</td>
						<td>#rc.report[ local.i ].email#</td>
						<td>#rc.report[ local.i ].viewed ? 'Yes' : 'No'#</td>
						<td>#rc.report[ local.i ].registered#</td>
						<td>#rc.report[ local.i ].event_name#</td>
						<td>#rc.report[ local.i ].invitation_label#</td>
						<td>#rc.report[ local.i ].sent_date#</td>
					</tr>	
				</cfloop>		
			</tbody>	
		</table>	
	</div>
</body>
</cfoutput>
</html>	
