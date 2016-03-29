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
					<th>First Name</th>
					<th>Last Name</th>
					<th>Email</th>
					<cfloop from="1" to="#rc.report_headers_cnt#" index="local.i">
						<th>#rc.fn_set_headers( rc.report_headers[ local.i ], {}, rc.selected_agenda_ids )#</th>
					</cfloop>	
				</tr>	
			</thead>
			<tbody>
				<cfloop from="1" to="#rc.report_results_cnt#" index="local.k">
					<tr>
						<td>#rc.report_results[ local.k ][ 'first_name' ]#</td>
						<td>#rc.report_results[ local.k ][ 'last_name' ]#</td>
						<td>#rc.report_results[ local.k ][ 'email' ]#</td>
						<cfloop from="1" to="#rc.report_columns_cnt#" index="local.j">
							<td>#rc.fn_set_columns( rc.report_results[ local.k ][ rc.report_columns[ local.j ] ], rc.report_columns[ local.j ] )#</td>
						</cfloop>
					</tr>	
				</cfloop>	
			</tbody>	
		</table>	
	</div>
</body>
</cfoutput>
</html>	

