<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li class="active">Site Layout</li>
</ol>
<!--// BREAD CRUMBS END //-->
<h2 class="page-title color-02">Registration Site Layout</h2>

<div class="container-fluid">
	<form action="#buildURL("websiteLayout.doSave")#" method="post">
		<div class="row">
			<div class="col-md-9">
				<p class="page-subtitle">Choose the global layout you'd like to use for your site.</p>
			</div>
			<div class="col-md-3">
				<button type="submit" class="btn btn-success btn-lg btn-block"><strong>Save Selected Layout</strong></button>
			</div>	
		</div>
		<hr>
		<div class="row">
			<div class="col-md-6">
				<div class="radio">
				  <label>
				    <input type="radio" name="event_layout" id="event_layout" value="layout-01" #rc.checked[ rc.event_layout.s_value eq "layout-01" ]# />
				    <strong>Fixed Width Layout</strong><br> <em>Fixed width traditional layout with a large centered logo - Easy to style</em>
				  </label>
				</div>
				<img src="/assets/img/layout/layout-01.jpg" class="img-responsive" alt="" style="border: 1px solid rgba(0,0,0,.2); border-radius: 3px;">
			</div>

			<div class="col-md-6">
				<div class="radio">
				  <label>
				    <input type="radio" name="event_layout" id="event_layout" value="layout-02" #rc.checked[ rc.event_layout.s_value eq "layout-02" ]# />
				    <strong>Full Width Layout</strong><br> <em>Full width hero graphic and form steps, good for large captivating graphics</em>
				  </label>
				</div>
				<img src="/assets/img/layout/layout-02.jpg" class="img-responsive" alt="" style="border: 1px solid rgba(0,0,0,.2); border-radius: 3px;">
			</div>
		</div>
		<br><br>
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="radio">
				  <label>
				    <input type="radio" name="event_layout" id="event_layout" value="layout-03" #rc.checked[ rc.event_layout.s_value eq "layout-03" ]# />
				    <strong>Mixed Layout</strong><br> <em>A fixed width hero graphic with fixed width form steps</em>
				  </label>
				</div>
				<img src="/assets/img/layout/layout-03.jpg?v=2" class="img-responsive" alt="" style="border: 1px solid rgba(0,0,0,.2); border-radius: 3px;">
			</div>
		</div>
		<br>
		
	</form>
</div>

<!--// fORM END //-->
</cfoutput>

