/**
* @file  /model/managers/Slug.cfc
* @author
* @description
*/
component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="slugDAO" getter="true" setter="true";
	/**
	* Takes a string a returns a URL / SEO Friendly Format
	*/
	public string function generate( required string input, string remove="", boolean dups=true, string separator="-" ){
		var slug = arguments.input;
		try{
			slug = urlDecode( slug );
		}
		catch(any e){
		}
		slug = slug
				.toLowerCase() // convert to lowercase
				.replaceAll( "ä|â|á|à|å|ã", "a" ) // Replace special "a" characters
				.replaceAll( "ß", "b" ) // Replace special "b" characters
				.replaceAll( "ç|¢", "c" ) // Replace special "c" characters
				.replaceAll( "é|è|ë", "e" ) // Replace special "e" characters
				.replaceAll( "ƒ", "f" ) // Replace special "f" characters
				.replaceAll( "í|ï|î|ì", "i" ) // Replace special "i" characters
				.replaceAll( "ñ", "n" ) // Replace special "n" characters
				.replaceAll( "ó|ö|ô|ø|õ|ð", "o" ) // Replace special "o" characters
				.replaceAll( "š", "s" ) // Replace special "s" characters
				.replaceAll( "ú|ü|µ|û", "u" ) // Replace special "u" characters
				.replaceAll( "×", "x" ) // Replace special "x" characters
				.replaceAll( "ÿ|ý", "y" ) // Replace special "y" characters
				.replaceAll( "²", "z" ) // Replace special "z" characters
				.replaceAll( "&[A-Za-z0-9]+;", "" ) // Remove HTML Entities
				.replaceAll( arguments.remove, "" ) // allows additional words / phrases to be removed in the slug
				.replaceAll( "&", "and" ) // Replace standalone ampersands with the word and
				.replaceAll( "–", "-" ) // Replace all – em dashes with a - dash
				.replaceAll( "\+", " " ) // Replace all +'s with a space
				.replaceAll( "[^A-Za-z0-9" & arguments.separator & " ]+", "" ) // Remove all Non-AlphaNumeric Characters except for Spaces and the separator
				.trim() // remove leading and trailing spaces
				.replaceAll( "\s+", arguments.separator ) // Replace 1 or more spaces with a single separator
				.replaceAll( "-+", arguments.separator ); // Replace 2 or more separator's with a single separator
		if( !arguments.dups ){
			slug = dedup( input=slug, separator=arguments.separator );
		}
		return slug;
	}
	/**
	* Removes Duplicates from a string
	*/
	private string function dedup( required string input, string separator="-" ) {
		var cleaned = [];
		var cnt = 0;
		arguments['input'] = listToArray( arguments.input, arguments.separator );
		cnt = arrayLen( arguments.input );
		for( var i = 1; i <= cnt; i++ ){ // loop over each part of the slug
			if( cleaned.indexOf( arguments.input[i] ) == -1 ){
				arrayAppend( cleaned, arguments.input[i] );
			}
		}
		return arrayToList( cleaned, arguments.separator );
	}
	/**
	* Generates and Saves a Slug returning the ID
	*/
	public struct function save( required string input ) {
		var info = {
			'slug': generate( arguments.input )
		};
		info['slug_id'] = getSlugDAO().slugSet( info.slug );
		return info;
	}
}