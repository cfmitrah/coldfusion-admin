<cfoutput>
	<ol class="breadcrumb">
	  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
	  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
	  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
	  <li><a href="#buildURL( 'emailManagement' )#">Email Management</a></li>
	  <li class="active">Send Emails</li>
	</ol>
	<h2 class="page-title color-03">Send Emails</h2>
	<p class="page-subtitle">By specifying your settings below you can send test emails, or send offical emails to attendees</p>	
	<div class="basic-wrap mt-medium">
		<div class="container-fluid">
			<!---// START EMAIL OPTIONS //--->
			<cfinclude template="inc/frm.chooseEmailOptions.cfm" />
			<!---// END EMAIL OPTIONS //--->
			
			<!---// START SEND TEST EMAIL //--->
			<cfinclude template="inc/frm.sendTestEmail.cfm" />
			<!---// END SEND TEST EMAIL //--->
			
			<!--//START INVITATION LIVE EMAILS //-->
			<cfinclude template="inc/frm.sendInvitationEmails.cfm" />
			<!--//END INVITATION LIVE EMAILS //-->
			
			<!--//START COMMUNICATION LIVE EMAILS //-->
			<cfinclude template="inc/frm.sendCommunicationEmails.cfm" />
			<!--//END COMMUNICATION LIVE EMAILS //-->
		</div>
	</div>
	<!--//START EMAIL HISTORY //--->				
	<cfinclude template="inc/section.emailHistory.cfm" />
	<!--//START EMAIL HISTORY //--->				

	<!--//START CANCEL EMAIL //--->				
	<cfinclude template="inc/modal.cancel_email.cfm" />
	<!--//START CANCEL EMAIL //--->				
</cfoutput>	
