
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
				<tr role="row">
					<cfloop from="1" to="#rc.report_data.header_cnt#" index="local.i">
						<th rowspan="1" colspan="1">#replace( rc.report_data.formatted_headers[ local.i ], "_", " ", "ALL" )#</th>
					</cfloop>
				</tr>	
			</thead>
			<tbody>
				<cfloop from="1" to="#rc.report_data.report_data_cnt#" index="local.i">
					<tr>
						<cfloop from="1" to="#rc.report_data.header_cnt#" index="local.k">
							<td>
                                <cfif listFindNocase( "hotel_checkin_date,hotel_checkout_date", rc.report_data.headers[ local.k ] )>
                                    #dateformat( rc.report_data.report_data[ local.i ][ rc.report_data.headers[ local.k ] ], "mm/dd/yyyy" )#
                                <cfelse>
                                    #rc.report_data.report_data[ local.i ][ rc.report_data.headers[ local.k ] ]#        
                                </cfif>
                            </td>
						</cfloop>
					</tr>	
				</cfloop>
			</tbody>
		</table>	
	</div>
</body>
</cfoutput>
</html>	
