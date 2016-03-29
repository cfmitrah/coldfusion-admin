/**
 *
 * @depends /bootstrap.min.js
 * @depends /plugins/cfjs/jquery.cfjs.js
 */
var cfrequest = cfrequest || {};
var dependency = function() {
	 var $fields = $("input, textarea, select"),
		fields_with_dependencies ,$fields_with_dependencies;
		  	
	 reload = function( trigger_change ) {
		 if( typeof cfrequest.fields != "undefined" ) {
			fields_with_dependencies = $.grep( cfrequest.fields, function( n, i ) {
				return n.dependency_count;
			});
			$fields_with_dependencies=$();
			for( var i = 0, cnt = fields_with_dependencies.length; i < cnt; i++ ) {
				var field = fields_with_dependencies[ i ], 
					$dependencies = $(), 
					$field = $( "[data-field_id=" + field.field_id + "]" );
	
				for( var d = 0, dcnt = field.field_dependency.length; d < dcnt; d++ ) {
					var dependency= field.field_dependency[ d ], 
						$dependency = $("[data-field_id=" + dependency.dependency + "]");
					$dependency.attr("data-hidden",true);
					$dependency.parentsUntil('.row').hide();
					$dependencies = $dependencies.add($dependency);
				}
	
				$field.each(function(){
					$(this).data("dependencies", $dependencies);	
					$fields_with_dependencies = $fields_with_dependencies.add( $(this) );
				});
			}
		}
		if( typeof trigger_change != "undefined" && trigger_change ) {
			$fields_with_dependencies.trigger( "change", "input, textarea, select");
		}
	 }
	 
	 init = function() {
		this.reload();
		if( typeof cfrequest.fields != "undefined" ) {
			$("#attendee-reg-form").on( "change", "input, textarea, select", function() {
				var $elem=$(this), 
					elem_type=$elem.attr("type"), 
					$dependencies = $elem.data("dependencies"), 
					value=$elem.val(),
					allVals = [];
				
				if( elem_type == "radio" ){
					value = $( "input[data-field_id=" + $elem.data("field_id") + "]:checked" ).val();
				}else if( elem_type == "checkbox" ) {
					$( "input[data-field_id=" + $elem.data("field_id") + "]:checked" ).each(function(){
						allVals.push( $(this).val() );
					});
					value = allVals.join("^");
				}
				
				checkDependency( $elem.data( "field_id" ), value, $elem, $dependencies );
			});
		
			$fields_with_dependencies.trigger( "change", "input, textarea, select");
		}
	}

	 function checkDependency( field_id, value, $elem, $dependencies ) {
		for( var i = 0, cnt = cfrequest.fields.length; i < cnt; i++ ) {
			var field = cfrequest.fields[i];
			if( field.field_id == field_id ){
				
				$($dependencies).each(function(){
					$(this).attr("data-hidden",true);
					$(this).data("hidden",true);
					$(this).parentsUntil('.row').hide();
				});
				for( var d = 0, dcnt = field.field_dependency.length; d < dcnt; d++ ) {
					var dependency = field.field_dependency[ d ], 
						$dependency_field = $( $("[data-field_id=" + dependency.dependency + "]"), $fields );
						
					if( $.ListFindNoCase( value, $.Trim( dependency.value ), "^" )  ) {
						$dependency_field.attr("data-hidden",false);
						$dependency_field.data("hidden",false);
						$dependency_field.parentsUntil('.row').show();
						var $other_checkbox = $($dependency_field,"input[data-other_field=\"true\"]");
						if( $other_checkbox ) {
							$other_checkbox.each(function(){
								var $elem = $(this),
									is_checked = $elem.prop("checked"),
									id = $elem.attr("id")
									$other_wrapper = $("#" + id + "_other_wrapper");
								$other_wrapper.hide();
								if( is_checked ) {
									$other_wrapper.show();
								}
							});
						}
					}
				}
				break
			}
		}	
	}
		
	 return {
		 init: init,
		 reload: reload
	 }
 };
$(function(){
	
	dependency().init();
		
});
