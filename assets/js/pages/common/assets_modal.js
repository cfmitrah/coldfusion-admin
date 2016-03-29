$(function(){
// asset library selected item state
	var single_asset_select = $("#media_library_modal").data("single_asset_select") || false;
	console.log( single_asset_select );
	$('#media_library_modal').on( "click", ".asset-item", function(){
		if( single_asset_select ) {
			$(".asset-item").removeClass( "selected" );
		}
		$(this).toggleClass("selected");

	});
	// asset search
	$("#quick-asset-search").keyup(function(){
 
        // Retrieve the input field text and reset the count to zero
        var filter = $(this).val(), count = 0;
 
        // Loop through the comment list
        $(".asset-item").each(function(){
 
            // If the list item does not contain the text phrase fade it out
            if ($(this).text().search(new RegExp(filter, "i")) < 0) {
                $(this).fadeOut();
 
            // Show the list item if the phrase matches and increase the count by 1
            } else {
                $(this).show();
                count++;
            }
        });
 
        // Update the count
        var numberItems = count;
        $("#filter-count").text("Number of Results = "+count);
    });
});