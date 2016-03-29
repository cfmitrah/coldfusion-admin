/**
 *
 * @depends /bootstrap.min.js
 * @depends /plugins/cfjs/jquery.cfjs.js
 * @depends /plugins/handlebars/handlebars-v3.0.0.js
 */
var opt_source = $("#options-template").html()
	,select_source = $("#select-template").html()
	,opt_template = Handlebars.compile(opt_source,{noEscape: true})
	,select_template = Handlebars.compile(select_source,{noEscape: true})
	,display_source=$("#display-template").html()
	,display_template = Handlebars.compile(display_source);

	
$(function(){
	var selected_id = 0;
	$("#hotel_room_type_id").parentsUntil(".row").hide();
	$("#hotel_id").parentsUntil(".row").hide();

	$("#registration-form").on("change", "#hotel_room_type_id", function() {
		set_check_in_out_dates();
	});
	
	if( typeof cfrequest.hotel_rooms != "undefined") {
		build_rooms_field( cfrequest.hotel_rooms, cfrequest.hotel_rooms.count);	
	}
	
	build_hotel_field( cfrequest.hotels.data, cfrequest.hotels.count);
	set_check_in_out_dates();
	
	function set_check_in_out_dates() { 
		var $elem=$("#hotel_room_type_id"),
			$hotel_checkout_date=$("#hotel_checkout_date"),
			$hotel_checkin_date=$("#hotel_checkin_date"),
			$room_type = $elem.find(":selected");
		
		if( $elem.is("input") ) $room_type = $elem;	

		
		$('#hotel_checkout_date, #hotel_checkin_date').each(function(k, v) {
			var $elem = $(v), $input = $elem.clone();
			$elem.after( $input );
			$elem.remove();
			
			$input
			.attr({"data-date-mindate":$room_type.data("mindate"),"data-date-maxdate":$room_type.data("maxdate")})
			.datetimepicker({
				collapse: true,
				pickTime: false,
				useCurrent: false
			})
			.on( ".bootstrap-datetimepicker-widget:visible", function( event ){
				$( ".bootstrap-datetimepicker-widget:visible" ).hide();
			}).on( "blur", function( event ) {
				$( ".bootstrap-datetimepicker-widget:visible" ).hide();
			})
			.on( "focus", function( event ) {
				$(this).datetimepicker().show();
			});
			
			$( $input.parent() ).find('span.input-group-addon').click(function(e) {
				$input.focus(); 
			});
			
		});
		dependency().reload(true);
	}
	
	function build_rooms_field( hotel_rooms, count ) {
		var options = "", 
			$elem=$("#hotel_room_type_id"),
			data_field_id=$elem.data("field_id")
			$hotel_checkout_date=$("#hotel_checkout_date"),
			checkout_data_field_id=$hotel_checkout_date.data("field_id")
			$hotel_checkin_date=$("#hotel_checkin_date"),
			checkin_data_field_id=$hotel_checkin_date.data("field_id");
			
		$("#hotel_room_type_id").parentsUntil(".row").show();
		if( count ) {
			$("#hotel_room_type_id_display").remove();
			if( count > 1) {
				var data_attrs = "";
				
				$.map( hotel_rooms.data, function( room, index ) {
					var _opt=room;
					_opt['data_attrs'] = " data-mindate=\"" + room.min_date + "\" ";
					_opt['data_attrs'] += " data-maxdate=\"" + room.max_date + "\" ";
					_opt['value'] = room.room_type_id;
					_opt['display'] = room.room_type;
					_opt['selected'] = "";
					_opt['index'] = index;
					if( selected_id == room.room_type_id ) {
						_opt['selected'] = "selected";
					}
					options += opt_template( _opt );
				});
				
				$hotel_room_type_id = $(select_template( {options:options, name:cfrequest.field_prefix + "[1].hotel.hotel_room_type_id", id:"hotel_room_type_id",data_field_id:data_field_id} ));
				
				$elem.after( $hotel_room_type_id );
				
				
				
				$hotel_room_type_id.val( cfrequest.reg_hotel_room_type_id ).trigger("liszt:updated").trigger("change");
				$elem.remove();
				
				if( Number(cfrequest.reg_hotel_room_type_id) == 0 ) {
					cfrequest.reg_hotel_room_type_id = $("#hotel_room_type_id option:first").val();
					$hotel_room_type_id.val( cfrequest.reg_hotel_room_type_id ).trigger("liszt:updated").trigger("change");
				}
				
			}else{
				var data_attrs = " data-mindate=\"" + hotel_rooms.data[0].min_date + "\" ";
				data_attrs += " data-maxdate=\"" + hotel_rooms.data[0].max_date + "\" ";
				$hotel_room_type_id = $(display_template({value:hotel_rooms.data[0].room_type_id,display:hotel_rooms.data[0].room_type,name:cfrequest.field_prefix + "[1].hotel.hotel_room_type_id", id:"hotel_room_type_id",data_field_id:data_field_id, data_attrs:data_attrs}));
				
				$elem.after( $hotel_room_type_id );
				$elem.remove();
				$("#hotel_room_type_id").parentsUntil(".row").hide();
			}
		}
		dependency().reload(true);
	}
	
	function build_hotel_field( hotels, count ) {
		var options = "",$elem=$("#hotel_id"), data_field_id=$elem.data("field_id");
		$("#hotel_id").parentsUntil(".row").show()
		if( count ) {
			if( count > 1) {
				$.map( hotels, function( hotel, index ) {
					var _opt=hotel;
					_opt['value'] = hotel.hotel_id;
					_opt['display'] = hotel.name;
					_opt['index'] = index;
					_opt['selected'] = "";
					if( selected_id == hotel.hotel_id ) {
						_opt['selected'] = "selected";
					}
					options += opt_template( _opt );
				});
				$hotel_id = $(select_template( {options:options, name:cfrequest.field_prefix + "[1].hotel.hotel_id", id:"hotel_id",data_field_id:data_field_id} ));
				
				$elem.after( $hotel_id );
				$hotel_id.on("change",function(){
					get_rooms($(this).find(':selected').data("index"));
				});
				$elem.remove();
				$hotel_id.val( cfrequest.reg_hotel_id ).trigger("liszt:updated").trigger("change");
			}else{	
				$hotel_id = $(display_template({display:hotels[0].name, value:hotels[0].hotel_id,name:cfrequest.field_prefix + "[1].hotel.hotel_id", id:"hotel_id",data_field_id:data_field_id}));
				
				$elem.after( $hotel_id );
				$elem.remove();
				$("#hotel_id").parentsUntil(".row").hide();
			}
		}
		dependency().reload(true);
	}
	

	
	function get_rooms( hotel_index ) {
		if( typeof hotel_index == "undefined" ) {
			hotel_index = 0;
		}
		var rooms = cfrequest.hotels.data[hotel_index].rooms;
		build_rooms_field( rooms, rooms.count);
	}
	
});