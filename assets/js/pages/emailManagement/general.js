/**
 *
 * @depends /plugins/datatables/jquery.dataTables.min.js
 * @depends /plugins/datatables/dataTables.bootstrap.js
 * @depends /plugins/cfjs/jquery.cfjs.js
 */
$(function(){
	var $modal = $( "#send-test-email-modal" ), email_id;
	
	$( "#system_listing" ).on( 'click', 'a.send_test_email', function( event ){
		var $agenda_link = $( this ),
		email_id = $agenda_link.data( 'email_id' );
		//trigger the modal
		$modal.modal();
		event.preventDefault();
		//bind a click event to the modal action button make sure we only do this "once" to avoid zombie events that live on forever
		$("#send-test-action").one( 'click', function( event ){
			$.ajax({
				url: cfrequest.send_test_email_url,
				type: "POST",
				data: { email_id: email_id, email_address : $('#email_address').val() },
				cache: false,
			    dataType: "json"
			}).then(function(){
				$('#email_address').val('');
				//close the modal
				$modal.modal( 'hide' );
			},function(){
				console.warn( 'There was an error' );				
			})
			event.preventDefault();
		});
	});

});
