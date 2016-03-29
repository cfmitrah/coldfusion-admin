component output="false"{
	/*
	* Credit: http://kvz.io/blog/2009/06/10/create-short-ids-with-php-like-youtube-or-tinyurl/
	* Allows any number to be encoded to a custom string based on a defined dictionary of characters.
	* Mainly because ID's in URLs are boring.  http://site.com/yZ8fsBl is more fun than http://site.com/999999999999
	* Examples
	* -------------------------------------------------------------
	* Encoding:
	* basex.encode( value=999999999999, dict="DICTIONARY_16" ); // "E8D4A50FFF"
	* basex.encode( value=999999999999, dict="DICTIONARY_32" ); // "X4BBB4ZZ"
	* basex.encode( value=999999999999, dict="DICTIONARY_52" ); // "yZ8fsBl"
	* basex.encode( value=999999999999 ); // yZ8fsBl
	* basex.encode( value=999999999999, dict="DICTIONARY_62" ); // "HbXm5a3"
    *
	* Decoding:
	* basex.decode( value="E8D4A50FFF", dict="DICTIONARY_16" ); // 999999999999
	* basex.decode( value="X4BBB4ZZ", dict="DICTIONARY_32" ); // 999999999999
	* basex.decode( value="yZ8fsBl", dict="DICTIONARY_52" ); // 999999999999
	* basex.decode( value="yZ8fsBl" ); // 999999999999
	* basex.decode( value="HbXm5a3", "dict="DICTIONARY_62" ); // 999999999999
    *
	* Padding ( Ensures a minimum length of the encoded string, also useful to eliminate most acronyms ):
	* basex.encode( value=11, pad=4 ); // 1000C
	* basex.decode( value="1000C", pad=4 ); // 11
	* basex.encode( value=11 ); // C
	* basex.decode( value="C" ); // 11
	*/
	/**
	* BaseX init method
	*/
	public struct function init(  ) {
		// numbers and A-F only
		variables['DICTIONARY_16'] = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];
		// numbers and uppercase letters A-Z
		variables['DICTIONARY_32'] = ["1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","J","K","M","N","P","Q","R","S","T","U","V","W","X","Y","Z"];
		// numbers, uppercase and lowercase B-Z minus vowels
		variables['DICTIONARY_52'] = ["0","1","2","3","4","5","6","7","8","9","B","C","D","F","G","H","J","K","L","M","N","P","Q","R","S","T","V","W","X","Y","Z","b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","y","z"];
		// numbers, uppercase and lowercase A-Z
		variables['DICTIONARY_62'] = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
		// numbers, uppercase and lowercase A-Z and ~!@##$%^& ( minus 0,o,O,1,i,I,l,L useful to generate passwords )
		variables['DICTIONARY_PASS'] = ["2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","J","K","M","N","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","j","k","m","n","p","q","r","s","t","u","v","w","x","y","z","~","!","@","##","$","%","^","&"];
		// numbers, uppercase and lowercase A-Z and ~!@##$%^& ( useful to generate passwords )
		variables['DICTIONARY_70'] = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","~","!","@","##","$","%","^","&"];
		// numbers, uppercase and lowercase A-Z and +"@*#%&/|(  )=?'~[!]{}-_:.,;
		variables['DICTIONARY_89'] = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","+","""","@","*","##","%","&","/","|","( "," )","=","?","~","[","]","{","}","$","-","_",".",":",",",";","<",">"];
		return this;
	}
	/**
	* Takes a large number and converts it to a YouTube style string i.e. 1TCKi1kpgWX
	* @value The number to be encoded to a string
	* @dict (optional) The dictionary to use
	* @pad (optional) The padding ( minimum length of the generated string ) to use
	*/
	public string function encode( required numeric value, string dict="DICTIONARY_52", numeric pad=5 ) {
		var result = [];
		var dictionary = structKeyExists( variables, arguments.dict ) ? variables[arguments.dict] : variables['DICTIONARY_52'];
		var base = createObject( "java", "java.math.BigInteger" ).init( javaCast( "string", arrayLen( dictionary ) ) );
		var exponent = 1;
		var remaining = createObject( "java", "java.math.BigInteger" ).init( javaCast( "string", arguments.value ) );
		var a = createObject( "java", "java.math.BigInteger" ).ZERO;
		var b = createObject( "java", "java.math.BigInteger" ).ZERO;
		var c = createObject( "java", "java.math.BigInteger" ).ZERO;
		var d = createObject( "java", "java.math.BigInteger" ).ZERO;
		var bi = createObject( "java", "java.math.BigInteger" ).ZERO;
		// check if padding is bading used
		if( pad ) {
			remaining = remaining.add( base.pow( pad - 1 ) );
		}
		// generate the encoded string
		while( true ) {
			a = base.pow( exponent ); //16^1 = 16
			b = remaining.mod( a ); //119 % 16 = 7 | 112 % 256 = 112
			c = base.pow( exponent - 1 );
			d = b.divide( c );
			arrayAppend( result, dictionary[d.intValue(  ) + 1] );
			remaining = remaining.subtract( b ); //119 - 7 = 112 | 112 - 112 = 0
			if( remaining.equals( bi ) ) {
				break;
			}
			exponent++;
		}
		result = reverse( arrayToList( result, "" ) );
		return result;
	}
	/**
	* Decodes a YouTube style string ( i.e. 1TCKi1kpgWX ) to a number
	* @value The encoded string to be decoded
	* @dict (optional) The dictionary to use
	* @pad (optional) The padding ( minimum length of the generated string ) that was used when encoding the string
	*/
	public numeric function decode( required string value, string dict="DICTIONARY_52", numeric pad=5 ) {
		var chars = listToArray( reverse( arguments.value ), "" );
		var cnt = arrayLen( chars );
		var dictionary = structKeyExists( variables, arguments.dict ) ? variables[arguments.dict] : variables['DICTIONARY_52'];
		var base = createObject( "java", "java.math.BigInteger" ).init( javaCast( "string", arrayLen( dictionary ) ) );
		var result = createObject( "java", "java.math.BigInteger" ).ZERO;
		var map = createObject( "java", "java.util.HashMap" ).init(  );
		var exponent = 0;
		// create a map for efficiency
		for( var i = 1; i <= base; i++ ) {
			map.put( dictionary[i], createObject( "java", "java.math.BigInteger" ).init( javaCast( "string", i - 1 ) ) );
		}
		// generate the number
		for( var i = 1; i <= cnt; i++ ) {
			result = result.add( base.pow( exponent ).multiply( map.get( chars[i] ) ) );
			exponent++;
		}
		// check if padding is bading used
		if( pad ) {
			result = result.subtract( base.pow( pad - 1 ) );
		}
		return result.toString(  );
	}
	/**
	* Gets or Adds a new dictionary to use for encoding / decoding
	* @name The name of the dictionary to get / or create
	* @dict An array of characters to use as the dictionary
	*/
	public array function dict( required string name, array chars=[] ) {
		// check to see if we are adding a new dictionary
		if( arrayLen( chars ) ) {
			variables[arguments.name] = arguments.chars;
		}
		return structKeyExists( variables, arguments.name ) ? variables[arguments.name] : [];
	}
	/**
	* Generates a random string ( useful for passwords )
	* @dict (optional) The dictionary to use
	*/
	public string function random( numeric size=8, string dict="DICTIONARY_PASS" ) {
		// generate an encoded string with a number between 10000 - 999999999 that is at least 5 characters long
		var str = encode( randRange( 10000, 999999999 ), arguments.dict, arguments.size );
		str = listToArray( str, "" ); // convert the string to an array
		createObject( "java", "java.util.Collections" ).shuffle( str ); // shuffle it just because
		str = arrayToList( str, "" ); // convert the array back to a string
		return len( str ) > arguments.size ? left( str, arguments.size ) : str; // return the string and make sure it is the requested size
	}
	/**
	* Generates an encoding for a date converted to epoch
	* @date (optional) The dictionary to use
	*/
	public string function epoch( date the_date=now(), dict="DICTIONARY_62" ) {
		return encode( dateDiff( "s", "January 1 1970 00:00", dateConvert( "local2utc", arguments.the_date ) ), arguments.dict, 0 );
	}
}