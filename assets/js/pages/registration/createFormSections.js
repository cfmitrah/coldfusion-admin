/**
 *
 * @depends /jquery-1.11.0.min.js
 * @depends /plugins/ckeditor/ckeditor.js
 * @depends /plugins/UI/jquery-ui.js
 */
$(function(){
	var $section_list = $( "#form-section-list" ),
	$add_section = $('#btn-add-section'),
	$form = $( "#add-section" ),
	layout_types = { 
		"2-columns": "2 Column Layout",
		"1-column": "1 Column Layout" };

	CKEDITOR.replace( "summary" );
	summary_editor = CKEDITOR.instances['summary'];
	$section_list.sortable({
	  update: function( event, ui ) {
	  	updateSort();
	  }
	});
	$("#btn-rest-section").on("click",function(){
		$("#section_id").val(0);
		$("#sort").val(0);
	});
	$section_list.on( "click", "a[data-action]", function( event ) {
		event.preventDefault();
		var $elem = $(this),
			id = $elem.data( "section_id" ),
			remove_section_result, edit_section_result,
			action=$elem.data( "action" );
			if( action == "remove_section" ) {
				if(confirm("Are you sure you want to delete this form section?")) {
					remove_section_result = $.ajax({  
						url: cfrequest.section_delete,
						method: "POST",
						data: { 
							'registration_type_id': cfrequest.registration_type_id,
							'section_id': id
						}
					} );
					remove_section_result.always(function( data ){ 
						getSections();
					});
				}else {
					return false;
				}
				
			}else if( action == "edit_section" ) {
				edit_section_result = $.ajax({  
					url: cfrequest.section_edit,
					method: "POST",
					data: { 
						'registration_type_id': cfrequest.registration_type_id,
						'section_id': id
					}
				} );
				edit_section_result.always(function( data ){ 
					editSection( data );
				});
			}
	});
	$form.on( "submit", function( event ) {
		event.preventDefault();
		
		 summary_editor.updateElement();
		var $obj = $( this ),
			add_section_result = $.ajax({  
				url: cfrequest.section_save,
				method: "POST",
				data: $form.serialize(),
				beforeSend: function( jqxhr ){
					loading( $add_section, true );
				}
			} );
		add_section_result.always(function( data ){ 
			getSections();
			$("#section_id").val(0);
			$("#sort").val(0);
			loading( $add_section, false );
			$form[0].reset();
			summary_editor.setData( "" );
			
		});
	});
	
	getSectionTypes( "All", 0 );
	getSections();
//Functions
	function getSectionTypes( section_type, selected ) {
		loading($("#section_type_id_label"),true)
		var _result = $.ajax({  
			url: cfrequest.section_types_get,
			data: { 'type': section_type, 'registration_type_id':cfrequest.registration_type_id }
		} );
		_result.always( function( data ){
		var option=[],options="";
			for ( var i = 0, cnt = data.count; i < cnt; i++ ) { 
				var row = data.data[ i ];
				option.push( "<option value=\"" ); option.push( row.section_type_id ); option.push( "\"" ); option.push("\">" );
					option.push( row.name );option.push( "(" );option.push( row.description );option.push( ")" );
				option.push( "</option>" );
			}
			options = option.join( "" );
			$('#section_type_id').html( options ).val( selected );
			loading($("#section_type_id_label"),false)
		});
	}
	function getSections(){
		var sections_result = $.ajax({  
			url: cfrequest.sections_get,
			data: { 'registration_type_id': cfrequest.registration_type_id }
		} );
		sections_result.always( function( data ){
			var section = [];
			$section_list.empty();
			for ( var i = 0, cnt = data.count; i < cnt; i++ ) { 
				var row = data.data[ i ];
				section.push( "<li id=\"" ); section.push( row.section_id ); section.push( "\" class=\"ui-sortable-handle\">" );
				section.push( "		<a href=\"#\" class=\"btn btn-small btn-danger\" data-section_id=\"" ); section.push( row.section_id ); section.push( "\" data-action=\"remove_section\">" );
				section.push( "			<span class=\"glyphicon glyphicon-remove-circle\"></span>");
				section.push("		</a>" );
				section.push( "		<a href=\"#\" class=\"btn btn-small btn-primary\" data-section_id=\"" ); section.push( row.section_id ); section.push( "\" data-action=\"edit_section\">" );
				section.push( "			<span class=\"glyphicon glyphicon-edit\"></span>");
				section.push("		</a>" );
				section.push( "		<strong>" );section.push( row.title ); section.push( "</strong> - " ); section.push( layout_types[ row.layout ] );
				section.push( "</li>" );
			}
			$section_list.html( section.join( "" ) );
			updateSort();
		});
	}
	function updateSort(){
		var ids = $section_list.sortable( "toArray" ).join(","),
		section_sort_result = $.ajax({  
			url: cfrequest.sections_sort_update,
			data: { 
				'registration_type_id': cfrequest.registration_type_id,
				'section_ids': ids
			}
		} );
		section_sort_result.always( function( data ){
			//getSections();
		});
	}
	function editSection( section_data ) {
		getSectionTypes( section_data.section_type, section_data.section_type_id );
		$('#section_id').val( section_data.section_id );
		$('#title').val( section_data.title );
		$('#label').val( section_data.label );
		$('#summary').val( section_data.summary );
		summary_editor.setData( section_data.summary );
		$('#layout').val( section_data.layout );
		$('#sort').val( section_data.sort );
		$('#section_type_id').val( section_data.section_type_id );
		$("#group_allowed").prop( "checked", false );
		if( typeof section_data.settings.group_allowed != "undefined" && section_data.settings.group_allowed == 1) {
			$("#group_allowed").prop( "checked", true );
		}

	}

});