/**
 *
 * @depends /plugins/cfjs/jquery.cfjs.js
 * @depends /plugins/ckeditor/ckeditor.js
 * @depends /pages/common/media.js
 * @depends /plugins/moment/moment-date-timepicker.js
 
 */
 MP = {};
 MP = MP.app || {};
$(function(){
	var type, email_id;
	//shows the test or live div	
	$( '#email_type' ).on( 'change', function(){
		var $field;
		$field = $( this );
		email_id = $field.val();
		type = $field.find( 'option:selected' ).data( 'type' );
		if( $field.val() != 'none' ){
			$( '#email-test-or-live' ).show();
			$( '#test_email_type' ).val( type );
			$( '#test_email_id' ).val( email_id );
			$( '#invitation-live-settings, #communications-live-settings, .test-frm' ).hide();
		}else{
		}
		$( '#send_type' ).val( 'none' );
	});

	$( '#send_type' ).on( 'change', function(){
		var $field, value;
		$field = $( this );
		value = $field.val(); 
		
		if( value != 'none' && value == 'test' ){
			$( '#choose-test-addresses' ).show();
			$( '.test-frm' ).show();
			$( '#invitation-live-settings, #communications-live-settings' ).hide();
		}
		if( value != 'none' && value == 'live' && type == 'invitation' ){
			$( '.test-frm' ).hide();
			$( '#invitation-live-settings' ).show();
			$( '#invitation_email_type' ).val( type );
			$( '#invitation_email_id' ).val( email_id );
		}
		if( value != 'none' && value == 'live' && type == 'communication' ){
			$( '.test-frm, #invitation-live-settings, .send-option' ).hide();
			$( '#communications-live-settings' ).show();
			$( '#communication_email_type' ).val( type );
			$( '#communication_email_id' ).val( email_id );
		}
	});
	
	$( '#registration_types' ).on( 'click', function( event ){
		$( '.send-option' ).hide();
		$( '#choose-attendee-types' ).show();
	});
	
	$( '#all-attendees' ).on( 'click', function( event ){
		$( '.send-option' ).hide();
	});
	$( '#individuals' ).on( 'click', function( event ){
		$( '.send-option' ).hide();
		$( '#individuals-listing' ).show();
	});



	
	$( '.import_type' ).on( 'click', function(){
		var $field = $( this );
		$( '.file-box' ).hide();
		if( $field.val() == 'file' ) $( '#choose-file' ).show();
		if( $field.val() == 'list' ) $( '#choose-addresses' ).show();
	});

	$('.datetime').datetimepicker({
	    pickTime: true,
	}).on( 'blur', function( event ){
		$( '.bootstrap-datetimepicker-widget:visible' ).hide();
	});

	//cancel email 
	var $modal = $( "#cancel-email" );
	
	$( "#email_history_listing" ).on( 'click', 'a.cancel-email', function( event ){
		var $link = $( this );
		//trigger the modal
		$modal.modal();
		$( '#cancel-email-action' ).on( 'click', function(){
			$.ajax({
				url: cfrequest.cancel_email_url,
				type: "POST",
				data: $link.data(),
				cache: false,
			    dataType: "json"
			}).then(function(){
				//close the modal
				$modal.modal( 'hide' );
				//redraw the table
				$link.hide();
				$link.parents( 'tr' ).find( 'td:eq( 4 )' ).text( 'Cancelled' );
			},function(){
				console.log( 'There was an error' );				
			})
		});		
		event.preventDefault();
	});

});