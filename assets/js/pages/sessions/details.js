/**
 *
 * @depends /plugins/cfjs/jquery.cfjs.js
 * @depends /plugins/ckeditor/ckeditor.js
 * @depends /pages/common/media.js
 * @depends /pages/common/listing.js
 * @depends /pages/common/assets_modal.js
 * @depends /plugins/moment/moment.js
 * @depends /plugins/date-timepicker/date-timepicker.js
 * @depends /plugins/UI/jquery-ui.js
 */
var photo_datatable = "";
var file_datatable = "";
$(function(){

	CKEDITOR.replace( 'session_overview' );
	
	$session_speakers = $('#session_speakers');
	$speakers = $session_speakers.find( ".table:first" );
	
	$assign = $( "#assign-speaker" );
	$speaker_select = $assign.find( "select:first" );
	$assign
		.on("click", ".add", function( event ){
			event.preventDefault();
			var opt = $speaker_select[0].options[$speaker_select[0].selectedIndex];
			if( opt.value && +opt.value ){
				
				var company = $(opt).data('company');
				var title = $(opt).data('title');
				
				addSpeaker( opt.value, opt.text, company, title );
			}
		});
		
	function setupRemoveButtons () {
		$session_speakers.find('.remove').unbind();
		
		$session_speakers.find('.remove').bind('click', function (event) {
			event.preventDefault();
			
			var speaker_id = $(this).data('speaker_id');
			removeSpeaker(speaker_id);
		});
	}
	
	function repopulateSpeakersDropdown (speakers) {
		
		$speaker_select.find('option.speaker_option').detach();
		
		speakers.forEach (function (speaker) {
			$speaker_select.append('<option class="speaker_option" value="' + speaker.speaker_id + '" data-company="' + speaker.company + '" data-title="' + speaker.title + '">' + speaker.display_name + '</option>');
		});
	}
		
	// handles adding a speaker
	function addSpeaker( speaker_id, speaker_name, company, title ) {
		var row;
		
		var add_label = $assign.find('.add').html();
		$assign.find('.add').html($assign.find('.add').data('loading-text'));
		$assign.find('.add').addClass('disabled');
		
		// always add just in case
		$.ajax({
			url: "/speakers/addToSession",
			type: "POST",
			data: {
				'session_id': $session_speakers.data( "session_id" ),
				'speaker_id': speaker_id
			},
			dataType: "json",
			success: function (data) {
				$assign.find('.add').removeClass('disabled');
				$assign.find('.add').html(add_label);
				
				// check to see if it is already in the list
				if( !$session_speakers.find("tbody tr[data-speaker_id=" + speaker_id + "]").length ) {
					// build the row to add
					row = [];
					row.push( "<tr data-speaker_id=\"" ); row.push( speaker_id ); row.push( "\">" );
					row.push( "	<td>" ); row.push( company ); row.push( "</td>" );
					row.push( "	<td>" ); row.push( speaker_name ); row.push( "</td>" );
					row.push( "	<td>" ); row.push( title ); row.push( "</td>" );
					row.push( "	<td><a href='#' class='btn btn-sm btn-danger remove' data-speaker_id='" + speaker_id + "' data-loading-text='Removing...'><strong>Remove</strong> </a></td>" );
					row.push( "</tr>" );
					// add the row to the table
					$session_speakers
						.find( "tbody" )
							.append( row.join( "" ) );
							
					setupRemoveButtons();
					
					if (typeof data.speakers_params.missing != 'undefined') {
						repopulateSpeakersDropdown(data.speakers_params.missing);
					}
				}				
			}
		});
	}
	// handles removing a sesssion
	function removeSpeaker( speaker_id ) {
		var remove_btn = $session_speakers.find('table a.remove[data-speaker_id="' + speaker_id + '"]');
		
		var remove_label = remove_btn.html();
		remove_btn.html(remove_btn.data('loading-text'));
		remove_btn.addClass('disabled');
		
		$.ajax({
			url: "/speakers/removeFromSession",
			type: "POST",
			data: {
				'session_id': $session_speakers.data( "session_id" ),
				'speaker_id': speaker_id
			},
			success: function (data) {
				remove_btn.removeClass('disabled');
				remove_btn.html(remove_label);
				
				$session_speakers
						.find( 'tbody tr[data-speaker_id="' + speaker_id + '"]' )
							.detach();
							
				if (typeof data.speakers_params.missing != 'undefined') {
					repopulateSpeakersDropdown(data.speakers_params.missing);
				}
			},
			dataType: "json"
		});
	}
	
	setupRemoveButtons();
	
	// handles removing a sesssion
	function removePhoto( session_id ) {
		$.ajax({
			url: "/speakers/removePhoto",
			type: "POST",
			data: {
				'speaker_id': $speaker.data( "speaker_id" )
			},
			dataType: "json"
		});
	}

	if( cfrequest.photos_listing_config.ajax_source != undefined && cfrequest.photos_listing_config.aoColumns != undefined && cfrequest.photos_listing_config.table_id  != undefined){
		photo_datatable = setDataTables( cfrequest.photos_listing_config.ajax_source, cfrequest.photos_listing_config.aoColumns, cfrequest.photos_listing_config.table_id );
		//$('#photos_listing_wrapper .dataTables_filter').parentsUntil('#photos_listing_wrapper').remove();
		$('#photos_listing_wrapper').on('click','a[data-remove_media="true"]',function(){
			event.preventDefault();
			var result = $.ajax({  url: $(this).data('link') } );
			result.always(function(){
				photo_datatable._fnAjaxUpdate();

			});
		});
	}

	if( cfrequest.files_listing_config.ajax_source != undefined && cfrequest.files_listing_config.aoColumns != undefined && cfrequest.files_listing_config.table_id  != undefined){
		file_datatable = setDataTables( cfrequest.files_listing_config.ajax_source, cfrequest.files_listing_config.aoColumns, cfrequest.files_listing_config.table_id );
		//$('#files_listing_wrapper .dataTables_filter').parentsUntil('#files_listing_wrapper').remove();
		$('#files_listing_wrapper').on('click','a[data-remove_media="true"]',function(){
			event.preventDefault();
			var result = $.ajax({  url: $(this).data('link') } );
			result.always(function(){
				file_datatable._fnAjaxUpdate();
			});
		});
	}

	$('table.data-table').on('click','a[data-manage_media="true"]',function(){
		event.preventDefault();
		$('#asset-manage-modal').modal('show');
		var media_result = $.ajax({  url: cfrequest.mediaGetUrl,data:{'media_id':$(this).data('media_id')} } );
			media_result.always(function( data ){
				for (var key in data ) {
					var elm = $('#asset-manage-modal input[id="asset_' + key + '"]');
				   	if( elm.length  ){
				   		if( elm.attr('type') == 'checkbox' ){
				   			elm.prop( 'checked', data[ key ] );
				   		}else if( elm.attr('type') == 'password' ){
				   			elm.val( '' );
				   		}else{
				   			elm.val( data[ key ] );
				   		}
					}
				}
			});
	});

	$('#btn_save_media').on('click',function(){
		var media_save_result = $.ajax({
				url: cfrequest.mediaSaveUrl,
				data:{
					'media_id':$('#asset_media_id').val(),
					'media_asset.label':$('#asset_label').val(),
					'media_asset.publish':$('#asset_publish').val(),
					'media_asset.expire':$('#asset_expire').val(),
					'media_asset.password':$('#asset_password').val(),
					'media_asset.tags':$('#asset_tags').val(),
					'media_asset.downloadable':$('#asset_downloadable').prop('checked')
				}
			} );
			media_save_result.always(function(  ){
				file_datatable._fnAjaxUpdate();
				photo_datatable._fnAjaxUpdate();
				$('#asset-manage-modal').modal('hide');
			});
	});

	$('#asset-library-modal').on('show.bs.modal', function(e){

		var result = $.ajax({  url: cfrequest.mediaListUrl } );
		result.always(function( data ){
			var lst = '<div class="asset-item" />';
			//lst.append('<h4>' + + '</h4>')
			//$('#media_library_modal').html( lst );
			$('#media_library_modal').html('');
			$( data.data ).each(function( i, v ){
				var lst = $('<div class="asset-item" />').attr('data-id',v.media_id).attr('data-file_type',v.icon);
				lst.append('<img src="/assets/media/' + v.filename + '" alt="" class="thumb">')
					.append('<h4>' + v.filename + '</h4>')
					.append('<p><strong>File Type:</strong> ' + v.mimetype + '</p>')
					.append('<p><strong>Tags:</strong><span class="label label-primary">'+v.tags+'</span></p>')
					.append('<span class="glyphicon glyphicon-ok"></span>');
				$('#media_library_modal').append( lst );
			});

		});

	});

	$('#btn_use_selected_assets').on('click',function(){
		var _ids = '';
		var types = '';
		$('#media_library_modal div.asset-item.selected ').each(function(){
			_ids = $.ListAppend( _ids, $(this).data('id') );
			types = $.ListAppend( types, $(this).data('file_type') );
		});
		var media_library_result = $.ajax({  url: '/media/associateassets/', data:{'ids':_ids, 'types':types, 'session_id': $(this).data('session_id')} } );
			media_library_result.always(function(){
				file_datatable._fnAjaxUpdate();
				photo_datatable._fnAjaxUpdate();
			});
		$('#asset-library-modal').modal('hide');
	});

	$('.dateonly-datetime').datetimepicker({
        pickTime: false
    });

	$( "#category" ).autocomplete({
      source: cfrequest.categories
    });

});


