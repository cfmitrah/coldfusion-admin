<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'agendas.default' )#">Agenda</a></li>
  <li class="active">#rc.agenda.label# Details</li>
</ol>
<!--// BREAD CRUMBS END //--><h2 class="page-title color-02">#rc.agenda.label#</h2>
<p class="page-subtitle">Edit specifics related to this agenda item such as time, fees, restrictions and more.</p>

<ul class="nav nav-tabs mt-medium" role="tablist">
	<li class="active"><a href="##agenda-item-main" role="tab" data-toggle="tab">Main Details</a></li>
	<li><a href="##agenda-item-fees" role="tab" data-toggle="tab">Associated Fees</a></li>
	<li><a href="##agenda-item-waitlist" role="tab" data-toggle="tab">Attendee Capacity Settings</a></li>
	<li><a href="##agenda-item-restrictions" role="tab" data-toggle="tab">Restrictions</a></li>
</ul>


<div class="tab-content">
<!--- start of agenda details --->
<cfinclude template="inc/tab.details.cfm" />
<!--- end of agenda details --->

<!--- start of agenda fees--->
<cfinclude template="inc/tab.fees.cfm" />
<!--- end of agenda fees --->

<!--- start of agenda capacity --->
<cfinclude template="inc/tab.capacity.cfm" />
<!--- end of agenda capacity --->
<!--- start of agenda restrictions --->
<cfinclude template="inc/tab.restrictions.cfm" />
<!--- end of agenda restrictions --->
<!--- start of agenda fee remove modal --->
<cfinclude template="inc/modal.delete_fee.cfm" />
<!--- end of agenda fee remove modal --->
</div>
</cfoutput>