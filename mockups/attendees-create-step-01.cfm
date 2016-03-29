<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<div id="main-content-wrapper">
		<div id="main-content" class="no-sidebar">
			<ol class="breadcrumb">
			  <li><a href="index.cfm">Dashboard</a></li>
			  <li><a href="attendees-index.cfm">Attendees</a></li>
			  <li class="active">Create New Attendee</li>
			</ol>

			<h2 class="page-title">Create New Attendee</h2>
			<p class="page-subtitle">First please select the event that this attendee will be associated with.</p>
			<form action="attendees-create-step-02.cfm" class="basic-wrap">
				<div class="form-group">
					<label for="" class="required">Which event will this attendee be associated with?</label>
					<select name="" id="" class="form-control">
						<option value="">Select Event...</option>
					</select>
				</div>
				<div class="form-group">
					<input type="submit" class="btn btn-lg btn-success" value="Continue to Next Step">
				</div>
			</form>
		</div>
	</div>

</div>

<cfinclude template="shared/footer.cfm"/>