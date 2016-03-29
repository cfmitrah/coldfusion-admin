<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL('agendas.default')#">Agenda</a></li>
  <li class="active">Agenda Grouping Rules</li>
</ol>
<div id="action-btns" class="pull-right"> 
	<a href="##" data-toggle="modal" data-target="##add-grouping" class="btn btn-lg btn-info">Add New Grouping</a>
</div>
<h2 class="page-title color-02">Agenda Grouping Rules</h2>
<p class="page-subtitle">
	Here is where you can set several agenda items into a group, where one or more must be chosen to continue on the agenda during registration.
</p>


<h3 class="form-section-title mt-medium">Manage Existing Groupings</h3>

<!--- Matt turn this into a data table yo --->
<table class="table table-striped table-hover mt-medium">
	<thead>
		<tr>
			<th>Group Name</th>
			<th>Min. Num Selections Required</th>
			<th>Contained Agenda Items</th>
			<th>Options</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Sample group name</td>
			<td>2</td>
			<td>Agenda Item 1, Agenda Item 2, Agenda Item 3, Agenda Item 4</td>
			<td>
				<a href="##" class="btn btn-sm btn-danger">Remove Grouping</a>
			</td>
		</tr>
		<tr>
			<td>Sample group name Dos</td>
			<td>3</td>
			<td>Agenda Item 1, Agenda Item 2, Agenda Item 3, Agenda Item 4</td>
			<td>
				<a href="##" class="btn btn-sm btn-danger">Remove Grouping</a>
			</td>
		</tr>
	</tbody>
</table>


<!--- start of delete fee modal --->
<cfinclude template="inc/modal.add-grouping.cfm" />
<!--- end of delete fee modal --->
</cfoutput>

