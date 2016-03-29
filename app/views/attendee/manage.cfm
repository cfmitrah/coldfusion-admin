<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildurl( "dashboard" )#">Dashboard</a></li>
  <li><a href="#buildurl( action="event.details", queryString="event_id=" & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildurl( "attendee" )#">Event Attendee List</a></li>
  <li class="active">Manage Attendee</li>
</ol>
<!--// BREAD CRUMBS END //-->
<div id="action-btns" class="pull-right">
	<!--- If they came from the event, and not from the global attendee page --->
	<cfif rc.attendee.parent_attendee_id gt 0 && rc.attendee.parent_attendee_id NEQ rc.attendee.attendee_id >
	<a href="#buildURL( action:"attendee.manage", queryString="attendee_id=" & rc.attendee.parent_attendee_id )#" class="btn btn-lg btn-info">Back to Primary Attendee</a>
	</cfif>
	<a href="#buildURL("attendee")#" class="btn btn-lg btn-default">Back to All Event Attendees</a>
</div>

<h2 class="page-title color-02">Manage <cfif rc.attendee.parent_attendee_id EQ rc.attendee.attendee_id>Parent Record<cfelse>Attendee</cfif>: #rc.attendee.formatted_name#, Status( #rc.attendee.attendee_status# )</h2>
<p class="page-subtitle">Here is the registration information on #rc.attendee.formatted_name# Attendee ID(#rc.attendee.attendee_id#) captured when registering for #rc.event_name#.</p>
<div class="container-fluid">
	<div class="row mt-medium">
		<div class="col-md-5">
			<div class="btn-group">
			  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
			    Actions <span class="caret"></span>
			  </button>
			  <ul class="dropdown-menu" role="menu">
				<cfif rc.attendee.attendee_status EQ "Cancelled">
			    <li><a href="#rc.action_urls.activate#">Activate</a></li>
			    <cfelse>
			    <li><a href="#rc.action_urls.cancel#">Cancel</a></li>
			    <li><a href="#rc.action_urls.cancel_with_email#">Cancel and Send Email</a></li>
				</cfif>
				<li><a href="#buildURL( action="attendee.sendConfirmation", queryString="attendee_id=" & rc.attendee_id & "&registration_id=" & rc.attendee.registration_id )#">
				Re-send Confirmation</a></li>
				<cfif rc.attendee.group_allowed  >
				<li>
					<cfif rc.attendee.parent_attendee_id gt 0>
					<a href="#buildURL(action:"attendee.create", queryString="parent_id=" & rc.attendee.parent_attendee_id & "&registration_type_id=" & rc.attendee.registration_type_id & "&registration_id=" & rc.attendee.registration_id )#">Add a Group Member</a>
					<cfelse>
						<a href="#buildURL(action:"attendee.create", queryString="parent_id=" & rc.attendee.attendee_id & "&registration_type_id=" & rc.attendee.registration_type_id & "&registration_id=" & rc.attendee.registration_id )#">Add a Group Member</a>
					</cfif>
				</li>
				</cfif>
			  </ul>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-3">
			<div class="bs-callout bs-callout-warning">
			    <h4>Total Fees</h4>
			    <p>#rc.attendee.cost_breakdown.total_fees_cancels_display#</p>
			</div>
		</div>
		<div class="col-sm-3">
			<div class="bs-callout bs-callout-info">
			    <h4>Total Paid</h4>
			    <p id="total_credits_display">#rc.attendee.cost_breakdown.total_credits_display#</p>
			</div>
			<cfif rc.processor_credit_cards.credit_card_types.count && rc.can_pay>
			<button class="btn btn-warning btn-block#(!rc.attendee.cost_breakdown.total_credits ? " div-hide":"")#" 
				data-toggle="modal" 
				data-target="##refund-modal" 
				id="refund_modal_button" 
				data-total="#rc.attendee.cost_breakdown.total_credits#">
			    Refund/Void
			</button>
			</cfif>
		</div>
		<div class="col-sm-3">
			<div class="bs-callout bs-callout-success">
			    <h4>Total Discounts</h4>
			    <p id="total_discounts_display">#rc.attendee.cost_breakdown.total_discounts_display#</p>
			</div>
		</div>
		<div class="col-sm-3">
			<div class="bs-callout bs-callout-danger">
			    <h4>Total Due</h4>
			    <p id="total_due_display">#rc.attendee.cost_breakdown.total_due_display#</p>
			</div>
			<cfif rc.processor_credit_cards.credit_card_types.count && rc.can_pay >
			<button class="btn btn-success btn-block#(rc.attendee.cost_breakdown.total_due lte 0? " div-hide":"")#" 
				data-toggle="modal" 
				data-target="##payment-modal" 
				id="payment_modal_button" 
				data-total="#rc.attendee.cost_breakdown.total_due#">
			    Make payment
			</button>
			</cfif>
		</div>
		
	</div>
	
