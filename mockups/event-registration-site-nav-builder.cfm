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
			  <li><a href="event-registration-site-content.cfm">Site Content</a></li>
			  <li class="active">Navigation Preferences</li>
			</ol>
			<h2 class="page-title color-02">Registration Site Navigation Builder and Preferences</h2>
			<p class="page-subtitle">Manage the  order of navigation items for the registration website, as well as apply page specific settings.</p>
			<form action="" class="basic-wrap mt-large">
				<div class="container-fluid">
					<h3 class="form-section-title">Additional Pages</h3>
					<div class="row">
						<div class="form-group col-md-6 col-md-offset-3">
							<label for="">Choose any additional pages you'd like to show on the registration site:</label>
							<div id="additional-choices-wrap">
								<div class="checkbox">
								    <label>
								    	<input type="checkbox" data-page="agenda"> <strong>Agenda</strong> - This page will contain a well formatted schedule of your event
								    </label> 
								</div>
								<div class="checkbox">
								    <label>
								    	<input type="checkbox" data-page="sessions"> <strong>Sessions</strong> - This page will contain detailed information on event sessions
								    </label> 
								</div>
								<div class="checkbox">
								    <label>
								    	<input type="checkbox" data-page="speakers"> <strong>Speakers</strong> - This page will contain detailed information on event speakers
								    </label> 
								</div>
							</div>
						</div>
					</div>
					<h3 class="form-section-title">Set Navigation Link Order</h3>
					<div class="alert alert-info">These are the content pages you have created for the registration site. Set the order you want them to display in the header.</div>
					<div class="row">
						<div class="form-group col-md-6 col-md-offset-3">
							<label for="">Set Desired Order:</label><br>
							<ul class="draggable-list">
								<li class="undraggable">Registration - Landing Page (Always First)</li>
							</ul>
							<ul class="draggable-list" id="reg-site-menu-order">
								
								<li>Sample Custom Page</li>
								<li>Another Sample Custom Page</li>
							</ul>
							<p class="help-block">You can also set the order for agenda, sessions, and speakers if you choose to use those pages. (See Additional Pages Section Above)</p>
						</div>
						<div class="col-md-6 col-md-offset-3">
							<input type="submit" class="btn btn-block btn-lg btn-success" value="Save Menu Settings">
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>

<script>
$(function(){
	// This is for organizing the sections once they are created
	$( "#reg-site-menu-order" ).sortable();

	var $menu = $('#reg-site-menu-order');

	$('#additional-choices-wrap :checkbox').change(function() {
    	if($(this).data("page")=="agenda"){
            if( $(this).prop('checked') ) {
            	$menu.append('<li id="agenda-list-item">Agenda</li>');
            }else {
            	
            	$menu.find('#agenda-list-item').remove();
            }
        }
        if($(this).data("page")=="sessions"){
           if( $(this).prop('checked') ) {
            	$menu.append('<li id="session-list-item">Sessions</li>');
            }else {
            	
            	$menu.find('#session-list-item').remove();
            } 
        }
        if($(this).data("page")=="speakers"){
            if( $(this).prop('checked') ) {
            	$menu.append('<li id="speaker-list-item">Speakers</li>');
            }else {
            	
            	$menu.find('#speaker-list-item').remove();
            }
        }
	});

	

});
</script>

<cfinclude template="shared/footer.cfm"/>