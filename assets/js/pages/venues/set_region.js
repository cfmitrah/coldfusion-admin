/**
 *
 * @depends /plugins/cfjs/jquery.cfjs.js
 */
$(function(){
	var $country_code = $( '#country_code' ), $region = $( '#region_code' );
	
	$country_code.on( 'change', function( event ){
		var value = $( this ).val();
		
		$.ajax({
			url: cfrequest.ajax_get_region_url,
			type: "POST",
			data: { region_code : value },
			cache: false,
		    dataType: "json"
		}).then(function( ret ){
			$region.empty();	
			$.each( ret.regions, function( idx, region ){
				var $opt = $( '<option />', { value : region.region_code, text : region.region_name });
				$region.append( $opt );
			});
		},function(){
			console.log( 'There was an error' );				
		});
		
	});
	
});