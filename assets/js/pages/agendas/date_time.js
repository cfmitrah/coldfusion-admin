/**
 *
 * @depends /plugins/moment/moment-date-timepicker.js
 */
// Date - Time Picker Initialization ------------------------------------
$('.timeonly-datetime').datetimepicker({
    pickDate: false
}).on( 'blur', function( event ){
	$( '.bootstrap-datetimepicker-widget:visible' ).hide();
});

$('.dateonly-datetime').datetimepicker({
    pickTime: false
}).on( 'blur', function( event ){
	$( '.bootstrap-datetimepicker-widget:visible' ).hide();
});

