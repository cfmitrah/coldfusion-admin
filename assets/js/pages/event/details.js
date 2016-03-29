/**
 *
 * @depends /plugins/cfjs/jquery.cfjs.js
 * @depends /plugins/ckeditor/ckeditor.js
 * @depends /pages/common/media.js
 * @depends /plugins/slugify/slugify.min.js
 * @depends /plugins/moment/moment-date-timepicker.js
 */
$(function(){ 

	CKEDITOR.replace( "event_overview" );
	CKEDITOR.replace( "contact_page_overview" );
	CKEDITOR.replace( "begin_registration_message" );
	CKEDITOR.replace( "registration_closed_message" );
	CKEDITOR.replace( "event_conf_page_text" );
	
	CKEDITOR.replace( "mop_check_text" );
	CKEDITOR.replace( "mop_po_text" );
	CKEDITOR.replace( "mop_invoice_text" );
	CKEDITOR.replace( "mop_on_site_text" );
	
	
	// Slug Preview Field
	var $slug_output = $("#slug-output"),
		$extension_input = $("#extension-input"),
		$domain_select = $("#domain-name"),
		$domain_output = $("#domain-output");

	$slug_output.html( slugify( $extension_input.val() ) );
	
	$extension_input.on("keyup", function(){
		$slug_output.html( slugify( $extension_input.val() ) );
	});
	
	$domain_select.on( "change", function( e ){
		var domain, $field;
		$field = $( this );
		if( $field.val() == 0 ) return;
		domain = $field.find( "option:selected" ).text();
		$domain_output.html( domain );
		$extension_input.prop( "disabled", false );
	});

	//Date - Time Picker Initialization ------------------------------------
	$(".timeonly-datetime").datetimepicker({
	    pickDate: false
	})
	.on( "blur", function( event ){
		$( ".bootstrap-datetimepicker-widget:visible" ).hide();
	});

	$(".dateonly-datetime").datetimepicker({
	    pickTime: false
	})
	.on( "blur", function( event ){
		$( ".bootstrap-datetimepicker-widget:visible" ).hide();
	});

	$('.toggle-collapse-btn').on('click', function(e){
		e.preventDefault();
		$(this).parent().children('.row').children('.toggle-wrap').slideToggle();
	});
	
});