$(document).ready(function(){ 	

	// Slug Preview Field
	var $slug_output = $('#slug-output'),
		$extension_input = $('#extension-input'),
		$domain_select = $('#domain-name'),
		$domain_output = $('#domain-output');
	$slug_output.html( slugify( $extension_input.val() ) );
	$extension_input.on('keyup', function(){
		$slug_output.html( slugify( $extension_input.val() ) );
	});
	$domain_select.on( 'change', function( e ){
		var domain, $field;
		$field = $( this );
		if( $field.val() == 0 ) return;
		domain = $field.find( 'option:selected' ).text();
		$domain_output.html( domain );
		$extension_input.prop( 'disabled', false );
	});
});