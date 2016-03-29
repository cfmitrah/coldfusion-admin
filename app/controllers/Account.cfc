/**
*
* @file  /model/managers/Account.cfc
* @author - CL
* @description - This will handle all account related requests.
*
*/

component extends="$base" accessors="true"
{
	property name="manageUsersManager" setter="true" getter="true";

	//START PAGE VIEWS
	/**
	* Default
	* This method will render the event agenda list
	**/
	public void function default( rc ) {
		rc[ 'user' ] = getManageUsersManager().getUserInfo();
		return;
	}

	/**
	* Change password
	* This method will create an agenda item
	*/
	public void function changePassword( rc ) {
		if( ! getSessionManageUserFacade().isLoggedIn() ){
			redirect( 'login' );
		}
	}

	/**
	* doChangePassword
	* This method will change the password
	*/
	public void function doChangePassword( rc ) {
		password_change_status = getManageUsersManager().changePassword( rc.password );
		if ( password_change_status.success ){
			addSuccessAlert( password_change_status.message );
		}
		else {
			addWarningAlert( password_change_status.message );
		}
		redirect( "account.changePassword" );
		return;
	}
}
