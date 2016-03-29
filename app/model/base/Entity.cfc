component displayname="Base Entity" accessors="true" extends="Object" {
	property name="IsPersisted" type="boolean" default="false" setter="true" getter="true" persistent='false';
	// @hint global constructor arguments.  All Extended entities should call super.init() so that this gets called
	

	public any function getEntityName() {
		var props = getMetaData(this);
		if( structKeyExists( props, "ENTITYNAME") and len( props.entityName ) ){
			return props.entityName;
		}
		return '';
	}

	public any function getPrimaryKey( any entityName, boolean rtnAllKeys=false ) {
		var sName 	= ( structKeyExists( arguments, "entityName" ) and len( arguments.entityName ) ? arguments.entityName : getEntityName() );
		//var aPKs 	= ormGetSessionFactory().getClassMetadata( sName ).getIdentifierColumnNames();
		var aPKs 	= [];
		if( arrayLen( aPKs ) gt 1 && structKeyExists( arguments, "rtnAllKeys" ) && arguments.rtnAllKeys )
		{
			return aPKs;
		}
		else if( arrayLen( aPKs ) )
		{
			return aPKs[1];
		}
		
		return '';
	}
	
	public array function getProperties() {
		if(!structKeyExists(variables, "metaProperties")) {
			var metaData = getMetaData(this);
			
			variables.metaProperties = metaData.properties;
			
			// Also add any extended data
			if(structKeyExists(metaData, "extends") && structKeyExists(metaData.extends, "properties")) {
				variables.metaProperties = arrayConcat(metaData.extends.properties, variables.metaProperties);
			}
		}
		return variables.metaProperties;
	}
	
	public struct function getORMProperties() {
		var propertyStruct 			= {};
		var hasExtendedComponent 	= true;
		var currentEntityMeta 		= getMetaData(this);
		
		do {
			if(structKeyExists(currentEntityMeta, "properties")) {
				for(var i=1; i<=arrayLen(currentEntityMeta.properties); i++) {
					if(!structKeyExists(propertyStruct, currentEntityMeta.properties[i].name)) {
						propertyStruct[currentEntityMeta.properties[i].name] = duplicate(currentEntityMeta.properties[i]);	
					}
				}
			}
			
			hasExtendedComponent = false;
			
			if(structKeyExists(currentEntityMeta, "extends")) {
				currentEntityMeta = currentEntityMeta.extends;
				if(structKeyExists(currentEntityMeta, "persistent") && currentEntityMeta.persistent) {
					hasExtendedComponent = true;	
				}
			}
		} while (hasExtendedComponent);
		
		return propertyStruct;
	}


	public any function getMemento( boolean includePK=true )
	{
		var propertyStruct 			= {};
		var currentEntityMeta 		= getMetaData(this);
		
		do {
			if(structKeyExists(currentEntityMeta, "properties")) 
			{
				for(var i=1; i<=arrayLen(currentEntityMeta.properties); i++)
				{
					if( !structKeyExists( propertyStruct, currentEntityMeta.properties[i].name ) && structKeyExists( currentEntityMeta.properties[i], 'ORMTYPE' ) ) 
					{
						if( includePK && currentEntityMeta.properties[i].name == getPrimaryKey() || ( currentEntityMeta.properties[i].name != getPrimaryKey() ) )
						{
							propertyStruct[currentEntityMeta.properties[i].name] = "";
							if( structKeyExists( variables, currentEntityMeta.properties[i].name ) )
							{
								propertyStruct[ currentEntityMeta.properties[i].name ] = variables[ currentEntityMeta.properties[i].name ];
							}
						}
					}
				}
			}

			hasExtendedComponent = false;
			
			if(structKeyExists(currentEntityMeta, "extends")) {
				currentEntityMeta = currentEntityMeta.extends;
				if(structKeyExists(currentEntityMeta, "persistent") && currentEntityMeta.persistent) {
					hasExtendedComponent = true;	
				}
			}
		} while (hasExtendedComponent);

		return propertyStruct;
	}

	public void function setValues( required struct props, boolean overRidePrimaryKey=false ) {
		var ormProps = getORMProperties();
		
		for( var prop in arguments.props ){
			if( getPrimaryKey() != prop || ( overRidePrimaryKey && getPrimaryKey() == prop ) ){
				variables[ prop ] = arguments.props[ prop ];
				if( structKeyExists( ormProps, prop ) && isStruct( ormProps[prop] ) 
					&& structKeyExists( ormProps[prop], 'ORMTYPE' ) && listfindnocase('float,double,big_decimal,long,integer,short,int',ormProps[prop].ORMTYPE)  
					&& !isnumeric( variables[ prop ] ) ){
					structDelete(variables, prop );
				}

				if( structKeyExists( ormProps, prop ) && isStruct( ormProps[prop] ) 
					&& structKeyExists( ormProps[prop], 'ORMTYPE' ) && listfindnocase('boolean,bit',ormProps[prop].ORMTYPE)  
					&& !isboolean( variables[ prop ] ) ){
					variables[ prop ] = 0;
				}
			}
		}
	}

}
