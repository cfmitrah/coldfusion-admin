/**
 *
 * @depends /plugins/cfjs/jquery.cfjs.js
 * @depends /plugins/slugify/slugify.min.js
 * @depends /plugins/parsley/parsley.js
 */
$(function(){ 
	
	// Slug Preview Field
	var $slug_output = $("#slug"),
		$extension_input = $("#event_name");
	
	$extension_input.on("keyup", function(){
		$slug_output.val( slugify( $extension_input.val() ) );
	});	
});