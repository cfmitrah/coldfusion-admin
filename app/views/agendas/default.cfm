<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li class="active">Agenda</li>
</ol>
<!--// BREAD CRUMBS END //-->
<div id="action-btns" class="pull-right"> 
	<a href="#buildURL('agendas.settings')#" class="btn btn-lg btn-warning">Agenda Settings</a>
	<a href="#buildURL('agendas.create')#" class="btn btn-lg btn-info">Create New Agenda Item</a>
	<a href="#buildURL('agendarules')#" class="btn btn-lg btn-primary">Agenda Grouping Rules</a>	
</div>

<h2 class="page-title color-02">Agenda</h2>
<p class="page-subtitle">
	The schedule is composed of agenda items. To create an agenda item, click the 'Create New Agenda Item' button above. You can manage the exisiting agenda items by clicking 'manage' in the related table row below.
</p>
#view('common/Listing')#

<!--- start of delete fee modal --->
<cfinclude template="inc/modal.delete_agenda.cfm" />
<!--- end of delete fee modal --->
</cfoutput>

