/**
 *
 * @depends /plugins/datatables/jquery.dataTables.min.js
 * @depends /plugins/datatables/dataTables.bootstrap.js
 * @depends /plugins/cfjs/jquery.cfjs.js
 * @depends /pages/common/listing.js
 * @depends /plugins/x-editable/bootstrap-editable.js
 * @depends /plugins/moment/moment-date-timepicker.js
 * @depends /plugins/parsley/parsley.js
 */
$(function(){
	$('.dateonly-datetime').datetimepicker({
	    pickTime: false
	}).on( 'blur', function( event ){
		$( '.bootstrap-datetimepicker-widget:visible' ).hide();
	});
	
	$( '.bootstrap-datetimepicker-widget' ).css( 'z-index', '99999' );

	var $attendee_type_form = $("#attendee_type_form"),
		$edit_attendee_modal = $("#EditAttendeTypeModal");
		
	$edit_attendee_modal.on('hidden.bs.modal', function () {
		$("#registration_type_id").val('');
    	$("#registration_type").val('');
    	$("#access_code").val('');
    	$("#sort").val("");
    	$attendee_type_form.parsley().reset();
	});

	$("#btn_save_attendee_type").on("click",function(){

		//todo: make attendee_type required
		
		if ($attendee_type_form.parsley().validate()) {
			$.ajax({
			    type: "POST",
			    url: cfrequest.save_registration_type_url,
			  	data: {
			  		'registration_type': $("#registration_type").val(), 
			  		'access_code':$("#access_code").val(),
			  		'active': $("#registration_active").val(),
			  		'registration_type_id': $("#registration_type_id").val(), 
			  		'sort':$("#sort").val(),
			  		'group_allowed':$("#group_allowed").val() 
			  	},
			  	cache: false,
			    dataType: "json",
			    success: function(data) {
				    //add error handling
				    $("#EditAttendeTypeModal").modal("hide");
				    dataTable.fnDraw();
			    },
			    error: function(err) {
				    if (err.status == 200) {
					    if (!window.console){
						console.log(err);
						}
				    }
				    else {
				    	if (!window.console){
				    		console.log('Error:' + err.responseText + '  Status: ' + err.status);
				    	}
				    }
			    }
			});
		}
	});
	
	$("#new_reg_pricing_save").on('click',function(){
		savePricing();
	});

	$('#event_listing').on('table_ready',function(){
		$("button[data-modifypricing='true']").on('click',function(){
			getPricing( $(this).data('typeid') );
			$('#registration_pricing_type_id').val( $(this).data('typeid') );
			$("#EditAttendeTypePricingModal").modal("show");
		});
		$("button[data-modifytype='true']").on('click',function(){
			getType( $(this).data('typeid') );
			$("#EditAttendeTypeModal").modal("show");
			$('#registration_type_id').val( $(this).data('typeid') );
			$('#registration_type').val( $(this).data('type') );
		});
	});

});


function getType( type_id ){
	$('#registration_type_id').val( 0 );
	$('#registration_type').val( '' );
	$.ajax({
	    type: "POST",
	    url: cfrequest.get_registration_type_url,
	  	data: {
	  		"registration_type_id": type_id
	  	},
	  	cache: false,
	    dataType: "json",
	    success: function( type_data ) {
	    	$("#registration_type_id").val( type_data.data[0].registration_type_id );
			$("#registration_type").val( type_data.data[0].registration_type );
			$("#registration_active").val( type_data.data[0].active );
			$("#access_code").val( type_data.data[0].access_code );
			$("#sort").val( type_data.data[0].sort );
			$("#group_allowed").val( type_data.data[0].group_allowed );
	    },
	    error: function(err) {
		    if (err.status == 200) {
			    if (!window.console){
		    		console.log(err);
		    	}
		    }
		    else {
		    	if (!window.console){
		    		console.log('Error:' + err.responseText + '  Status: ' + err.status);
		    	}
		    }
	    }
	});
}


