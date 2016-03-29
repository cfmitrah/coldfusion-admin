/**
* I am the DAO for the Session Agenda object
* @file  /model/dao/SessionAgenda.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/**
	* I get an agenda fo a session 
	* @session_id the ID of a session that you want to get the agenda for
	*/
	public struct function SessionAgendaGet( required string session_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SessionAgendaGet"
		});
		sp.addParam( type="in", dbvarname="@session_id", cfsqltype="cf_sql_integer", value=arguments.session_id );
		sp.addProcResult( name="Agenda", resultset=1 );
		
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	

}
