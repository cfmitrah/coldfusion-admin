$(function(){
	var $modal = $( "#delete-agenda-item" ), agenda_item_id;
	
	$( "#agendas_listing" ).on( 'click', 'a.trigger_delete', function( event ){
		var $agenda_link = $( this ),
		agenda_item_id = $agenda_link.data( 'agendaItemId' );
		//trigger the modal
		$modal.modal();
		event.preventDefault();
		//bind a click event to the modal action button make sure we only do this "once" to avoid zombie events that live on forever
		$("#delete-agenda-action").one( 'click', function( event ){
			$.ajax({
				url: cfrequest.delete_agenda_item_url,
				type: "POST",
				data: { agenda_item_id: agenda_item_id },
				cache: false,
			    dataType: "json"
			}).then(function(){
				//close the modal
				$modal.modal( 'hide' );
				//redraw the table
				dataTable.fnDraw();
			},function(){
				console.log( 'There was an error' );				
			})
			event.preventDefault();
		});
	});

});
