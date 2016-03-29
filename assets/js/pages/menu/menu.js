/**
 *
 * @depends /plugins/nested-sortable/jqueryui.mjs.nested-sortable.js
 */

$( document ).ready( function(){
	var $menus = $( "#menus" ),
		$btn = $( ".btn-success" ),
		$cancelbtn = $( ".btn-cancel" ),
		$menu_id = $menus.find( "#menu_id" ),
		$label = $( "#label" ),
		$link = $( "#link" ),
		$linkchoice = $( "#linkchoice" ),
		$internalpagebase = $( "#internalpagebase" ),
		$target = $( "#target" ),
		$list = $menus.find( ".listsort" ),
		$overview = $menus.find( ".overview" );
		$link.prop( "disabled", true );

	// build sortable
    $list.nestedSortable( {
		handle: "div",
		items: "li",
		toleranceElement: "> div",
		opacity: .6,
		placeholder: "placeholder",
		maxLevels: 2
	} );
	// events
	$menus
		.on( "click", ".add", function( event ){ // handles adding of menus
			event.preventDefault();
			var $obj = $( this ),
				$menu = $obj.parent();
			$menus.data( "connected", null );
			$menu_id.val( "0" );
			$label.val( "" );
			$link.val( "" );
			$target.val( "_self" );
			$btn.text( "Create Menu" );
			$menus
				.find( ".alert" )
					.hide();
		} )
		.on( "click", ".edit", function( event ){ // handles editing of menus
			event.preventDefault();
			var $obj = $( this ),
				$menu = $obj.parent();
			$menus.data( "connected", $menu );
			$menu_id.val( $menu.data( "menu_id" ) );
			$label.val( $.trim( $menu.find( ".label" ).text() ) );
			if ($menu.data( "link" ) == '(no link)') {
				$linkchoice.val( "(no link)" );
				$link.prop( "disabled", true );
			}
			else if ($menu.data( "link" ).indexOf( "http://" ) > -1 || $menu.data( "link" ).indexOf( "https://" ) > -1) {
				$linkchoice.val( "external" );
				$link.prop( "disabled", false );
			}
			else {
				$linkchoice.val( $menu.data( "link" ) );
			}
			$link.val( $menu.data( "link" ) );
			$target.val( $menu.data( "target" ) );
			$btn.text( "Update Menu Item" );
			$menus
				.find( ".alert" )
					.hide();
		} )
		.on( "click", ".remove", function( event ){ // handles editing of menus
			event.preventDefault();
			var $obj = $( this ),
				$menu = $obj.parent(),
				menu_id = $menu.data( "menu_id" );
			$.ajax( {
				url: "/menu/remove",
				type: "POST",
				data: {
					'menu_id': menu_id
				},
				dataType: "json",
				beforeSend: function( xhr, settings ){
					$menu
						.parent()
							.fadeOut( "fast", function(){
								$menu
									.parent()
										.remove();
							});
					loading( $btn, true ); // change button to loading
					$menus
						.find( ".alert" )
							.remove();
				}
			} )
			.always( function( xhr, status ){
				loading( $btn, false );
			} );
		} )
		.on( "click", ".save-order", function( event ){ // serializing of list
			event.preventDefault();
			var $btn = $( this ),
				order = [],
				tree = [],
				cnt = 0;
			$list
				.children()
					.each( function( i, v ){ // each li top level categories
						var $obj = $( this ),
							$menu = $obj.children( "div" ),
							parent_id = $menu.data( "menu_id" );
						cnt = cnt + 1;
						order.push( $menu.data("menu_id") );
						tree.push( {
							menu_id: $menu.data( "menu_id" ),
							children: []
						} );
						$obj
							.find( "ol div" )
								.each( function( i2, v2 ){
									var $sub_menu = $( this );
										cnt = cnt + 1;
									order.push( $sub_menu.data( "menu_id" ) );
									tree[tree.length -1].children.push( $sub_menu.data( "menu_id" ) );
								} );
					} );
			$.ajax( {
				
				url: "/menu/sort",
				type: "POST",
				data: {
					"sort": order.join( "," ),
					"tree": JSON.stringify( tree )
				},
				dataType: "json",
				beforeSend: function( xhr, settings ){
					loading( $btn, true ); // change button to loading
					$overview
						.find( ".alert" )
							.hide();
				}
			} )
			.done( function( data, status, xhr ){
				var item = [];
				if( data.success ){
					$overview.append( "<p class=\"alert alert-success\"><i class=\"fa fa-check\"></i> " + data.message + " <button type=\"button\" class=\"close\" data-dismiss=\"alert\">x</button></p>" );
				}
				else{
					$overview.append( "<p class=\"alert alert-danger\"><i class=\"fa fa-times-circle\"></i> " + data.message + " <button type=\"button\" class=\"close\" data-dismiss=\"alert\">x</button></p>" );
				}
			} )
			.always( function( xhr, status ){
				loading( $btn, false );
			} );
		} );

	 $linkchoice
		.on( "change", function( event ){ // Handle change
			var $obj = $( this );
			var $opt= $( "#linkchoice option:selected" );
			if ($opt.val() === "external") {
				$link.val( "" );
				$link.prop( "disabled", false );
			}
			else if ( $opt.val() === "(no link)" ) {
				$link.val( "(no link)" );
				$link.prop( "disabled", true );
			}
			else {
				$link.val( $opt.val() );
				$link.prop( "disabled", true );
				$label.val($opt.prop( "innerHTML" ));
			}	
		});
	

	 $link
	 	.on( "blur", function( event ) {
	 		if ( $linkchoice.val() == "external" && ( $link.val().indexOf( "http://" ) === -1 && $link.val().indexOf( "https://" ) === -1 ) ) {
	 			$link.val( "http://" + $link.val());
	 		}
	 	});
	 	
	 $cancelbtn
		 .on( "click", function( event ) {
			 $btn.text( "Add Menu Item" );
			 $linkchoice.val( "(no link)" );
			 $link.prop( "disabled", true );
			 $menus
				.find( ".alert" )
					.show();
		 });
	 
	// form submissions
	$menus.on( "submit", function( event ){
		event.preventDefault();
		$link.prop( "disabled", false );
		var update = $menu_id.val() == "0" ? false : true;
		$.ajax( {
			url: "/menu/save",
			type: "POST",
			data: $menus.serialize(),
			dataType: "json",
			beforeSend: function( xhr, settings ){
				loading( $btn, true ); // change button to loading
				$menus
					.find( ".alert" )
						.hide();
			}
		} )
		.done( function( data, status, xhr ){
			var item = [];
			if( data.success ){
				$menus.prepend( "<p class=\"alert alert-success\"><i class=\"fa fa-check\"></i> " + data.message + " <button type=\"button\" class=\"close\" data-dismiss=\"alert\">x</button></p>" );
				$menus.trigger( "reset" ); // clear the form
				if( update ){ // update the values
					$menus
						.data( "connected" )
						.data( "link", data.link )
						.data( "label", data.label )
						.data( "target", data.label )
						.find( ".label" )
							.html( data.label );
				}
				else{ // append the new entry
					item.push( "<li>" );
					item.push( "	<div class=\"clearfix\" data-menu_id=\"" ); item.push( data.menu_id ); item.push( "\" data-label=\"" ); item.push( data.label ); item.push( "\" data-link=\"" ); item.push( data.link ); item.push( "\" data-target=\"" ); item.push( data.target ); item.push( "\">" );
					item.push( "		<span>" ); item.push( data.label ); item.push( "</span>" );
					item.push( "		<a class=\"remove pull-right\" href=\"##\"><i class=\"fa fa-trash-o\"></i></a>" );
					item.push( "		<a class=\"edit pull-right\" href=\"##\" ><i class=\"fa fa-edit\"></i></a>" );
					item.push( "	</div>" );
					item.push( "</li>" );
					$list.append( item.join( "" ) );
				}
				$btn.text( "Add Menu Item" );
			}
			else{
				$menus.prepend( "<p class=\"alert alert-danger\"><i class=\"fa fa-times-circle\"></i> " + data.message + " <button type=\"button\" class=\"close\" data-dismiss=\"alert\">x</button></p>" );
			}
		} )
		.always( function( xhr, status ){
			loading( $btn, false );
		} );
	} );
} );