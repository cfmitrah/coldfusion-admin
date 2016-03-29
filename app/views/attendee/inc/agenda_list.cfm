<cfoutput>
<cfset local.total_fees = rc.agenda_manage.fees />
<div class="tab-content" id="session_wrapper">
	<table class="table table-striped table-hover">
		<thead>
            <tr>
                <th>Name</th>
                <th>Scheduled Time</th>
                <cfif local.total_fees >
                <th>Associated Fee</th>
                </cfif>
                <th>Add to Agenda</th>
            </tr>
        </thead>
	<cfloop from="1" to="#rc.agenda_manage.count#" index="local.idx">
		<cfset local.tab_name = rc.agenda_manage.data[ local.idx ].display />
		<cfset local.session_count = rc.agenda_manage.data[ local.idx ].count />
		<cfset local.agenda_categories = rc.agenda_manage.data[ local.idx ] />
		<cfset local.header_count = local.agenda_categories.count />
		<cfset local.agenda_category_data = local.agenda_categories.data />
		<cfset local.colspan = ( local.total_fees ? 4 : 3) />
		<cfset local.groups = listToArray( listSort( local.agenda_categories.sub_group_keys, "Text" ) ) />
		<thead>
            <tr class="table-header-row">
                <th colspan="#local.colspan#">#local.tab_name# (#local.session_count#)</th>
            </tr>
        </thead>
        <tbody>
        	<cfloop array=#local.groups# index="local.category_name">
            	<cfset local.agenda_section = local.agenda_category_data[local.category_name]/>
				<cfset local.session_count = local.agenda_section.count />
				<cfset local.header = local.agenda_section.header />
				<cfif len( local.header )>
				<tr>
					<th colspan="#local.colspan#">#local.header#</th>
				</tr>
				</cfif>
				<cfloop from="1" to="#local.session_count#" index="local.session_idx">
					<cfset local.session = local.agenda_section.data[ local.session_idx ] />
					<cfset local.availability = rc.agenda_manage.availability[ 'agenda_id_' & local.session.agenda_id ] />
        		<tr>
                    <td>
                    	<!--- <a href="##" data-agenda_action="modal_pop_up" data-agenda_id="#local.session.agenda_id#"></a> --->
                    	#local.session.session_display#
                    </td>
                    <td>#local.session.scheduled_time#</td>
                    <cfif local.total_fees >
                    <td>#local.session.associated_fee#</td>
                    </cfif>
                    <td class="text-center" data-included="#local.session.included#" data-agenda_id="#local.session.agenda_id#">
                        <cfif local.availability.show_checkbox || 
	                        ( !local.availability.show_checkbox && listFindnocase(rc.attendee.Agenda.agenda_ids,local.session.agenda_id) )>
                        	#local.session.include_option#
                        <cfelse>
                        	Capacity Reached
                        </cfif>
                    	<div class="bg-danger agenda-conflicts">Conflicts</div>
                    </td>
                </tr>	
				</cfloop>	
        	</cfloop>
        </tbody>
    </cfloop>
    </table>
</div>
</cfoutput>