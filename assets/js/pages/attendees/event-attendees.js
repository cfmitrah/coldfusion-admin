/**
 *
 * @depends /pages/common/listing.js
 */
  
$(function(){

	$("#attendee_listing_wrapper").on("click","a.btn-danger",function() {
		var confirm_result = confirm("Are you sure that you want to remove this attendee from this Event?");
		return confirm_result;
	});
	
});
