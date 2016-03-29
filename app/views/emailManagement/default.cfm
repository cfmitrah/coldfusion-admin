<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li class="active">Email Management</li>
</ol>
<div id="action-btns" class="pull-right">
	<!--- <a href="#buildURL( 'emailManagement.emailDefaults' )#" class="btn btn-lg btn-default">Configure Defaults</a> --->
	<a href="#buildURL( 'emailManagement.emailTool' )#" class="btn btn-lg btn-warning" style="text-transform: uppercase;">Email Sending Tool</a>
</div>
<h2 class="page-title color-03">Email Management</h2>
<p class="page-subtitle">In this section, manage email content for your event. Choose when to send emails, who to send them to, and much more.</p>


<!--// start invitation emails //-->
<cfinclude template="inc/section.invitation.cfm" />
<!--// end invitation emails //-->

<!--// start system generated emails //-->
<cfinclude template="inc/section.autoResponder.cfm" />
<!--// end system generated emails //-->

<!--// start communication emails //-->
<cfinclude template="inc/section.communication.cfm" />

<!--// end communication emails //-->

<!--// start communication emails //-->
<cfinclude template="inc/modal.sendTestEmail.cfm" />
<!--// end communication emails //-->

</cfoutput>