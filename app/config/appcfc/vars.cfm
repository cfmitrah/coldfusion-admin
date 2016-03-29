<cfscript>
	//Application configuration
	this.name 					= hash( getCurrentTemplatePath() & 'MeetingPlay' );
	this.sessionManagement 		= true;
	this.loginstorage			= "session";	
	this.sessionmanagement		= true;
	
	if( listfindnocase( 'local,dev-qa', getEnvironment() ) ){
		this.applicationtimeout	= "#CreateTimeSpan(1,1,15,30)#";	
		this.sessiontimeout		= "#CreateTimeSpan(1,0,0,0)#";	
	}else{
		this.applicationtimeout	= "#CreateTimeSpan(4,0,15,30)#";
		this.sessiontimeout		= "#CreateTimeSpan(0,2,0,0)#";
	}

	include "#$.configPath#appCFC/mappings.cfm";
	

	// FW/1 - configuration:
	variables['framework'] 			= application.config.framework;
	variables['framework']['base'] 	= getDirectoryFromPath( CGI.SCRIPT_NAME ) & 'app/';

	
	//ORM configuration
	this['ormenabled'] 	= false;
	this['datasource'] 	= application.config.datasource;
	this['ormsettings'] = application.config.ormsettings;
	
</cfscript>