/**
*
* @file  /model/managers/Discounts.cfc
* @author - JG
* @description - This will control all things Discounts in reference to an Event.
*
*/

component extends="$base" accessors="true"
{
	property name="DiscountsManager" setter="true" getter="true";
	/**
	* before
	* This method will be executed before running any controller methods
	*/
	public void function before( rc ) {
		if( !getCurrentEventID() ){
			redirect('event.select');
		}
		rc['event_id'] = getCurrentEventID();
		rc['sidebar'] = "sidebar.event.details";
		super.before( rc );
		return;
	}
	//START PAGE VIEWS
	/**
	* Default 		
	* This method will render the discount list
	**/
	public void function default( rc ) {

		return;
	}
	//END PAGE VIEWS
		
}