/**
 * @depends /plugins/ckeditor/ckeditor.js
 */
$(function(){
	var $tab_definitions_dates = $("#tab_definitions_dates"),
		$tab_definitions_categories = $("#tab_definitions_categories"),
		$layout_type_tabs = $("#layout_type_tabs"),
		$layout_type_list = $("#layout_type_list"),
		$group_by_date = $("#group_by_date"),
		$group_by_category = $("#group_by_category"),
		$tab_sort_categories = $("#tab_sort_categories");
		
	CKEDITOR.replace( 'agenda_help' );
	
	if( $group_by_category.prop("checked") == true ) {
		$tab_definitions_dates.hide();
		$tab_definitions_categories.show();
		//$tab_sort_categories.hide()
	}
	if( $group_by_date.prop("checked") == true ) {
		$tab_definitions_dates.show();
		$tab_definitions_categories.hide();
		//$tab_sort_categories.show()
	}
	
	$("input[name='agenda_settings.group_by']").on("click",function(){
		if( $group_by_date.prop("checked") == true ) {
			$tab_definitions_dates.show();
			$tab_definitions_categories.hide();
			//$tab_sort_categories.hide()
		}else {
			$tab_definitions_dates.hide();
			$tab_definitions_categories.show();
			//$tab_sort_categories.show()
		}
	});
		
		
});