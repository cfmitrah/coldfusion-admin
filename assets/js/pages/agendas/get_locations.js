$(function(){

	$( '#venues' ).on( 'change', function( event ){
		var $field = $( this ), $location = $( '#location' ).empty(), value = $field.val();
		if( value > 0 ){
			$.ajax({
				url: cfrequest.ajax_get_locations_url,
				type: "POST",
				data: { venue_id: value },
				cache: false,
			    dataType: "json"
			}).then(function( ret ){
				$location.append( $( '<option />', { value : 0, text : 'Choose a Location' } ) );	
				$.each( ret.locations, function( idx, location ){
					var $opt = $( '<option />', { value : location.location_id, text : location.location_name });
					$location.append( $opt );
				});
				$( '#locations' ).slideDown( 'fast' );
			},function(){
				console.log( 'There was an error retrieving the locations for this venue' );
			});
		}else{
			$( '#locations' ).slideUp( 'fast' );
		}
		 
	});
});