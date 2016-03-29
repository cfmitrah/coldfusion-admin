/**
*
* @file  /model/managers/events.cfc
* @author
* @description
*
*/

component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="SSODao" getter="true" setter="true";
	/**
	* I save changes to an sso
	*/
	public any function save(){
		return getSSODao().SSOSet( argumentCollection=arguments );
	}
	/**
	* I save changes to an sso
	*/
	public any function remove( required numeric sso_id, required numeric company_id ){
		getSSODao().SSORemove( argumentCollection=arguments );
		return;
	}
	/**
	*  I get the company ssos
	*/
	public struct function getCompanySSOs( required numeric company_id, boolean active ) {
		return queryToStruct( recordset=getSSODao().SSOsGet( argumentCollection=arguments ).result );
	}
	/**
	* Get SSO Details
	*/
	public any function getSSO( required numeric sso_id ){
		return getSSODao().SSOGet( sso_id=arguments.sso_id );
	}
}