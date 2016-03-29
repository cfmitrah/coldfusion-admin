/**
 *
 * @depends /plugins/chosen/chosen.jquery.js
 * @depends /plugins/jquery.multi-select.js
 * @depends /plugins/moment/moment-date-timepicker.js
 
 */

 $(function(){
	$('.datetime').datetimepicker({
	    pickTime: false,
	}).on( 'blur', function( event ){
		$( '.bootstrap-datetimepicker-widget:visible' ).hide();
	});
	 
 	$('.chosen').chosen();
	$('#std-field-select').multiSelect({keepOrder: true,
		afterSelect: function(values){
			cfrequest.standard_fields = $.ListAppend( cfrequest.standard_fields, values );
			$("#report-standard-fields").val( cfrequest.standard_fields );
		},
		afterDeselect: function(values){
			$( values ).each(function( idx, name){
				var pos = $.ListFindNoCase( cfrequest.standard_fields, name );
				if( pos ) {
				    cfrequest.standard_fields = $.ListDeleteAt( cfrequest.standard_fields, pos );
				}
				$("#report-standard-fields").val( cfrequest.standard_fields );		
			})
		
		}
	});

	$(cfrequest.standard_fields_array).each(function( idx, el ){
		$("#std-field-select").multiSelect('select', el );
	});
	

 	$('#select-all-ff').click(function(){
 	  $('#std-field-select').multiSelect('select_all');
 	  return false;
 	});
 	$('#deselect-all-ff').click(function(){
 	  $('#std-field-select').multiSelect('deselect_all');
 	  return false;
 	});

 	$('#agenda-item-select').multiSelect({ selectableOptgroup: true });

 	$('#select-all-ai').click(function(){
 	  $('#agenda-item-select').multiSelect('select_all');
 	  return false;
 	});
 	$('#deselect-all-ai').click(function(){
 	  $('#agenda-item-select').multiSelect('deselect_all');
 	  return false;
 	});

 	//modals
	var $delete_report_modal = $( "#delete-report" );
	var $run_report_modal = $("#run-report");
	
	$( ".run-report-modal" ).on( 'click', function( event ){
		var $link = $( this );
		//trigger the modal
		$run_report_modal.modal();
		$("#run-report-action").one( 'click', function( event ){
			$run_report_modal.modal( 'hide' );
			//temporary untill we have a report ID to navigate to
			window.location = cfrequest.run_custom_report_url + '?custom_report_id=' + $link.data( 'custom_report_id' );
		});
		event.preventDefault();
	});

	$( ".delete-report-modal" ).on( 'click', function( event ){
		var $link = $( this ), 
		$row = $link.parents( 'tr' ),
		data = $row.data();
		console.log( data );
		//trigger the modal
		$delete_report_modal.modal();
		$("#delete-report-action").one( 'click', function( event ){			
			$delete_report_modal.modal( 'hide' );
			$row.remove();
			$.ajax({
				url: cfrequest.ajax_delete_report_url,
				type: "POST",
				data: data,
				cache: false,
			    dataType: "json"
			}).then(function(){
				console.log( 'success' );	
			},function(){
				console.warn( 'There was an error', arguments );				
			});
		});
		
		event.preventDefault();
	});
 	


 });