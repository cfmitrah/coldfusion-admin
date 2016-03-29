/**
* @file  /model/managers/Company.cfc
*/
component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="FormUtilities" setter="true" getter="true";
	property name="BaseX" setter="true" getter="true";
	property name="RegistrationTypesDao" setter="true" getter="true";
	property name="AttendeeDao" setter="true" getter="true";
	property name="AgendaDao" setter="true" getter="true";
	property name="RegistrationFieldDao" setter="true" getter="true";
	property name="CustomReportDao" setter="true" getter="true";
	property name="PaymentProcessorsDao" setter="true" getter="true";
	property name="ReportDao" getter="true" setter="true";
	property name="SpreadSheetUtilities" setter="true" getter="true";
	property name="config" setter="true" getter="true";
	/**
	* deleteCustomReport
	* This method will delete the custom report
	*/
	public void function deleteCustomReport( required numeric custom_report_id ) {
		getCustomReportDao().CustomReportRemove( argumentCollection=arguments );
		return;
	}
	private string function setColumnTypeList(  required numeric cnt ){
		var types = [];
		for( var i=1; i<=arguments.cnt; i++ ){
			arrayAppend( types, "VarChar" );
		}
		return arrayToList( types );
	}
	/**
	* createRegistrationSummaryReportXLS
	* This method will create the XLS file
	*/
	public any function createCustomReportXLS( required numeric custom_report_id ) {
		var report = runReport( custom_report_id=custom_report_id );
		var columns = report.columns;
		var results = arrayToQuery( report.results );
		var path = "";
		var columns_cnt = arrayLen( columns );
		var query = queryNew( arrayToList( columns ), setColumnTypeList( columns_cnt ) );
		var query_cnt = results.recordCount;
		var fn_header = getFnHeaderSetter();
		var fn_columns = getFnBodySetter();
		var sheet = spreadsheetNew();
		var filename =  getBaseX().encode( value=randRange( 999999, 1000000000 ), dict="DICTIONARY_16" ) & '.xls';
		//create the path
		path = expandPath( getConfig().paths.media & filename );
		//create the file
		fileWrite( path, '' );
		//format the query to be used
		//create the header row
		queryAddRow( query );
		for( var k=1;k<=columns_cnt;k++ ){
			querySetCell( query, columns[ k ], ucase( fn_header( columns[ k ], report.labels, report.selected_agenda_ids ) ) );
			querySetCell( query, 'first_name', "First Name" );
			querySetCell( query, 'last_name', "Last Name" );
			querySetCell( query, 'email', "Email" );
		}

		//create the body rows
		for( var i=1;i<=query_cnt;i++ ) {
			queryAddRow( query );
			for(var k=1;k<=columns_cnt;k++){
				if( listFindNoCase("hotel_checkout_date,hotel_checkin_date", columns[ k ] ) ) {
					querySetCell(query, columns[ k ], dateFormat( fn_columns( results[ columns[ k ] ][ i ], columns[ k ], report.selected_agenda_ids ), "mm/dd/yyyy") );
				}else{
					querySetCell(query, columns[ k ], fn_columns( results[ columns[ k ] ][ i ], columns[ k ], report.selected_agenda_ids )  );
				}
			}
			querySetCell( query, 'FIRST_NAME', results[ 'first_name' ][ i ] );
			querySetCell( query, 'last_name', results[ 'last_name' ][ i ] );
			querySetCell( query, 'email', results[ 'email' ][ i ] );
		}
		//write the spreadsheet
		if( structKeyExists( report, "header_text" ) && len( report.header_text ) ) {
			spreadsheetAddRow( sheet, report.header_text, 1,1 );
			SpreadsheetFormatRow( sheet, {'font':"Arial", 'fontsize':"16",'bold':"true",'alignment':"left",'textwrap':"false" }, 1);
		}
		spreadsheetAddRows( sheet, query );
		spreadsheetWrite( sheet, path, true );
		return filename;
	}
	/**
	* getAttendeeTypesAsStruct
	* This method will return a struct of attendee types
	**/
	public struct function getAttendeeTypesAsStruct( required numeric event_id ) {
		return queryToStruct( getRegistrationTypesDao().registrationTypesGet( event_id=arguments.event_id, active=1 ).result.registration_types );
	}
	/**
	* getAttendeeTypesAsStruct
	* This method will return a struct of attendee statuses
	**/
	public struct function getAttendeeStatusesAsStruct() {
		return queryToStruct( getAttendeeDao().AttendeeStatusesGet().result.statuses );
	}
	/**
	* getAttendeeTypesAsStruct
	* This method will return a struct of payment processors
	**/
	public struct function getPaymentProcessorsAsStruct() {
		return queryToStruct( getPaymentProcessorsDao().PaymentProcessorsGet().result.result1 );
	}
	/**
	* getAttendeeTypesAsStruct
	* This method will return a struct of registation fields
	**/
	public array function getRegistrationFieldsAsArray( required numeric event_id ){
		var i = 1;
		var k = 1;
		var fields = queryNew( "field_id, label, field_name", "VARCHAR, VARCHAR, VARCHAR" );
		var standard_fields = getStandardFields();
		var standard_fields_cnt = arrayLen( standard_fields );
		var custom_fields = getRegistrationFieldDao().RegistrationFieldsCustomList( event_id=arguments.event_id ).result.fields;
		var custom_fields_cnt = custom_fields.recordCount;
		for( i; i<=standard_fields_cnt; i++ ){
			queryAddRow( fields );
			querySetCell( fields, "field_id", standard_fields[ i ].field_id );
			querySetCell( fields, "label", standard_fields[ i ].label );
			querySetCell( fields, "field_name", standard_fields[ i ].field_name );
		}
		for( k; k<=custom_fields_cnt; k++ ){
			queryAddRow( fields );
			querySetCell( fields, "field_id", custom_fields.field_id[ k ] );
			querySetCell( fields, "label", custom_fields.label[ k ] );
			querySetCell( fields, "field_name", custom_fields.field_name[ k ] );
		}
		return queryToArray( fields );
	}
	/**
	* getAttendeeTypesAsStruct
	* This method will return a struct of registation fields
	**/
	public struct function getRegistrationFieldsAsStruct( required numeric event_id ){
		var i = 1;
		var k = 1;
		var fields = queryNew( "field_id, label, field_name", "VARCHAR, VARCHAR, VARCHAR" );
		var standard_fields = getStandardFields();
		var standard_fields_cnt = arrayLen( standard_fields );
		var custom_fields = getRegistrationFieldDao().RegistrationFieldsCustomList( event_id=arguments.event_id ).result.fields;
		var custom_fields_cnt = custom_fields.recordCount;

		for( i; i<=standard_fields_cnt; i++ ){
			queryAddRow( fields );
			querySetCell( fields, "field_id", standard_fields[ i ].field_id );
			querySetCell( fields, "label", standard_fields[ i ].label );
			querySetCell( fields, "field_name", standard_fields[ i ].field_name );
		}

		for( k; k<=custom_fields_cnt; k++ ){
			queryAddRow( fields );
			querySetCell( fields, "field_id", custom_fields.field_id[ k ] );
			querySetCell( fields, "label", custom_fields.label[ k ] );
			querySetCell( fields, "field_name", custom_fields.field_name[ k ] );
		}
		return queryToStruct( fields );
	}
	/**
	* getAgendasAsStruct
	* This method will return a struct of agendas for the opts list
	**/
	public query function getAgendasAsStruct( required numeric event_id ){
		var i = 1; var k = 1;
		var groups = ""; var groups_cnt = 0;
		var agendas = getAgendaDao().AgendasGet( event_id=arguments.event_id ).result.agendas;
		var agendas_cnt = agendas.recordCount;
		var grouped_agendas = {};
		var query = queryNew( "agenda_id, start_date, start_time, end_time, name, date_group", "INTEGER, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR" );
		var query_cnt = 0;
		//create a query of compiled data I can consume
		for( i; i<=agendas_cnt; i++ ){
			queryAddRow( query );
			querySetCell( query, 'agenda_id', agendas['agenda_id'][i] );
			querySetCell( query, 'name', agendas['label'][i] & ' ' & timeFormat( agendas['start_time'][i], "h:mm tt" ) & "-" & timeFormat( agendas['end_time'][i], "h:mm tt" ) );
			querySetCell( query, "start_date", dateFormat( agendas['start_time'][i], "dddd mmm dd, yyyy" ) );
			querySetCell( query, "start_time", timeFormat( agendas['start_time'][i], "h:mm tt" ) );
			querySetCell( query, "end_time", timeFormat( agendas['end_time'][i], "h:mm tt" ) );
			querySetCell( query, "date_group", dateConvert( "local2utc", agendas['start_time'][i] ).getTime() );
		}
		return query;
	}
	/**
	* saveReport
	* This method will
	**/
	public numeric function saveReport(
		required string report_name,
		required string start_date,
		required string end_date,
		required numeric event_id,
		string agenda_items="",
		string attendee_status="",
		string standard_fields="",
		string attendee_types="",
		string balance=0,
		numeric custom_report_id=0,
		string payment_methods=""
	) {
		var params = {};
		var where_clause = [];
		var report_id = len( arguments.custom_report_id ) ? arguments.custom_report_id : 0;
		//if we have payment methods
		if( structKeyExists( arguments, 'payment_methods' ) && len( arguments.payment_methods ) ){
			arrayAppend( where_clause, ' cpp.processor_id in (' & arguments.payment_methods & ')' );
		}

		//build the argument list
		params['filters'] = arrayLen( where_clause ) ? arrayToList( where_clause, " and " ) : "";
		params['label'] = arguments.report_name;
		params['attendee_types'] = arguments.attendee_types;
		params['attendee_statuses'] = arguments.attendee_status;
		params['range_from'] = dateFormat( arguments.start_date, 'mm/dd/yyyy' );
		params['range_to'] = dateFormat( arguments.end_date, 'mm/dd/yyyy' );
		params['agendas'] = arguments.agenda_items;
		params['fields'] = arguments.standard_fields;
		params['event_id'] = arguments.event_id;
		params['balance_due_operator'] = arguments.operator;
		params['balance_due'] = val( arguments.balance );
		params['payment_processors'] = arguments.payment_methods;
		//are we saving this? if so set the report id
		if( len( report_id ) ){
			params['custom_report_id'] = report_id;
		}
		//save the report, return the report id
		return getCustomReportDao().CustomReportSet( argumentCollection=params );
	}
	/**
	* getCustomReportParameters
	* This method will get the report parameters.
	**/
	public any function getCustomReportParameters( rc ) {
		return getCustomReportDao().CustomReportGet( argumentCollection=arguments );
	}
	/**
	* runReport
	* This method will run a custom report by the report id.
	**/
	public struct function runReport( required numeric custom_report_id ) {
		//get the parameters from the saved criteria
		var custom_report_fields = getCustomReportDao().CustomReportGet( argumentCollection=arguments );
		var params = {
			'label' : custom_report_fields.proc_vars.label,
			'event_id' : val( custom_report_fields.proc_vars.event_id ),
			'registration_type_id_list' : custom_report_fields.proc_vars.attendee_types,
			'attendee_status_list' : custom_report_fields.proc_vars.attendee_statuses,
			'agenda_id_list' : custom_report_fields.proc_vars.agendas,
			'registration_date_from' : dateFormat( custom_report_fields.proc_vars.range_from, "mm/dd/yyyy" ),
			'registration_date_to' : dateFormat( custom_report_fields.proc_vars.range_to, "mm/dd/yyyy" ),
			'filters' : custom_report_fields.proc_vars.filters,
			'fields' : custom_report_fields.proc_vars.fields,
			'balance_due' : custom_report_fields.proc_vars.balance_due,
			'balance_due_operator' : custom_report_fields.proc_vars.balance_due_operator
		};
		var reporting_results = getCustomReportDao().CustomReportingReport( argumentCollection=params ).result;
		var report_labels = {};
		//ge the custom report results and results count
		var custom_report_results = reporting_results.results;

		var custom_report_results_cnt = custom_report_results.recordCount;
		//get all avaiable fields we can build our query on
		var available_fields = custom_report_results.columnList;
		//need to pull out all of the agenda items if there are any
		var agenda_items = pluckAgendaItems( available_fields );
		//get the selected fields and make sure we add our default fields and the agenda items if any are avaialable
		//the agenda items need to be added last
		var standard_fields = "FIRST_NAME,LAST_NAME,EMAIL";
		var selected_fields = listToArray( listAppend( listAppend( standard_fields, custom_report_fields.result, "," ), agenda_items, "," ) );
		var selected_fields_cnt = arrayLen( selected_fields );
		//create the query and create the column headers
		var query = queryNew( arrayToList( selected_fields ) );

		//we need to loop over the report results and enter in the data in regards the users selected fields
		for( var idx=1; idx <= custom_report_results_cnt; idx++ ){
			//add a new row to this data
			queryAddRow( query );
			//this loop will loop over all selected fields and set the data that represents it
			//this corresponds to the fields that the user has selected
			for( var kdx = 1; kdx <= selected_fields_cnt; kdx++ ){
				if( listFindNoCase( custom_report_results.columnList, selected_fields[ kdx ] ) ){
					QuerySetCell( query, selected_fields[ kdx ], custom_report_results[ selected_fields[ kdx ] ][ idx ] );
				}
			}
			//loop over the custom fields and check to see if there are any selected custom fields in the request
			//if so lets populated
			if( len( custom_report_results[ 'custom' ][ idx ] )){
				//pluck out the json per the custom fields per query row
				var custom_fields = deserializeJSON( custom_report_results[ 'custom' ][ idx ] );

				//this loop will loop over all custom fields and set the data that represents it
				//this corresponds to the fields that the user has selected
				for( var jdx=1; jdx <= selected_fields_cnt; jdx++ ){
					if( structKeyExists( custom_fields, selected_fields[ jdx ] ) ){
						querySetCell( query, selected_fields[ jdx ], custom_fields[ selected_fields[ jdx ] ] );
					}
				}

			}
		}
		for (var i=1; i LTE reporting_results.labels.recordCount; i=i+1) {
			report_labels[ reporting_results.labels[ 'field_name' ][ i ] ] = reporting_results.labels[ 'label' ][ i ];
		}
		return {
			'header_text':reporting_results.event_details.name,
			'results' :  removeUnselectedAgendaRows( custom_report_fields.proc_vars.agendas, queryToArray( query ) ),
			'headers' : removeUnselectedAgendaHeaders( custom_report_fields.proc_vars.agendas, replaceBaseX( selected_fields ) ),
			'columns' : removeUnselectedAgendaHeaders( custom_report_fields.proc_vars.agendas, selected_fields ),
			'agenda_items' : removeUnselectedAgendaHeaders( custom_report_fields.proc_vars.agendas, listToArray( agenda_items ) ),
			'params' : params,
			'query' : query,
			'labels': report_labels,
			'selected_agenda_ids' : custom_report_fields.proc_vars.agendas
		};
	}

	/**
	* METHOD NAME - removeUnselectedAgendaRows
	* DESC - this will remove un selected agenda rows
	*/
	public array function removeUnselectedAgendaRows( required string agenda_items, required array rows  ){
	    var formatted_rows = [];
	    for( i=1; i <= arrayLen( rows ); i++ ){
	        var keys = listToArray( structKeyList( rows[ i ] ) );
	        for( var j = 1; j<=arrayLen( keys ); j++ ){
	            if( listFindNoCase( keys[ j ], "agenda", "_" )  && ! listFindNoCase( agenda_items, listLast( keys[ j ], "_" ) ) ){
	                structDelete( rows[ i ], keys[ j ] );
	            }
	        }
	        arrayAppend( formatted_rows, rows[ i] );
	    }
	    return formatted_rows;
	}
	/**
	* METHOD NAME - removeUnselectedAgendaHeaders
	* DESC - this will remove un selected agenda items from the header of the report
	*/
	public array function removeUnselectedAgendaHeaders( required string agenda_items, required array headers ){
	    var formatted_headers = [];
	    var uniques = [];
	    for( var i = 1; i<= arrayLen( headers ); i++ ){
	        var agenda_key_array = listToArray( headers[ i ], "_" );
			//custom agenda items have been selected
			if( len( agenda_items ) ){
		        for( var k = 1; k<= listLen( agenda_items ); k++ ){
		            //insert the agenda items
		            if( ArrayFindNoCase( agenda_key_array, "agenda" ) && ArrayFindNoCase( agenda_key_array, listGetAt( agenda_items, k ) )){
		                arrayAppend( formatted_headers, headers[ i ] );
		            }
		            //insert the non agenda items
		            if( ! ArrayFindNoCase( agenda_key_array, "agenda" ) && ! ArrayFindNoCase( agenda_key_array, listGetAt( agenda_items, k ) ) ){
		                arrayAppend( formatted_headers, headers[ i ] );
		            }
		        }
			}
			//default for scenarios where no agenda items are selected
			if( ! len( agenda_items )){
	            if( ! ArrayFindNoCase( agenda_key_array, "xxx" ) ){
	                arrayAppend( formatted_headers, headers[ i ] );
	            }
			}
	    }
	    for( i=1; i<=arrayLen( formatted_headers ); i++ ){
	        if( ! arrayFindNoCase( uniques, formatted_headers[i])){
	            arrayAppend( uniques, formatted_headers[i] );
	        }
	    }
	    return uniques;
	}


	/**
	* getCustomReportList
	* This method will get a list of custom reports
	**/
	public array function getCustomReportList( required numeric event_id ) {
		return queryToArray( getCustomReportDao().CustomReportsGet( argumentCollection=arguments ).result.report );
	}
	/**
	* arrayToQuery
	* This method will turn an array of struct to a query
	**/
	private query function arrayToQuery( array ){
	    var column_names = "";
	    var query = queryNew( "" );
	    var i=1;
	    var j=1;
	    //if there's nothing in the array, return the empty query
	    if( ! arrayLen( array ) ){
	        return query;
	    }
	    //get the column names into an array =
	    column_names = structKeyArray( array[ 1 ] );
	    //build the query based on the colNames
	    query = queryNew( arrayToList( column_names ) );
	    //add the right number of rows to the query
	    queryAddRow( query, arrayLen( array ));
	    //for each element in the array, loop through the columns, populating the query
	    for( var i=1; i <= arrayLen( array ); i++ ){
	        for( var j=1; j <= arrayLen( column_names ); j++ ){
	            querySetCell( query, column_names[ j ], array[ i ][ column_names[ j ] ], i );
	        }
	    }
	    return query;
	}
	/**
	* replaceBaseX
	* This method will strip the base x from the field column
	**/
	private array function replaceBaseX( required array fields ){
		var fields_cnt = arrayLen( fields );
		var i = 1;
		var list_cnt = 0;
		var final_fields = [];
		for( i; i<=fields_cnt; i++ ){
			list_cnt = listLen( fields[i], "_" );
			if( findNoCase( "xxx", left( listGetAt( fields[i], list_cnt, "_" ), 3 ) ) ){
				arrayAppend( final_fields, listDeleteAt( fields[i], list_cnt, "_" ) );
			}else{
				arrayAppend( final_fields, fields[i] );
			}
		}
		return final_fields;
	}

	/**
	* getFnBodySetter
	* This method will set the body column correctly
	**/
	public any function getFnBodySetter(){
		return function( column, key ){
			if( len( column ) eq 1 && column == "." ) return "";
			var hide_display_list = "first_name,last_name,email";
			if( listFindNoCase( hide_display_list, key ) ){
				return;
			}
			if( listFindNoCase("hotel_checkout_date,hotel_checkin_date", key ) ) {
				return dateFormat( column, "mm/dd/yyyy");
			}
			if( listFirst( key, "_" ) == "xxx" ){
				return yesNoFormat( column );
			}
			return column;
		};
	}
	/**
	* getFnHeaderSetter
	* This method will set the header column correctly
	**/
	public any function getFnHeaderSetter(){
		return function( header, labels={}, agenda_ids ){
			var hide_display_list = "first_name,last_name,email";
			if( listFindNoCase( hide_display_list, header ) ){
				return;
			}
			if( structKeyExists( labels, header ) && len( labels[header] )  ) {
				return labels[header];
			}
			if( listFirst( header, "_" ) == "xxx" ){
				var agenda_item = getAgendaDao().AgendaGet( agenda_id= val( listLast( header, "_" ) ) );

				if( ! listFindNoCase( agenda_ids, agenda_item.agenda_id )){
                    return;
                }
				return agenda_item.label & ' - ' & dateFormat( agenda_item.start_time, "mm/dd/yyyy" ) & ' ' & timeFormat( agenda_item.start_time, "h:mm tt" );
			}
			return reReplace( replace( header, "_", " ", "ALL" ), "\b(\w)", "\u\1", "ALL" );
		};
	}
	/**
	* pluckAgendaItems
	* This method will pluck the agenda items by id
	**/
	private string function pluckAgendaItems( required string fields ){
		var fields_cnt = listLen( arguments.fields );
		var agenda_items = "";
		for( var i=1; i<=fields_cnt; i++ ){
			if( listFirst( listGetAt( arguments.fields, i ), "_" ) == "xxx" ){
				agenda_items = listappend( agenda_items, listGetAt( arguments.fields, i ) );
			}
		}
		return agenda_items;
	}
	/**
	* getStandardFields
	* This method will return all standard fields
	**/
	private array function getStandardFields(){
		var tmp = [
			{ 'field_id' : "ACTIVE", 'label' : "Active", 'field_name' : "ACTIVE" },
			{ 'field_id' : "ADDRESS_1", 'label' : "Address 1", 'field_name' : "ADDRESS_1" },
			{ 'field_id' : "ADDRESS_2", 'label' : "Address 2", 'field_name' : "ADDRESS_2" },
			{ 'field_id' : "ATTENDEE_STATUS", 'label' : "Attendee Status", 'field_name' : "ATTENDEE_STATUS" },
			{ 'field_id' : "BALANCE_DUE", 'label' : "Balance Due", 'field_name' : "BALANCE_DUE" },
			{ 'field_id' : "CELL_PHONE", 'label' : "Cell Phone", 'field_name' : "CELL_PHONE" },
			{ 'field_id' : "CITY", 'label' : "City", 'field_name' : "CITY" },
			{ 'field_id' : "COMPANY_NAME", 'label' : "Company Name", 'field_name' : "COMPANY_NAME" },
            { 'field_id' : "country_name", 'label' : "Country", 'field_name' : "country_name" },
			{ 'field_id' : "COUNTRY_CODE", 'label' : "Country Code", 'field_name' : "COUNTRY_CODE" },
			{ 'field_id' : "DOB", 'label' : "Date Of Birth", 'field_name' : "DOB" },
			{ 'field_id' : "EMERGENCY_CONTACT_NAME", 'label' : "Emergency Contact Name", 'field_name' : "EMERGENCY_CONTACT_NAME" },
			{ 'field_id' : "EMERGENCY_CONTACT_PHONE", 'label' : "Emergency Contact Phone", 'field_name' : "EMERGENCY_CONTACT_PHONE" },
			{ 'field_id' : "EXTENSION", 'label' : "Extension", 'field_name' : "EXTENSION" },
			{ 'field_id' : "FAX_PHONE", 'label' : "Fax Phone", 'field_name' : "FAX_PHONE" },
			{ 'field_id' : "GENDER", 'label' : "Gender", 'field_name' : "GENDER" },
			{ 'field_id' : "HOME_PHONE", 'label' : "Home Phone", 'field_name' : "HOME_PHONE" },
			{ 'field_id' : "JOB_TITLE", 'label' : "Job Title", 'field_name' : "JOB_TITLE" },
			{ 'field_id' : "NAME_ON_BADGE", 'label' : "Name On Badge", 'field_name' : "NAME_ON_BADGE" },
			{ 'field_id' : "POSTAL_CODE", 'label' : "Postal Code", 'field_name' : "POSTAL_CODE" },
			{ 'field_id' : "PREFIX", 'label' : "Prefix", 'field_name' : "PREFIX" },
			{ 'field_id' : "REGION_CODE", 'label' : "Region Code", 'field_name' : "REGION_CODE" },
			{ 'field_id' : "REGISTRATION_TIMESTAMP", 'label' : "Registration Date", 'field_name' : "REGISTRATION_TIMESTAMP" },
			{ 'field_id' : "REGISTRATION_TYPE", 'label' : "Registration Type", 'field_name' : "REGISTRATION_TYPE" },
			{ 'field_id' : "SECONDARY_EMAIL", 'label' : "Secondary Email", 'field_name' : "SECONDARY_EMAIL" },
			{ 'field_id' : "SUFFIX", 'label' : "Suffix", 'field_name' : "SUFFIX" },
			{ 'field_id' : "TOTAL_CHARGES", 'label' : "Total Charges", 'field_name' : "TOTAL_CHARGES" },
			{ 'field_id' : "WORK_PHONE", 'label' : "Work Phone", 'field_name' : "WORK_PHONE" },
			{ 'field_id' : "CC_EMAIL", 'label' : "CC Email", 'field_name' : "CC_EMAIL" },
			{ 'field_id' : "hotel_requested", 'label' : "Hotel Requested", 'field_name' : "HOTEL_REQUESTED" },
			{ 'field_id' : "hotel_name", 'label' : "Hotel Name", 'field_name' : "HOTEL_NAME" },
			{ 'field_id' : "hotel_room_type", 'label' : "Hotel Room Type", 'field_name' : "HOTEL_ROOM_TYPE" },
			{ 'field_id' : "hotel_checkin_date", 'label' : "Hotel Checkin Date", 'field_name' : "HOTEL_CHECKIN_DATE" },
			{ 'field_id' : "hotel_checkout_date", 'label' : "Hotel Checkout Date", 'field_name' : "HOTEL_CHECKOUT_DATE" },
			{ 'field_id' : "hotel_number_rooms", 'label' : "Hotel Number Rooms", 'field_name' : "HOTEL_NUMBER_ROOMS" },
			{ 'field_id' : "hotel_reservation_name", 'label' : "Hotel Reservation Name", 'field_name' : "HOTEL_RESERVATION_NAME" },
			{ 'field_id' : "hotel_reservation_phone", 'label' : "Hotel Reservation Phone", 'field_name' : "HOTEL_RESERVATION_PHONE" },
			{ 'field_id' : "hotel_reservation_email", 'label' : "Hotel Reservation Email", 'field_name' : "HOTEL_RESERVATION_EMAIL" }
		];
		return tmp;
	}
}