</div>
<!--- To keep the information logical and organized, The tabs are basically the form sections from when they registered. --->
<!---<div class="row mt-medium">
	<div class="col-md-12">
		<div class="alert alert-info cf">
			<strong class="pull-left">Would you like to resend a confirmation email?</strong>
			<a href="#buildURL( action="attendee.sendConfirmation", queryString="attendee_id=" & rc.attendee_id & "&registration_id=" & rc.attendee.registration_id )#" class="btn btn-success pull-right">
				Re-send Confirmation
			</a>
		</div>
	</div>
</div>
--->

<form method="post" action="#buildURL( "attendee.save" )#" id="attendee-reg-form" enctype="multipart/form-data" data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden">
	<input type="hidden" name="attendee_id" value="#rc.attendee_id#" />
	<input type="hidden" name="attendee_status" value="#rc.attendee.attendee_status#" />
	<input type="hidden" name="current_registration_type_id" value="#rc.attendee.registration_type_id#" />
	<input type="hidden" name="register_field[1].standard.email" value="#rc.attendee.email#" />
	<input type="hidden" name="register_field[1].standard.registration_id" value="#rc.attendee.registration_id#" />
	<input type="hidden" name="upload_prefix" value="#rc.attendee.email#" />
<div class="row mt-medium">
	<div class="col-md-6">
	    <div class="form-group">
	        <label for="">
	            Attendee type
	        </label>
	        <select name="register_field[1].standard.registration_type_id" id="standard_registration_type_id">
	            #rc.attendee_types#
	        </select>
	        <span class="help-block">
		        Please note that if you change the attendee type and the questions are not the same, you will lose the information that was saved for that attendee.  Please make sure you save at the bottom of the screen.
	        </span>
	    </div>
	</div>
	<div class="col-md-6">
		<div class="form-inline pull-right">
	        <div class="form-group">
		        
	            <label for="">
		            Enter Promo Code (for this attendee) if applicable
		        </label>
	            <div class="input-group">
					<input type="text" name="promo_code" id="promo_code" class="form-control" />
					<div class="input-group-btn">
						<a class="btn btn-primary" id="apply_promo_code" type="button">Apply</a>		
					</div>
				</div>
	        </div>
	        <span class="help-block" id="promo_notification"></span>
		</div>        
    </div>
</div>
<!-- Nav tabs -->
<ul class="nav nav-tabs mt-medium" role="tablist">
	<li class="dropdown active">
		<a href="##" class="dropdown-toggle" data-toggle="dropdown">
			Choose Form Section to Manage <span class="caret"></span>
		</a>
	
		<ul class="dropdown-menu" role="menu">
			<cfloop from="1" to="#rc.sections.count#" index="local.idx">
				<cfset local.tab = rc.sections.tabs[ local.idx ]  />
				<li class="#rc.active_class[tab.active]#"><a href="###local.tab.id#" role="tab" data-toggle="tab">#local.tab.name#</a></li>
			</cfloop>
		</ul>
	</li>
	<cfif rc.agenda_manage.count or rc.attendee.agenda.count>
	<li class="dropdown">
		<a href="##" class="dropdown-toggle" data-toggle="dropdown">
			Agenda <span class="caret"></span>
		</a>
		<ul class="dropdown-menu" role="menu">
			<cfif rc.attendee.agenda.count>
				<li class=""><a href="##agenda-tab" role="tab" data-toggle="tab">View</a></li>
			</cfif>
			<cfif rc.agenda_manage.count>
				<li class=""><a href="##manage-agenda-tab" role="tab" data-toggle="tab">Manage</a></li>
			</cfif>
		</ul>
	</li>
	</cfif>
	<cfif rc.attendee.parent_attendee_id gt 0 >
	<li class=""><a href="##manage-group-tab" role="tab" data-toggle="tab">Group</a></li>
	</cfif>
	<li class=""><a href="##detail-tab" role="tab" data-toggle="tab">Detail</a></li>
	<li class=""><a href="##notes-tab" role="tab" data-toggle="tab">Notes</a></li>

