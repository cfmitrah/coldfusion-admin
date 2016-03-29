$( document ).ready( function(  ){
	var $cache = $( "#cache" );
	$cache
		.on( "click", ".remove", function( event ){
			event.preventDefault(  );
			var $obj = $( this );
			$.ajax( {
				url: "/systemadmin/removeCache",
				type: "POST",
				data: {
					"cache_key": $obj.data( "key" )
				},
				dataType: "json",
				beforeSend: function( xhr, settings ){
					$cache
						.find( ".alert.alert-success" )
							.remove();
					loading( $obj, true ); // change button to loading
				}
			} )
			.done( function( data, status, xhr ){
				var $table = $obj.parents( "table:first" );
				$obj
					.parents( "tr:first" )
						.remove();
				if( $table.find( "tr").length ){
					$table.remove();
					$cache
						.find(".purge")
							.remove();
				}
				$cache
					.find( ".wrapper" )
						.append( "<p class=\"alert alert-success\"><i class=\"fa fa-check\"></i> The cache key has been successfully removed <button type=\"button\" class=\"close\" data-dismiss=\"alert\">x</button></p>" );
			} )
			.always( function( xhr, status ){
				loading( $obj, false );
			} );
		} )
		.on( "click", ".purge", function( event ){
			event.preventDefault(  );
			var $obj = $( this );
			$.ajax( {
				url: "/systemadmin/purgeCache",
				type: "POST",
				data: {
					"cache_key": $obj.data( "key" )
				},
				dataType: "json",
				beforeSend: function( xhr, settings ){
					$cache
						.find( ".alert.alert-success" )
							.remove();
					loading( $obj, true ); // change button to loading
				}
			} )
			.done( function( data, status, xhr ){
				$obj.remove();
				$cache
					.find( "table" )
						.remove();
				$cache
					.find( ".wrapper" )
						.append( "<p class=\"alert alert-success\"><i class=\"fa fa-check\"></i> The cache has been successfully purged <button type=\"button\" class=\"close\" data-dismiss=\"alert\">x</button></p>" );
			} )
			.fail( function( xhr, status ){
				loading( $obj, false );
			} );
		} );
} );