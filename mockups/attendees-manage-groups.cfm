<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<div id="main-content-wrapper">
		<div id="main-content" class="no-sidebar">
			<ol class="breadcrumb">
			  <li><a href="index.cfm">Dashboard</a></li>
			  <li><a href="">Attendees</a></li>
			  <li class="active">Groups</li>
			</ol>
			<!--- <div id="action-btns" class="pull-right">
				<a href="attendees-create-step-01.cfm" class="btn btn-lg btn-primary">Create New Group</a>
			</div> --->
			
			<h2 class="page-title">Attendee Groups</h2>
			<p class="page-subtitle">Below attendees are categorized by the events they are related too. Groups are also formed from 'tags' which are optional keywords you can use when setting up an events details. Click any group to view it's related attendees.</p>
			<hr>
			<div class="cf">
				<div style="width: 30%; float: left;">
					<h4 class="inline">12 Existing Groups </h4>
				</div>
				<div style="width: 30%; float: left;">
					<p class="inline"><strong>Sort By: &nbsp;</strong>
						<select name="" id="" class="form-control inline" style="width: 70%;">
							<option value="">Alphabetical</option>
							<option value="">Number of Attendees (Ascending)</option>
							<option value="">Number of Attendees (Descending)</option>
							<option value="">Events Only</option>
							<option value="">Tags Only</option>
						</select>
					</p>
				</div>
				<div style="width: 31%; float: right;">
					<input type="text" class="form-control" placeholder="Enter Event Name or Tag to Filter Results...">
				</div>
			</div>
			<hr>
			<div id="groups-tile-wrap" class="cf">
				<div class="tile tile-primary" onclick="javascript:location.href='attendees-group-details.cfm'">
					<div class="tile-header"><strong>Event:</strong> Hobsons University 2014</div>
					<div class="tile-content">216 Attendees</div>
					<div class="tile-footer">View Group</div>
				</div>
				<div class="tile tile-primary" onclick="javascript:location.href='attendees-group-details.cfm'">
					<div class="tile-header"><strong>Keyword:</strong> eCommerce</div>
					<div class="tile-content">1045 Attendees</div>
					<div class="tile-footer">View Group</div>
				</div>
				<div class="tile tile-primary" onclick="javascript:location.href='attendees-group-details.cfm'">
					<div class="tile-header"><strong>Event:</strong> Sample Event Name</div>
					<div class="tile-content">68 Attendees</div>
					<div class="tile-footer">View Group</div>
				</div>
				<div class="tile tile-primary" onclick="javascript:location.href='attendees-group-details.cfm'">
					<div class="tile-header"><strong>Keyword:</strong> HTML5</div>
					<div class="tile-content">753 Attendees</div>
					<div class="tile-footer">View Group</div>
				</div>
				<div class="tile tile-primary" onclick="javascript:location.href='attendees-group-details.cfm'">
					<div class="tile-header"><strong>Event:</strong> Hobsons University 2014</div>
					<div class="tile-content">216 Attendees</div>
					<div class="tile-footer">View Group</div>
				</div>
				<div class="tile tile-primary" onclick="javascript:location.href='attendees-group-details.cfm'">
					<div class="tile-header"><strong>Keyword:</strong> eCommerce</div>
					<div class="tile-content">1045 Attendees</div>
					<div class="tile-footer">View Group</div>
				</div>
				<div class="tile tile-primary" onclick="javascript:location.href='attendees-group-details.cfm'">
					<div class="tile-header"><strong>Event:</strong> Sample Event Name</div>
					<div class="tile-content">68 Attendees</div>
					<div class="tile-footer">View Group</div>
				</div>
				<div class="tile tile-primary" onclick="javascript:location.href='attendees-group-details.cfm'">
					<div class="tile-header"><strong>Keyword:</strong> HTML5</div>
					<div class="tile-content">753 Attendees</div>
					<div class="tile-footer">View Group</div>
				</div>
				<div class="tile tile-primary" onclick="javascript:location.href='attendees-group-details.cfm'">
					<div class="tile-header"><strong>Event:</strong> Hobsons University 2014</div>
					<div class="tile-content">216 Attendees</div>
					<div class="tile-footer">View Group</div>
				</div>
				<div class="tile tile-primary" onclick="javascript:location.href='attendees-group-details.cfm'">
					<div class="tile-header"><strong>Keyword:</strong> eCommerce</div>
					<div class="tile-content">1045 Attendees</div>
					<div class="tile-footer">View Group</div>
				</div>
				<div class="tile tile-primary" onclick="javascript:location.href='attendees-group-details.cfm'">
					<div class="tile-header"><strong>Event:</strong> Sample Event Name</div>
					<div class="tile-content">68 Attendees</div>
					<div class="tile-footer">View Group</div>
				</div>
				<div class="tile tile-primary" onclick="javascript:location.href='attendees-group-details.cfm'">
					<div class="tile-header"><strong>Keyword:</strong> HTML5</div>
					<div class="tile-content">753 Attendees</div>
					<div class="tile-footer">View Group</div>
				</div>
			</div>
			
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>