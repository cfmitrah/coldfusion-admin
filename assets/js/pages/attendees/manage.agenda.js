/**
 *
 * @depends /plugins/cfjs/jquery.cfjs.js
 */
 var agenda_ids = "";
$(function(){
	$(".agenda-conflicts",$("#manage-agenda-tab")).hide();
	$("td[data-included=\"1\"]").each(function(){
		agenda_ids = $.ListAppend( agenda_ids, $(this).data( "agenda_id" ) )
	});
	
	$("input[data-agenda_id]:checked").each(function(){
		agenda_ids = $.ListAppend( agenda_ids, $(this).data( "agenda_id" ) )
	});
	
	$("input[data-agenda_id]").on("click",function(){
		var $elem = $(this),
			conflict_result=false,
			checked=$elem.prop("checked"),
			agenda_id=$elem.data("agenda_id"),
			pos = $.ListFind( agenda_ids, agenda_id ),
			$conflict_msg = $(".agenda-conflicts",$elem.parent());
		if( !checked && pos ) {
			agenda_ids = $.ListDeleteAt( agenda_ids, pos );
		}
		$conflict_msg.hide();
		if( checked && agenda_ids ) {
			conflict_result = $.ajax({  
				url: cfrequest.agenda_conflict_check_url,
				data: {'agenda_ids':agenda_ids, 'agenda_id':agenda_id }
		    });
			    
			conflict_result.always(function( data ){
				conflict_result = data.has_conflict;
				if( checked && !conflict_result ) {
					agenda_ids = $.ListAppend( agenda_ids, agenda_id );
					
				}else{
					
					$elem.prop("checked",false);
					$conflict_msg.show();
				}
			});
		}

		
	});
});