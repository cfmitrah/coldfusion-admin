$(function(){
	var $fee_modal = $( "#delete-session-fee" ), fee_id;

	//temporary for now until I finish the tabs
	//there will be more logic inserted here
	$( 'input[name="agenda.has_date_range"], input[name="attendance_limit"], input[name="agenda.waitlist"]' ).on( 'change', function(){
		var $field = $( this );
		$( '#' + $field.data( 'hidden_div' ) )[ parseInt( $field.val() ) ? 'slideDown' : 'slideUp' ]( 'fast' );
		if( $field.hasClass( 'attendance_limit' ) ) $( 'input#attendance_limit' ).val('');
	});

	
	$( ".remove-fee" ).on( 'click', function( event ){
		var $fee_link = $( this ), 
		$row = $fee_link.parents( 'tr' ),
		agenda_price_id = $row.data( 'agenda_price_id' ),
		agenda_id = $row.data( 'agenda_id' );

		//trigger the modal
		$fee_modal.modal();
		//bind a click event to the modal action button make sure we only do this "once" to avoid zombie events that live on forever
		$("#delete-fee-action").one( 'click', function( event ){
			$.ajax({
				url: cfrequest.ajax_delete_fee_url,
				type: "POST",
				data: { agenda_price_id: agenda_price_id, agenda_id: agenda_id },
				cache: false,
			    dataType: "json"
			}).then(function(){
				//close the modal
				$fee_modal.modal( 'hide' );
				//redraw the table
				$row.remove();
			},function(){
				console.log( 'There was an error' );				
			})
		});
		
		event.preventDefault();
	});

});