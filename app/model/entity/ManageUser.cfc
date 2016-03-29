
component displayname="Manage Users" persistent="true" accessors="true" extends="app.model.base.Entity" {

	property name="UserID" 			ormtype="int" 		column="user_id" fieldtype="id"  generator="identity";
	property name="firstname" 		ormtype="string" 	column="first_name";
	property name="lastname" 		ormtype="string" 	column="last_name";
	property name="password" 		ormtype="string";
	property name="salt" 			ormtype="string";
	property name="username"		ormtype="string";
	property name="active"			ormtype="boolean" default="1";
	property name="role"			ormtype="string" default="" setter="true";
	
	//PROPERTIES
	
	public any function getFullName() {
		
		return getFirstName() & ' ' & getLastName();
	}


	public void function setValues( required struct props ){
		
		super.setValues( arguments.props, true );
		
		if( structKeyExists( variables, "FIRST_NAME" ) ) setFirstName( variables.first_name );
		if( structKeyExists( variables, "LAST_NAME" ) ) setLastName( variables.last_name );
		if( structKeyExists( variables, "USER_ID" ) ) variables['userid'] = variables.user_id;
		
		return;
	}
	
	
}
