/**
 *
 * @depends /plugins/cfjs/jquery.cfjs.js
 * @depends /plugins/ckeditor/ckeditor.js
 */
$(function(){
	CKEDITOR.replace( "speaker-bio-text" );
	var $speaker = $( "#speaker" ),
		$sessions = $speaker.find( ".table:first" ),
		$assign = $( "#speaker-assign" ),
		$session_select = $assign.find( "select:first" );
	// handle when the user removes a session
	$speaker
		.on("click", ".remove", function( event ){
			event.preventDefault();
			var $obj = $( this ),
				$row = $obj.parents( "tr:first" );
			removeSession( $row.data( "session_id" ) );
			$row.fadeOut( "fast", function(){
				$row.remove();
			});
		})
		.on("click", ".remove-photo", function( event ){
			event.preventDefault();
			var $obj = $( this ),
				$img = $obj.siblings( "img" );
			$img.attr( "src", $img.data( "nophoto" ) );
			$obj.remove();
			removePhoto();
		});
	// handle when the user clicks assign
	$assign
		.on("click", ".add", function( event ){
			event.preventDefault();
			var opt = $session_select[0].options[$session_select[0].selectedIndex];
			if( opt.value && +opt.value ){
				addSession( opt.value, opt.text );
			}
		});
	// handles adding a session
	function addSession( session_id, session_title ) {
		var row;
		// check to see if it is already in the list
		if( !$sessions.find("tbody tr[data-session_id=" + session_id + "]").length ) {
			// build the row to add
			row = [];
			row.push( "<tr data-session_id=\"" ); row.push( session_id ); row.push( "\">" );
			row.push( "	<td>" ); row.push( session_title ); row.push( "</td>" );
			row.push( "	<td><a href=\"#\" class=\"remove text-danger\"><span class=\"glyphicon glyphicon-remove-circle\"></span> <strong>Remove</strong> </a></td>" );
			row.push( "</tr>" );
			// add the row to the table
			$sessions
				.find( "tbody" )
					.append( row.join( "" ) );
		}
		// always add just in case
		$.ajax({
			url: "/speakers/addToSession",
			type: "POST",
			data: {
				'speaker_id': $speaker.data( "speaker_id" ),
				'session_id': session_id
			},
			dataType: "json"
		});
	}
	// handles removing a sesssion
	function removeSession( session_id ) {
		$.ajax({
			url: "/speakers/removeFromSession",
			type: "POST",
			data: {
				'speaker_id': $speaker.data( "speaker_id" ),
				'session_id': session_id
			},
			dataType: "json"
		});
	}
	// handles removing a sesssion
	function removePhoto( session_id ) {
		$.ajax({
			url: "/speakers/removePhoto",
			type: "POST",
			data: {
				'speaker_id': $speaker.data( "speaker_id" )
			},
			dataType: "json"
		});
	}
});