component output="false" displayname="" accessors="true" { 
	property name="AlertBox"        setter="true" getter="true" persistent='false';
    property name="utilities"       setter="true" getter="true" persistent='false';
    property name="dsn" 		    setter="true" getter="true" persistent='false';
    property name="beanfactory"     setter="true" getter="true" persistent='false';
	/* CFStatic is not available in entity objects */
    
	public function init() {
		
		return this;
	}

	public any function getCache() {
	        if( !structKeyExists( variables, "Cache" ) || ( structKeyExists( variables, "Cache" ) && !isobject( variables.cache ) ) ) {
	            variables.cache = new org.utilities.Cache();
	        }
	        return variables.cache;
	    }

	public any function getutilities() {
		if( !structKeyExists( variables, "utilities" ) ){
			variables.utilities = new org.utilities.utilities();
		}
		return variables.utilities;
	}
	
	public any function getAlertBox() {
		if( !structKeyExists( variables, "AlertBox" ) ){
			variables.AlertBox = new org.utilities.AlertBox();
		}
		return variables.AlertBox;
	}
	
	private void function addInfoAlert (required string message ) {
		getAlertBox().addInfoAlert(argumentCollection=arguments);
	}
	
	/**
	*	Facade to the kuubd AlertBox addErrorAlert() method
	*/
	private void function addErrorAlert (required string message ) {
		getAlertBox().addErrorAlert(argumentCollection=arguments);
	}
	
	/**
	*	Facade to the kuubd AlertBox addWarningAlert() method
	*/
	private void function addWarningAlert (required string message ) {
		getAlertBox().addWarningAlert(argumentCollection=arguments);
	}
	
	/**
	*	Facade to the kuubd AlertBox addSuccessAlert() method
	*/
	private void function addSuccessAlert (required string message ) {
		getAlertBox().addSuccessAlert(argumentCollection=arguments);
	}
	
	/**
	*	Facade to the kuubd AlertBox clear() method
	*/
	private void function clearAlert () {
		getAlertBox().clear();
	}
	
	/**
	@hint "I set a variable into the variables scope."
	*/
	public void function setValue( required string key, required any value ) {
		
		variables[ arguments.key ] = arguments.value;
	}

	public void function setValues( required struct props ) {
		for( var prop in arguments.props ){
			if( getPrimaryKey() != prop ){
				variables[ prop ] = arguments.props[ prop ];
			}
		}
	}

	/**
	@hint "I get a variable from the variables scope by a key."
	*/
	public any function getValue( required string key) {
		if( structKeyExists( variables, arguments.key ) ){
			return variables[arguments.key];
		}else{
			return '';
		}
	}


	public any function get() {//legacy
		return getValue( argumentCollection:arguments );
	}

	//" access="public" returntype="any" output="false" hint="I am called if ColdFusion can't find the requested method.">
	//hint="The name of the requested method." 
	//hint="The struct of arguments."
	function OnMissingMethod( required string MissingMethodName, required struct MissingMethodArguments   ) {
		//Define the local scope.
		var LOCAL = {};

		
		//Get the property method (get/set).
		LOCAL.PropertyMethod = Left( ARGUMENTS.MissingMethodName, 3 );
 
		//Get the property name.
		LOCAL.PropertyName = Right( ARGUMENTS.MissingMethodName, ( Len( ARGUMENTS.MissingMethodName ) - 3 ) );
 
		//Check to see what the method is.
		if (LOCAL.PropertyMethod EQ "Get"){
			//Return property.
			return THIS.getValue( LOCAL.PropertyName ); 
		}else if (LOCAL.PropertyMethod EQ "Set") 
 		{
			//Set property
			return THIS.setValue( LOCAL.PropertyName, ARGUMENTS.MissingMethodArguments[ 1 ] );
 
		}else{
			throw("Component.MissingMethod","Method does not exist","The method you are attempting to access, #UCase( ARGUMENTS.MissingMethodName )#, is not a valid method of this component.");
		}
	}

	public any function getMemento(){
		
		return variables;
	}
	
	private void function setabort(){
		writeDump(arguments); abort;
	}
	private void function die(){
		for( var i=1; i <= arrayLen( arguments ); i++ ){		
			writeoutput( '<br />' );
			writedump( arguments[i] );
			writeoutput( '<br /><br /><hr /><br /><br />' );
		}
		abort;
	}

	/**
	* Converts structure keys to all lowercase
	* @from The struct to be lowered
	*/
	public struct function lowerStruct( required struct from ) {
		var cnt = 0;
		var to = {};
		for( var key in arguments.from ){
			if( isStruct( arguments.from[key] ) ) {
				to[lCase(key)] = lowerStruct( arguments.from[key] );
			}
			else if( isArray( arguments.from[key] ) ) {
				cnt = arrayLen( arguments.from[key] );
				for( var i = 1; i <= cnt; i++ ) {
					if( isStruct( arguments.from[key][i] ) ){
						arguments['from'][i] = lowerStruct( arguments.from[key][i] );
					}
					else{
						arguments['from'][key][i];
					}
				}
				to[lCase( key )] = arguments['from'][key];
			}
			else{
				to[lCase( key )] = arguments['from'][key];
			}
		}
		return to;
	}
}