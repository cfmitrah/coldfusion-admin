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
			  <li><a href="#">Sessions</a></li>
			  <li class="active">Create Session</li>
			</ol>
			<h2 class="page-title color-02">Create a Session</h2>
			<p class="page-subtitle">Fill in the details below to get started. After adding basic information, you can associate photos, assets, and more to this session.</p>
			<div class="row mt-medium">
				<div class="col-md-12">
					<form role="form" class="basic-wrap">
						<div class="form-group">
							<label for="" class="required">Session Name / Title</label>
							<input type="text" class="form-control" id="">
						</div>

						<div class="form-group">
							<label for="">Description <small>- 1 Sentence - High Level Summary</small></label>
							<input type="text" class="form-control" id="">
						</div>
						<div class="cf">
							<button type="submit" class="btn btn-success btn-lg pull-right"><strong>Create Session</strong></button>
						</div>
					</form>
				</div>
			</div>
			
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>