/**
 *
 * @depends /plugins/cfjs/jquery.cfjs.js
 */
$(function(){
	var $venue = $( "#venue" ),
		$tabs = $( ".nav-tabs" ),
		$locations = $( "#venue-locations" ),
		$add_location_modal = $( "#add-location-modal" ),
		$location_name = $( "#location_name" );
	// location tab
	$locations
		.on( "click", ".remove", function( event ) { // removes a location from a venue
			event.preventDefault();
			var $elem = $( this ),
				$row = $elem.parents( "tr:first" );
			removeLocation( $row.data( "location_id" ) );
			$row.fadeOut( "fast", function(){
				$row.remove();
			});
		});
	$add_location_modal
		.on("keyup", function( event ) { // if enter / return is pressed and there is a value trigger the add
			if( ( event.keyCode == 13 || event.keyCode == 10 ) && $.trim( $location_name.val() ) ) {
				$add_location_modal
					.find( ".add" )
						.trigger( "click" );
			}
		})
		.on( "click", ".add", function( event ) { // add the location
			event.preventDefault();
			var $elem = $( this ),
				value = $.trim( $location_name.val() );
			if( value ) {
				addLocation( $elem, value );
				$location_name
					.val( "" )
					.focus();
			}
		});
	// handles adding a location to a venue
	function addLocation( $btn, location_name ) {
		var row;
		// switch to the locations tab
		$tabs
			.find( "li:eq(1) a" )
				.tab( "show" );
		// always add just in case
		$.ajax({
			url: "/venues/addLocation",
			type: "POST",
			data: {
				'location_name': location_name,
				'venue_id': $venue.data( "venue_id" )
			},
			dataType: "json",
			beforeSend: function(xhr, settings){
				loading( $btn, true ); // change button to loading
			}
		})
		.done(function(data, status, xhr){
			row = [];
			row.push( "<tr data-location_id=\"" + data.location_id + "\">" );
			row.push( "	<td>" + data.location_name + "</td>" );
			row.push( "	<td><a href=\"#\" class=\"remove btn btn-danger btn-sm\">Remove</a></td>" );
			row.push( "</tr>" );
			$locations
				.find( "tbody" )
					.append( row.join( "" ) );
		})
		.always(function(xhr, status){
			loading( $btn, false );
		});;
	}
	// handles removing a location
	function removeLocation( location_id ) {
		$.ajax({
			url: "/venues/removeLocation",
			type: "POST",
			data: {
				'location_id': location_id,
				'venue_id': $venue.data( "venue_id" )
			},
			dataType: "json"
		});
	}
	// photos tab
	var $photos = $("#venue-photos"),
		$photo_listing = $photos.find("table");
		$dropzone = $photos.find(".dropzone");
	$photos
		.on( "click", ".remove", function( event ) { // remove a photo
			event.preventDefault();
			var $elem = $( this ),
				$row = $elem.parents( "tr:first" );
			removePhoto( $row.data( "media_id" ) );
			$row.fadeOut( "fast", function(){
				$row.remove();
			});
		});
	$dropzone[0].dropzone.on( "success", function( file, data ) { // on successful upload add the row
		addPhoto( data );
	});

	// handles removing a photo
	function removePhoto( media_id ) {
		$.ajax({
			url: "/media/disassociate",
			type: "POST",
			data: {
				'media_id': media_id,
				'venue_id': $venue.data( "venue_id" )
			},
			dataType: "json"
		});
	}
	// adds a photo to the table
	function addPhoto( data ){
		var row = [];
		row.push( "<tr data-media_id=\""); row.push( data.media_id ); row.push( "\">" );
		row.push( "	<td><img src=\"" ); row.push( data.url ); row.push( data.thumbnail ); row.push( "\" /></td>" );
		row.push( "	<td>" ); row.push( data.filename ); row.push( "</td>" );
		row.push( "	<td>" ); row.push( data.filesize ); row.push( "</td>" );
		row.push( "	<td>" ); row.push( data.uploaded ); row.push( "</td>" );
		row.push( "	<td><a href=\"#\" class=\"remove btn btn-danger btn-sm\">Remove</a></td>" );
		row.push( "</tr>");
		$photo_listing
			.find( "tbody" )
				.append( row.join( "" ) );
	}
});