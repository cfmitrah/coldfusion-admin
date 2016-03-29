/**
*
* @file  /model/managers/SessionAgenda.cfc
* @author  
* @description
*
*/

component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="SessionAgendaDao" getter="true" setter="true";
	
	/**
	* I get an agenda of a session
	* @session_id the ID of the session that you want the agenda for
	*/
	public query function getAgenda( required numeric session_id ) {
		
		return getSessionAgendaDao().SessionAgendaGet( arguments.session_id ).result.Agenda;
	}
		
			

}