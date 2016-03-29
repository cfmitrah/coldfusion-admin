
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
					<th>Registration ID</th>
					<th>Company</th>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Amount</th>
					<th>Detail Name</th>
					<th>Payment Type</th>
					<th>Description</th>
				</tr>	
			</thead>
			<tbody>
				<cfloop from="1" to="#rc.report_cnt#" index="local.i">
					<tr>
						<td>#rc.report[ local.i ].registration_id#</td>
						<td>#rc.report[ local.i ].company#</td>
						<td>#rc.report[ local.i ].first_name#</td>
						<td>#rc.report[ local.i ].last_name#</td>
						<td>#dollarFormat( rc.report[ local.i ].amount )#</td>
						<td>#rc.report[ local.i ].payment_type#</td>
						<td>#rc.report[ local.i ].description#</td>
					</tr>	
				</cfloop>		
			</tbody>	
		</table>	
	</div>
</body>
</cfoutput>
</html>	
