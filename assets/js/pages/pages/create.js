/**
 *
 * @depends /plugins/cfjs/jquery.cfjs.js
 * @depends /plugins/slugify/slugify.min.js
 */
$(document).ready(function(){
	var $slug = $("#slug");
	$("#title").on("change keyup", function(event){ // generates slug
		var $obj = $(this);
		$slug.val( slugify( $obj.val() ) );
	})
});