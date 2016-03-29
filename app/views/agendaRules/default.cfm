<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL('agendas.default')#">Agenda</a></li>
  <li class="active">Agenda Grouping Rules</li>
</ol>
<div id="action-btns" class="pull-right">
	<a href="##" data-toggle="modal" data-target="##grouping-rule" id="btn_new_grouping" class="btn btn-lg btn-info">Add New Grouping</a>
    <a href="##" data-toggle="modal" data-target="##dependency-rule" id="btn_new_dependency" class="btn btn-lg btn-info">Add New Dependency</a>
</div>
<h2 class="page-title color-02">Agenda Rules</h2>
<p class="page-subtitle">
	Here is where you can set several agenda items into a group, where one or more must be chosen to continue on the agenda during registration.
</p>

<h3 class="form-section-title mt-medium">Manage Existing Rules</h3>

<!--- Matt turn this into a data table yo --->
<table class="table table-striped table-hover mt-medium" id="agenda_rules_listing"></table>
<!--- start of delete fee modal --->
<cfinclude template="inc/modal.grouping.cfm" />
<cfinclude template="inc/modal.dependency.cfm" />
<!--- end of delete fee modal --->
</cfoutput>