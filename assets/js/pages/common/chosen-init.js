/**
 * @depends /plugins/chosen/chosen.jquery.js
 */
$(function() {
	chosen_init();
});
function chosen_init() {
	$(".chosen-select,.chosen-multiple").chosen();
	$(".chosen-container-single").css({"width":"100%"});
	$(".chosen-container-single input").css({"width":"100%"}).addClass("form-control");
	$(".chosen-container-multi").css({"width":"100%"});
	$(".chosen-container-multi input").css({"width":"100%"}).addClass("form-control");
}