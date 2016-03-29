/**
 *
 * @depends /jquery-1.11.0.min.js
 * @depends /bootstrap.min.js
 * @depends /ie/html5shiv.min.js
 * @depends /ie/respond.min.js
 */
// helper function to add loading icon
function loading($btn, state){
	if(state){
		$btn
			.addClass("loading")
			.prepend("<i class=\"fa fa-spinner fa-spin\"></i> ");
	}
	else{
		$btn
			.removeClass("loading")
			.find("i.fa-spinner")
				.remove();
	}
}
//Created by JG/Aaron
//this will set active links in the sidebar
var path, url_regex;
path = window.location.pathname.toLowerCase();
url_regex = RegExp( path.replace( /\/$/, '' ) + "$" );
$( "#sidebar a" ).each( function( i, v ) {
    var $elem = $( this );
	if( url_regex.test( this.href.toLowerCase().replace( /\/$/, '' ) ) ){
    	$elem.addClass( 'active' );
    	return false;
	}
});
