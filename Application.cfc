/**
* Application.cfc Config extends FW1
*/
component extends="org.corfield.framework" {
	$ = {};
	$.configPath = "/app/config/";
	loadConfig();
	include $.configPath & "appCFC/vars.cfm";
	/**
	* Sets up the application
	*/
	public void function setUpApplication() {
		var xbf = "";
		var loc = {};
		loadConfig();
		include $.configPath & "appCFC/setUpApplication.cfm";
		return;
	}
	/**
	* Sets up a Request
	*/
	public void function setupRequest() {
		if( !structKeyExists( application, "config" ) ){
			loadConfig();
		}
		if( getEnvironment() == "live" && cgi.SERVER_PORT is 80 ) {
			var path = replace( cgi.query_string, "path_info=", "", "All" );
			location( url="https://" & cgi.server_name & path, addtoken="false" );
		}
		getBeanFactory().getBean("SessionManageUserFacade").validateSession( getBeanFactory().getBean("config").user );
		controller( "security.accessCheck" );
		return;
	}
	/**
	* Sets up a Error Request
	*/
	public void function onError( any exception, string event ){
		var ignore = "path_info=/favicon.ico";
		var env = getEnvironment();
		if( findNocase( ignore, cgi.query_string ) ) {
			return;
		}
		if( env == "live" ){
			//send out an error email
			var mailerService = new mail();
			var mail_body = "";
            mailerService.setTo( 'matt.g@meetingplay.com;carl.w@meetingplay.com' );
            mailerService.setBcc( 'joshua.g@excelaweb.com' );
            mailerService.setFrom( 'matt.g@meetingplay.com' );
            mailerService.setSubject( 'MP ERROR: ' & arguments.event );
            mailerService.setType("html");
            savecontent variable="mail_body"{
                WriteOutput("There was an error: " & exception.cause.message & "<br><br><HR /><br><br>" );
				writedump( var=arguments.exception, label="Exception Error Struct" );
                WriteOutput("<br><br>FORMS<br><hr /><br>" );
				writedump( var=form, label="FORM Vars" );
                WriteOutput("<br><br>URL<br><hr /><br>" );
				writedump( var=url, label="URL Vars" );
            }
			mailerService.send( body=mail_body );
			location( url='/applicationErrors/default/event/' & arguments.event & '/message/' & URLEncodedFormat( exception.cause.message ), addToken="no" );
		}else{
			super.onError( exception, event );
		}
	}

	/**
	* Gets the Current Environment
	*/
	public string function getEnvironment() {
		var env = "dev";
		var host = cgi.server_name;
		if( host == "manage.meetingplay.com" ) {
			env = "live";
		}
		else if( host.indexOf("local") != -1 ) {
			env = "local";
		}
		return env;
	}
	/**
	* Loads the config from json files
	*/
	public void function loadConfig() {
		var path = expandPath( "/app/config/" );
		var defaults = path & "default-config.json"; // ensures all the framework configuration settings are available
		var sidebar = path & "sidebar.json"; // ensures all the framework configuration settings are available
		var config = path & getEnvironment() & ".json"; // default config is the dev config just to be safe
		if(!fileExists( config ) || !fileExists( defaults ) || !fileExists( sidebar ) ){
			throw(type="mp.App", message="The configuration file config.json could not be found.");
		}
		else{
			application['config'] = deserializeJSON( fileRead( defaults ) );
			application['config']['sidebar'] = deserializeJSON( fileRead( sidebar ) );
			structAppend(application.config, deserializeJSON( fileRead( config ) ) );
			if( structKeyExists( application.config, "mappings" ) ) {
				if( structKeyExists( application.config.mappings, "cdn" ) ) {
					application['config']['paths']['cdn_image_upload_dir'] = expandpath( application.config.mappings.cdn & "images/" );
					application['config']['paths']['cdn_file_upload_dir'] = expandpath( application.config.mappings.cdn & "files/" );
					application['config']['paths']['cdn_temp_upload_dir'] = expandpath( application.config.mappings.cdn & "temp/" );

					if( !directoryExists( application.config.paths.cdn_file_upload_dir ) ) {
						DirectoryCreate( application.config.paths.cdn_file_upload_dir & "temp/" );
						DirectoryCreate( application.config.paths.cdn_file_upload_dir & "events/" );
					}
					if( !directoryExists( application.config.paths.cdn_image_upload_dir ) ) {
						DirectoryCreate( application.config.paths.cdn_image_upload_dir & "temp/" );
						DirectoryCreate( application.config.paths.cdn_image_upload_dir & "events/" );
					}
				}
			}
		}
		return;
	}
	/**
	* Gets the FW/1 Settings
	*/
	public struct function getFWSettings() {
		return variables.framework;
	}
	public void function die(){
        for( var i=1; i <= arrayLen( arguments ); i++ ){
            writeoutput( '<br />' );
            writedump( arguments[i] );
            writeoutput( '<br /><br /><hr /><br /><br />' );
        }
        abort;
    }
}