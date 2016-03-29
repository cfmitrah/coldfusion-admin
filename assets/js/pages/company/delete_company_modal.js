$(function(){
	var $modal = $( "#delete-company-venue" );

	$( ".remove-venue" ).on( 'click', function( event ){
		var $venue_link = $( this ), 
		$row = $venue_link.parents( 'tr' ),
		data = $row.data();
		//trigger the modal
		$modal.modal();
		//bind a click event to the modal action button make sure we only do this "once" to avoid zombie events that live on forever
		$("#delete-venue-action").one( 'click', function( event ){
			$.ajax({
				url: cfrequest.ajax_delete_venue_url,
				type: "POST",
				data: data,
				cache: false,
			    dataType: "json"
			}).then(function(){
				//close the modal
				$modal.modal( 'hide' );
				//redraw the table
				$row.remove();
			},function(){
				console.log( 'There was an error' );				
			});
		});
		
		event.preventDefault();
	});



});
