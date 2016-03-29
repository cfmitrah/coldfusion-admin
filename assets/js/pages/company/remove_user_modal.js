$(function(){
	var $modal = $( "#remove-company-user" );

	$( ".remove-user" ).on( 'click', function( event ){
		var $processor_link = $( this ), 
		$row = $processor_link.parents( 'tr' ),
		data = $row.data();
		//trigger the modal
		$modal.modal();
		//bind a click event to the modal action button make sure we only do this "once" to avoid zombie events that live on forever
		$("#remove-company-user-action").one( 'click', function( event ){
			$.ajax({
				url: cfrequest.ajax_remove_user_url,
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
