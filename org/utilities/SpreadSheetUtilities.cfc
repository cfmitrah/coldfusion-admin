
component output="false" displayname="SpreadSheetUtilities"  {
	

	public function init(){
		return this;
	}
	
	public string function createSimpleSpreadSheet(
		required query xls_query,
		required string file_path,
		required array columns,
		string filename = "",
		string file_type = ".xls",
		struct header_data = {},
		string header_text="",
		array custom_row_data = []
	){
		var i = 1;
		var k = 1;			
		var path = "";
		var basex = new BaseX();
		var params = arguments;		
		var query = queryNew( arrayToList( params.columns ) );
		var columns_cnt = arrayLen( params.columns );
		var query_cnt = arguments.xls_query.recordCount;
		var sheet = spreadsheetNew();
		//set the file name
		params.filename = ( len( params.filename ) ? params.filename : basex.encode( value=randRange( 999999, 1000000000 ), dict="DICTIONARY_16" ) ) & arguments.file_type;
		//create the path
		path = expandPath( params.file_path & params.filename );
		//create the file
		fileWrite( path, '' );
		
		//format the query to be used	
		//create the header row
		queryAddRow( query );
		for( k=1;k<=columns_cnt;k++ ){
			var col = columns[ k ];
			var col_label = col;
			if( structKeyExists( header_data, col ) ) {
				col_label = header_data[ col ];
			}
			querySetCell( query, col, ucase( col_label ) );
//			querySetCell( query, col, ucase( replace( col_label, "_", " ", "ALL" ) ) );
		}
		
		//create the body rows
		for( i=1;i<=query_cnt;i++ ) {
			queryAddRow( query );
			for(k=1;k<=columns_cnt;k++){
				var field_val = replace( params.xls_query[ columns[ k ] ][ i ], ",", " ", "ALL" );
				if( isdate( field_val ) ) {
					querySetCell(query, columns[ k ], " " & dateformat( field_val, "mm/dd/yyyy") );
				}else{
					querySetCell(query, columns[ k ], field_val );
				}
			}
		}

		//write the spreadsheet
		if( len( arguments.header_text ) ) {
			spreadsheetAddRow( sheet, arguments.header_text, 1,1 );
			SpreadsheetFormatRow( sheet, {'font':"Arial", 'fontsize':"16",'bold':"true",'alignment':"left",'textwrap':"false" }, 1);
		}

		//if we have a custom row data lets prepend this 
		if( arrayLen( custom_row_data ) ){
			var custom_row_cnt = arrayLen( custom_row_data );
			spreadsheetAddRow( sheet, "  ", 1,1 );
			for( k=1;k<=custom_row_cnt;k++ ){
				spreadsheetAddRow( sheet, replace( custom_row_data[ k ], ",", " ", "ALL" ), k,1 );
				spreadsheetFormatRow( sheet, {'font':"Arial", 'fontsize':"16",'bold':"true",'alignment':"left",'textwrap':"false" }, k );
			}	
			
			for( i = 1; i<= custom_row_cnt; i++ ){
				SpreadSheetSetRowHeight( sheet, i, 30 );
			}		
			spreadsheetAddRow( sheet, "  ", 1,1 );
		}
		
		spreadsheetAddRows( sheet, query );		
		spreadsheetWrite( sheet, path, true );
		//out
		return params.filename;
	}
}

