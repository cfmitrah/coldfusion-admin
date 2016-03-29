/**
 *
 * @depends /plugins/cfjs/jquery.cfjs.js
 */
$(function(){
	var $thisid;
	$('.color-input').on('click', function(){
		$thisid = this.id;
	});


	// $('.color-input').ColorPicker({
	// 	onSubmit: function(hsb, hex, rgb, el) {
	// 		$(el).val(hex);
	// 		$(el).ColorPickerHide();
	// 	},
	// 	onBeforeShow: function () {
	// 		$(this).ColorPickerSetColor(this.value);
	// 	},
	// 	onChange: function (hsb, hex, rgb) {
	// 		$('#'+$thisid).val(hex);
	// 	}

	// })
	// .bind('keyup', function(){
	// 	$(this).ColorPickerSetColor(this.value);
	// });

	$('.color-input').ColorPicker({
		onBeforeShow: function () {
			$(this).ColorPickerSetColor($('#'+$thisid+'_input').val());
		},
		onShow: function (colpkr) {
			$(colpkr).fadeIn(500);
			return false;
		},
		onHide: function (colpkr) {
			$(colpkr).fadeOut(500);
			return false;
		},
		onChange: function (hsb, hex, rgb) {
			$('#'+$thisid).css('background', '#' + hex);
			console.log($('#'+$thisid+'_input'));
			$('#'+$thisid+'_input').val(hex);
		}
	});
	
	$("#theme-rolling").on("click", "a[data-theme]", function( event ){
		var $elem = $(this), theme_result
		event.preventDefault();
		theme_result = $.ajax({  
			url: cfrequest.theme_template_url,
			data: {'theme_tamplate':$elem.data("theme")}
		} );
		theme_result.always(function( data ){
			for( var key in data ) {
				$("#" + key ).val( $.LTrim(data[ key ]) );
			}
			$('#theme-tabs a[href="#edit-theme"]').tab('show')
		});
			
	});
	
	// $("#current_theme span.a").css( { background:"#" + cfrequest.theme_a } );
	// $("#current_theme span.b").css( { background:"#" + cfrequest.theme_b } );
	// $("#current_theme span.c").css( { background:"#" + cfrequest.theme_c } );
	// $("#current_theme span.d").css( { background:"#" + cfrequest.theme_d } );
	// $("#current_theme span.e").css( { background:"#" + cfrequest.theme_e } );


	// Themeing 
	var headerBg = $('#theme-header'),
		navigationBg = $('#theme-container #navigation'),
		navigationFont = $('#theme-container #navigation li a'),
		activeNavigationBgAndFont = $('#theme-container #navigation li a.active'),
		leadBannerBgAndFont = $('#theme-container #hero-text'),
		leadGraphicBg = $('#theme-container #hero-image'),
		bottomAreaBg = $('#theme-container #bottom-wrap'),
		locationIcon = $('#theme-container #event-details p span'),
		locationFont = $('#theme-container #event-details p'),
		formHeaderFont = $('#theme-container .step h3'),
		inactiveFormStepAndColor = $('#theme-container #form-navigation a'),
		formActiveStep = $('#theme-container #form-navigation a.active'),
		buttonBgAndFont = $('#theme-container .btn');

	$('#close-theme-preview').on('click', function(e){
		e.preventDefault();
		$('#preview-theme-overlay').fadeOut();
		$('body').css({'overflow-y':'auto'});
	});

	$('#preview-theme-btn').on('click', function(e){
		e.preventDefault();
		setColors();
		$('body').css({'overflow-y':'hidden'});
		$('#preview-theme-overlay').fadeIn();
	});

	function setColors(){
		headerBg.css({'background': '#'+$('#hdr_bkg_c_block_input').val() });
		navigationBg.css({'background': '#'+$('#nav_bkg_c_block_input').val() });
		navigationFont.css({'color': '#'+$('#nav_link_text_c_block_input').val() });
		activeNavigationBgAndFont.css({
			'background': '#'+$('#active_nav_link_bkg_c_block_input').val(),
			'color':'#'+$('#active_nav_link_txt_c_block_input').val()
		});
		leadBannerBgAndFont.css({
			'background': '#'+$('#btm_ban_c_block_input').val(),
			'color':'#'+$('#btm_ban_txt_c_block_input').val()
		});
		leadGraphicBg.css({'background': '#'+$('#bkg_behind_graphic_c_block_input').val() });
		bottomAreaBg.css({'background': '#'+$('#btm_area_bkg_c_block_input').val() });
		locationIcon.css({'color': '#'+$('#loc_time_icon_c_block_input').val() });
		locationFont.css({'color': '#'+$('#loc_time_font_c_block_input').val() });
		formHeaderFont.css({'color': '#'+$('#active_step_bkg_c_block_input').val() });
		inactiveFormStepAndColor.css({
			'background': '#'+$('#frm_step_bkg_c_block_input').val(),
			'color': '#'+$('#frm_step_font_c_block_input').val()
		});
		formActiveStep.css({
			'background': '#'+$('#active_step_bkg_c_block_input').val(),
			'color': '#'+$('#frm_step_font_c_block_input').val()
		});
		buttonBgAndFont.css({'background': '#'+$('#btn_bkg_c_block_input').val(), 'color':'#'+$('#btn_font_c_block_input').val() });
	}

	var activeLayout;
	$('#layout-nav-btns .btn').on('click',function(e){
		e.preventDefault();
		$('#layout-nav-btns .btn').removeClass('btn-primary');
		$(this).addClass('btn-primary');
		activeLayout = $(this).attr('rel');
		$('.layout-changer').attr("id",activeLayout);
	});

});
