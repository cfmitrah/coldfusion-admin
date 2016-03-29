<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<cfinclude template="shared/config-sidebar.cfm"/>
	<div id="main-content-wrapper" class="has-sidebar">
		<div id="main-content">
			<ol class="breadcrumb">
			  <li><a href="index.cfm">Dashboard</a></li>
			  <li class="active">Venues</li>
			</ol>
			<div id="action-btns" class="pull-right">
				<a href="configuration-venues-create.cfm" class="btn btn-lg btn-info">Create New Venue</a>
			</div>

			<h2 class="page-title color-06">Venues</h2>
			<h3>Venues, typically hotels, are the locations in which an event can be hosted.</h3>
			<p class="page-subtitle">In this section you can add venues and sub locations to choose from when setting up events and scheduling sessions.</p>
			
			<!--- <div class="well">
				<span class="label label-success" style="display: inline-block; width: 80px;"> public</span>&nbsp; venues allow anybody contribute to the sub location list. Sub locations consist of conference rooms, dining halls, and other locations you'd typically schedule a session to. <br><br>
				<span class="label label-danger" style="display: inline-block; width: 80px;"> private</span>&nbsp; venues are only viewable and accessible by members of your company.
			</div> --->

			<table class="table table-striped table-hover data-table tm-large">
				<thead>
					<tr>
						<th>Venue Name</th>
						<th>Website</th>
						<th>Address</th>
						<th>Contact Number</th>
						<th># Sub Locations</th>
						<th>Photos</th>
						<th>Options</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Staples Center</td>
						<td><a href="">Visit</a></td>
						<td>1111 S. Figueroa Street - Los Angeles, CA 90015</td>
						<td>n/a</td>
						<td>36</td>
						<td><span class="glyphicon glyphicon-ok"></span></td>
						<td><a href="configuration-venues-edit-private.cfm" class="btn btn-primary btn-sm">View Venue</a></td>
					</tr>
					<tr>
						<td>PepsiCo Headquarters</td>
						<td><a href="">Visit</a></td>
						<td>PepsiCo, Inc. 700 Anderson Hill Road - Purchase, NY 10577</td>
						<td>(914) 253-2000</td>
						<td>12</td>
						<td><span class="glyphicon glyphicon-ok"></span></td>
						<td><a href="configuration-venues-edit-private.cfm" class="btn btn-primary btn-sm">View Venue</a></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>