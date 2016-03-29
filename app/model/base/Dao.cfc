component output="false" extends="Object" accessors="true" {
	property name="SessionManageUserFacade"  setter="true" getter="true";

	public function init(){
		return this;
	}

	public struct function trim_fields( required struct input ){
		for(var key in arguments.input ){
			if( structKeyExists(arguments.input, key) && isSimpleValue( arguments.input[key] ) && !isNumeric( arguments.input[key] ) ) {
				arguments['input'][key] = trim( arguments.input[key] );
			}
		}
		return arguments.input;
	}

}