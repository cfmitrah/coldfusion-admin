/**
*
* @file  /model/managers/SystemAdmin.cfc
* @author
* @description
*
*/

component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="systemAdminDao" getter="true" setter="true";
	/**
	* Multi line method description
	*
	*/
	public struct function getListing( numeric order_index=0, string order_dir="asc", string search_value="", numeric start_row=0, numeric total_rows=10, numeric draw=1 ) {
		var system_admins = getSystemAdminDao().SystemAdminsGet( (start_row+1), total_rows).result.system_admins;
		var rtn = {"draw"=arguments.draw, "recordsTotal"=system_admins.recordCount, "recordsFiltered"=system_admins.recordCount,"data"=[]};

		for ( var i=1; i <= system_admins.RecordCount; i++) {
			arrayappend( rtn['data'], queryRowToStruct( system_admins, i, true ));
		}

		return rtn;
	}

	/**
	* Multi line method description
	*
	*/
	public any function create( required struct props ) {

		return;
	}

	/**
	* Multi line method description
	*
	*/
	public any function save( required struct props ) {

		return;
	}



	/**
	* Handles Getting a list of all of the stored procedures
	*/
	public struct function getStoredProcedures() {
		var data = getSystemAdminDao().StoredProceduresList().result;
		var result = queryToStruct( recordset=data );
		result['count'] = data.recordCount;
		return result;
	}
	/**
	* Gets a Procedure and Parses it
	*/
	public struct function getStoredProcedure( required string name ) {
		var data = getSystemAdminDao().StoredProcedureGet( name=arguments.name ).result;
		var result = queryToStruct( recordset=data.metadata, single=true );
		var buffer = createObject( "java", "java.lang.StringBuilder" );
		result['parameters'] = queryToArray( recordset=data.parameters );
		result['definition'] = "";
		result['parameter_cnt'] = data.parameters.recordCount;
		// loop the sp_helptext result and build the procedure
		for( var i = 1; i <= data.definition.recordCount; i++ ){
			buffer.append( data.definition.text[i] );
		}
		result['definition'] = buffer.toString();
		buffer.setLength( 0 );
		return result;
	}
	/**
	* Gets a Procedure and Parses it
	*/
	public string function buildDaoMethod( required struct details ) {
		var buffer = createObject( "java", "java.lang.StringBuilder" );
		var crlf = chr( 13 ) & chr( 10 );
		var tab = chr( 9 );
		var required = {
			'yes': "required ",
			'no': ""
		};
		var cf_sql_types = {
			'BIGINT': "cf_sql_bigint",
			'INT': "cf_sql_integer",
			'TINYINT': "cf_sql_tinyint",
			'SMALLINT': "cf_sql_smallint",
			'BIT': "cf_sql_bit",
			'CHAR': "cf_sql_char",
			'NCHAR': "cf_sql_char",
			'DATE': "cf_sql_date",
			'DATETIME': "cf_sql_timestamp",
			'DATETIME2': "cf_sql_timestamp",
			'SMALLDATETIME': "cf_sql_timestamp",
			'DECIMAL': "cf_sql_decimal",
			'DOUBLE': "cf_sql_double",
			'FLOAT': "cf_sql_float",
			'MONEY': "cf_sql_money",
			'REAL': "cf_sql_real",
			'TIME': "cf_sql_time",
			'VARCHAR': "cf_sql_varchar",
			'NVARCHAR': "cf_sql_varchar",
			'TEXT': "cf_sql_longvarchar",
			'NTEXT': "cf_sql_longvarchar"
		};
		var cf_types = {
			'BIGINT': "numeric",
			'INT': "numeric",
			'TINYINT': "numeric",
			'SMALLINT': "numeric",
			'BIT': "boolean",
			'CHAR': "string",
			'NCHAR': "string",
			'DATE': "date",
			'DATETIME': "date",
			'DATETIME2': "date",
			'SMALLDATETIME': "date",
			'DECIMAL': "numeric",
			'DOUBLE': "numeric",
			'FLOAT': "numeric",
			'MONEY': "numeric",
			'REAL': "numeric",
			'TIME': "date",
			'VARCHAR': "string",
			'NVARCHAR': "string",
			'TEXT': "string",
			'NTEXT': "string"
		};
		var has_output = hasOutput( params=arguments.details.parameters, cnt=arguments.details.parameter_cnt ); // determine if there are any output params
		var has_single_id_output = hasSingleIdOutput( params=arguments.details.parameters, cnt=arguments.details.parameter_cnt ); // determine if there is only 1 output and it is an id
		var query_count = queryCount( definition=arguments.details.definition );
		var types = {
			'yes': "inout",
			'no': "in"
		};
		var comment = reMatch( "\s*/\*.+\*/", arguments.details.definition );
		if( arrayLen( comment ) ) {
			buffer.append( comment[1] );
			buffer.append( crlf );
		}
		// method definition
		buffer.append( "	public ");
		// try to determine if we should return a void, struct or number
		if( !query_count && !has_output ){
			buffer.append( "void" );
		}
		else if( has_single_id_output ){
			buffer.append( "numeric" );
		}
		else{
			buffer.append( "struct" );
		}
		buffer.append(" function " ).append( arguments.details.name ).append( "(");
		// arguments
		if( !arguments.details.parameter_cnt ) {
			buffer.append( ") {" );
		}
		else if(arguments.details.parameter_cnt == 1 ) {
			buffer.append( " " ).append( required[isRequired( param=arguments.details.parameters[1].param, data_type=arguments.details.parameters[1].data_type, definition=arguments.details.definition )== true || arguments.details.parameters[1].name.indexOf( "_id" ) != -1] ).append( cf_types[arguments.details.parameters[1].data_type] ).append( " " ).append( arguments.details.parameters[1].name ).append( " ) {" ).append( crlf );
		}
		else {
			buffer.append( crlf );
			for( var i = 1; i <= arguments.details.parameter_cnt; i++ ){
				buffer.append( "		" ).append( required[isRequired( param=arguments.details.parameters[i].param, data_type=arguments.details.parameters[i].data_type, definition=arguments.details.definition ) == true || arguments.details.parameters[i].name.indexOf( "_id" ) != -1] ).append( cf_types[arguments.details.parameters[i].data_type] ).append( " " ).append( arguments.details.parameters[i].name ).append( defaultValue( param=arguments.details.parameters[i].param, data_type=arguments.details.parameters[i].data_type, definition=arguments.details.definition ) ).append( "," ).append( crlf );
			}
			buffer.append( "	" ).append(") {").append( crlf );
		}
		// body
		buffer.append( "		var sp = new StoredProc();" ).append( crlf );
		buffer.append( "		var result = {}; " ).append( crlf );
		if( has_output ) {
			buffer.append( "		var data = {}; " ).append( crlf );
		}
		buffer.append( "		sp.setAttributes({" ).append( crlf );
		buffer.append( "			'datasource': getDSN()," ).append( crlf );
		buffer.append( "			'procedure': """).append( arguments.details.name ).append( """" ).append( crlf );
		buffer.append( "		});" ).append( crlf );
		if( hasString( params=arguments.details.parameters, cnt=arguments.details.parameter_cnt ) ) {
			buffer.append( "		trim_fields( arguments );  // trim all of the inputs").append( crlf );
		}
		// loop over all of the params and add their attributes
		for( var i = 1; i <= arguments.details.parameter_cnt; i++ ) {
			// generate the add param line and set the type to in or inout, "out" only params will have to be determined manually
			buffer.append( "		sp.addParam( type=""" ).append( types[arguments.details.parameters[i].is_output == 1] ).append( """" );
			// set the dbvarname
			buffer.append( ", dbvarname=""").append( arguments.details.parameters[i].param ).append( """" );
			// set the cfsqltype
			buffer.append(", cfsqltype=""").append( cf_sql_types[arguments.details.parameters[i].max_length == "MAX" ? "TEXT" : arguments.details.parameters[i].data_type] ).append( """" );
			// set the value
			buffer.append(", value=arguments.").append( arguments.details.parameters[i].name );
			// set the max_length if it is a string and it is not a MAX length param
			if( cf_types[arguments.details.parameters[i].data_type] == "string" && arguments.details.parameters[i].max_length != "MAX" ) {
				if( arguments.details.parameters[i].data_type.startsWith( "N" ) ) { // double byte checks
					buffer.append( ", maxlength=" ).append( javaCast( "string", int( arguments.details.parameters[i].max_length / 2 ) ) );
				}
				else{
					buffer.append( ", maxlength=" ).append( arguments.details.parameters[i].max_length );
				}
			}
			// set the null attribute
			if( !isRequired( param=arguments.details.parameters[i].param, data_type=arguments.details.parameters[i].data_type, definition=arguments.details.definition ) ) {
				// if it is numeric
				if( cf_types[arguments.details.parameters[i].data_type] == "numeric" ) {
					buffer.append( ", null=( !arguments." ).append( arguments.details.parameters[i].name ).append( " )" );
				}
				else{
					buffer.append( ", null=( !len( arguments." ).append( arguments.details.parameters[i].name ).append( " ) )" );
				}
			}
			// set the output variable
			if( arguments.details.parameters[i].is_output ) {
				buffer.append( ", variable=""" ).append( arguments.details.parameters[i].name ).append( """" );
			}
			buffer.append( " );" ).append( crlf );
		}
		// add any proc results
		for( var i = 1; i <= query_count; i++ ){
			buffer.append( "		sp.addProcResult( name=""result").append( javaCast("string", i ) ).append(""", resultset=").append( javaCast("string", i )  ).append(" );").append( crlf );
		}
		// add the execution and output
		buffer.append( "		result = sp.execute();").append( crlf );
		if( !query_count && !has_output ){
			buffer.append( "		return;").append( crlf );
			buffer.append( "	}");
		}
		else if( has_single_id_output ){
			buffer.append( "		return result.getProcOutVariables().").append( getSingleSingleIdOutput( params=arguments.details.parameters, cnt=arguments.details.parameter_cnt ) ).append(";").append( crlf );
			buffer.append( "	}");
		}
		else if( has_output) {
			buffer.append( "		data['prefix'] = result.getPrefix();").append( crlf );
			buffer.append( "		structAppend( data, result.getProcOutVariables() );" ).append( crlf );
			if( query_count == 1 ) {
				buffer.append( "		data['result'] = result.getProcResultSets().result1 );" ).append( crlf );
			}
			else if( query_count > 1 ) {
				buffer.append( "		structAppend( data, result.getProcResultSets() );" ).append( crlf );
			}
			buffer.append( "		return data;").append( crlf );
			buffer.append( "	}");
		}
		else{
			if( query_count == 1 ) {
				buffer.append( "		return {").append( crlf );
				buffer.append( "			'prefix' = result.getPrefix(),").append( crlf );
				buffer.append( "			'result' = result.getProcResultSets().result1").append( crlf );
				buffer.append( "		};").append( crlf );
			}
			else{
				buffer.append( "		return {").append( crlf );
				buffer.append( "			'prefix' = result.getPrefix(),").append( crlf );
				buffer.append( "			'result' = result.getProcResultSets()").append( crlf );
				buffer.append( "		};").append( crlf );
			}
			buffer.append( "	}");
		}
		return buffer.toString();
	}
	/**
	* Determines if there are any output variables
	*/
	public boolean function hasString( required array params, required numeric cnt ) {
		var string_types = "CHAR,NCHAR,VARCHAR,NVARCHAR";
		var has_string = false;
		for( var i = 1; i <= arguments.cnt; i++ ){
			if( listFindNoCase(string_types, arguments.params[i].data_type) ) {
				has_string = true;
				break;
			}
		}
		return has_string;
	}
	/**
	* Determines the number of queries that the proc returns
	*/
	public numeric function queryCount( required string definition ) {
		var count = 0;
		var match = [];
		var match_cnt = 0;
		// count the number of selects
		count = arrayLen( reMatch( "SELECT", arguments.definition ) );
		// count the number of EXECUTE statements that don't end in SET
		match = reMatch( "EXECUTE\sdbo\.[^\n ]+", arguments.definition );
		match_cnt = arrayLen( match );
		for( var i = 1; i <= match_cnt; i++ ) {
			if( !match[i].endsWith( "Set" ) && !match[i].endsWith( "HandleError" ) ){
				count = count + 1;
			}
		}
		// check to see if sp_executesql is found
		if( arrayLen( reMatch( "sp_executesql", arguments.definition ) ) ){
			count = 1;
		}

		return count;
	}
	/**
	* Determines if there are any output variables
	*/
	public boolean function hasOutput( required array params, required numeric cnt ) {
		var has_output = false;
		for( var i = 1; i <= arguments.cnt; i++ ){
			if( arguments.params[i].is_output ) {
				has_output = true;
				break;
			}
		}
		return has_output;
	}
	/**
	* Determines if there are any output variables
	*/
	public boolean function hasSingleIdOutput( required array params, required numeric cnt ) {
		var outputs = 0;
		for( var i = 1; i <= arguments.cnt; i++ ){
			if( arguments.params[i].is_output && arguments.params[i].name.indexOf( "_id" ) != -1 ) {
				outputs = outputs + 1;
			}
		}
		return outputs == 1;
	}
	/**
	* Gets the single output variables name
	*/
	public string function getSingleSingleIdOutput( required array params, required numeric cnt ) {
		var param = "";
		for( var i = 1; i <= arguments.cnt; i++ ){
			if( arguments.params[i].is_output && arguments.params[i].name.indexOf( "_id" ) != -1 ) {
				param = arguments.params[i].name;
				break;
			}
		}
		return param;
	}
	/**
	* Determines if a param is required or not
	*/
	public string function defaultValue( required string param, required string data_type, required string definition ) {
		var value = "";
		var match = reMatch( arguments.param & " " & arguments.data_type & "[^\n]+=[^\n]+", arguments.definition );
		if( arrayLen( match ) ) {
			// get the value
			value = match[1].replaceAll( "^[^=]+=\s*", "" ).replaceAll( "(?i)\sOUTPUT", "" ).replaceAll( ",$", "" );
			// convert the value
			value = value.replaceAll( "^'", """" ).replaceAll( "'$", """" );
			value = value.replaceAll( "(?i)NULL", """""" );
			if( arguments.param.indexOf( "_id" ) != -1 ) {
				value = "0";
			}
			value = "=" & value;
		}
		return value;
	}
	/**
	* Determines if a param is required or not
	*/
	public boolean function isRequired( required string param, required string data_type, required string definition ) {
		return !arrayLen( reMatch( arguments.param & " " & arguments.data_type & "[^\n]+=", arguments.definition ) );
	}


}