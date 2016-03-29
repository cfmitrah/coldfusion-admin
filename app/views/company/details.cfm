<cfset existing_company = rc.manage_company_id gt 0>
<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="##">Dashboard</a></li>
  <li><a href="#buildURL( 'event.default' )#">Company</a></li>
  <li class="active">#rc.company_details.company.company.data[1].company_name# Details</li>
</ol>
<!--// BREAD CRUMBS END //-->
</cfoutput>
<h2 class="page-title color-02">Company Details</h2>
<p class="page-subtitle">Set standard information pertaining to your company such as the name of it, and contact information.</p>
<!--// the tabs //-->
<ul class="nav nav-tabs mt-medium" role="tablist">
	<li class="active"><a href="#company-essentials" role="tab" data-toggle="tab">Essentials</a></li>
	<cfif existing_company>
		<li><a href="#company-hotels" role="tab" data-toggle="tab">Hotels/Venues</a></li>
		<li><a href="#company-payments" role="tab" data-toggle="tab">Payments</a></li>
		<li><a href="#company-managers" role="tab" data-toggle="tab">Account Managers</a></li>
		<li><a id="users_tab" href="#company-users" role="tab" data-toggle="tab">Users</a></li>
		<li><a href="#company-attendees" role="tab" data-toggle="tab">Attendees</a></li>
	</cfif>
</ul>

<div class="tab-content">
<!--- start of company essentials --->
<cfinclude template="inc/tab.essentials.cfm" />
<!--- end of company essentials --->
<cfif existing_company>
	<!--- start of company hotels--->
	<cfinclude template="inc/tab.hotels.cfm" />
	<!--- end of company hotels --->
	<!--- start of company payments --->
	<cfinclude template="inc/tab.payments.cfm" />
	<!--- end of company payments --->
	<!--- start of company managers --->
	<cfinclude template="inc/tab.managers.cfm" />
	<!--- end of company managers --->
	<!--- start of company users --->
	<cfinclude template="inc/tab.users.cfm" />
	<!--- end of company users --->
	<!--- start of company attendees --->
	<cfinclude template="inc/tab.attendees.cfm" />
	<!--- end of company attendees --->

	<!--- start of company payment  remove modal --->
	<cfinclude template="inc/modal.remove_processor.cfm" />
	<!--- end of company venue remove modal --->

	<!--- start of company excluded credit card remove modal --->
	<cfinclude template="inc/modal.remove_excludedcreditcard.cfm" />
	<!--- end of company excluded credit card remove modal --->

	<!--- start of company account manager remove modal --->
	<cfinclude template="inc/modal.remove_accountmanager.cfm" />
	<!--- end of company account manager remove modal --->

	<!--- start of company user remove modal --->
	<cfinclude template="inc/modal.remove_user.cfm" />
	<!--- end of company user remove modal --->

	<!--- start of company attendees remove modal --->
	<cfinclude template="inc/modal.see_attendee.cfm" />
	<!--- end of company attendees remove modal --->
</cfif>


</div>
