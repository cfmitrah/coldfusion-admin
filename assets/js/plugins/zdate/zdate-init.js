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


	// Date - Time Picker Initialization ------------------------------------
	$('.std-datetime').datetimepicker();
	$('.timeonly-datetime').datetimepicker({
        pickDate: false
    });
    $('.dateonly-datetime').datetimepicker({
        pickTime: false
    });
	$('.full-datetime').datetimepicker({
		 pickDate: true
		 ,pickTime: true
	});
					         
                    	
	var stime = $("#start_time");
	var etime = $("#end_time");
	var day_id = $("#day_id");
	var date_warning = $("#date_warning");
	
	$("#end_time").on('change', function(){
		if (moment( stime.val() ).isAfter( etime.val() ) ){
			date_warning.html('The event start time must be before the end time, please correct before you can continue');
			date_warning.show();
		}
		else{
			date_warning.html('');
			date_warning.hide();
		}
	});
						
	$(".editDay").on("click", function(e){
		e.preventDefault();
		day_id.val($(this).data('dayid') );
		stime.val( $(this).data('starttime') );
		etime.val( $(this).data('endtime') );
		$("#event_save_btn").html("Update Existing Event Date/Time");
		$("#resetEditDay").show();
	});			
	
	$("#resetEditDay").on("click", function(e){
		e.preventDefault();
		day_id.val("");
		stime.val("");
		etime.val("");
		$("#event_save_btn").html("Add New Date");
		$("#resetEditDay").hide();
	});

});