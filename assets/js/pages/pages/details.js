/**
 *
 * @depends /plugins/cfjs/jquery.cfjs.js
 * @depends /plugins/moment/moment-date-timepicker.js
 * @depends /plugins/ckeditor/ckeditor.js
 * @depends /plugins/slugify/slugify.min.js
 * @depends /pages/common/assets_modal.js
 */
$(function(){
	$(window).on("load", function(){
		CKEDITOR.replace( "page-body-text" );
	});
	var $page = $( "#page" ),
		$tabs = $( ".nav-tabs" );
	// date / time pickers
	$("#publish_on, #expire_on").datetimepicker({});
	$("#btn_use_selected_assets").on("click",function(){
		var $selected = $("#asset-library-modal .asset-item.selected");
		$("#hero_graphic_id").val( $selected.data("id") );
		$('#asset-library-modal').modal("hide");
		$("#hero_graphic_change_to_label").html("Changing hero graphic to: " + $selected.data("file_name") )
	});
	$('#asset-library-modal').on('show.bs.modal', function(e){
		
		loading($("#asset-library-modal-label"), true);
		var result = $.ajax({  url: cfrequest.media_list_url } );
		result.always(function( data ){
			var lst = '<div class="asset-item" />';
			$('#media_library_modal').html('');
			$( data.data ).each(function( i, v ){
				var lst = $('<div class="asset-item" />').attr('data-id',v.media_id).attr('data-file_type',v.icon).attr("data-file_name",v.filename);
				lst.append('<img src="/assets/media/' + v.filename + '" alt="" class="thumb">')
					.append('<h4>' + v.filename + '</h4>')
					.append('<p><strong>File Type:</strong> ' + v.mimetype + '</p>')
					.append('<p><strong>Tags:</strong><span class="label label-primary">'+v.tags+'</span></p>')
					.append('<span class="glyphicon glyphicon-ok"></span>');
				$('#media_library_modal').append( lst );
			});
			loading($("#asset-library-modal-label"), false);
		});

	});
});