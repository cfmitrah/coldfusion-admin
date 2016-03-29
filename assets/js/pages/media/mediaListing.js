/**
 *
 * @depends /plugins/cfjs/jquery.cfjs.js
 * @depends /plugins/zeroClipboard/ZeroClipboard.min.js
 */

( function( w ){
	 w.fnDataTableCallback = function(){		
		var clip = new ZeroClipboard( document.querySelectorAll( '.copy-media' ), {
			moviePath : '/plugins/zeroClipboard/ZeroClipboard.swf'
		});		
		clip.on( 'copy', function( event ){
			var $link = $( event.target );
			var path = cfrequest.media_url + $link.data( 'clipboardText' );
			event.clipboardData.setData('text/plain', path );
		});
		clip.on( 'aftercopy', function( event ) {
			alert('Copied text to clipboard: ' + event.data['text/plain']);
			
		});
	};
})( window );
 