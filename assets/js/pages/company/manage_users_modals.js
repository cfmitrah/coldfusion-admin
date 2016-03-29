$(function(){
	var $parent = $("#company-users"),
		$modal = $( "#assign-user" ),
		$modal_remove = $( "#remove-company-user" ),
		$submit_button = $( "#submit_add_form" ),
		$sidebar_view_users = $( "#sidebar_view_all_users" ),
		$sidebar_add_user = $( "#sidebar_add_new_users" ),
		$uevents = $( "#user_events" ).uevents({
			company_events: cfrequest.company_events
		});
		
	$sidebar_view_users.on ('click', function (event) {
		event.preventDefault();
		$('#users_tab').tab("show");
	});
	
	$sidebar_add_user.on ('click', function (event) {
		event.preventDefault();
		$('#users_tab').tab("show");
		
		$parent.find ('.add_new').click();
	});

	$modal.on('show.bs.modal', function () {
		$modal.find('.new_div form input').val('');
    	$modal.find('.new_div form').parsley().reset();
	});
	
	$parent.on ('click', '.add_existing', function (event) {
		event.preventDefault();
		
		$submit_button.addClass('existing');
		$submit_button.removeClass('new');
		
		$modal.find('.new_div').hide();
		$modal.find('.existing_div').show();
	});
	
	$parent.on ('click', '.add_new', function (event) {
		event.preventDefault();
		
		$submit_button.addClass('new');
		$submit_button.removeClass('existing');
		
		$modal.find('.existing_div').hide();
		$modal.find('.new_div').show();
	});
	
	$( ".remove-user" ).on( 'click', function( event ){
		removeCompanyUser(this);
		event.preventDefault();
	});
	
	$( ".user-events" ).on( 'click', function( event ) {
		loadUserEvents(this);
		event.preventDefault();
	});
	
	if (cfrequest.users_action == 'view_all_users') {
		$sidebar_view_users.click ();
	} else if (cfrequest.users_action == 'add_new_user') {
		$sidebar_add_user.click ();
	}
	
	function loadUserEvents (btn) {
		$button = $(btn);
		$button
			.addClass('disabled')
			.html('<strong>Loading...</strong>');
		
		
		var user_id = $button.parents('tr').first().data('user_id'),
			displayname = $button.parents('tr').first().data('displayname');
		var callback = function () {
			$uevents.modal('show');
			
			$button
				.removeClass('disabled')
				.html('<strong>Events</strong>');
		};
		
		$uevents.uevents('load_user', user_id, displayname, callback);
	}
	
	function removeCompanyUser (link) {
		var $processor_link = $( link ), 
		$row = $processor_link.parents( 'tr' ),
		data = $row.data();
		//trigger the modal
		$modal_remove.modal();
		//bind a click event to the modal action button make sure we only do this "once" to avoid zombie events that live on forever
		$("#remove-company-user-action").one( 'click', function( event ){
			$.ajax({
				url: cfrequest.ajax_remove_user_url,
				type: "POST",
				data: data,
				cache: false,
			    dataType: "json"
			}).then(function(){
				
				$('#user_id').append(
					$('<option>')
						.addClass('user_option')
						.val($row.data('user_id'))
						.text($row.data('displayname'))
				);
				
				//close the modal
				$modal_remove.modal( 'hide' );
				//redraw the table
				$row.remove();
			},function(){
				console.log( 'There was an error' );				
			});
		});
	}
	
	$submit_button.on ('click', function (event) {
		event.preventDefault();
		
		var data = {},
			validate = false,
			alert_message = 'The user was created and associated to this company.',
			alert_class = 'alert-success',
			current_url = cfrequest.save_new_user_url;
			
		if ($(this).hasClass('existing')) {
			validate = true;
			current_url = cfrequest.save_existing_user_url;
			alert_message = 'The user was associated to this company.',
			data = {
				'user.user_id': $('#user_id').val()
			};
		} else if ($(this).hasClass('new')) {
			if ($modal.find('.new_div form').parsley().validate()) {
				validate = true;
				data = {
					'user.username': $('#username').val(),
					'user.password': $('#password').val(),
					'user.first_name': $('#first_name').val(),
					'user.last_name': $('#last_name').val(),
					'user.active': $('#active_yes').is(':checked')? '1': '0',
					'user.is_system_admin': $('#is_system_admin_yes').is(':checked')? '1': '0',
				};
			}
		}
		
		if (validate) { 
			
			var add_label = $submit_button.html();
			$submit_button.html($submit_button.data('loading-text'));
			$submit_button.addClass('disabled');
			
			$.ajax ({
				type: "POST",
			    url: current_url,
			  	data: data,
			  	cache: false,
			  	dataType: "json",
			  	success: function (data) {
			  		
			  		$submit_button.removeClass('disabled');
					$submit_button.html(add_label);
					
					$modal.modal('hide');
					
				  	if (typeof data.user.user_id != 'undefined') {
				  		var $tr = $('<tr data-displayname="' + data.user.displayname + '" data-company_id="' + data.company_id + '" data-user_id="' + data.user.user_id + '">').append(
				            $('<td>').append(data.user.displayname),
				            $('<td>').append(data.user.username),
				            $('<td>').append(
				            	$('<a>')
					            	.addClass('btn btn-sm btn-primary user-events')
					            	.html('<strong>Events</strong>')
					            	.on('click',function(){
					            		loadUserEvents(this);
										event.preventDefault();
									}),
				            	$('<a>')
					            	.addClass('btn btn-sm btn-danger remove-user')
					            	.html('<strong>Remove</strong>')
					            	.on('click',function(){
										removeCompanyUser(this);
										event.preventDefault();
									})
				            )
				        );
				  		$parent.find('table tbody').append($tr);
				  		
				  		// If we added an existing user, we must remove it from the dropdown of available users to relate
				  		if ($submit_button.hasClass('existing')) {
				  			$('#user_id option[value=' + data.user.user_id + ']').detach();
				  		}
				  	} else {
				  		alert_message = 'The user could not be associated to this company.';
				  		alert_class = 'alert-danger';
				  	}
				  	
				  	//Showing the alert message.
				  	$parent.find ('.ajax_alert').detach();
				  	var $alert = $('<div>')
				  		.addClass('alert ajax_alert ' + alert_class)
			  			.append (
			  				$('<a>')
			            	.addClass('close')
			            	.attr('href', '#')
			            	.attr('data-dismiss', 'alert')
			            	.text('×')
			  			)
			  			.append(alert_message);
			  		$parent.prepend ($alert);
			  	}
			});
		}
	});
});