</ul>
<div id="attendee-manage">
	<!-- Tab panes -->
	<div class="tab-content">
		<cfloop from="1" to="#rc.sections.count#" index="local.idx">
			<cfset local.tab = rc.sections.tabs[ local.idx ]  />
			<div class="tab-pane #rc.active_class[tab.active]#" id="#local.tab.id#" data-section="true">
				<h3 class="form-section-title">Reg. Form #local.tab.name#</h3>
				<div class="row">
				#local.tab.content#
				</div>
				<br class="cf"/>
			</div>
		</cfloop>
		<cfif rc.attendee.agenda.count>
			<div class="tab-pane " id="agenda-tab">
				<h3 class="form-section-title">Agenda for #rc.attendee.formatted_name#</h3><!--- Leaving this in for print  --->
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Time</th>
							<th>Session Name</th>
						</tr>
					</thead>
					<tbody>
						<cfloop from="1" to="#rc.attendee.agenda.count#" index="local.idx">
							<cfset local['agenda_item'] = rc.attendee.agenda.data[ local.idx ] />
							<cfset local['agenda_item']['query_string'] = "attendee_id=" & rc.attendee.attendee_id & "&registration_id=" & rc.attendee.registration_id & "&agenda_id=" & local.agenda_item.agenda_id />
							<cfset local['agenda_item']['cancel_url'] = buildURL( action="attendee.cancelAgendaItem", queryString=local.agenda_item.query_string  ) />
							<tr>
								<td>#local.agenda_item.start_time# to #local.agenda_item.end_time#</td>
								<td>#local.agenda_item.title#</td>
							</tr>
						</cfloop>
					</tbody>
				</table>
				
					
				<br class="cf"/>
			</div>
		</cfif>
		<cfif rc.agenda_manage.count>
			<div class="tab-pane" id="manage-agenda-tab">
				<cfinclude template="inc/edit_agenda.cfm" />
			</div>
		</cfif>
		<cfif rc.attendee.parent_attendee_id gt 0 >
		<div class="tab-pane" id="manage-group-tab">
			<cfinclude template="inc/edit_group.cfm" />
		</div>
		</cfif>
		<div class="tab-pane " id="detail-tab">
			<h3 class="form-section-title">Details</h3>
			<table id="registration_details" class="table table-striped table-hover data-table tm-large" >
				<thead><tr></tr></thead>
				<tbody></tbody>
			</table>
			<br class="cf"/>
		</div>
		<div class="tab-pane " id="notes-tab">
			<h3 class="form-section-title">Notes</h3>
			<div class="row">
				<div class="form-group col-md-12">
					<label for="note" class="">New Note</label>
					<textarea name="attendee_note" id="attendee_note" class="form-control" rows="5" maxlength="4000"></textarea>
				</div>
			</div>
			<cfif rc.attendee.notes.count>
				<h3 class="form-section-title">Past Notes</h3>
			</cfif>
			<cfloop from="1" to="#rc.attendee.notes.count#" index="local.idx">
				<cfset local.note = rc.attendee.notes.data[ local.idx ] />
				<p>
					#local.note.note#
					<br/>
					<em>#dateFormat( local.note.last_modified, "Long")# #timeFormat( local.note.last_modified, "h:mm tt")#</em>
				</p>
				
			</cfloop>
			<br class="cf"/>
		</div>
	</div>
	<div class="cf mt-medium">
		<button type="submit" class="btn btn-lg btn-success">Save Attendee Information</button>
	</div>
</div>
</form>

<div class="modal fade" id="payment-modal" tabindex="-1" role="dialog" aria-labelledby="payment-modal" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="payment-modal-label">Make a Payment:<span></span></h4>
			</div>
			<div class="modal-body">
				#view( "attendee/inc/payment_form" )#
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
				<button type="button" class="btn btn-success" id="btn_process_payment">Make Payment</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="refund-modal" tabindex="-1" role="dialog" aria-labelledby="refund-modal" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="refund-modal-label">Refund/Void<span></span></h4>
			</div>
			<div class="modal-body">
				<div class="alert alert-info" >
					<p><strong>Voids</strong> can only be made the SAME DAY a transaction was processed.  A void cancels out the transaction.  The amount of a void is not editable.</p>

					<p><strong>Refunds</strong> can only be made the <strong>DAY FOLLOWING</strong> a transaction was processed (or anytime after that).  A refund provides funds back to the attendee.  The amount you refund is at your discretion; however, the maximum amount you can refund is the amount of a single transaction.</p>
				</div>
				#view( "attendee/inc/refund_form" )#
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel and Close</button>
				<button type="button" class="btn btn-success" id="btn_process_refund">Process Refund/Void</button>
			</div>
		</div>
	</div>
</div>


</cfoutput>
<cfinclude template="inc/hotel.cfm" />