/**
 *
 * @depends /plugins/chosen/chosen.jquery.js
 * @depends /plugins/moment/moment-date-timepicker.js
 * @depends /plugins/cfjs/jquery.cfjs.js
 * @depends /pages/common/listing.js
 * @depends /plugins/parsley/parsley.js
 * @depends /pages/attendees/field.dependency.js
 * @depends /pages/attendees/manage.agenda.js
 */
 
$(function(){
	var $payment_form = $("#payment_form"),
		$refund_form = $("#refund_form")
		$btn_process_payment = $("#btn_process_payment")
		$refund_modal = $("#refund-modal"),
		$payment_modal = $('#payment-modal'),
		$refund_info_processor_tx_id = $("#refund_info_processor_tx_id"),
		$refund_info_amount = $("#refund_info_amount"),
		$refund_info_notes = $("#refund_info_notes"),
		$btn_process_refund = $("#btn_process_refund"),
		$btn_process_payment = $("#btn_process_payment"),
		$refund_info_tx_x_date = $("#refund_info_tx_x_date"),
		$refund_info_tx_last_4 = $("#refund_info_tx_last_4"),
		$refund_info_action = $("#refund_info_action"),
		$refund_info_amount = $("#refund_info_amount"),
		$refund_info_item_id = $("#refund_info_item_id"),
		$refund_notification = $("#refund_notification"),
		$refund_info_payment_type = $("#refund_payment_type"),
		$promo_code = $("#promo_code"),
		$apply_promo_code = $("#apply_promo_code");
	//refund_modal_button

	$payment_form.parsley();
	$refund_form.parsley();

	$registration_details_datatable = setDataTables( cfrequest.registration_details_url, cfrequest.details_list_columns, "registration_details", 99 );
	var registration_details_oSettings = $registration_details_datatable.fnSettings();
	
	
	$('#attendee-manage select[multiple]').css({"width":"300px"});
	$('#attendee-manage [data-section] select').chosen();
	$("#standard_registration_type_id").css({"width":"300px"}).addClass("form-control").chosen();
	$(".chosen-container-multi").css({"width":"100%"});
	$(".chosen-container-multi input").css({"width":"100%"}).addClass("form-control");
	
	$(".timeonly-datetime").datetimepicker({ pickDate: false });
	$(".dateonly-datetime").datetimepicker({ pickDate: true });
	
	$(".timeonly-datetime, .dateonly-datetime").datetimepicker()
	.on( "blur", function( event ){
		$( ".bootstrap-datetimepicker-widget:visible" ).hide();
	});

	
	$payment_form.on("change","#account_info_payment_type",function(){
		var $elem = $(this), value=$elem.val(), $credit_card_info=$("#credit_card_info");
		$credit_card_info.addClass("div-hide");
		if( value == "credit_card" ) {
			$credit_card_info.removeClass("div-hide");
		}
		
	});
	
	$payment_form.on("change","#account_info_credit_card_type",function(){
		var $elem = $( 'option:selected',this )
		$("#account_info_account_number")
			.attr( "data-parsley-pattern", $elem.data("card_pattern") )
			.attr( "maxlength", $elem.data("card_digits") );
		$("#account_info_cvv")
			.attr( "maxlength", $elem.data("cvv_digits") );

	});
	
	$("#account_info_credit_card_type").trigger("change");
	$("#account_info_payment_type").trigger("change");
	$payment_modal.on('show.bs.modal', function (e) {
		$payment_form.parsley( 'validate' );
		$("#notification").addClass("div-hide");
		$("#account_info_amount").val( $("#payment_modal_button").data("total") );	
	});
	
	$btn_process_payment.on("click",function(){
		//todo: refresh totals
		//todo: refresh Reg details table
		if( !$payment_form.parsley().validate() ) {
			return false;
		}
		var $obj = $( this ),
			process_payment_result =  $.ajax({  
				url: cfrequest.payment_url,
				method: "POST",
				data: $payment_form.serialize(),
				beforeSend: function( jqxhr ){
					loading( $btn_process_payment, true );
				}
			} );
		process_payment_result.always(function( data ){ 
			$("#notification").addClass("div-hide");
			if( data.success ) {
				$("#payment-modal").modal( "hide" );
				getAttendee();
				$("#account_info_account_number").val('');
				$("#account_info_cvv").val('');
				$("#account_info_month").val($("#account_info_month option:first").val());
				$("#account_info_year").val($("#account_info_year option:first").val());
			}else{
				$("#notification").removeClass("div-hide");
				$("#notification").html( data.formatted_message );
			}
			loading( $btn_process_payment, false );
			$registration_details_datatable.fnDraw();
		});

	});
	
	$btn_process_refund.on("click",function(){
		
		if( !$refund_form.parsley().validate() ) {
			return false;
		}
		var	urls = {"void":cfrequest.do_void_url,"refund":cfrequest.do_refund_url},
			do_refund_result =  "",
			$obj = $(this);
			loading( $obj, true );
			do_refund_result = $.ajax({  
				url: urls[ $refund_info_action.val() ],
				method: "POST",
				data: $refund_form.serialize(),
				beforeSend: function( jqxhr ){}
			} );
		do_refund_result.always(function( data ) { 
			$refund_notification.addClass("div-hide");
			if( data.success ) {
				$refund_modal.modal( "hide" );
				getAttendee();
			}else{
				$refund_notification.removeClass("div-hide");
				$refund_notification.html( data.formatted_message );
			}
			loading( $obj, false );
			$registration_details_datatable.fnDraw();
		});
	});
	$refund_modal.on('show.bs.modal', function (e) {
		$refund_form.parsley( 'validate' );
		getPayments();
	});
	$refund_info_processor_tx_id.on("change",function(){
		var $selected_option = $("option:selected",$(this) );
		$refund_info_amount.val( $selected_option.data("refundable_amount") );
		$refund_info_notes.val( $selected_option.data("refund_notes") );
		$refund_info_tx_x_date.val( $selected_option.data("tx_x_date") );
		$refund_info_tx_last_4.val( $selected_option.data("tx_last_4") );
		$refund_info_item_id.val( $selected_option.data("item_id") );
		$refund_info_payment_type.val( $selected_option.data("payment_type") );
		$refund_info_amount.attr("readonly",false);
		$refund_info_action.val('refund');
		if( $selected_option.data( "allow_void" ) ) {
			$refund_info_amount.attr("readonly",true);
			$refund_info_action.val('void');
			$refund_info_notes.val( $.ReplaceNoCase( $selected_option.data("refund_notes"), "Refund","Void","ALL")  );
		}
	});
	$apply_promo_code.on("click", function(e) {
		var $obj = $(this);
		loading( $obj, true );
		e.preventDefault();
		var apply_promo_code_result = $.ajax({  
			url: cfrequest.apply_promo_code_url,
			cache: false,
			data: {'code':$promo_code.val(),'attendee_id':cfrequest.attendee_id,'registration_id':cfrequest.registration_id }
	    });
		apply_promo_code_result.always(function( data ) {
			$("#promo_notification").html( data.notification );
			getAttendee();
			$registration_details_datatable.fnDraw();
			loading( $obj, false );
		});
	});

	function getAttendee() {
		var get_attendee_result =  $.ajax({  
				url: cfrequest.get_attendee_url,
				method: "POST",
				data: {'attendee_id':cfrequest.attendee_id},
				beforeSend: function( jqxhr ){}
			} );
		get_attendee_result.always(function( data ) { 
			$("#payment_modal_button,#refund_modal_button").addClass("div-hide");
			$("#total_due_display").html( data.cost_breakdown.total_due_display );
			$("#total_credits_display").html( data.cost_breakdown.total_credits_display );
			if( data.cost_breakdown.total_credits ) {
				$("#refund_modal_button").removeClass("div-hide");	
			}
			if( data.cost_breakdown.total_due ) {
				$("#payment_modal_button").removeClass("div-hide");	
			}
		});
	}

	function getPayments() {
		var get_payments_result =  $.ajax({  
				url: cfrequest.get_registration_payments_url,
				method: "POST",
				data: {'attendee_id':cfrequest.attendee_id, 'registration_id':cfrequest.registration_id},
				beforeSend: function( jqxhr ){}
			} );
		get_payments_result.always(function( data ) { 
			var option=[];
			$refund_info_processor_tx_id.html('');
			for ( var i = 0, cnt = data.count; i < cnt; i++ ) { 
				var row = data.payments[ i ];
				
				option.push( "<option value=\"" );option.push( row.processor_tx_id );option.push( "\"");
						option.push( " data-refundable_amount=\"");option.push( row.refundable_amount );option.push( "\"" );
						option.push( " data-refund_notes=\"");option.push( row.refund_notes );option.push( "\"" );
						option.push( " data-tx_last_4=\"");option.push( row.tx_last_4 );option.push( "\"" );
						option.push( " data-tx_x_date=\"");option.push( row.tx_x_date );option.push( "\"" );
						option.push( " data-allow_void=\"");option.push( row.allow_void );option.push( "\"" );
						option.push( " data-item_id=\"");option.push( row.registration_detail_id );option.push( "\"" );
						option.push( " data-payment_type=\"");option.push( row.payment_type );option.push( "\"" );
						option.push( " >");
					option.push( row.refund_description );
				option.push( "</option>" );
			 }
			 $refund_info_processor_tx_id.append( option.join( "" ) );
			 $refund_info_processor_tx_id.trigger("change");

		});
	}
	
	$("#registration_details_wrapper .row").hide();
});
