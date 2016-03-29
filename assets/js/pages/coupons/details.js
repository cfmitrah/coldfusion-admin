/**
 *
 * @depends /plugins/cfjs/jquery.cfjs.js
 * @depends /plugins/moment/moment-date-timepicker.js
 * @depends /plugins/parsley/parsley.js
 */
$(function(){
	var $coupon = $( "#coupon" ),
		$types = $coupon.find( ".types" ),
		$coupon_value = $( "#coupon_value" )
		$value_wrapper = $("#value-wrapper");
	// date / time pickers
	$("#start_on, #end_on").datetimepicker({
	});

	$coupon
		.on( "click", ".formShowHide_ctrl", function( event ){
			var $elem = $( this ),
				show_id = $elem.data( "show_id" );
			if( show_id ) { // flat, discount, percentage
				$types
					.hide()
					.filter( "#" + show_id )
						.show();
				$value_wrapper.show();
			}
			else{ // no charge
				$value_wrapper.hide();
				$types.hide();
				$coupon_value.val( "0" );
			}
		})
		.find( ".formShowHide_ctrl:checked")
			.trigger( "click" );
});