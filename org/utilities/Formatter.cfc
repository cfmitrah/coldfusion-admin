component output="false"{
	/**
	* Format init method
	*/
	public struct function init(){
		return this;
	}
	/**
	* Formats a phone number
	*/
	public string function formatPhone( required string input ) {
		var formatted = arguments.input.replaceAll("[^0-9]+", "");
		var length = len( formatted );
		switch( length ){
			case 7:
				formatted = left( formatted, 3 ) & "-" & right( formatted, 4 );
			break;
			case 10:
				formatted = "(" & left( formatted, 3 ) & ") " & mid( formatted, 4, 3 ) & "-" & right( formatted, 4 );
			break;
			case 11:
				formatted = "+" & left( formatted, 1) & " (" & mid( formatted, 2, 3 ) & ") " & mid( formatted, 5, 3 ) & "-" & right( formatted, 4 );
			break;
			case 12:
				formatted = "+" & left( formatted, 2) & " (" & mid( formatted, 3, 3 ) & ") " & mid( formatted, 6, 3 ) & "-" & right( formatted, 4 );
			break;
		}
		return formatted;
	}
}