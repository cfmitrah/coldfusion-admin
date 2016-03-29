/**
 *
 * @depends /plugins/datatables/jquery.dataTables.min.js
 * @depends /plugins/datatables/dataTables.bootstrap.js
 * @depends /plugins/cfjs/jquery.cfjs.js
 */
$(function(){
	$( '#invitation_id' ).on( 'change', function(){
		var $select = $( this );
		if( $select.val() ==  'none' ) return false;
		$( '#resubmit' ).submit();
	});
});
