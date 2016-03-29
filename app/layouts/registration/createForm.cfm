<cfscript>
	local.sectionClass = { 'yes': "active", 'no': "" };
	local.section = listlast(rc.action,'.');
	local.links = { 
			'createAttendeeForm': "",
			'createFormSections': "",
			'assignSectionFields': ""
		};
	if( structKeyExists( rc, "registration_type_id" ) ){
		local.links[ 'createAttendeeForm' ] = " href=""" & buildURL( action="registration.createAttendeeForm" ) & """ ";
		local.links[ 'createFormSections' ] = " href=""" & buildURL( action="registration.createFormSections", queryString="registration_type_id=" & rc.registration_type_id ) & """ ";
		local.links[ 'assignSectionFields' ] = " href=""" & buildURL( action="registration.assignSectionFields", queryString="registration_type_id=" & rc.registration_type_id ) & """ ";
	}
	
</cfscript>
<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="index.cfm">Dashboard</a></li>
  <li><a href="#buildURL( 'registration.default' )#">Registration</a></li>
  <li class="active">Create Registration Form</li>
</ol>
<!--// BREAD CRUMBS END //-->
<h2 class="page-title color-02">Create New Registration Form</h2>
<p class="page-subtitle">Follow the form builder below to create a registration form unique to an attendee type</p>
<br>
<div id="form-builder-navbar" class="cf">
	<a #local.links[ 'createAttendeeForm' ]# class="blocknav1 #local.sectionClass[ local.section eq 'createAttendeeForm' ]#">1. Choose Attendee Type</a>
	<a #local.links[ 'createFormSections' ]# class="blocknav2 #local.sectionClass[ local.section eq 'createFormSections' ]#">2. Create Form Sections</a>
	<a #local.links[ 'assignSectionFields' ]# class="blocknav3 #local.sectionClass[ local.section eq 'assignSectionFields' ]#">3. Assign Fields to Sections</a>
</div>
<br>
#body#
</div>
</cfoutput>