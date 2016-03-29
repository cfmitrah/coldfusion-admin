<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="/index.cfm">Dashboard</a></li>
  <li class="active">Hotels and Booking</li>
</ol>
<!--// BREAD CRUMBS END //--><div id="action-btns" class="pull-right">
	<a href="#buildURL('hotels.create')#" class="btn btn-lg btn-info">Add New Hotel</a>
	<a href="#buildURL('standardReports.hotelReservationsReport')#" class="btn btn-lg btn-warning">Run Report</a>
</div>
<h2 class="page-title color-03">Event Hotels and Booking</h2>
<p class="page-subtitle">If you have reserved hotel space for attendees registering for this event, you can manage the details here.</p>
<br>
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
			<td rowspan=6>
				<p><a href="#buildURL('hotels.edit')#"><strong>JW Marriott of Austin TX</strong> [edit]</a></p>
				<!--- if address on file --->
				<p>12345 Hotel Address Frederick, MD 21702</p>
				<!--- if phone number on file --->
				<p>(800) 111-2919</p>	
			</td> <!--- rowspan = number of room types being displayed --->
			<td rowspan=3>3/23/2015</td><!---  rowspan = number of room types for reserved for certain date --->
			<td>Single King Bed</td>
			<td>200</td>
			<td>0</td>
			<td>200</td>
		</tr>
		<tr>
			<td>Double Queen Bed</td>
			<td>100</td>
			<td>0</td>
			<td>100</td>
		</tr>
		<tr>
			<td>Luxury Penthouse Sweet</td>
			<td>5</td>
			<td>0</td>
			<td>5</td>
		</tr>
		<tr>
			<td rowspan=3>3/24/2015</td>
			<td>Single King Bed</td>
			<td>100</td>
			<td>0</td>
			<td>100</td>
		</tr>
		<tr>
			<td>Double Queen Bed</td>
			<td>50</td>
			<td>0</td>
			<td>50</td>
		</tr>
		<tr>
			<td>Luxury Penthouse Sweet</td>
			<td>1</td>
			<td>0</td>
			<td>1</td>
		</tr>
	</tbody>
</table>

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
			<td rowspan=4><a href="#buildURL('hotels.edit')#"><strong>Marriott Marquis of Austin TX</strong> [edit]</a></td> <!--- rowspan = number of room types being displayed --->
			<td rowspan=2>3/23/2015</td><!---  rowspan = number of room types for reserved for certain date --->
			<td>Single King Bed</td>
			<td>20</td>
			<td>20</td>
			<td>0</td>
		</tr>
		<tr>
			<td>Single Queen Bed</td>
			<td>50</td>
			<td>50</td>
			<td>0</td>
		</tr>
		<tr>
			<td rowspan=2>3/24/2015</td>
			<td>Single King Bed</td>
			<td>10</td>
			<td>10</td>
			<td>0</td>
		</tr>
		<tr>
			<td>Single Queen Bed</td>
			<td>10</td>
			<td>10</td>
			<td>0</td>
		</tr>
	</tbody>
</table>

</cfoutput>