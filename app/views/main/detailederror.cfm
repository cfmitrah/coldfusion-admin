<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
</ol>
<!--// BREAD CRUMBS END //-->
<h1>An Error Occurred</h1>
<p>Details of the exception:</p>
<cfoutput>
	<ul>
		<li>Failed action: <cfif structKeyExists( request, 'failedAction' )>#request.failedAction#<cfelse>unknown</cfif></li>
		<li>Application event: #request.event#</li>
		<li>Exception type: #request.exception.type#</li>
		<li>Exception message: #request.exception.message#</li>
		<li>Exception detail: #request.exception.detail#</li>
		<li>Exception TagContext: 
			<ul>
			<cfloop array="#request.exception.TagContext#" index="local.TagContext">
				<li>Line: #local.TagContext.LINE#, Template:  #local.TagContext.template#</li>
			</cfloop>
			</ul>
		</li>
		
	</ul>
</cfoutput>

<cfdump var='#request.exception#' expand="true" />