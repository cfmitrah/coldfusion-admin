/**
 *
 * @depends /jquery-1.11.0.min.js
 */

$(function(){
	var $expand = $('.btn-expand'),
		$copy_form_url = $("#copy_form_url"),
		$btn_path_copy = $("#btn_path_copy"),
		$registration_type_id_copy_to = $("#registration_type_id_copy_to");

	$expand.on('click', function(e){
		e.preventDefault();
		$(this).parent().children('.reg-grid-container').slideToggle();
	});
	
	$("a[data-duplicate]").on("click",function(){
		var $obj = $(this);
		$copy_form_url.val( $obj.data("link") );
		event.preventDefault();
	});
	$btn_path_copy.on("click",function(){
		event.preventDefault();
		field_result = $.ajax({  
			url: $copy_form_url.val(),
			data: {'registration_type_id_copy_to':$registration_type_id_copy_to.val()}
		} );
		field_result.always(function( data ){
			 location.reload();
		});
	});
});