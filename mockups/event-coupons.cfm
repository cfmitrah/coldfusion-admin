<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>
<div id="page">
	<cfinclude template="shared/event-sidebar.cfm"/>
	<!--- Sidebar Ends Content Starts --->
	<div id="main-content-wrapper" class="has-sidebar">
		<div id="main-content">
			<ol class="breadcrumb">
				<li><a href="#">Dashboard</a></li>
				<li><a href="#">Events</a></li>
				<li><a href="#">Event Name</a></li>
				<li class="active">Discounts</li>
			</ol>
			<div id="action-btns" class="pull-right">
				<a href="event-coupin-create.cfm" class="btn btn-lg btn-primary">Create New Discount</a>
			</div>
			<h2 class="page-title color-02">Discounts</h2>
			<p class="page-subtitle">Manage and create new discounts for attendees to use during registration.</p>
			<br>
			<div class="container-fluid" id="discounts-legend">
				<div class="row">
					<div class="col-md-4 text-center">
						<span class="label label-primary">Flat Fee</span> - Value is the amount the attendee will pay.
					</div>
					<div class="col-md-4 text-center">
						<span class="label label-success">Deduction</span> - Value is the dollar amount subtracted from total cost.
					</div>
					<div class="col-md-4 text-center">
						<span class="label label-info">Percentage Discount</span> - Value is percentage subtracted from total cost.
					</div>
				</div>
			</div>
			<table id="discounts-table" class="table table-striped data-table">
				<thead>
					<tr>
						<th>Code</th>
						<th>Starts On</th>
						<th>Ends On</th>
						<th>Type</th>
						<th>Value</th>
						<th>Limit</th>
						<th>Times Used</th>
						<th>Status</th>
						<th>Options</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>DKFX92</td>
						<td>9/11/2014</td>
						<td>9/22/2014</td>
						<td><span class="label label-primary">Flat Fee</label></td>
						<td>$100.00</td>
						<td>No Limit</td>
						<td>72</td>
						<td>Active</td>
						<td>
							<a href="event-coupin-edit.cfm" class="btn btn-primary btn-sm">Manage</a>
							<a href="##" class="btn btn-danger btn-sm">Delete</a>
						</td>
					</tr>
					<tr>
						<td>345AS2</td>
						<td>9/11/2014</td>
						<td>9/22/2014</td>
						<td><span class="label label-success">Deduction</label></td>
						<td>-$20.00</td>
						<td>100</td>
						<td>16</td>
						<td>Active</td>
						<td>
							<a href="event-coupin-edit.cfm" class="btn btn-primary btn-sm">Manage</a>
							<a href="##" class="btn btn-danger btn-sm">Delete</a>
						</td>
					</tr>
					<tr>
						<td>FLS0101</td>
						<td>9/11/2014</td>
						<td>9/22/2014</td>
						<td><span class="label label-info">Percentage Discount</label></td>
						<td>-10%</td>
						<td>No Limit</td>
						<td>5</td>
						<td>Inactive</td>
						<td>
							<a href="event-coupin-edit.cfm" class="btn btn-primary btn-sm">Manage</a>
							<a href="##" class="btn btn-danger btn-sm">Delete</a>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
<cfinclude template="shared/footer.cfm"/>