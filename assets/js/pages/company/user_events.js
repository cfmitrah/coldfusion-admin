/**
 * Ajax Table Plugin
 *
 * @requires	jQuery
 * @author		Oscar Diaz
 * @version		1
 * @param {jQuery} $
 */

(function( $ ){
	var methods = {
		
		_init: function (options) {
			
			var defaults = {
				messages: {
					no_events: 'No events found'
				},
				user_events_ids: [],
				urls: {
					user_events: cfrequest.user_events_url,
					add_selected_events: cfrequest.user_add_events,
					remove_event: cfrequest.user_remove_event
				}
			};
						
			var base_settings = $.extend(true, defaults, options);
			
			return this.each(function () {
				var $me = $(this),
					settings = $.extend(true, {}, base_settings),
					$event_select = $me.find('.uevents_event_select');
					
				$event_select.chosen();
				$me.find(".chosen-container-multi").css({"width":"100%"});
				$me.find(".chosen-container-single").css({"width":"100%"});
				$me.find(".chosen-container-multi input").css({"width":"100%"}).addClass("form-control");
				$me.find(".chosen-container-single input").css({"width":"100%"}).addClass("form-control");
				
				$me.find(".uevents_add_selected").on ("click", function (evt) {
					evt.preventDefault();
					
					$me.uevents('addSelectedEvents');
				});
				
				//
				$me.data('uevents', {
					target 		: $me,
					settings 	: settings
				});
			});
		},
		
		load_user: function (user_id, displayname, callback) {
			var $me = $(this),
				settings = $me.data('uevents').settings,
				$table = $me.find('.uevents_table');
				
			// Save the current user in the settings
			$me.data('uevents').settings.current_user = user_id;
			
			// Clear the trs
			$table.find('tbody tr').detach ();
			
			// Put the name of the user
			$me.find ('.uevents_user_name').text(displayname);
			
			// Get the url
			var url = settings.urls.user_events;
			
			$.ajax ({
				url: url,
				cache: false,
				dataType: 'json',
				type: 'post',
				data: {
					'user.user_id': user_id
				},
				success: function (data) {
					$table.find('tbody tr').detach ();
					$me.uevents('_load_user_events', data.events.data);
					if (data.success && data.events.count == 0) {
						$table.find('tbody').append (
							$('<tr>')
								.append(
									$('<td>')
										.attr('colspan', '100%')
										.addClass('uevents_notification_row')
										.attr('align', 'center')
										.html('<strong>' + settings.messages.no_events + '</strong>')
								)
						);
					}
					
					// Reload the available events
					$me.uevents('_load_available_events');
					
					if (typeof callback == 'function') {
						callback();
					}
				}
			});
			
			return $me;
		},
		
		addSelectedEvents: function () {
			var $me = $(this),
				settings = $me.data('uevents').settings,
				$add_selected_button = $me.find('.uevents_add_selected'),
				$select = $me.find('.uevents_event_select');
				
			var selected_events = $select.val();
			
			if (selected_events !== null && selected_events.length > 0) {
				
				var btn_text = $add_selected_button.text();
				
				$add_selected_button
					.addClass('disabled')
					.text('Saving...');
					
				$me.find('.uevents_remove').addClass('disabled');
				
				$.ajax ({
					cache: false,
					dataType: 'json',
					type: 'post',
					url: settings.urls.add_selected_events,
					data: {
						user_id: settings.current_user,
						er_event_id: selected_events.join(',')
					},
					success: function (data) {
						if (data.success) {
							$me.uevents('_load_user_events', data.events.data);
							$me.uevents('_load_available_events');
						}
						
						$add_selected_button
							.removeClass('disabled')
							.text(btn_text);
							
						$me.find('.uevents_remove').removeClass('disabled');
					}
				});
			}
			
			return $me;
		},
		
		_load_available_events: function () {
			var $me = $(this),
				settings = $me.data('uevents').settings,
				$select = $me.find('.uevents_event_select'),
				user_events_ids = settings.user_events_ids;
				
			var options = [];
			for ( var i = 0, cnt = settings.company_events.count; i < cnt; i++ ) {
				var row = settings.company_events.data[ i ];
				
				// Only load the event  if the user doesn't already own it
				if (user_events_ids.indexOf(row.event_id) < 0) {	
					options.push( "<option value=\"" + row.event_id + "\">" );
					options.push( row.name );
					options.push( "</option>" );
				}
			}
			options = options.join( "" );
			$select.html( options ).trigger("chosen:updated");
			
			return $me;
		},
		
		_load_user_events: function (events) {
			var $me = $(this),
				settings = $me.data('uevents').settings,
				$table = $me.find('.uevents_table'),
				$select = $me.find('.uevents_event_select'),
				user_events_ids = [];
				
			// Clear the trs
			$table.find('tbody tr').detach ();
				
			events.forEach (function (current, key) {
				var $tr = $('<tr>')
					.append (
						$('<td>')
							.text (current.event_name),
						$('<td>')
							.text (current.role),
						$('<td>')
							.append (
								$('<a>')
									.addClass('btn btn-danger uevents_remove')
									.attr('id', 'uevents_remove_' + current.event_id)
									.text('Remove Access')
									.click(function (evt) {
										evt.preventDefault();
										$me.uevents('removeEventAccess', current.event_id);
									})
							)
					);
					
				$table.find('tbody').append($tr);
				user_events_ids.push(current.event_id);
			});
			
			$me.data('uevents').settings.user_events_ids = user_events_ids;
				
			return $me;
		},
		
		removeEventAccess: function (event_id) {
			var $me = $(this),
				settings = $me.data('uevents').settings,
				$remove_button = $('#uevents_remove_' + event_id),
				$select = $me.find('.uevents_event_select');
			
			var btn_text = $remove_button.text();
				
			$remove_button
				.addClass('disabled')
				.text('Removing...');
				
			$me.find('.uevents_remove').addClass('disabled');
			$me.find('.uevents_add_selected').addClass('disabled');
			
			$.ajax ({
				cache: false,
				dataType: 'json',
				type: 'post',
				url: settings.urls.remove_event,
				data: {
					user_id: settings.current_user,
					er_event_id: event_id
				},
				success: function (data) {
					if (data.success) {
						$me.uevents('_load_user_events', data.events.data);
						$me.uevents('_load_available_events');
					}
					
					$remove_button
						.removeClass('disabled')
						.text(btn_text);
						
					$me.find('.uevents_remove').removeClass('disabled');
					$me.find('.uevents_add_selected').removeClass('disabled');
				}
			});
			
			return $me;
		}
	};
	
	// initialization
	$.fn.uevents = function( method ) {
		var $me;		
		
		//Check for all the depencencies
		if (typeof $ === 'undefined'){
			$.error( 'jquery is required to run jQuery.uevents');
		} else if (methods[method]) {
			$me = methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ));
		} else if ( typeof method === 'object' || ! method ) {
			$me =  methods._init.apply( this, arguments );
		} else {
			$.error( 'Method ' +  method + ' does not exist on jQuery.uevents' );
		}
		
		if ($me === 'undefined') {
			$me = $(this);
		}
			
		return $me;
	};
		
})( jQuery );