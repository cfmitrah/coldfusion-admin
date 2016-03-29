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
			  <li><a href="#">Speakers</a></li>
			  <li class="active">Create</li>
			</ol>
			<h2 class="page-title color-02">Create a Speaker</h2>

			<p class="page-subtitle">To begin, fill in the basic information below about the speaker.</p>
			<form action="" role="form" class="basic-wrap">
				<div class="form-group">
					<label for="">First Name</label>
					<input type="text" class="form-control">
				</div>
				<div class="form-group">
					<label for="">Last Name</label>
					<input type="text" class="form-control">
				</div>
				<div class="form-group">
					<label for="">Display Name <small> How you want the name to display to attendees. (ex. Smith, John)</small></label>
					<input type="text" class="form-control">
				</div>
				<div class="cf">
					<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Create Speaker</strong></button>
				</div>
			</form>
			

		</div>
	</div>
</div>


<cfinclude template="shared/footer.cfm"/>