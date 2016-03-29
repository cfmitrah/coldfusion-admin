<cfif local.review_agenda.count>
<cfoutput>
<div class="well">
    <h5 class="section-title relative">
        Agenda
    </h5>
    <table style="font-family: sans-serif; font-size: 13px; border-collapse: collapse;" align="left" width="100%" cellpadding="5" cellspacing="0">
        <thead>
            <tr align="left" style="background: ##363636">
                <th width="55%" style="color: ##fff;">Name</th>
                <th width="45%" style="color: ##fff;">Scheduled Time</th>
            </tr>
        </thead>
        <tbody>
             <cfloop from="1" to="#local.review_agenda.count#" index="local.count">
                 <cfset local.item = local.review_agenda.data[ local.count ] />
                <tr style="border-bottom: 1px solid ##ccc;">
                    <td>#local.item.title#</td>
                    <td>#local.item.start_time# to #local.item.end_time#</td>
                </tr>
            </cfloop> 
        </tbody>
    </table>
</div>
</cfoutput>
</cfif>