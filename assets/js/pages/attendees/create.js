/**
 *
 * @depends /plugins/chosen/chosen.jquery.js
 * @depends /plugins/cfjs/jquery.cfjs.js
 * @depends /plugins/parsley/parsley.js
 */
 
$(function(){
	var $registration_type = $("#registration_type"),
	$check_code = $("#check_code"),
	$access_code_wrapper = $("#access_code_wrapper");

	$registration_type.on("change",function(){
		var $selected_opt = $("#registration_type option:selected")
		$access_code_wrapper.hide();
		if( $selected_opt.data("has_access_code") ) {
			$access_code_wrapper.show();
		}
		$check_code.val( $selected_opt.data("has_access_code") )
	});
	$registration_type.trigger("change");

	
});
