<!---
	
	Copyright 2008, Bob Silverberg
	
	Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in 
	compliance with the License.  You may obtain a copy of the License at 
	
		http://www.apache.org/licenses/LICENSE-2.0
	
	Unless required by applicable law or agreed to in writing, software distributed under the License is 
	distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or 
	implied.  See the License for the specific language governing permissions and limitations under the 
	License.
	
--->
<cfcomponent output="false" name="ServerRuleValidator_Creditcard" extends="AbstractServerRuleValidator" hint="I am responsible for performing the Creditcard validation.">

	<cffunction name="validate" returntype="any" access="public" output="false" hint="I perform the validation returning info in the validation object.">
		<cfargument name="validation" type="any" required="yes" hint="The validation object created by the business object being validated." />
		<cfargument name="locale" type="string" required="yes" hint="The locale to use to generate the default failure message." />

		<cfset var args = [arguments.validation.getPropertyDesc()] />

		<cfscript>
			if( shouldTest(arguments.validation) ){
				if( !IsCreditCard( arguments.validation.getObjectValue(), 'MASTERCARD' ) 
					AND !IsCreditCard( arguments.validation.getObjectValue(), 'VISA' )
					AND !IsCreditCard( arguments.validation.getObjectValue(), 'AMEX' ) 
					AND  !IsCreditCard( arguments.validation.getObjectValue(), 'DISCOVER' )
					)
				{
					fail(arguments.validation,variables.messageHelper.getGeneratedFailureMessage("defaultMessage_Creditcard",args,arguments.locale)) ;
				}
			}
		</cfscript>
	</cffunction>
	

	<cfscript>
		function IsCreditCard(required ccNo)
		{
			    var rv = "";
			    var str = "";
			    var chk = 0;
			    var ccln = 0;
			    var strln = 0;
			    var i = 1;
			
			    if(reFind("[^[:digit:]]",ccNo)) return FALSE;
				ccNo = replace(ccNo," ","","ALL");
			    rv = Reverse(ccNo);
			    ccln = Len(ccNo);
			    if(ccln lt 12) return FALSE;
			    for(i = 1; i lte ccln; i = i + 1) {
			        if(i mod 2 eq 0) {
			            str = str & Mid(rv, i, 1) * 2;
			        } else {
			            str = str & Mid(rv, i, 1);
			        }
			    }
			    strln = Len(str);
			    for(i = 1; i lte strln; i = i + 1) chk = chk + Mid(str, i, 1);
			    if((chk neq 0) and (chk mod 10 eq 0)) {
			        if(ArrayLen(Arguments) lt 2) return TRUE;
			        switch(UCase(Arguments[2])) {
			        case "AMEX":        if ((ccln eq 15) and (((Left(ccNo, 2) is "34")) or ((Left(ccNo, 2) is "37")))) return TRUE; break;
			        case "DINERS":        if ((ccln eq 14) and (((Left(ccNo, 3) gte 300) and (Left(ccNo, 3) lte 305)) or (Left(ccNo, 2) is "36") or (Left(ccNo, 2) is "38"))) return TRUE; break;
			        case "DISCOVER":    if ((ccln eq 16) and (Left(ccNo, 4) is "6011")) return TRUE; break;
			        case "MASTERCARD":    if ((ccln eq 16) and (Left(ccNo, 2) gte 51) and (Left(ccNo, 2) lte 55)) return TRUE; break;
			        case "VISA":        if (((ccln eq 13) or (ccln eq 16)) and (Left(ccNo, 1) is "4")) return TRUE; break;
			        default: return TRUE;
			        }
			    }
			    return FALSE;
		
		}
	</cfscript>
</cfcomponent>
	

