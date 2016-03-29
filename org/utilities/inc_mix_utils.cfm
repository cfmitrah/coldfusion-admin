<cffunction name="toWddx" access="public" returnType="string" output="false">
    <cfargument name="input" type="any" required="true">
    <cfargument name="useTimezoneInfo" type="boolean" required="false" default="true">
    <cfset var result = "">
    <cfwddx action="cfml2wddx" input="#arguments.input#" output="result" useTimezoneInfo="#arguments.useTimezoneInfo#">
    <cfreturn result>
    
</cffunction>

<cffunction name="toCFML" access="public" returnType="any" output="false">
    <cfargument name="input" type="any" required="true">
    <cfargument name="validate" type="boolean" required="false" default="false">
    
    <cfset var result = "">
    <cfwddx action="wddx2cfml" input="#arguments.input#" output="result" validate="#arguments.validate#">
    <cfreturn result>
    
</cffunction>