/**
 *
 * @depends /plugins/cfjs/jquery.cfjs.js
 */
$(function(){
	var $coupons = $( "#coupons_listing" );
	$coupons
		.on( "click", ".delete", function( event ){
			event.preventDefault();
			var $elem = $( this ),
				$row = $elem.parents( "tr:first" ),
				coupon_id = $elem.data( "coupon_id" );
			$.ajax({
				url: "/coupons/delete",
				type: "POST",
				data: {
					'coupon_id': coupon_id
				},
				dataType: "json",
				beforeSend: function(xhr, settings){
					$row.fadeOut( "fast", function(){
						$row.remove();
					});
				}
			})
			.done(function(data, status, xhr){
				$coupons.dataTable()._fnAjaxUpdate();
			});
		});
});