function getPricing( type_id ){
	$('#type_pricing_table').html('');
	$.ajax({
	    type: "POST",
	    url: cfrequest.get_registration_type_pricing_url,
	  	data: {
	  		"registration_type_id": type_id
	  	},
	  	cache: false,
	    dataType: "json",
	    success: function( pricing_data ) {
	    
	    	$.each( pricing_data.data,function( i, item ){
	    	console.log( item )
	    		 var $tr = $('<tr>').append(
		            $('<td>').append(
		            	$('<a>').addClass('editable_field')
		            	.html( $.DateFormat( new Date(item.valid_from), 'mm/dd/yyyy') )
						.attr({'data-pricingid':item.registration_price_id,'data-fieldname':'valid_from'})
		            	),
		            $('<td>').append(
		            	$('<a>').addClass('editable_field')
		            	.html( $.DateFormat( new Date(item.valid_to), 'mm/dd/yyyy') )
						.attr({'data-pricingid':item.registration_price_id,'data-fieldname':'valid_to'})
		            	),
		            $('<td>').append(
		            	$('<a>').addClass('editable_field')
		            	.html( $.DollarFormat(item.price) )
						.attr({'data-pricingid':item.registration_price_id,'data-fieldname':'price'})
		            	),
		            $('<td>').html(item[4] ? "Yes" : "No"),
		            $('<td>').append(
		            	$('<button>')
		            	.attr({"data-pricingid":item.registration_price_id,"data-removepricing":"true"})
		            	.addClass('btn btn-xs btn-danger')
		            	.text('Remove')
		            	.on('click',function(){
							removePricing( $(this).data("pricingid") );
						})
		            )
		        );
	    		$('#type_pricing_table').append($tr);
	    	});
	    	$('.editable_field').editable({
	    		url: cfrequest.save_registration_type_pricing_url,
				type: 'text',
				ajaxOptions: {
				    dataType: 'json'
				},
				success: function(response, newValue) {
				    if(!response) {
				        return "Unknown error!";
				    }
				    if(response.success === false) {
				         return response.msg;
				    }
				},
				pk: 1,
				name: '',
				title: 'Update value',
		       params: function (params) {  //params already contain `name`, `value` and `pk`
				    var data = params;
				    data['name']=$(this).data('fieldname');
				    data['pk']=$(this).data('pricingid');
				    data['fieldupdate']=true;
				    data['registration_type_id'] = type_id;
				    data['registration_pricing_type_id']=$(this).data('pricingid');
				    return data;
				}
			})

	    },
	    error: function(err) {
		    if (err.status == 200) {
			    if (!window.console){
		    		console.log(err);
		    	}
		    }
		    else {
		    	if (!window.console){
		    		console.log('Error:' + err.responseText + '  Status: ' + err.status);
		    	}
		    }
	    }
	});
}

function savePricing( ){
	$.ajax({
	    type: "POST",
	    url: cfrequest.save_registration_type_pricing_url,
	  	data: {
	  		"registration_type_id": $("#registration_pricing_type_id").val(),
	  		"reg_pricing.valid_from": $("#new_reg_pricing_valid_from").val(),
			"reg_pricing.valid_to": $("#new_reg_pricing_valid_to").val(),
			"reg_pricing.price": $("#new_reg_pricing_price").val(),
			"reg_pricing.is_default": $("#new_reg_pricing_is_default").prop("checked")
			},
	  	cache: false,
	    dataType: "json",
	    success: function( pricing_data ) {
	  		$("#new_reg_pricing_valid_from").val('')
			$("#new_reg_pricing_valid_to").val('')
			$("#new_reg_pricing_price").val('')
			$("#new_reg_pricing_is_default").prop("checked",false)
			getPricing( $("#registration_pricing_type_id").val() );
	    },
	    error: function(err) {
		    if (err.status == 200) {
			    if (!window.console){
		    		console.log(err);
		    	}
		    }
		    else {
		    	if (!window.console){
		    		console.log('Error:' + err.responseText + '  Status: ' + err.status);
		    	}
		    }
	    }
	});
}
function removePricing( pricingid){
	$.ajax({
	    type: "POST",
	    url: cfrequest.remove_registration_type_pricing_url,
	  	data: {
	  		"registration_type_id": $("#registration_pricing_type_id").val(),
	  		"registration_price_id": pricingid
			},
	  	cache: false,
	    dataType: "json",
	    success: function( pricing_data ) {
			getPricing( $("#registration_pricing_type_id").val() );
	    },
	    error: function(err) {
		    if (err.status == 200) {
			    if (!window.console){
		    		console.log(err);
		    	}
		    }
		    else {
		    	if (!window.console){
		    		console.log('Error:' + err.responseText + '  Status: ' + err.status);
		    	}
		    }
	    }
	});
}
