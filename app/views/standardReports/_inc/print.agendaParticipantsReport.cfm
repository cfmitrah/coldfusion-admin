
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
					<th>Agenda Label</th>
					<th>Session Title</th>
					<th>Attendee Status</th>
					<th>Company</th>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Agenda Start Date</th>
					<th>Agenda Start Time</th>
					<th>Registration Date</th>
					<th>Registration Types</th>
					<th>Location</th>
					<th>Category</th>
				</tr>	
			</thead>
			<tbody>
				<cfloop from="1" to="#rc.report_cnt#" index="local.i">
					<tr>
						<td>#rc.report[ local.i ].label#</td>
						<td>#rc.report[ local.i ].title#</td>
						<td>#rc.report[ local.i ].attendee_status#</td>
						<td>#rc.report[ local.i ].company#</td>
						<td>#rc.report[ local.i ].first_name#</td>
						<td>#rc.report[ local.i ].last_name#</td>
						<td>#dateFormat( rc.report[ local.i ].start_time, "MM/DD/YYYY" )#</td>
						<td>#timeFormat( rc.report[ local.i ].start_time, "h:mm TT" )#</td>
						<td>#rc.report[ local.i ].registration_timestamp#</td>
						<td>#rc.report[ local.i ].registration_type#</td>
						<td>#rc.report[ local.i ].location_name#</td>
						<td>#rc.report[ local.i ].category#</td>
					</tr>	
				</cfloop>		
			</tbody>	
		</table>	
	</div>
</body>
</cfoutput>
</html>	

