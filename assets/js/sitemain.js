$(function(){
	// Sidebar Layout---------------------------------------------------------
	//GET BROWSER WINDOW HEIGHT
	var currHeight = $(window).height();
	//SET HEIGHT OF SIDEBAR AND CONTENT ELEMENTS
	$('#sidebar, #main-content').css('height', currHeight);

	//ON RESIZE OF WINDOW
	$(window).resize(function() {
		//GET NEW HEIGHT
		var currHeight = $(window).height();	
		//RESIZE BOTH ELEMENTS TO NEW HEIGHT
		$('#sidebar, #main-content').css('height', currHeight);
	});

	// Data Tables Initialization -------------------------------------------
	$('.data-table').dataTable();

	//Show / Hide Form inputs based on selection ----------------------------
	$('.formShowHide_ctrl').formShowHide();

	// Date - Time Picker Initialization ------------------------------------
	$('.std-datetime').datetimepicker();
	$('.timeonly-datetime').datetimepicker({
        pickDate: false
    });
    $('.dateonly-datetime').datetimepicker({
        pickTime: false
    });
});