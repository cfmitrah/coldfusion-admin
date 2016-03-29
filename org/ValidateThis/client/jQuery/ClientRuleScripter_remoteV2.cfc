<!---
	
	Copyright 2011, John Whish & Bob Silverberg
	
	Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in 
	compliance with the License.  You may obtain a copy of the License at 
	
		http://www.apache.org/licenses/LICENSE-2.0
	
	Unless required by applicable law or agreed to in writing, software distributed under the License is 
	distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or 
	implied.  See the License for the specific language governing permissions and limitations under the 
	License.
	
	
	Usage:
	<property name="UserName" desc="Email Address">
		<rule type="ajax">
			<param name="remoteURL" value="../RemoteDemo/CheckDupNickname.cfm" />
			<!-- list of jquery selectors -->
			<param name="fieldlist" value="#UserName,#NickName" />
		</rule>
	</property>
--->
<cfcomponent output="false" name="ClientRuleScripter_ajax" extends="AbstractClientRuleScripter" hint="I am responsible for generating JS code for the ajax validation.">

	<cffunction name="generateInitScript" returntype="any" access="public" output="false" hint="I generate the validation 'method' function for the client during fw initialization.">
		<cfargument name="defaultMessage" type="string" required="false" default="The value failed remote validation">
		<cfset var theCondition="">
		
		<!--- JAVASCRIPT VALIDATION METHOD --->
		<cfsavecontent variable="theCondition">
		function(v,e,o){
			var r = true;
			var fieldlist = ( typeof o.fieldlist === undefined ) ? '#' + e.id : o.fieldlist += ',#' + e.id;
			datastring = $(fieldlist).serialize();
			$.ajax({url:o.remoteURL,data:datastring,async:false,success:function(data,status,xhr){r=data==='true'}});
			return r;
		}</cfsavecontent>
		
		<cfreturn generateAddMethod(theCondition,arguments.defaultMessage)/>
	</cffunction>

	<cffunction name="generateAddRule" returntype="any" access="public" output="false" hint="I generate the JS script required to implement a validation.">
		<cfargument name="validation" type="any" required="yes" hint="The validation object that describes the validation." />
		<cfargument name="locale" type="Any" required="yes" />
		<cfargument name="selector" type="Any" required="yes" />
		<cfset var theScript 		= "" />
		<cfset var parameters		= arguments.VALIDATION.getPARAMETERS() />
		<cfset var failureMessage 	= determineFailureMessage(arguments.validation,arguments.locale,parameters) />
		<cfset var messageDef 		= getMessageDef(failureMessage,'remote',arguments.locale)/>
		<cfset var conditionDef 	= getConditionDef(argumentCollection=arguments)>
		<cfoutput>
		<cfsavecontent variable="theScript">
			if(#arguments.selector#.length){
				#arguments.selector#.rules("add", {remote:{ 
						url: "#parameters.remoteURL#", 
						type: "#(structKeyExists( parameters, "type") and len( parameters.type ) ? parameters.type:'post')#",
						data:{#(structKeyExists( parameters, "data") and len( parameters.data ) ? parameters.data:'')#} 
					}#messageDef##conditionDef#});
			}
		</cfsavecontent>
		</cfoutput>		
		
		<cfreturn theScript/>
	</cffunction>

	<cffunction name="getDefaultFailureMessage" returntype="any" access="private" output="false">
		<cfargument name="validation" type="any"/>
		<cfreturn createDefaultFailureMessage("#arguments.validation.getPropertyDesc()# failed remote validation.") />
	</cffunction>

</cfcomponent>

