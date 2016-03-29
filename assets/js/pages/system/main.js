/**
 *
 * @depends /pages/common/listing.js
 */
 
$(function(){

	$users_datatable = setDataTables( cfrequest.users_url, cfrequest.user_list_columns, "users", 50 );
	var users_datatable_oSettings = $users_datatable.fnSettings();
});
