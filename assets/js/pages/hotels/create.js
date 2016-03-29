/**
 *
 * @depends /plugins/handlebars/handlebars-v3.0.0.js
 * @depends /plugins/moment/moment-date-timepicker.js
 * @depends /plugins/parsley/parsley.js
 */
var opt_source = $("#options-template").html()
	,opt_template = Handlebars.compile(opt_source)
	,rtype_source = $("#eventhotelroom-template").html()
	,rtype_template = Handlebars.compile(rtype_source)
	,index_cnt = 1;

Handlebars.registerHelper('ifin_use', function(in_use, options) {
  if(in_use === 0) {
    return options.fn(this);
  }
  return options.inverse(this);
});

$(function(){
	var $hotel_id = $("#hotel_id"),
	$hotel_id_label = $("#hotel_id_label"),
	$room_type_label = $("#room_type_label"),
	$room_types_wrapper = $("#room-types-wrapper"),
	$add_date_btn = $("#add-date-btn"),
	$new_hotel_form = $("#new_hotel"),
	$btn_save_hotel = $("#btn_save_hotel"),
	$new_hotel_modal = $("#new-hotel-modal");
	
	
	var applyDatepickers = function(){
		$('#room-types-wrapper').find(".datepicker").datetimepicker({
		    pickTime: false
		})
		.on( "blur", function( event ){
			$( ".bootstrap-datetimepicker-widget:visible" ).hide();
		});
	}
	$btn_save_hotel.on("click",function() {
		$new_hotel_form.parsley().validate()
		if( $new_hotel_form.parsley().isValid() ) {
			hotel_save();
		}
	});
	$room_types_wrapper.on("click","[data-action=\"remove\"]",function(){
		var $elem = $(this), link_id = $elem.data("link");
		loading( $room_type_label, true );
		$("[data-parent_link=\"" + link_id + "\"]").remove();
		loading( $room_type_label, false );
	});
	$hotel_id.on("change", function() {
		hotel_get();
		rooms_get();
	});
	$add_date_btn.on("click", function() {
		index_cnt++;
		$room_types_wrapper.append( rtype_template({index:index_cnt, hotel_room_id:0}) );
		applyDatepickers();
	});
	
	if( cfrequest.hotel_id ) {
		hotel_get();
		rooms_get();
	}else{
		hotels_get();
	}
	function hotel_save() {
		var hotel_result;
		loading( $btn_save_hotel, true );
		hotel_result = $.ajax({  
			url: cfrequest.urls.save_hotel
			,data: $new_hotel_form.serialize()
			,cache: false
			,type: "POST"
			,dataType: "json"
		} );
		hotel_result.always(function( data ){
			loading( $btn_save_hotel, false );
			$new_hotel_modal.modal("hide");
			hotels_get( data.hotel_id );
		});
	}
	
	function hotels_get( selected_id ) {
		var hotels_result;
		loading( $hotel_id_label, true );
		hotels_result = $.ajax({  
			url: cfrequest.urls.hotel_list
			,data: {}
			,cache: false
			,type: "POST"
			,dataType: "json"
		} );
		hotels_result.always(function( data ){
			$hotel_id.html("<option></option>");
			data.data.map( function( hotel_opt, index ) {
				if( !hotel_opt.in_use ) {
					hotel_opt['value'] = hotel_opt.hotel_id;
					hotel_opt['display'] = hotel_opt.name;
					hotel_opt['selected'] = "";
					if( selected_id == hotel_opt.hotel_id ) {
						hotel_opt['selected'] = "selected";
					}
					$hotel_id.append( opt_template(hotel_opt) );
				}
			});
			$hotel_id.trigger("change");
			loading( $hotel_id_label, false );
		});
	}
	function hotel_get() {
		var hotel_result;
		if( $hotel_id.val() > 0 ) {
			loading( $hotel_id_label, true );
			hotel_result = $.ajax({  
				url: cfrequest.urls.hotel_get
				,data: {'hotel_id':$hotel_id.val()}
				,cache: false
				,type: "POST"
				,dataType: "json"
			} );
			hotel_result.always(function( data ){
				$("#hotel_address").val( data.address_1 );
				$("#hotel_url").val( data.url );
				if( $("#hotel_dispaly_name").length ) {
					$("#hotel_dispaly_name").html( data.name );
				}
				loading( $hotel_id_label, false );
			});
		}
	}
	function rooms_get( ) {
		var rooms_result;
		if( $hotel_id.val() > 0 ) {
			loading( $room_type_label, true );
			rooms_result = $.ajax({  
				url: cfrequest.urls.room_room_list
				,data: {'hotel_id':$hotel_id.val()}
				,cache: false
				,type: "POST"
				,dataType: "json"
			} );
			rooms_result.always(function( data ){
				$room_types_wrapper.html("");
				data.data.map( function( room_type, index ) {
					room_type.index = index+1;
					$room_types_wrapper.append( rtype_template(room_type) );
					index_cnt = room_type.index;
				});
				applyDatepickers();
				$("[data-room_type_id]").each(function(index, value){
					var $elem = $(this);
					$elem.val( $elem.data("room_type_id") );					
				});
				loading( $room_type_label, false );
			});
		}
	}
	
});
