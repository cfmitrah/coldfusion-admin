/**
 *
 * @depends /pages/common/listing.js
 * @depends /pages/common/listing.js
 * @depends /plugins/moment/moment-date-timepicker.js
 */
$(function(){
	var standard_list = cfrequest.standard_field_listing_config,
		custom_list = cfrequest.custom_field_listing_config,
		dependencies_list = cfrequest.dependencies_listing_config,
		hotel_list = cfrequest.hotel_field_listing_config,
		login_list = cfrequest.login_field_listing_config,
		$standard_list_datatable, $login_list_datatable,$dependencies_list_datatable, $hotel_list_datatable,
		$standard_field_listing = $("table#standard_field_listing"),
		$hotel_field_listing = $("table#hotel_field_listing")
		$login_field_listing = $("table#login_field_listing"),
		$standard_field_manage = $("#standard-field-manage"),
		$standard_field_id = $("#standard_field_id"),
		$standard_field_label = $("#standard_field_label"),
		$standard_field_name = $("#standard_field_name"),
		$standard_field_required = $("#standard_field_required"),
		$standard_field_type = $("#standard_field_type"),
		$standard_field_help = $("#standard_field_help"),
		$save_standard_field = $("#btn_save_standard_field"),
		$standard_field_name_display = $("#standard_field_name_display"),
		$listing = $("#registration_listing"),
		$custom_field_id = $("#custom_field_id"),
		$custom_field_label = $("#custom_field_label"),
		$custom_field_required = $("#custom_field_required"),
		$custom_field_help = $("#custom_field_help"),
		$custom_field_type = $("#custom_field_type"),
		$custom_field_max_length  = $("#custom_field_max_length"),
		$custom_field_manage = $("#custom-field-manage"),
		$custom_field_name_display = $("#custom_field_name_display"),
		$custom_field_options = $("#field-options"),
		$custom_field_choices = $("#field-choices"),
		$save_custom_field = $("#btn_save_custom_field"),
		$dependency_parent_field = $( "#dependency_parent_field" ),
		$dependency_child_field = $( "#dependency_child_field" ),
		$field_dependency_manage = $( "#field-dependency-manage" ),
		$custom_field_narrative = $( "#custom_field_narrative" ),
		$dependency_field_id = $("#field_dependency_id"),
		$custom_field_has_other=$("#custom_field_has_other"),
		$field_region_options=$("#field-region-options"),
		$standard_region_code=$("#standard_region_code"),
		$custom_field_narrative=$("#custom_field_narrative"),
		$standard_field = $("#standard_field"),
		$confirm_field_wrapper = $("#confirm-field-wrapper"),
		$confirm_field = $("#confirm_field"),
		$required_wrapper = $("#required_wrapper"),
		$narrative_wrapper = $("#narrative_wrapper"),
		$help_text_wrapper = $("#help_text_wrapper"),
		standard_oSettings="", login_oSettings="", custom_oSettings="", hotel_oSettings="", dependency_oSettings="",
		confirm_field_value = "",
		$custom_field_date_range_start=$("#custom_field_date_range_start"),
		$custom_field_date_range_end=$("#custom_field_date_range_end"),
		$custom_field_date_default=$("#custom_field_date_default"),
		$field_options_date_range=$("#field-options-date-range"),
		$standard_field_max_length=$("#standard_field_max_length"),
		$custom_field_admin_only=$("#custom_field_admin_only"),
		$hotel_field_hide=$("#hotel_field_hide"),
		$hotel_number_rooms_wrapper=$("#hotel_number_rooms_wrapper"),
		$hotel_min_number_rooms=$("#hotel_min_number_rooms"),
		$hotel_max_number_rooms=$("#hotel_max_number_rooms"),
		$standard_field_admin_only=$("#standard_field_admin_only"),
		$field_duplicate_manage = $("#field-duplicate-manage"),
		$btn_save_duplicate_field = $("#btn_save_duplicate_field"),
		$duplicate_form = $("#duplicate_form"),
		$duplicate_field_id = $("#duplicate_field_id"),
		$duplicate_field_label=$("#duplicate_field_label"),
		$standard_field_reg_view_only = $("#standard_field_reg_view_only"),
		$custom_field_reg_view_only = $("#custom_field_reg_view_only"),
		$standard_field_hide_on_review = $("#standard_field_hide_on_review"),
		$custom_field_hide_on_review = $("#custom_field_hide_on_review");

	$listing.on("click", "a[data-duplicate]", function( event ){
		var $elem = $(this), field_result
		loading($elem,true);
		event.preventDefault();
		var field_result = $.ajax({  
				url: cfrequest.registration_field_get_url,
				data: { 'field_id': $elem.data('field_id') }
			} );
		field_result.always(function( data ){
			$duplicate_field_label.val( data.label );		
			$duplicate_field_id.val( $elem.data('field_id') );
			$field_duplicate_manage.modal("show");
			loading($elem,false);
		});
			
	});
	$btn_save_duplicate_field.on("click",function(){
		field_result = $.ajax({  
			url: cfrequest.field_duplicate_url,
			data: $duplicate_form.serialize()
		} );
		field_result.always(function( data ){
			$custom_list_datatable.fnDraw();
			$field_duplicate_manage.modal("hide");
		});
	});
	$(".dateonly-datetime").datetimepicker({
	    pickTime: false
	})
	.on( "blur", function( event ){
		$( ".bootstrap-datetimepicker-widget:visible" ).hide();
	});
	
	$listing.on("click", "a[data-remove]", function( event ){
		event.preventDefault();
		doRemove.apply( this );
	});
	$("#btn_new_custom_field").on("click",function(){
		clearCustomModalForm();
	});
	$listing.on("click", "a[data-manage]", function( event ){
		var $elem = $(this);
		event.preventDefault();
		doManage( $elem, $elem.data( "manage" ) );
			
	});
	//Standard fields
	
	$save_standard_field.on( "click",function(){
		saveField( "registration" );
	});
	
	if( standard_list.ajax_source != undefined && standard_list.aoColumns != undefined && standard_list.table_id  != undefined){
		setTimeout( getStandardFields(), 1000);
	}
	
	//hotel fields
	if( hotel_list.ajax_source != undefined && hotel_list.aoColumns != undefined && hotel_list.table_id  != undefined){
		setTimeout( getHotelFields(), 1000);
	}

	//Custom fields
	if( custom_list.ajax_source != undefined && custom_list.aoColumns != undefined && custom_list.table_id  != undefined){
		setTimeout( getCustomFields(), 2000);
	}
	
	//Dependencies
	if( dependencies_list.ajax_source != undefined && dependencies_list.aoColumns != undefined && dependencies_list.table_id  != undefined){
		setTimeout( getDependencies(), 3000);
	}
	
	//login fields
	if( login_list.ajax_source != undefined && login_list.aoColumns != undefined && login_list.table_id  != undefined){
		setTimeout( getLoginFields(), 3000);
	}

	$save_custom_field.on("click",function() {
		loading($save_custom_field, true );
		saveField( 'custom' );
	});
	
	$custom_field_type.on("change", $custom_field_manage, function() {
		displayFieldOptions( $("option:selected", this ).val() );
	});

	$('#additional-options-btn').on("click", function(e){
		e.preventDefault();
		$(this).html('Add Additional Choices');
		additionalChoices( "form-options-inputs-wrap" );
	});
	$('#standard-additional-options-btn').on("click", function(e){
		e.preventDefault();
		$(this).html('Add Additional Choices');
		additionalChoices( "standard-form-options-inputs-wrap" );
	});
	$( "#btn_new_dependency_field" ).on( "click", function (e) {
		populateDependencyFields();
		$dependency_field_id.val( 0 );
	});

	$( "#btn_save_dependency_field" ).on( "click", function (e) {
		var $form = $("#dependency_form"), value="";
		if( $("#parent_value:visible").length ) {
			value = $( "#parent_value" ).val();
		}else{
			value = $("#parent_options_inner_wrapper input:checked").val();
		}
		field_result = $.ajax({  
				url: cfrequest.save_dependency_url +'?'+ $form.serialize(),
				data: { 'value': value }
			} );
		field_result.always(function( data ){
			$dependencies_list_datatable.fnDraw();
			$field_dependency_manage.modal("hide");
		});

	});
	$dependency_parent_field.on("change",function(){
		var $elem = $(this);
		displayDependencyValue( $( "option:selected", $elem ).data( "has_options" ), $elem.val(), "" );
	});

	function getLoginFields() {
		iDisplayLength =10;
		if( login_list.display_length != undefined && login_list.display_length != undefined ){
			iDisplayLength = login_list.display_length;
		}
		$login_list_datatable = setDataTables( login_list.ajax_source, login_list.aoColumns, login_list.table_id, iDisplayLength );
		login_oSettings = $login_list_datatable.fnSettings();
	}
	function getHotelFields() {
		iDisplayLength =10;
		if( hotel_list.display_length != undefined && hotel_list.display_length != undefined ){
			iDisplayLength = hotel_list.display_length;
		}
		$hotel_list_datatable = setDataTables( hotel_list.ajax_source, hotel_list.aoColumns, hotel_list.table_id, iDisplayLength );
		hotel_oSettings = $hotel_list_datatable.fnSettings();
	}
	function getCustomFields() {
		iDisplayLength =10;
		if( custom_list.display_length != undefined && custom_list.display_length != undefined ){
			iDisplayLength = custom_list.display_length;
		}
		$custom_list_datatable = setDataTables( custom_list.ajax_source, custom_list.aoColumns, custom_list.table_id, iDisplayLength );
		custom_oSettings = $custom_list_datatable.fnSettings();
	}
	function getStandardFields() {
		iDisplayLength =10;
		if( standard_list.display_length != undefined && standard_list.display_length != undefined ){
			iDisplayLength = standard_list.display_length;
		}
		$standard_list_datatable = setDataTables( standard_list.ajax_source, standard_list.aoColumns, standard_list.table_id, iDisplayLength );
		standard_oSettings = $standard_list_datatable.fnSettings();
	}
	function getDependencies() {
		iDisplayLength =10;
		if( dependencies_list.display_length != undefined && dependencies_list.display_length != undefined ){
			iDisplayLength = dependencies_list.display_length;
		}
		$dependencies_list_datatable = setDataTables( dependencies_list.ajax_source, dependencies_list.aoColumns, dependencies_list.table_id, iDisplayLength );
		dependency_oSettings = $dependencies_list_datatable.fnSettings();
	}
	//Functions
	function populateDependencyFields( parent_value, child_value, dependency_value, option_data ) {
		getAllRegistrationFields(function( data ){
			 option=[];

			 for ( var i = 0, cnt = data.count; i < cnt; i++ ) { 
				 var row = data.data[ i ];
				 if( row.standard_field != 2 ) {
					 option.push( "<option value=\"" ); option.push( row.field_id ); option.push( "\" data-has_options=\""); option.push( row.has_options ); option.push("\">" );
					 	option.push( row.label );
					 option.push( "</option>" );
				 }
			 }
			 options = option.join( "" );
			 $("#dependency_parent_field,#dependency_child_field").html( options );
			 if( child_value != undefined ) {
				 $dependency_child_field.val( child_value );
			 }
			 if( parent_value != undefined ) {
				 $dependency_parent_field.val( parent_value );
		     }
			 //$dependency_parent_field.trigger( "change" );
			 displayDependencyValue( $( "option:selected", $dependency_parent_field ).data( "has_options" ), $dependency_parent_field.val(), dependency_value );
		});
	}
	function getAllRegistrationFields(fnc ) {
		var option=[],options,field_result = $.ajax({  
				url: cfrequest.get_event_fields_url
			} );
		field_result.always( fnc );
		
	}
	function displayDependencyValue( has_options, field_id, value ) {
		var field_result, option, options;
		if( value == undefined ) {
			value = ""
		}
		$("#parent_options_inner_wrapper").html( "" );
		if( has_options ){
			field_result = $.ajax( { url: cfrequest.get_field_choices_url, data: { 'field_id': field_id } } );
			field_result.always(function( data ){
				 option=[];
				 for ( var i = 0, cnt = data.count; i < cnt; i++ ) { 
					var row = data.data[ i ];
					option.push( "<div class=\"radio\">" );
					    option.push( "<label>" );
					    	option.push( "<input type=\"radio\" name=\"parent_option_value\" value=\"");option.push( $.LTrim( row.value ) ); option.push( "\" /> ");option.push( $.LTrim( row.choice ) );
					    option.push( "</label>" );
					option.push( "</div>" );
				 }

				 $("#parent_options_inner_wrapper").html( option.join( "" ) );
				 $("#parent_options_inner_wrapper input[value='" + $.LTrim( value ) + "']").prop( "checked",true );
			});
			
			$("#parent_value_wrapper").hide();
			$("#parent_options_wrapper").show();
		}else{
			$("#parent_value_wrapper").show();
			$("#parent_options_wrapper").hide();
			$("#parent_value").val( value );
		}
		
	}
	function additionalChoices( input_wrap_id ) {
		var additional_input = "";
		var start = $("#" + input_wrap_id + " input").length;
		var choice_cnt = start + 4;
		for ( var i = start; i < choice_cnt; i++) { 
			additional_input = additional_input + '<div class="col-md-3"><input type="text" id="field_choices[' + i + ']" data-choice="true" class="form-control"></div>';
		};

		$("#" + input_wrap_id ).append( additional_input );
	}
	function displayFieldOptions( select_field_type ) {
		$custom_field_options.hide();
		$custom_field_choices.hide();
		$confirm_field_wrapper.hide();
		$required_wrapper.show();
		$narrative_wrapper.show();
		$help_text_wrapper.show();
		$("#field-choice-options").hide();
		$field_options_date_range.hide();
		switch( select_field_type ){
			case "checkbox":
			case "multiple_select":
			case "radio":
			case "select":
				$custom_field_choices.show();
				$("#field-choice-options").show();
			break;
			case "date":
				$field_options_date_range.show();
			break;
			case "tel":
				$custom_field_max_length.val(15);
			break;
			case "text":
			case "textarea":
			case "password":
				$custom_field_options.show();
			break;
			case "confirm":
				/*getAllRegistrationFields(function( data ){
					 var option=[];
					 for ( var i = 0, cnt = data.count; i < cnt; i++ ) { 
						 var row = data.data[ i ];
						 if( $.ListFindNoCase("email,text,date", row.field_type ) && row.standard_field != 2 ) {
							 option.push( "<option value=\"" ); option.push( row.field_name );option.push("\">" );
							 	option.push( row.label );
							 option.push( "</option>" );
						 }
					 }
					 options = option.join( "" );
					 console.log('foo')
					 $confirm_field
					 	.html( options )
					 	.val( confirm_field_value );
				});*/
				$confirm_field_wrapper.show();
			break;
			case "narrative":
				$required_wrapper.hide();
				$help_text_wrapper.hide();
				$narrative_wrapper.show();
			break;
			case "section_header":
				$required_wrapper.hide();
				$narrative_wrapper.hide();
				$help_text_wrapper.hide();
			break;
		}
	}
	function getRegistrationFieldInfo( field_id, type ) {
		var url = { 
			'registration': cfrequest.registration_field_get_url,
			'standard': cfrequest.standard_field_get_url,
			'custom': cfrequest.registration_field_get_url
		 },
		 params = { 
			'registration': { 'field_id': field_id },
			'custom': { 'field_id': field_id },
			'standard': { 'standard_field_id': field_id }
		 };
		var field_result = $.ajax({  
				url: url[ type ],
				data: params[ type ]
			} );
		field_result.always(function( data ){
			populateModal( data, type );
		});
	}
	function saveField( type ){
		var $choices = $("input[data-choice]"),
			choice_cnt = $choices.length,
			field_result,
			data ={
			'custom': {
				field_id: ( $custom_field_id.val() || 0 ),
				label: $custom_field_label.val(),
				field_name: $standard_field_name.val(),
				required: $custom_field_required.prop( "checked" ),
				field_type: $custom_field_type.val(),
				narrative: $custom_field_narrative.val(),
				standard_field: 0,
				'attributes.placeholder': $custom_field_help.val(),
				'attributes.maxlength': $custom_field_max_length.val(),
				'attributes.has_other_input': $custom_field_has_other.prop("checked"),
				'attributes.admin_only': $custom_field_admin_only.prop("checked"),
				'attributes.confirm_field': $confirm_field.val(),
				'attributes.date_range_start': $custom_field_date_range_start.val(),
				'attributes.date_range_end': $custom_field_date_range_end.val(),
				'attributes.default_date': $custom_field_date_default.val(),
				'attributes.reg_view_only': $custom_field_reg_view_only.prop("checked"),
				'attributes.hide_on_review': $custom_field_hide_on_review.prop("checked")
			},
			'registration': {
				field_id: $standard_field_id.val(),
				label: $standard_field_label.val(),
				field_name: $standard_field_name.val(),
				required: $standard_field_required.prop( "checked" ),
				field_type: $standard_field_type.val(),
				standard_field: $standard_field.val(),
				'attributes.placeholder': $standard_field_help.val(),
				'attributes.maxlength': $standard_field_max_length.val(),
				'attributes.maxlength': $standard_field_max_length.val(),
				'attributes.hotel_hide': $hotel_field_hide.prop( "checked" ),
				'attributes.min': $hotel_min_number_rooms.val(),
				'attributes.max': $hotel_max_number_rooms.val(),
				'attributes.admin_only': $standard_field_admin_only.prop("checked"),
				'attributes.reg_view_only': $standard_field_reg_view_only.prop("checked"),
				'attributes.hide_on_review': $standard_field_hide_on_review.prop("checked")
			}
		};

		if( choice_cnt ){
			var cnt = 1,
				delete_cnt=1;
			$choices.each(function( key, obj ){
				var value = $.trim( $(obj).val() );
				if( value ){
					data[ type ]["choices["+cnt+"].id"] = ( $(obj).data("id") || 0 );
					data[ type ]["choices["+cnt+"].value"] = value;
					cnt++;
				}else if( $(obj).data("id") ){
					data[ type ]["delete_choices["+delete_cnt+"].id"] = ( $(obj).data("id") || 0 );
					delete_cnt++;
				}
			});
		}else if( data.registration.field_name == "region_code" ){
			data["registration"]['attributes.region_code'] = $standard_region_code.val();
		}
		field_result = $.ajax({  
			url: cfrequest.field_save_url,
			data: data[ type ],
			type:"POST"
		} );
		field_result.always(function( data ){
			if( type == "custom" ){
				$custom_field_manage.modal("hide")
				$custom_list_datatable.fnDraw();
			}else{
				$standard_field_manage.modal("hide");
				if( $standard_field.val() == 1 ) {
					$standard_list_datatable.fnDraw();
				}else if( $standard_field.val() == 2 ) {
					$login_list_datatable.fnDraw();
				}else if( $standard_field.val() == 3 ) {
					$hotel_list_datatable.fnDraw();
				}
			}
			loading($save_custom_field, false );
		});
	}
	function clearCustomModalForm(){
		$("#form-options-inputs-wrap").html( "" )
		$custom_field_name_display.html( "" );
		$custom_field_label.val( "" );
		$custom_field_type.val( "" );
		$custom_field_required.prop( 'checked', false );
		$custom_field_admin_only.prop( 'checked', false );
		$custom_field_id.val( "" );
		$custom_field_help.val( "" );
		$custom_field_max_length.val( "" );
		$custom_field_date_range_end.val( "" );
		$custom_field_date_range_start.val( "" );
		$custom_field_date_default.val("");
		displayFieldOptions( $custom_field_type.val() );
	}
	function populateModal( data, type ){
		var add_input=[],choice_cnt=0;
		if( type == "custom" ){
			confirm_field_value = "";
			if( typeof data.attributes.confirm_field != "undefined" ) {
				confirm_field_value = data.attributes.confirm_field;
			}
			displayFieldOptions( data.field_type );
			getAllRegistrationFields(function( data ){
				 var option=[];
				 for ( var i = 0, cnt = data.count; i < cnt; i++ ) { 
					 var row = data.data[ i ];
					 if( $.ListFindNoCase("email,text,date", row.field_type ) ) {
						 option.push( "<option value=\"" ); option.push( row.field_name );option.push("\">" );
						 	option.push( row.label );
						 option.push( "</option>" );
					 }
				 }
				 options = option.join( "" );
				 $confirm_field
				 	.html( options )
				 	.val( confirm_field_value );
			});
			$('#form-options-inputs-wrap').html( "" );
			$custom_field_name_display.html( data.label );
			$custom_field_label.val( data.label );
			$custom_field_type.val( data.field_type );
			$custom_field_required.prop( "checked", ( data.required || false ) );
			$custom_field_has_other.prop( "checked", ( data.attributes.has_other_input || false ) );
			$custom_field_id.val( data.field_id );
			$custom_field_help.val( data.attributes.placeholder );
			$custom_field_max_length.val( data.attributes.maxlength );
			$custom_field_date_range_end.val( data.attributes.date_range_end );
			$custom_field_date_range_start.val( data.attributes.date_range_start );
			$custom_field_date_default.val( data.attributes.default_date )
			$custom_field_narrative.val( data.narrative );
			$custom_field_admin_only.prop( "checked", ( data.attributes.admin_only || false ) );
			$custom_field_reg_view_only.prop( "checked", ( data.attributes.reg_view_only || false ) );
			$custom_field_hide_on_review.prop( "checked", ( data.attributes.hide_on_review || false ) );
			
			
			choice_cnt = data.choices.length;
			if( choice_cnt ){
				for ( var i = 0; i < choice_cnt; i++) { 
					add_input.push( "<div class=\"col-md-3\">" );
						add_input.push( "<input type=\"text\" id=\"field_choices[" );add_input.push( i );add_input.push( "]\" data-id=\"" );add_input.push( data.choices[i].choice_id );add_input.push( "\"" );
										add_input.push( " data-choice=\"true\" value=\"" ); add_input.push( $.LTrim( data.choices[i].choice ) ); add_input.push( "\" class=\"form-control\">" );
					add_input.push( "</div>" );
				};

				$('#form-options-inputs-wrap').append( add_input.join( "" ) );
			}
		}else{
			$standard_field_help.val("");
			$standard_field_max_length.val("")
			$standard_field.val( data.standard_field );
			$field_region_options.hide();
			if( data.field_name == "region_code" ) {
				$field_region_options.show();
				if( typeof data.attributes.region_code != "undefined" ) {
					$standard_region_code.val( data.attributes.region_code );
				}
			}
			$("#standard-form-options-inputs-wrap").html( "" );
			$standard_field_name_display.html( data.label );
			$standard_field_label.val( data.label );
			$standard_field_name.val( data.field_name );
			$standard_field_type.val( data.field_type );
			$standard_field_required.prop( "checked", ( data.required || false ) );
			$standard_field_admin_only.prop( "checked", ( data.attributes.admin_only || false ) );
			$standard_field_reg_view_only.prop( "checked", ( data.attributes.reg_view_only || false ) );
			
			if( data.standard_field == 2 ) {
				$standard_field_required.prop( "checked", true ).attr("disabled","true");
			}
			$standard_field_id.val( data.field_id );
			if( typeof data.attributes.placeholder != "undefined" ) {
				$standard_field_help.val( data.attributes.placeholder );
			}

			if( typeof data.attributes.maxlength != "undefined" ) {
				$standard_field_max_length.val( data.attributes.maxlength );
			}
			$hotel_field_hide.prop( "checked", false );
			if( typeof data.attributes.hotel_hide != "undefined" && data.attributes.hotel_hide == 1) {
				$hotel_field_hide.prop( "checked", true );
			}
			$standard_field_hide_on_review.prop( "checked", false );
			if( typeof data.attributes.hide_on_review != "undefined" && data.attributes.hide_on_review == 1) {
				$standard_field_hide_on_review.prop( "checked", true );
			}
			$hotel_min_number_rooms.val( "" );
			if( typeof data.attributes.min != "undefined" ) {
				$hotel_min_number_rooms.val( data.attributes.min );
			}
			$hotel_max_number_rooms.val( "" );
			if( typeof data.attributes.max != "undefined" ) {
				$hotel_max_number_rooms.val( data.attributes.max );
			}
			choice_cnt = data.choices.length;
			if( choice_cnt ){
				for ( var i = 0; i < choice_cnt; i++) { 
					add_input.push( "<div class=\"col-md-3\">" );
						add_input.push( "<input type=\"text\" id=\"field_choices[" );add_input.push( i );add_input.push( "]\" data-id=\"" );add_input.push( data.choices[i].choice_id );add_input.push( "\"" );
										add_input.push( " data-choice=\"true\" value=\"" ); add_input.push( $.LTrim( data.choices[i].choice ) ); add_input.push( "\" class=\"form-control\">" );
					add_input.push( "</div>" );
				};

				$("#standard-form-options-inputs-wrap").append( add_input.join( "" ) );
			}
			$("#hotel_field_hide_wrapper").hide();
			$("#hotel_number_rooms_wrapper").hide();
			
			if( data.field_name == "hotel_room_type_id" || data.field_name == "hotel_id" ) {
				$("#hotel_field_hide_wrapper").show();
			}
			if( data.field_name == "hotel_number_rooms" ) {
				$("#hotel_number_rooms_wrapper").show();
			}
			if( data.field_name != "region_code" && data.field_name != "country_code" ) {
				switch( data.field_type ){
					case "checkbox":
					case "multiple_select":
					case "radio":
					case "select":
						$("#standard-field-choices").show();
						if( data.standard_field == 2 ) {
							$("#standard-field-choices").hide();	
						}
					break;
					case "text":
					case "textarea":
					case "password":
						$("#standard-field-choices").hide();
					break;
					
				}
			}
			
		}
	}
	function populateDependencyModal( data ) {
		populateDependencyFields( data.field_id, data.dependency, data.value );
		$dependency_field_id.val( data.field_dependency_id );
	}
	function doRemove( ) {
		var $elem = $( this ), type=$elem.data( "remove" ),
			data ={
				'custom': {
					'field_id': $elem.data( "field_id" )
				},
				'unassign': {
					'field_id': $elem.data( "field_id" )
				},
				'dependency': {
					'field_dependency_id': $elem.data( "field_dependency_id" )
				}
			},
			urls ={
				'unassign': cfrequest.field_remove_url,
				'custom': cfrequest.field_remove_url,
				'dependency': cfrequest.remove_dependency_url
			},
			tables ={
				'custom': $custom_list_datatable,
				'unassign': $standard_list_datatable,
				'dependency': $dependencies_list_datatable
			},
			field_result = $.ajax({  
				url: urls[ type ],
				data: data[ type ]
			});
		
		field_result.always(function( data ){
			tables[ type ].fnDraw();
			if( type == "unassign" ) {
				$login_list_datatable.fnDraw();
			}
		});
	}
	function doManage( elem, type ) {
		var $modal = { 
				'custom':$custom_field_manage, 
				'standard':$standard_field_manage,
				'hotel':$standard_field_manage, 
				'registration':$standard_field_manage,
				'dependency':$field_dependency_manage
			},
			url = { 
				'registration': cfrequest.registration_field_get_url,
				'standard': cfrequest.standard_field_get_url,
				'hotel': cfrequest.standard_field_get_url,
				'custom': cfrequest.registration_field_get_url,
				'dependency': cfrequest.get_dependency_url,
				'quick_assign': cfrequest.quick_assign_url
			},
			func = { 
				'registration': populateModal,
				'standard': populateModal,
				'hotel': populateModal,
				'custom': populateModal,
				'dependency':populateDependencyModal
			},
			params = { 
				'registration': { 'field_id': elem.data( "field_id") },
				'custom': { 'field_id': elem.data( "field_id") },
				'hotel': { 'standard_field_id': elem.data( "standard_field_id") },
				'standard': { 'standard_field_id': elem.data( "standard_field_id") },
				'dependency': { 'field_dependency_id': elem.data( "field_dependency_id") },
				'quick_assign': { 'standard_field_id': elem.data( "standard_field_id") }
			}, 
			field_result = $.ajax({  
				url: url[ type ],
				data: params[ type ]
		    });
		    
		field_result.always(function( data ){
			if( type == "quick_assign" ) {
				$standard_list_datatable.fnDraw();
				$hotel_list_datatable.fnDraw();
				$login_list_datatable.fnDraw();
			}else{
				func[ type ]( data, type );
			}
		});

		if( typeof $modal[ type ] != "undefined" ) {
			$modal[ type ].modal( 'show' );
		}
	}
});