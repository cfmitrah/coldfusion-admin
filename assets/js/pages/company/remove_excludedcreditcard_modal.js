$(function(){
	var $modal = $( "#remove-company-excludedcreditcard" );

	$( ".remove-excludedcreditcard" ).on( 'click', function( event ){
		console.log("In excluded click. ")
		var $processor_link = $( this ), 
		$row = $processor_link.parents( 'tr' ),
		data = $row.data();
		//trigger the modal
		$modal.modal();
		//bind a click event to the modal action button make sure we only do this "once" to avoid zombie events that live on forever
		$("#remove-company-excludedcreditcard-action").one( 'click', function( event ){
			$.ajax({
				url: cfrequest.ajax_remove_excludedcreditcard_url,
				type: "POST",
				data: data,
				cache: false,
			    dataType: "json",
			    success: function (data) {
			    	//close the modal
					$modal.modal( 'hide' );
					
					if (data.removed) {
						//redraw the table
						$row.remove();
					}
			    },
			    error: function () {
			    	console.log( 'There was an error' );
			    }
			});
		});
		
		event.preventDefault();
	});



});
