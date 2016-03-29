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
			  <li><a href="#">Agenda</a></li>
			  <li class="active">Create Session</li>
			</ol>
			<h2 class="page-title color-02">Create a Session</h2>
			<p class="page-subtitle">To get things going, first fill in the basic information below.</p>
			<div class="row mt-medium">
				<div class="col-md-8">
					<form role="form" class="basic-wrap">
						<div class="form-group">
							<label for="" class="required">Session Name / Title</label>
							<input type="text" class="form-control" id="">
						</div>

						<div class="form-group">
							<label for="">Description <small>- 1 Sentence - S.E.O Purposes</small></label>
							<input type="text" class="form-control" id="">
						</div>
						<div class="form-group">
							<label for="">Summary <small>- 1 or 2 Sentences - S.E.O Purposes</small></label>
							<input type="text" class="form-control" id="">
						</div>
						<div class="form-group">
							<label for="">Overview <small>- Detailed - Viewable by End User</small></label>
							<textarea name="session-overview-text" id="session-overview-text" rows="20">
				            </textarea>
				            <script>
				            	CKEDITOR.replace( 'session-overview-text' );
				            </script>
						</div>
						
						<div class="form-group">
							<label for="" class="required">Hide on Agenda?</label>
							<div class="cf">
								<div class="radio pull-left">
									<label for="visible-yes">
										<input type="radio" name="radio-visible" /> Yes
									</label>
								</div>
								<div class="radio pull-left">
									<label for="visible-no">
										<input type="radio" name="radio-visible" id="visible-no" checked/> No
									</label>
								</div>
							</div>
						</div>
						
						<div class="cf">
							<button type="submit" class="btn btn-success btn-lg pull-right">Everything Look Good? <strong>Create Session!</strong></button>
						</div>
					</form>
				</div>
			</div>
			
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>