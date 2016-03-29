$(function(){
	var $modal = $( "#remove-paymentprocessor-creditcard" );

	$( ".remove-creditcard" ).on( 'click', function( event ){
		var $processor_link = $( this ), 
		$row = $processor_link.parents( 'tr' ),
		data = $row.data();
		//trigger the modal
		$modal.modal();
		//bind a click event to the modal action button make sure we only do this "once" to avoid zombie events that live on forever
		$("#remove-creditcard-action").one( 'click', function( event ){
			console.log("Here");
			console.log(cfrequest.ajax_remove_creditcard_url);
			console.log(data);
			$.ajax({
				url: cfrequest.ajax_remove_creditcard_url,
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
