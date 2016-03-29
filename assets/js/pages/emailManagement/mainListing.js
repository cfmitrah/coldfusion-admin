/**
 *
 * @depends /plugins/datatables/jquery.dataTables.min.js
 * @depends /plugins/datatables/dataTables.bootstrap.js
 * @depends /plugins/cfjs/jquery.cfjs.js
 */
var dataTable="", aaSorting, iDisplayLength=10;
$(function() {
	$.each( cfrequest, function( idx, config ){
		var aoColumns = config.aoColumns, table_id=config.table_id, 
			ajax_source=config.ajax_source;
		if( ajax_source != undefined && aoColumns != undefined && table_id  != undefined){
			setDataTables( ajax_source, aoColumns, table_id );
		}
	});
});
function setDataTables( source, cols, tableid, display_length ){
	iDisplayLength = display_length;
	var dt = $('#' + tableid ).dataTable( {
				"processing": true,
				"serverSide": true,
				"autoWidth": false,
				"iDisplayLength": iDisplayLength,
				"ajax": {
					"url": source,
					"type": "POST"
				},
				"fnDrawCallback": function( oSettings ) {
					$('#' + tableid ).trigger('table_ready');
				},
				"fnInitComplete": function() {
				},
				"columns": cols,
				 "aaSorting": []
				 
			} );	
	return dt;
}