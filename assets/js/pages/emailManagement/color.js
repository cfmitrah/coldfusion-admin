/**
 *
 * @depends /plugins/datatables/jquery.dataTables.min.js
 * @depends /plugins/datatables/dataTables.bootstrap.js
 * @depends /plugins/cfjs/jquery.cfjs.js
 */
$(function(){
	$('.color-input').on('click', function(){
		$thisid = this.id;
	});
	$('.color-input').ColorPicker({
		onSubmit: function(hsb, hex, rgb, el) {
			$(el).val(hex);
			$(el).ColorPickerHide();
		},
		onBeforeShow: function () {
			$(this).ColorPickerSetColor(this.value);
		},
		onChange: function (hsb, hex, rgb) {
			$('#'+$thisid).val(hex);
		}

	})
	.bind('keyup', function(){
		$(this).ColorPickerSetColor(this.value);
	});
});