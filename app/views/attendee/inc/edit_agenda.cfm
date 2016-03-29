<cfset local.active_class = {'yes': "active", 'No': "" } />
<cfoutput>
    <h3>Manage</h3>
    <div class="container-fluid">
        <div class="row">
	        <cfinclude  template="agenda_#rc.agenda_manage.layout_type#.cfm" />
        </div>
    </div>
</cfoutput>