<cfoutput>
<ol class="breadcrumb">
	<li><a href="#buildURL( 'dashboard' )#">Dashboard</a></li>
	<li><a href="#buildURL( 'event' )#">Events</a></li>
	<li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
	<li class="active">Coupons</li>
</ol>
<div id="action-btns" class="pull-right">
	<a href="#buildURL( 'coupons.detail' )#" class="btn btn-lg btn-primary">Create New Coupon</a>
</div>
<h2 class="page-title color-02">Coupons</h2>
<p class="page-subtitle">Manage and create new coupons for attendees to use during registration.</p>
<br>
<div class="container-fluid" id="discounts-legend">
	<div class="row">
		<div class="col-md-4 text-center">
			<span class="label label-primary">Flat Fee</span> - Value is the amount the attendee will pay.
		</div>
		<div class="col-md-4 text-center">
			<span class="label label-success">Discount</span> - Value is the dollar amount subtracted from total cost.
		</div>
		<div class="col-md-4 text-center">
			<span class="label label-info">Percentage</span> - Value is percentage subtracted from total cost.
		</div>
	</div>
</div>
#view("common/listing")#
</cfoutput>