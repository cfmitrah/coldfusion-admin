<!---
LICENSE
Copyright 2007 Brian Kotek

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
--->


<cfcomponent name="FormUtilities" hint="Form Utilities">

	<cffunction name="init" access="public" hint="Constructor.">
		<cfargument name="updateFormScope" type="boolean" required="false" default="false" hint="If true, adds the collections to the form scope." />
		<cfargument name="trimFields" type="boolean" required="false" default="true" />
		<cfset variables.instance.updateFormScope = arguments.updateFormScope />
		<cfset variables.instance.trimFields = arguments.trimFields />
		<cfreturn this />
	</cffunction>

	<cffunction name="compareLists" access="public" returntype="struct" output="false" hint="Given two versions of a list, I return a struct containing the values that were added, the values that were removed, and the values that stayed the same.">
		<cfargument name="originalList" type="any" required="true" hint="List of original values." />
		<cfargument name="newList" type="any" required="true" hint="List of new values." />
		<cfset var local = StructNew() />

		<cfset local.results = StructNew() />
		<cfset local.results.addedList = "" />
		<cfset local.results.removedList = "" />
		<cfset local.results.sameList = "" />

		<cfloop list="#arguments.originalList#" index="local.thisItem">
			<cfif ListFindNoCase(arguments.newList, local.thisItem)>
				<cfset local.results.sameList = ListAppend(local.results.sameList, local.thisItem) />
			<cfelse>
				<cfset local.results.removedList = ListAppend(local.results.removedList, local.thisItem) />
			</cfif>
		</cfloop>

		<cfloop list="#arguments.newList#" index="local.thisItem">
			<cfif not ListFindNoCase(arguments.originalList, local.thisItem)>
				<cfset local.results.addedList = ListAppend(local.results.addedList, local.thisItem) />
			</cfif>
		</cfloop>

		<cfreturn local.results />
	</cffunction>

	<cffunction name="buildFormCollections" access="public" returntype="any" output="false" hint="">
		<cfargument name="formScope" type="struct" required="true" />
		<cfargument name="updateFormScope" type="boolean" required="true" default="#variables.instance.updateFormScope#" hint="If true, adds the collections to the form scope." />
		<cfargument name="trimFields" type="boolean" required="true" default="#variables.instance.trimFields#" />
		<cfset var local = StructNew() />

		<cfset local.tempStruct = StructNew() />
		<cfset local.tempStruct['formCollectionsList'] = "" />

		<!--- Loop over the form scope. --->
		<cfloop collection="#arguments.formScope#" item="local.thisField">

			<cfset local.thisField = Trim(local.thisField) />

			<!--- If the field has a dot or a bracket... --->
			<cfif hasFormCollectionSyntax(local.thisField)>

				<!--- Add collection to list if not present. --->
				<cfset local.tempStruct['formCollectionsList'] = addCollectionNameToCollectionList(local.tempStruct['formCollectionsList'], local.thisField) />

				<cfset local.currentElement = local.tempStruct />

				<!--- Loop over the field using . as the delimiter. --->
				<cfset local.delimiterCounter = 1 />
				<cfloop list="#local.thisField#" delimiters="." index="local.thisElement">
					<cfset local.tempElement = local.thisElement />
					<cfset local.tempIndex = 0 />

					<!--- If the current piece of the field has a bracket, determine the index and the element name. --->
					<cfif local.tempElement contains "[">
						<cfset local.tempIndex = ReReplaceNoCase(local.tempElement, '.+\[|\]', '', 'all') />
						<cfset local.tempElement = ReReplaceNoCase(local.tempElement, '\[.+\]', '', 'all') />
					</cfif>

					<!--- If there is a temp element defined, means this field is an array or struct. --->
					<cfif not StructKeyExists(local.currentElement, local.tempElement)>

						<!--- If tempIndex is 0, it's a Struct, otherwise an Array. --->
						<cfif local.tempIndex eq 0 >
							<cfset local.currentElement[local.tempElement] = StructNew() />
						<cfelse>
							<cfset local.currentElement[local.tempElement] = ArrayNew(1) />
						</cfif>
					</cfif>

					<!--- If this is the last element defined by dots in the form field name, assign the form field value to the variable. --->
					<cfif local.delimiterCounter eq ListLen(local.thisField, '.')>

						<cfif local.tempIndex eq 0>
							<cfset local.currentElement[local.tempElement] = arguments.formScope[local.thisField] />
						<cfelse>
							<cfif isNumeric(local.tempIndex)>
								<cfset local.currentElement[local.tempElement][local.tempIndex] = arguments.formScope[local.thisField] />
							<cfelse>
								<cftry>
									<cfset local.currentElement[local.tempElement][local.tempIndex] = arguments.formScope[local.thisField] />
									<cfcatch></cfcatch>
								</cftry>
							</cfif>

						</cfif>

					<!--- Otherwise, keep going through the field name looking for more structs or arrays. --->
					<cfelse>

						<!--- If this field was a Struct, make the next element the current element for the next loop iteration. --->
						<cfif local.tempIndex eq 0>
							<cfset local.currentElement = local.currentElement[local.tempElement] />
						<cfelse>

							<!--- If we're on CF8, leverage the ArrayIsDefined() function to avoid throwing costly exceptions. --->
							<cfif server.coldfusion.productName eq "ColdFusion Server" and ListFirst(server.coldfusion.productVersion) gte 8>

								<cfif ArrayIsEmpty(local.currentElement[local.tempElement])
										or ArrayLen(local.currentElement[local.tempElement]) lt local.tempIndex
										or not ArrayIsDefined(local.currentElement[local.tempElement], local.tempIndex)>
									<cfset local.currentElement[local.tempElement][local.tempIndex] = StructNew() />
								</cfif>

							<cfelse>

								<!--- Otherwise it's an Array, so we have to catch array element undefined errors and set them to new Structs. --->
								<cftry>
									<cfset local.currentElement[local.tempElement][local.tempIndex] />
									<cfcatch type="any">
										<cfset local.currentElement[local.tempElement][local.tempIndex] = StructNew() />
									</cfcatch>
								</cftry>

							</cfif>

							<!--- Make the next element the current element for the next loop iteration. --->
							<cfset local.currentElement = local.currentElement[local.tempElement][local.tempIndex] />

						</cfif>
						<cfset local.delimiterCounter = local.delimiterCounter + 1 />
					</cfif>

				</cfloop>
			</cfif>
		</cfloop>

		<!--- Done looping. If we've been set to update the form scope, append the created form collections to the form scope. --->
		<cfif arguments.updateFormScope>
			<cfset StructAppend(arguments.formScope, local.tempStruct) />
		</cfif>

		<cfreturn local.tempStruct />
	</cffunction>

	<cffunction name="hasFormCollectionSyntax" access="private" returntype="boolean" output="false" hint="I determine if the field has the form collection syntax, meaning it contains a dot or a bracket.">
		<cfargument name="fieldName" type="any" required="true" />
		<cfreturn arguments.fieldName contains "." or arguments.fieldName contains "[" />
	</cffunction>

	<cffunction name="addCollectionNameToCollectionList" access="private" returntype="string" output="false" hint="I add the collection name to the list of collection names if it isn't already there.">
		<cfargument name="formCollectionsList" type="string" required="true" />
		<cfargument name="fieldName" type="string" required="true" />
		<cfif not ListFindNoCase(arguments.formCollectionsList, ReReplaceNoCase(arguments.fieldName, '(\.|\[).+', ''))>
			<cfset arguments.formCollectionsList = ListAppend(arguments.formCollectionsList, ReReplaceNoCase(arguments.fieldName, '(\.|\[).+', '')) />
		</cfif>
		<cfreturn arguments.formCollectionsList />
	</cffunction>

	<cffunction name="arrayRemoveEmpty" access="public" description="removes empty array elements" output="false" returntype="array">
		<cfargument name="theArray" required="true" type="array" />
		<cfset var i = 0 />
		<cfset var newArray = duplicate(arguments.theArray) />
		<cfloop from="#arrayLen(newArray)#" to="1" index="i" step="-1">
			<cftry>
				<cfset newArray[i] />
				<cfcatch type="coldfusion.runtime.UndefinedElementException">
					<cfset arrayDeleteAt(newArray,i) />
				</cfcatch>
			 	<cfcatch type="coldfusion.runtime.CfJspPage$ArrayBoundException">
			 		<cfset arrayDeleteAt(newArray,i) />
				</cfcatch>
				<cfcatch type="expression">
			 		<cfset arrayDeleteAt(newArray,i) />
				</cfcatch>
			</cftry>
		</cfloop>
		<cfreturn newArray />
	</cffunction>

	<cfscript>
	/**
	* Checks to make sure all of the requested fields in given scope exist
	* @fields A comma-delimited list of fields
	* @scope A structure to check
	*/
	public boolean function exists( required string fields, required struct scope ) {
		var requiredExist = true;
		var inputs = listToArray( arguments.fields );
		var cnt = arrayLen( inputs );
		var ors = listToArray( arguments.fields, "||" );
		var orCnt = arrayLen( ors );
		if( orCnt > 1 ){
			requiredExist = false;
			for( var o = 1; o <= orCnt; o++ ) {
				if( exists( fields=ors[o], scope=arguments.scope ) ){
					return true;
				}
			}
		}
		else{
			for( var i = 1; i <= cnt; i++ ){
				if( !structKeyExists( arguments.scope, inputs[i] ) ){
					requiredExist = false;
					break;
				}
			}
		}
		return requiredExist;
	}
	/**
	* Takes a string of options and assigns the selected attribute to one or more values
	* @options A option list
	* @value The value list to find and select
	* @delim The delimiter to use
	*/
	public string function setSelectedOptions( required string options, required string value, string delim="," ){
		var regEx = "";
		var replaceWith = "";
		var selected = arguments.options;
		var replaceValue = listToArray( arguments.value, arguments.delim );
		var listCnt = arrayLen( replaceValue );
		if( listCnt ) {
			for( var i = 1; i <= listCnt; i = i + 1 ) {
				regEx = "value\s?=\s?(""|')?" & replaceValue[i] & "('|"")\s?\>";
				replaceWith = "value=""" & replaceValue[i] & """ selected=""selected"">";
				selected = reReplace( selected, regEx, replaceWith );
			}
		}
		return selected;
	}
	/**
	* Takes an array of options and values, and generates an option list
	* @values The value of the options
	* @display The display for the options
	* @selected a Selected value
	* @delim The delimiter to use if multiple
	*/
	public string function buildOptionList( required array values, array display=arguments.values, string selected="", string delim="," ){
		var builder = "";
		var opts = "";
		var valuesCnt = arrayLen( arguments.values);

		for( var i = 1; i <= valuesCnt; i = i + 1){
			builder= builder & "<option value=""" & arguments.values[i] & """ >";
			builder= builder & arguments.display[i];
			builder= builder & "</option>";
		}

		opts = setSelectedOptions( builder, arguments.selected, arguments.delim );
		return opts;
	}
	/**
	* Creates an Option List with Opt Group Values
	* @recordset A query to build the list from
	* @group The column to group values in
	* @value The column to use for the value
	* @display The column to use for the display
	* @selected a Selected value
	* @delim The delimiter to use if multiple
	*/
	public string function buildGroupOptionList( required query recordset, required string group, required string value, string display=arguments.value, string selected="", string delim="," ){
		var builder = createObject("java", "java.lang.StringBuilder");
		var opts = "";
		var lastGroup = "";
		if( arguments.recordset.recordCount ){
			builder.append( "<optgroup label=""" ).append( arguments.recordset[arguments.group][1] ).append( """>" );
			lastGroup = arguments.recordset[arguments.group][1];
			for( var i = 1; i <= arguments.recordset.recordCount; i = i + 1 ) {
				if( arguments.recordset[arguments.group][i] != lastGroup ){
					lastGroup = arguments.recordset[arguments.group][i];
					builder.append( "</optgroup>" );
					builder.append( "<optgroup label=""" ).append( arguments.recordset[arguments.group][i] ).append( """>" );
				}
				builder.append( "<option value=""" ).append( arguments.recordset[arguments.value][i] & "" ).append( """>" );
				builder.append( arguments.recordset[arguments.display][i] );
				builder.append( "</option>" );

				if( i == arguments.recordset.recordCount ){
					builder.append( "</optgroup>" );
				}
			}
		}
		opts = setSelectedOptions( builder.toString(), arguments.selected, arguments.delim );
		return opts;
	}

  /**
	* Update the settings structure and return as serialized JSON
	* @args A structure of arguments
	*/
	public string function buildSettings( required struct args ) {
		// Declare local variables
			var settings = {};  // Holds the settings structure
			writedump(args);abort;
			structAppend( args, {'settings':"",'datetimeformat':"US",'hide_attendee_cost_breakdown':0, 'enable_capacity':false }, false );
		// If a settings string was passed, deserialize it into the structure
			if( isJson( args.settings ) ) {
				settings = deserializeJson( args.settings );
			}
			if( !isStruct( settings ) ) {
				settings = {};
			}
		// Check for the existence of a various settings fields and handle accordingly
			settings['datetimeformat'] = args.datetimeformat;
			settings['hide_attendee_cost_breakdown'] = args.hide_attendee_cost_breakdown;
			settings['enable_capacity'] = args.enable_capacity;
		// Serialize settings and return
			return serializeJson( settings );
		}

	</cfscript>
</cfcomponent>
