<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="/index.cfm">Dashboard</a></li>
  <li class="active">Hotels and Booking</li>
</ol>
<!--// BREAD CRUMBS END //--><div id="action-btns" class="pull-right">
	<a href="#buildURL('hotels.edit')#" class="btn btn-lg btn-info">Add New Hotel</a>
	<a href="#buildURL('standardReports.hotelReservationsReport')#" class="btn btn-lg btn-warning">Run Report</a>
</div>
<h2 class="page-title color-03">Event Hotels and Booking</h2>
<p class="page-subtitle">If you have reserved hotel space for attendees registering for this event, you can manage the details here.</p>
<br>

<cfloop from="1" to="#rc.booked_rooms.count#" index="local.hotel_idx">
	<cfset local['hotel'] = rc.booked_rooms.hotels[local.hotel_idx]/>
<table class="table table-bordered">
	<thead>
		<tr class="info">
			<th style="width: 300px;">Hotel Name</th>
			<th style="width: 140px;">Check-In</th>
			<th>Room Type</th>
			<th style="width: 170px;">Num. Rooms Reserved</th>
			<th style="width: 170px;">Num. Rooms Booked</th>
			<th style="width: 170px;">Num. Rooms Available</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td rowspan="#local.hotel.total_room_count#">
				<p><a href="#buildURL(action:"hotels.edit", queryString:"hotel_id=" & local.hotel.hotel_id )#"><strong>#local.hotel.hotel_name#</strong> [edit]</a></p>
				<!--- if address on file --->
				<p>#local.hotel.address_1#, #listLast( local.hotel.region_code, "-" )# #local.hotel.postal_code#</p>
				<!--- if phone number on file --->
				<p>#local.hotel.phone_number#</p>	
			</td> <!--- rowspan = number of room types being displayed --->
			<cfloop from="1" to="#local.hotel.dates.count#" index="local.date_idx">
				<cfset local['block_date'] = local.hotel.dates.data[local.date_idx]/>
				<td rowspan="#local.block_date.room_types.count#">#local.block_date.block_date#</td><!---  rowspan = number of room types for reserved for certain date --->
				<cfloop from="1" to="#local.block_date.room_types.count#" index="local.room_idx">
					<cfset local['room'] = local.block_date.room_types.data[local.room_idx]/>
					<td>#local.room.room_type#</td>
					<td>#local.room.rooms_allocated#</td>
					<td>#local.room.rooms_booked#</td>
					<td>#local.room.room_available#</td>
				<cfif local.room_idx neq local.block_date.room_types.count>
				</tr>
				</cfif>
				</cfloop>
				</tr>
			</cfloop>
		
	</tbody>
</table>
</cfloop>
</cfoutput>
