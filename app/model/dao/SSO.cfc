/**
* I am the DAO for the Event object
* @file  /model/dao/SSO.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {
	/*
	* Gets an SSO
	* @sso_id The SSO id
	*/
	public struct function SSOGet( required numeric sso_id ) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "SSOGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@sso_id", cfsqltype="cf_sql_integer", value=arguments.sso_id, variable="sso_id" );
		sp.addParam( type="out", dbvarname="@company_id", cfsqltype="cf_sql_integer", variable="company_id" );
		sp.addParam( type="out", dbvarname="@label", cfsqltype="cf_sql_varchar", variable="label" );
		sp.addParam( type="out", dbvarname="@config", cfsqltype="cf_sql_longvarchar", variable="config" );
		sp.addParam( type="out", dbvarname="@active", cfsqltype="cf_sql_bit", variable="active" );
		sp.addProcResult( name="logs", resultset=1 );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		structAppend( data, result.getProcResultSets() );
		return data;
	}
	/*
	* Adds a log entry for a SSO
	* @sso_id The id of the SSO
	* @user_id The id of the user
	* @action The type of action being logged, this is a friendly short name
	* @message (optional) The message to log if any
	* @ip (optional) The IP Address to log
	* @log_id (output) The generated log_id
	*/
	public numeric function SSOLogSet(
		required numeric sso_id,
		required numeric user_id,
		required string action,
		string message="",
		string ip=""
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "SSOLogSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@sso_id", cfsqltype="cf_sql_integer", value=arguments.sso_id );
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		sp.addParam( type="in", dbvarname="@action", cfsqltype="cf_sql_varchar", value=arguments.action, maxlength=50 );
		sp.addParam( type="in", dbvarname="@message", cfsqltype="cf_sql_varchar", value=arguments.message, maxlength=500, null=( !len( arguments.message ) ) );
		sp.addParam( type="in", dbvarname="@ip", cfsqltype="cf_sql_varchar", value=arguments.ip, maxlength=40, null=( !len( arguments.ip ) ) );
		sp.addParam( type="out", dbvarname="@log_id", cfsqltype="cf_sql_bigint", value=arguments.log_id, null=( !arguments.log_id ), variable="log_id" );
		result = sp.execute();
		return result.getProcOutVariables().log_id;
	}
	/*
	* Gets all of the logs for a given SSO
	* @sso_id The SSO id
	*/
	public struct function SSOLogsGet( required numeric sso_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "SSOLogsGet"
		});
		sp.addParam( type="in", dbvarname="@sso_id", cfsqltype="cf_sql_integer", value=arguments.sso_id );
		sp.addProcResult( name="logs", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().logs
		};
	}
	/*
	* Removes a SSO
	* @sso_id The id of the SSO
	*/
	public void function SSORemove( required numeric sso_id, required numeric company_id ) {
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "SSORemove"
		});
		sp.addParam( type="in", dbvarname="@sso_id", cfsqltype="cf_sql_integer", value=arguments.sso_id );
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.execute();
		return;
	}
	/*
	* Creates or Updates an SSO and Returns the SSO ID
	* @sso_id (optional) The id of the SSO if updating, 0 means add
	* @company_id The id of the company
	* @label A friendly label for the config
	* @config The configuration for the SSO (JSON String)
	* @active Whether or not the SSO is Active
	*/
	public numeric function SSOSet(
		required numeric sso_id=0,
		required numeric company_id,
		string label="",
		required string config,
		boolean active=1
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "SSOSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@sso_id", cfsqltype="cf_sql_integer", value=arguments.sso_id, null=( !arguments.sso_id ), variable="sso_id" );
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addParam( type="in", dbvarname="@label", cfsqltype="cf_sql_varchar", value=arguments.label, maxlength=150, null=( !len( arguments.label ) ) );
		sp.addParam( type="in", dbvarname="@config", cfsqltype="cf_sql_longvarchar", value=arguments.config );
		sp.addParam( type="in", dbvarname="@active", cfsqltype="cf_sql_bit", value=arguments.active, null=( !len( arguments.active ) ) );
		result = sp.execute();
		return result.getProcOutVariables().sso_id;
	}
	/*
	* Gets all of the SSOs for a Company
	* @company_id The company id
	*/
	public struct function SSOsGet( required numeric company_id, boolean active ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "SSOsGet"
		});
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		if( structKeyExists( arguments, "active") ){
			sp.addParam( type="in", dbvarname="@active", cfsqltype="cf_sql_bit", value=arguments.active );
		}
		else{
			sp.addParam( type="in", dbvarname="@active", cfsqltype="cf_sql_bit", value=0, null=true );
		}
		sp.addProcResult( name="ssos", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().ssos
		};
	}
}