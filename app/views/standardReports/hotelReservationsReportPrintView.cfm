<cfset request.layout = false>
<cfset local['col_cnt'] = arrayLen( rc.report_config.aoColumns ) />
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
		<table cellspacing="0" summary="">
			<thead>
				<tr role="row">
					<cfloop from="1" to="#local.col_cnt#" index="local.i">
						<th >#rc.report_config.aoColumns[ local.i ].sTitle#</th>
					</cfloop>
				</tr>	
			</thead>
			<tbody>
				<cfloop from="1" to="#rc.report_cnt#" index="local.i">
					<tr>
						<cfloop from="1" to="#local.col_cnt#" index="local.k">
							<cfset local['field_name'] = rc.report_config.aoColumns[ local.k ].data />
							<cfset local['field_value'] = rc.report[ local.i ][ local.field_name ] />
							<td>
                                <cfif listFindNocase( "hotel_checkin_date,hotel_checkout_date", local.field_name )>
                                    #dateformat( local.field_value, "mm/dd/yyyy" )#
                                <cfelse>
                                    #local.field_value#
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