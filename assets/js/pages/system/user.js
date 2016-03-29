 /**
 *
 * @depends /plugins/chosen/chosen.jquery.js
 */
$(function() {
	var $er_company_id = $("#er_company_id")
		,$er_event_id = $("#er_event_id")
		,$new_restriction_modal = $("#new-event-restriction-modal")
		,$btn_add_event_restriction = $("#btn_add_event_restriction")
		,$event_grid = $("#event-grid")
		,$events_label = $("#events_label")
		,$add_event_restriction_form = $("#add_event_restriction_form")
		,$user_events_tab = $("#user_events_tab");
		
	$('#user-details select').chosen();
	
	$er_company_id.on("change", function() {
		loading( $events_label, true );
		getCompanyEvents( $(this).val() );
	}).chosen().trigger("change");
	$er_event_id.chosen();
	
	$(".chosen-container-multi, .chosen-container-single").css({"width":"100%"});
	$(".chosen-container-multi input, .chosen-container-single input").css({"width":"100%"}).addClass("form-control");
	
	$btn_add_event_restriction.on( "click", function() {
		loading($btn_add_event_restriction,true);
		var er_result = $.ajax({  
				url: cfrequest.add_user_event_restriction_url,
				data: $add_event_restriction_form.serialize()
		    });
		    
		er_result.always(function( data ){
			refreshEventRestrictionGrid();
			loading($btn_add_event_restriction,false);
			$new_restriction_modal.modal('hide');
		});
	
	});
	
	$event_grid.on( "click", "a[data-remove_event_access]", function( event ) {
		var $obj = $(this);
		loading($obj,true)
		event.preventDefault();
		var er_result = $.ajax({  
				url: cfrequest.remove_user_event_restriction_url,
				data: {'er_event_id':$obj.data("event_id"), 'user_id':cfrequest.user_id }
		    });
		    
		er_result.always(function( data ) {
			refreshEventRestrictionGrid();
		});
	});
		
	
	
	function refreshEventRestrictionGrid() {
		if( cfrequest.user_id ) {
			loading( $user_events_tab, true );
			var er_result = $.ajax({  
					url: cfrequest.user_event_restrictions_url
					,data: { 'user_id':cfrequest.user_id }
					,cache: false
			    });
			    
			er_result.always(function( data ){
				var events = [];
				for ( var i = 0, cnt = data.count; i < cnt; i++ ) { 
					var row = data.data[ i ];
					events.push( "<div class=\"col-md-3\">" );
						events.push( "<div class=\"well text-center\">" );
							events.push( "<h4>" + row.event_name + "</h4>" );
							events.push( "<div class=\"alert alert-success\">Role: " + row.role + "</div>" );//er_event_id
							events.push( "<a href=\"\" class=\"btn btn-block btn-default\" data-remove_event_access=\"true\" data-event_id=\"" + row.event_id + "\">Remove Access</a>" );
						events.push( "</div>" );
					events.push( "</div>" );
				}
				events = events.join( "" );
				$("#event-grid .row").html( events );
				loading( $user_events_tab, false );
			});
		}
	}
	
	function getCompanyEvents( company_id ) {
		
		if( company_id ) {
			var er_result = $.ajax({  
					url: cfrequest.company_events_url
					,data: { 'company_id':company_id }
					,cache: false
			    });
			    
			er_result.always(function( data ){
				var options = [];
				for ( var i = 0, cnt = data.count; i < cnt; i++ ) { 
					var row = data.data[ i ];
					options.push( "<option value=\"" + row.event_id + "\">" );
						options.push( row.name );
					options.push( "</option>" );
				}
				options = options.join( "" );
				$er_event_id.html( options ).trigger("chosen:updated");
				loading( $events_label, false );				
			});
		}
	}
	
	refreshEventRestrictionGrid();
});
