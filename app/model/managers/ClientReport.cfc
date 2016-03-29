/**
*
* @file  /model/managers/ClientReport.cfc
* @author  
* @description
*
*/
 
component output="false" displayname="Client Report" accessors="true" extends="app.model.base.Manager" {
	property name="ClientReportDao";
 	property name="Underscore";
	property name="SpreadSheetUtilities";
	property name="config";

	//**************
	// METHOD NAME - getClientReportList
	//**************
	public struct function getClientReportList( required numeric event_id ){
		var list = queryToArray( 
				getClientReportDao().ClientReportsGet(argumentCollection={
					'event_id' : event_id
				}).result.list
		);
		return {
			'list' : list,
			'list_cnt' : arrayLen( list )
		};
	}
	//**************
	// METHOD NAME - downloadReport
	//**************
	public string function downloadReport( required numeric client_report_id, required numeric event_id ){
		var _ = getUnderscore();
		//pluck out the correct item
		var report_details = _.first( _.where( getClientReportList( event_id ).list, { 'client_report_id' : client_report_id } ) );
		var report_header = formatHeaderData( deserializeJSON( report_details.header ) );
		var report_proc = report_details.sproc;
		var results = getClientReportDao().genericProcExecute( report_proc ).result.data;
		//since MP is requiring us to go against CF standards I have to do some crazy shit
		var columns_headers = formatColumnList( results.GetColumnNames() );		
		var column_list = columns_headers.columns;
		var header_data = columns_headers.headers;
		var filename = formatFileName( report_details.label );
		//since MP is requiring us to go against CF standards I have to do some crazy shit
		var query = reformatQuery( results, column_list );		
		
		//generate the elx
		getSpreadSheetUtilities().createSimpleSpreadSheet( argumentCollection:{ 
			'xls_query' : query,
			'file_path' : getConfig().paths.media,
			'columns' : column_list,
			'filename' : filename,
			'header_data' : header_data,
			'custom_row_data' : report_header
		});		
		return getConfig().paths.media & filename & ".xls";
	}
	//**************
	// METHOD NAME - formatHeaderData
	//**************
	private array function formatHeaderData( required struct header ){
		var _ = getUnderscore();
		var tmp = [];
		for( var key in header ){
			//most likely will need to be a more dynamic method
			arrayAppend( tmp, replace( header[ key ], "@@DATE@@", dateFormat( now(), "mm/dd/yyyy" ), "ALL" ) );
		}
		return tmp;
	}
	//**************
	// METHOD NAME - reformatQuery
	//**************
	public any function reformatQuery( data, columns){
		var query = queryNew( arrayToList( columns ) );
		var columns_cnt = arrayLen( columns );
		var query_cnt = data.recordCount;
		var headers = data.GetColumnNames();
		var header_cnt = arrayLen( headers );
		//create the body rows
		for(var i = 1; i <= query_cnt; i++ ) {
			queryAddRow( query );
			for(var k=1; k<= columns_cnt; k++ ){
				var tmp_header = "x" & rereplace( headers[ k ],  "[^\w]", "", "all" );
				if( tmp_header == columns[ k ] ){
					querySetCell(query, columns[ k ], data[ headers[ k ] ][ i ] );	
				}
			}
		}
		return query;
	}
	//**************
	// METHOD NAME - formatFileName
	//**************
	private string function formatFileName( required string filename ){
		return replace( filename, " ", "-", "ALL" ) & "-" & now().getTime();
	}
	//**************
	// METHOD NAME - formatColumnList
	//**************
	public any function formatColumnList( cols ){
		var cols_cnt = arrayLen( cols );
		var columns = [];
		var headers = createObject( "java", "java.util.LinkedHashMap" ).init();
		for( var i = 1; i<= cols_cnt; i++ ){
			var stripped_column = "x" & rereplace( cols[ i ], "[^\w]", "", "all" );
			arrayAppend( columns, stripped_column );
			headers[ stripped_column ] = cols[ i ];
		}
		return {
			columns : columns,
			headers : headers
		};
	}
}