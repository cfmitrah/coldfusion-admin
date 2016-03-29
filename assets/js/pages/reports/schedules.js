/**
 *
 * @depends /plugins/cfjs/jquery.cfjs.js
 * @depends /plugins/ckeditor/ckeditor.js
 * @depends /pages/common/media.js
 * @depends /plugins/moment/moment-date-timepicker.js
 * @depends /plugins/parsley/parsley.js
 * @depends /plugins/underscore/underscore-min.js
 */
$(function(){
	$( 'form.validate-frm' ).parsley();	
	$('#weekly-or-daily').on('change', function(e){
 		e.preventDefault();
 		if(this.value == 'weekly') {
 			$('#day-picker').prop("disabled", false);
 		} else if(this.value == 'daily') {
 			$('#day-picker').prop("disabled", true);
 		}
 	});

	$('.datetime').datetimepicker({
	    pickTime: false,
	}).on( 'blur', function( event ){
		$( '.bootstrap-datetimepicker-widget:visible' ).hide();
	});

	$( '#create-scheduled-custom-report' ).on( 'click', function( vent ){
		var $modal, data, $dfr;
		data = $( this ).data();
		$( '.whiteout' ).show();
		$modal = $( "#custom-schedule-modal" );
		$modal.modal();
		$dfr = $.ajax({
			url: cfrequest.get_custom_reports,
			type : "GET",
			cache: false,
		    dataType: "json"
		});
		$dfr.done(function( ret ){
			var reports, $select;
			$select = $( '#custom_report_id' );
			reports = $.parseJSON( ret.reports );
			_.each( reports, function( report, idx){
				var $option = $( '<option />', { 'value' : report.custom_report_id, 'text' : report.label});
				$select.append( $option );
			}, this );
			$( '.whiteout' ).hide();
		});				
		vent.preventDefault();
	});

	


	$( '.edit_schedule' ).on( 'click', function(){
		var $modal, data, $dfr;
		data = $( this ).data();
		$( '.whiteout' ).show();
		$modal = $( "#schedule-modal" );
		$modal.modal();
		$( '#report-name' ).html( data.report_title + " Scheduled Report Settings" );
		console.log( $( '#report-name' ).text() );
		$dfr = $.ajax({
			url: cfrequest.edit_report_url,
			type : "POST",
			data : data, 
			cache: false,
		    dataType: "json"
		});
		
		$dfr.done(function(){
			var args, report;
			args = Array.prototype.slice.call( arguments );
			report = args[0].report;
			$( '#report_schedule_id' ).val( data.report_schedule_id );
			$( '#report_settings' ).val( report.report_settings );
			$( '#report' ).val( report.report );
			$( '#from' ).val( report.FROM_EMAIL );
			$( '#scheduled_to' ).val( report.to_email );
			$( '#scheduled_subject' ).val( report.subject );
			$( '#weekly-or-daily' ).val( report.frequency );
			$( '#day-picker' ).val( report.day == "" ? 2 : report.day );
			$( '#scheduled_startdate' ).val( report.begin_on );
			$( '#scheduled_enddate' ).val( report.end_on );
			if( report.frequency == 'daily' ){
	 			$('#day-picker').prop("disabled", true);				
			}else{
	 			$('#day-picker').prop("disabled", false );				
			}
			$( '.whiteout' ).hide();
		})
	});

	$( '.delete_schedule' ).on( 'click', function( event ){
		var $modal, data;
		$modal = $( "#delete-schedule" );
		data = $( this ).data();
		$modal.modal();
		$( '#delete-schedule-action' ).on( 'click', function( event ){
			$( '#row_' + data.report_schedule_id ).hide();
			$modal.modal( 'hide' );
		});
		event.preventDefault();
	});
});	
