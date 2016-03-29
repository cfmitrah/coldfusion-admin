$(function(){
	// Date - Time Picker Initialization ------------------------------------
	$('.std-datetime').datetimepicker();
	$('.timeonly-datetime').datetimepicker({
        pickDate: false
    });
    $('.dateonly-datetime').datetimepicker({
        pickTime: false
    });

    // Expand Reading on Detail Overview ----------------------------------
    $('#expand-reading').on('click', function(e){
    	e.preventDefault();
    	$('#overflow-wrap').toggleClass('expanded');
    	$(this).text(function(i, v){
           return v === 'Collapse Reading' ? 'Continue Reading' : 'Collapse Reading'
        })
    });

	// Form Step Validation -----------------------------------------------
	 $('.next').on('click', function () {
		var current = $(this).data('currentStep'),
		    next = $(this).data('nextStep');

		// When Clicking Continue, Scroll to Top of The Form
	
		$('html,body').animate({
		   scrollTop: $("#form-steps").offset().top
		});

		// only validate going forward. If current group is invalid, do not go further
		// .parsley().validate() returns validation result AND show errors
		if (next > current)
		  if (false === $('#registration-form').parsley().validate('step-' + current))
		    return;

		// validation was ok. We can go on next step.
		$('.step-' + current)
			.removeClass('show')
			.addClass('hidden');

		$('.step-' + next)
			.removeClass('hidden')
			.addClass('show');

		// for getting back to the step
		
		$('.step-nav-' + next)
			.addClass('visited');

		$('#form-navigation a').removeClass('active');
		$('.step-nav-' + next).addClass('active');

	}); 

	 // Jumping between form sections
	 $('#form-navigation a').on('click', function(e){
	 	e.preventDefault();

	 	// If we've already been to the page, we can get back to it
	 	if ( $(this).hasClass('visited') ) {
	 		//Which page we want to go to
	 		var goToStep = $(this).data('goToStep') ;

	 		$('#form-navigation a').removeClass('active');
			$('.step-nav-' + goToStep).addClass('active');

			$('.step')
				.removeClass('show')
				.addClass('hidden');

			$('.step-' + goToStep)
				.removeClass('hidden')
				.addClass('show');

	 	} else {
	 		alert('Complete the previous steps to continue');
	 		return false;
	 	}
	 });

});