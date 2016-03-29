/**
 *
 * @depends /plugins/datatables/jquery.dataTables.min.js
 * @depends /plugins/datatables/dataTables.bootstrap.js
 * @depends /plugins/cfjs/jquery.cfjs.js
 */
var dataTable="", aaSorting, iDisplayLength=10;
var cfrequest = cfrequest || {};
$(function() {
	var aoColumns = cfrequest.aoColumns, table_id=cfrequest.table_id, 
		ajax_source=cfrequest.ajax_source,display_length=cfrequest.display_length;
	if( display_length != undefined && display_length != undefined ){
		iDisplayLength = display_length;
	}
	if( ajax_source != undefined && aoColumns != undefined && table_id  != undefined){
		dataTable = setDataTables( ajax_source, aoColumns, table_id );
	}
	
	
});

function setDataTables( source, cols, tableid, display_length ){
	if( display_length != undefined && display_length != undefined ){
		iDisplayLength = display_length;
	}
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
				"infoCallback" : function(){
					if ( typeof fnDataTableCallback !== 'undefined' && $.isFunction( fnDataTableCallback )) {
						fnDataTableCallback();	
					}					
				},
				"columns": cols,
				 "aaSorting": []
				 
			} );	
	return dt;
}