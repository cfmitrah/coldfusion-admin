/**
 *
 * @depends /plugins/cfjs/jquery.cfjs.js
 * @depends /plugins/ckeditor/ckeditor.js
 * @depends /pages/common/media.js
 * @depends /plugins/moment/moment-date-timepicker.js
 * @depends /plugins/parsley/parsley.js
 */
$(function(){
	$( 'form.validate-frm' ).parsley();	

	$('.datetime').datetimepicker({
	    pickTime: false,
	}).on( 'blur', function( event ){
		$( '.bootstrap-datetimepicker-widget:visible' ).hide();
	});
	
	$( '.balance_opts' ).on( 'click', function(){
		$( '#balance_due_input' ).hide();
		if( $( this ).data( 'showbalance' ) == 1 ){
			$( '#balance_due_input' ).show().find( 'input' ).val( 0 );
		}
		
	});
	$('#weekly-or-daily').on('change', function(e){
 		e.preventDefault();
 		if(this.value == 'weekly') {
 			$('#day-picker').prop("disabled", false);
 		} else if(this.value == 'daily') {
 			$('#day-picker').prop("disabled", true);
 		}
 	});
 	
 	
 	$( "#save_schedule" ).on( "click", function(e){
	 	var report_fields, report_type, report_json, scheduled_params;
	 	report_fields = $( '.report_field' );
	 	report_type = $( '#report_type' ).val();
	 	report_json = format_report_params[ "get_" + report_type ]( report_fields );
	 	scheduled_params_json = format_report_params.get_scheduled_params();
	 	if( ! scheduled_params_json ){
		 	alert( 'All fields are required' );
		 	return false;
	 	}
	 	$.ajax({
		 	'type' : "POST",
		 	'url' : "/scheduledReports/ajaxDoSaveSchedule",
		 	'data' : { report_params : report_json, scheduled_params : scheduled_params_json }
	 	});
	 	return true;
 	});
 	
 	var format_report_params = {
 		get_hotel_reservations: function(){
 			var params;
		 	params = {
				'event_id' : parseInt( $( '#event_id' ).val() )
		 	};
		 	return JSON.stringify( params );
 		},
	 	get_coupons : function(){
		 	var params;
		 	params = {
				'event_id' : parseInt( $( '#event_id' ).val() ),
				'coupon_code_list' : $( '#coupon_code_list' ).val() ? $( '#coupon_code_list' ).val().join(",") : "",
				'coupon_type_list' : $( '#coupon_type_list' ).val() ? $( '#coupon_type_list' ).val().join(",") : ""
		 	};
		 	return JSON.stringify( params );
	 	},
 		get_invitation_status : function(){
		 	var params;
		 	params = {
				'company_id' : parseInt( $( '#company_id' ).val() ),
				'event_id' : parseInt( $( '#event_id' ).val() ),
				'invitation_id' : parseInt( $( '#invitation_id' ).val() ),
				'sent_date_from' : $( '#sent_date_from' ).val(),
				'sent_date_to' : $( '#sent_date_to' ).val()
		 	};
		 	return JSON.stringify( params );
 		},
 		get_registration_fees : function(){
		 	var params;
		 	params = {
				'balance_due_operator' : $( '#balance_due_operator' ).val(),
				'event_id' : parseInt( $( '#event_id' ).val() ),
				'balance_due' : $( '#balance_due' ).val().length > 0 ? parseFloat( $( '#balance_due' ).val() ) : 0,
				'attendee_count_operator' : $( '#attendee_count_operator' ).val(),
				'attendee_count' : $( '#attendee_count' ).val().length > 0 ? parseFloat( $( '#attendee_count' ).val() ) : 0,
				'company' : $( '#company' ).val()
		 	};
		 	return JSON.stringify( params );
 		},
 		get_financial_transactions : function(){
		 	var params;
		 	params = {
				'amount' : $( '#amount' ).val().length > 0 ? parseFloat( $( '#amount' ).val() ) : 0,
				'event_id' : parseInt( $( '#event_id' ).val() ),
				'amount_operator' : $( '#amount_operator' ).val(),
				'payment_type_id' : parseInt( $( '#payment_type_id' ).val() ),
				'detail_type_id_list' : $( '#detail_type_id_list' ).val() ? $( '#detail_type_id_list' ).val().join(",") : "",
				'detail_date_from' : $( '#detail_date_from' ).val(),
				'detail_date_to' : $( '#detail_date_to' ).val(),
				'attendee_id' : $( '#attendee_id' ).val().length > 0 ? parseFloat( $( '#attendee_id' ).val() ) : 0
		 	};
		 	return JSON.stringify( params );
 		},
 		get_agenda_participants : function(){
		 	var params;
		 	params = {
				'report_type' : parseInt( $( '.report_type:checked' ).val() ),
				'event_id' : parseInt( $( '#event_id' ).val() ),
				'category_id' : parseInt( $( '#category_id' ).val() ),
				'location_id' : parseInt( $( '#location_id' ).val() ),
				'agenda_id_list' : $( '#agenda_id_list' ).val() ? $( '#agenda_id_list' ).val().join(",") : "",
				'agenda_start_date_from' : $( '#agenda_start_date_from' ).val(),
				'agenda_start_date_to' : $( '#agenda_start_date_to' ).val()
		 	};
		 	return JSON.stringify( params );
 		},
	 	get_all_fields : function(){
		 	var params;
		 	params = {
				'company_id' : parseInt( $( '#company_id' ).val() ),
				'event_id' : parseInt( $( '#event_id' ).val() ),
				'registration_type_id_list' : $( '#registration_type_id_list' ).val(),
				'registration_date_to' : $( '#registration_date_to' ).val(),
				'registration_date_from' : $( '#registration_date_from' ).val()
		 	};
		 	return JSON.stringify( params );
	 	},
	 	get_registration_list : function(){
		 	var params, registration_type_id_list;
		 	registration_type_id_list = $( '.registration_type_id_list:checked' ).map(function() {
			 	return this.value;
			}).get();
		 	params = {
				'balance_due_operator' : $( '.balance_due_operator:checked' ).val(),
				'balance_due' : parseFloat( $( '.balance_due' ).val() ),
				'event_id' : parseInt( $( '#event_id' ).val() ),
				'registration_type_id_list' : registration_type_id_list.join(','),
				'registration_date_to' : $( '.registration_date_to' ).val(),
				'registration_date_from' : $( '.registration_date_from' ).val()
		 	};
		 	return JSON.stringify( params );
	 	},
	 	get_scheduled_params : function(){
		 	var errors, params;
		 	errors = false;
		 	params = {
			 	'from_email' : $( '#scheduled_from' ).val(),
			 	'to_email' : $( '#scheduled_to' ).val(),
			 	'scheduled_subject' : $( '#scheduled_subject' ).val(),
			 	'scheduled_frequency' : $( '#weekly-or-daily' ).val(),
			 	'day-picker' : parseInt( $( '#day-picker' ).val() ),
			 	'scheduled_startdate' : $( '#scheduled_startdate' ).val(),
			 	'scheduled_enddate' : $( '#scheduled_enddate' ).val(),
			 	'report' : $( '#report_type' ).val()
		 	};
		 	for( var key in params ){
			 	if( params[ key ].length == 0 ){
				 	errors = true;
			 	} 
		 	} 
		 	if( errors && ! validateEmail( $( '#scheduled_from' ).val() ) && ! validateEmail( $( '#scheduled_to' ).val() ) ) return false;
		 	return JSON.stringify( params );
	 	}
 	};
 	
	var validateEmail = function( email ) { 
	    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	    return re.test(email);
	}  	

	$(".chosen-select").chosen();
});	