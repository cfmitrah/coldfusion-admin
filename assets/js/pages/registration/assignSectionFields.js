/**
 *
 * @depends /jquery-1.11.0.min.js
 * @depends /plugins/UI/jquery-ui.js
 */
$(function(){
	var $sortable_standard_fields = $( "#form-field-bank,.reg-form-list" ),
		$sortable_hotel_fields = $( "#hotel-form-field-bank,.hotel-form-list" ),
        field_bank_id = "form-field-bank",
        hotel_field_bank_id = "hotel-form-field-bank", 
        $field_bank = $( "#form-field-bank" );

	$sortable_standard_fields.sortable({
	  connectWith: ".reg-form-list,.hotel-form-list",
	   forcePlaceholderSize: true,
            update: function( event, ui ) {
                var $item = ui.item;
                var $receiver = $item.parent();
                var item_id = $item.data( "field_id" );
                var section_id = $receiver.data( "section_id" );
                var receiver_id = $receiver.attr( "id" );
                if( ui.sender ) {
                    var $sender = ui.sender,
                        sender_id = $sender.attr( "id" );
                    if( $item.data("is_hotel_field") && receiver_id == field_bank_id) {
	                    console.log("yy")
	                    ui.sender.sortable("cancel");
	                    return;	                    
                    }
                    if( sender_id != field_bank_id ) {
                        removeField( $sender.data( "section_id" ), item_id );
                    }
                    if( receiver_id != field_bank_id ){
                        addField( section_id, item_id );
                    }
                }
                if( receiver_id != field_bank_id ){
                    updateSort( section_id, $receiver.sortable( "toArray" ).join(",") );
                }
            }
	}).disableSelection();
	
	$sortable_hotel_fields.sortable({
	  connectWith: ".hotel-form-list,#hotel-form-field-bank,#form-field-bank",
	   forcePlaceholderSize: true,
            update: function( event, ui ) {
                var $item = ui.item;
                var $receiver = $item.parent();
                var item_id = $item.data( "field_id" );
                var section_id = $receiver.data( "section_id" );
                var receiver_id = $receiver.attr( "id" );
                console.log(ui.sender,receiver_id,$item.data("is_hotel_field"))
                if( ui.sender ) {
                    var $sender = ui.sender,
                        sender_id = $sender.attr( "id" );
                        
                    if( $item.data("is_hotel_field") && receiver_id == field_bank_id) {
	                    console.log("yy")
	                    ui.sender.sortable("cancel");
	                    return;	                    
                    }
                    if( !$item.data("is_hotel_field") && receiver_id == hotel_field_bank_id ) {
	                    console.log("zz")
	                    ui.sender.sortable("cancel");
	                    return;
                    }
                    if( sender_id != field_bank_id ) {
                        removeField( $sender.data( "section_id" ), item_id );
                    }
                    if( receiver_id != hotel_field_bank_id ){
                        addField( section_id, item_id );
                    }
                }
                if( receiver_id != hotel_field_bank_id ){
                    updateSort( section_id, $receiver.sortable( "toArray" ).join(",") );
                }
            }
	}).disableSelection();
//Functions
	function addField( section_id, field_id ){
        var $header= $( "#header-section-" + section_id ), add_field_result;

        loading( $header, true );
        add_field_result = $.ajax({  
                url: cfrequest.field_save_url,
                method: "POST",
                data: { 'section_id': section_id, 'field_id': field_id }
            } );
        add_field_result.always(function( data ) { 
            loading( $header, false );
        });
    }
    function removeField( section_id, field_id ){
        var $header= $( "#header-section-" + section_id ), remove_field_result;

        loading( $header, true );
        remove_field_result = $.ajax({  
                url: cfrequest.field_remove_url,
                method: "POST",
                data: { 'section_id': section_id, 'field_id': field_id }
            } );
        remove_field_result.always(function( data ) { 
            loading( $header, false );
        });
    }
    function updateSort( section_id, ids ){
	    var $header= $( "#header-section-" + section_id );
        var section_sort_result = "";
        loading( $header, true );
        section_sort_result = $.ajax({  
            url: cfrequest.field_sort_update_url,
            data: { 
                'section_id': section_id,
                'field_ids': ids
            }
        } );
        section_sort_result.always( function( data ){
	        loading( $header, false );
	        
        });
    }
});