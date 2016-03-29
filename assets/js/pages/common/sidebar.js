/**
 *
 * @depends /plugins/chosen/chosen.jquery.js
 */
$( document ).ready( function(){
	$("#quick-change-event")
		.chosen()
		.change(function(){
			window.location.href = "/event/details/event_id/" + $(this).val();
		});
	$("#quick-change-company")
		.chosen()
		.change(function(){
			window.location.href = "/company/doselect/company.select/" + $(this).val();
		});		
	$("#quick-change-company-details")
		.chosen()
		.change(function(){
			window.location.href = "/company/details/manage_company_id/" + $(this).val();
		});	
});