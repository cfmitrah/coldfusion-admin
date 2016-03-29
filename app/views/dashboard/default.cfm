<style>

	/*#dashboard-tiles {
		max-width: 1200px;
		margin: 0 auto;
	}*/
	.panel-header h4 {
		height: 30px;
		line-height: 30px;
		padding: 0 20px;
		color: #fff;
		margin: 0 0 0 0;
		font-size: 1.1em;
	}
	.panel-body {
		height: 80px;
	}
	.panel-body p.lg {
		font-size: 32px;
	}
	#dashboard-tiles h3 {
		text-transform: uppercase;
		margin-top: 0;
	}
	.panel-primary h4 {
		background: #577a99;
	}
	.panel-primary {
		border-color: #c6d5e9;
	}
	.panel-success h4 {
		background: #5cb85c;
	}
	.panel-warning h4 {
		background: #b66b42;
	}
</style>

<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li class="active">At a Glance</li>
</ol>
<!--// BREAD CRUMBS END //-->

<div id="dashboard-tiles" class="row">


	<div class="col-md-4">
		<div class="well">
		<h3 class="text-center">Cost Breakdown</h3>
		<hr>
		<div class="panel panel-primary">
			<div class="panel-header">
				<h4 class="text-center">Total Fees</h4>
			</div>
			<div class="panel-body">
				<p class="lg text-center">#dollarFormat( rc.dashboard_stats.cost_breakdown.total_fees )#</p>
			</div>
		</div>
		<div class="panel panel-primary">
			<div class="panel-header">
				<h4 class="text-center">Total Discounted Value</h4>
			</div>
			<div class="panel-body">
				<p class="lg text-center">#dollarFormat( rc.dashboard_stats.cost_breakdown.total_discounts )#</p>
			</div>
		</div>
		<div class="panel panel-primary">
			<div class="panel-header">
				<h4 class="text-center">Total Amount Due</h4>
			</div>
			<div class="panel-body">
				<p class="lg text-center">#dollarFormat( rc.dashboard_stats.cost_breakdown.total_due )#</p>
			</div>
		</div>
		<div class="panel panel-primary">
			<div class="panel-header">
				<h4 class="text-center">Total Payments Made</h4>
			</div>
			<div class="panel-body">
				<p class="lg text-center">#dollarFormat( rc.dashboard_stats.cost_breakdown.total_payments )#</p>
			</div>
		</div>
		<div class="panel panel-primary">
			<div class="panel-header">
				<h4 class="text-center">Total Refunds Given</h4>
			</div>
			<div class="panel-body">
				<p class="lg text-center">#dollarFormat( rc.dashboard_stats.cost_breakdown.total_refunds )#</p>
			</div>
		</div>
		<div class="panel panel-primary">
			<div class="panel-header">
				<h4 class="text-center">Total Voided Transactions</h4>
			</div>
			<div class="panel-body">
				<p class="lg text-center">#dollarFormat( rc.dashboard_stats.cost_breakdown.total_voids )#</p>
			</div>
		</div>
		</div>
	</div>

	<div class="col-md-4">
		<div class="well">
		<h3 class="text-center">Invitations Breakdown</h3>
		<hr>
		<div class="panel panel-success">
			<div class="panel-header">
				<h4 class="text-center">Total Invitations Sent</h4>
			</div>
			<div class="panel-body">
				<p class="lg text-center">#val( rc.dashboard_stats.attendee_count_breakdown.total_invites_sent )#</p>
			</div>
		</div>
		<div class="panel panel-success">
			<div class="panel-header">
				<h4 class="text-center">Accepted Invitations</h4>
			</div>
			<div class="panel-body">
				<p class="lg text-center">#val( rc.dashboard_stats.attendee_count_breakdown.total_invites_accepted )#</p>
			</div>
		</div>
		<div class="panel panel-success">
			<div class="panel-header">
				<h4 class="text-center">Invitations Declined</h4>
			</div>
			<div class="panel-body">
				<p class="lg text-center">#val( rc.dashboard_stats.attendee_count_breakdown.total_invites_declined )#</p>
			</div>
		</div>
		<div class="panel panel-success">
			<div class="panel-header">
				<h4 class="text-center">Invites with No Response</h4>
			</div>
			<div class="panel-body">
				<p class="lg text-center">#val( rc.dashboard_stats.attendee_count_breakdown.total_invites_noresponse )#</p>
			</div>
		</div>
		<div class="panel panel-success">
			<div class="panel-header">
				<h4 class="text-center">Invitations Viewed</h4>
			</div>
			<div class="panel-body">
				<p class="lg text-center">#val( rc.dashboard_stats.attendee_count_breakdown.total_invites_viewed )#</p>
			</div>
		</div>
		</div>
	</div>

	<div class="col-md-4">
		<div class="well">
			<h3 class="text-center">Attendee Breakdown</h3>
			<hr>
			<div class="panel panel-warning">
				<div class="panel-header">
					<h4 class="text-center">Attendees Registered</h4>
				</div>
				<div class="panel-body">
					<p class="lg text-center">#val( rc.dashboard_stats.attendee_count_breakdown.total_event_registered )#</p>
				</div>
			</div>
			<div class="panel panel-warning">
				<div class="panel-header">
					<h4 class="text-center">Attendees Cancelled</h4>
				</div>
				<div class="panel-body">
					<p class="lg text-center">#val( rc.dashboard_stats.attendee_count_breakdown.total_event_cancelled )#</p>
				</div>
			</div>
			
		</div>
	</div>


</div>


		<!--- <div class="panel panel-primary">
			<div class="panel-header">
				<h4 class="text-center">invites_imported</h4>
			</div>
			<div class="panel-body">
				<p class="lg text-center">#val( rc.dashboard_stats.attendee_count_breakdown.total_invites_imported )#</p>
			</div>
		</div> --->

</cfoutput>