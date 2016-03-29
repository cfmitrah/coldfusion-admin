/**
 *
 * @depends /plugins/cfjs/jquery.cfjs.js
 */
$(function(){
	var $speaker = $( "#speaker" ),
		$first_name = $( "#first_name" ),
		$last_name = $( "#last_name" ),
		$display_name = $( "#display_name" );
	$speaker.on( "keyup", "#first_name, #last_name", function( event ) {
		$display_name.val( $.trim( $first_name.val() + ' ' + $last_name.val() ) );
	});
})