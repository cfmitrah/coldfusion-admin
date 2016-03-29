$(function(){
	var $modal = $( "#see-company-attendee" );

	$( ".see-attendee" ).on( 'click', function( event ){
		console.log("In user click handler");
		var $processor_link = $( this ), 
		$row = $processor_link.parents( 'td' ),
		data = $row.data();
		data = data.event_name.split(',');

		$modal.modal();
		var events = '';
		for (i = 0; i < data.length-1; i++) {
			//console.log(data);
			events += '<tr><td>' + data[i] + '</td></tr>';
			console.log(data[i]);
		}
		$( "#see-company-attendee tbody" ).html( events + '</td>');
		//bind a click event to the modal action button make sure we only do this "once" to avoid zombie events that live on forever
		
		
		event.preventDefault();
	});



});
