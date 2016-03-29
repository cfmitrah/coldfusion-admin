
component accessors="true" extends="app.model.base.Manager"  {
	property name="Crypto" 		getter="true" setter="true";
	property name="userDao" 	getter="true" setter="true";
	property name="usersDao" 	getter="true" setter="true";
	property name="userManager" getter="true" setter="true";

	variables.EntityName = "mangeuser";
	public function init() {
		return this;
	}

	public void function authenticate( required string username, required string password ) {
		var oAuth = new app.model.entity.ManageUser();
		var Auth = getUserDAO().UserManageCredentialsGet( username=arguments.username, password=arguments.username );
		var hashed_password = "";
		var qAuth = Auth.result.auth;
		var user_details = {};

		if( qAuth.recordCount ){
	    	hashed_password = getCrypto().compute( arguments.password, qAuth.Salt );
	    	if( hashed_password == qAuth.password ){
	    		oAuth.setValues( queryRowToStruct( qAuth ) );
	    		oAuth.setIsPersisted( true );

	    		user_details = getUserDAO().userGet( oAuth.getUserID() );
	    		user_details.companies = getUserDAO().userCompaniesGet( oAuth.getUserID() ).result.companies;
	    		user_details.companies_props = querytoStruct(user_details.companies);
	    		user_details.companies = valueList( user_details.companies.company_id );
				getSessionManageUserFacade().setValue( 'companies_details', user_details.companies_props );
				getSessionManageUserFacade().setValue( 'addresses', user_details.result.addresses );
				getSessionManageUserFacade().setValue( 'emails', user_details.result.emails );
				getSessionManageUserFacade().setValue( 'phoneNumbers', user_details.result.phone_numbers );

				getSessionManageUserFacade().setValue( 'companies', user_details.companies );
				getSessionManageUserFacade().setValue( 'user_events', getuserManager().getUserEvents( oAuth.getUserID() ) );
				user_details.props = queryRowToStruct( user_details.result.properties );

				getSessionManageUserFacade().setValues( user_details.props );
	    		getSessionManageUserFacade().populateSession( oAuth );

	    	}
    	}

	    if( !oAuth.getIsPersisted() ){
	    	getAlertBox().addErrorAlert('Wrong Username and password combination.');
	    }
	}

	public any function getUserInfo() {
		return getSessionManageUserFacade().getUserBean();
	}

	public any function logout() {

		getSessionAdminUserFacade().stopSession( );
	}


	public any function isUsernameInUse( required string Username, required numeric userid ) {
		/* this will check to see if a username is in use */
		return false;
	}

	/**
	* I change the password
	*/
	public struct function changePassword( required struct password) {
	    // Declare local variables
	    var confirmation_password = "";// Holds the new password confirmation
	    var current_password = ""; // The current password
	    var current_password_hashed = ""; // Holds the hashed version of the current password
	    var error = false; // Flag indicating an error was encountere
	    var new_password = ""; // The new password
	    var new_salt = ""; // Holds the new salt
	    var new_password_hashed = ""; // Holds the hashed version of the new password
	    var status = {
	        'success': false,
	        'message': ""
	    }; // Holds the status return structure
	    var success = 0; // Holds success flag
	    var user = {};// Holds the user bean
	    // If a password structure was passed, pull the values
	    if ( structKeyExists( password, "current" ) ) {
	        current_password = password.current;
	    }
	    if ( structKeyExists( password, "new" ) ) {
	        new_password = password.new;
	    }
	    if ( structKeyExists( password, "confirmation" ) ) {
	        confirmation_password = password.confirmation;
	    }
	     // Get the user bean
	     user = getSessionManageUserFacade().getUserBean();
	     // Hash the current password
	     current_password_hashed = getCrypto().compute( current_password, user.getSalt() );
	     // If the current password does not match, do the following
	    if ( user.getPassword() != current_password_hashed ) {
	        // Set error message
	        status[ 'message' ] = "The current password you provided did not match our records.";
	        // Set error flag
	        error = true;
	    }
	     // If the new passwords do not match, do the following
	    if ( !error && new_password != confirmation_password ) {
	        // Set error message
	        status[ 'message' ] = "The new passwords did not match.";
	        // Return status
	        return status;
	    }
	     // If we have yet to have an error, do the following:
	     if ( !error ) {
	     	// Get a new salt
	        new_salt = getCrypto().salt();
	        // Hash the new password
	        new_password_hashed = getCrypto().compute( new_password, new_salt );
            // Call the function to set the password
	        userDAO.userPasswordSet( user_id=user.getUserId(), password=new_password_hashed, salt=new_salt );
	        // Reauthenticate with the new password
	        authenticate( user.getUserName(), new_password );
	        // Get a refreshed copy of the user bean
	        user = getSessionManageUserFacade().getUserBean();
	        // Verify that the password was changed
	        success = user.getPassword() eq new_password_hashed;
	        status[ 'success' ] = success ? true : false;
	        status[ 'message' ] = success ? "Your password was successfully updated." : "Error. Your password was not updated.";
	    }
	    // Return status
	     return status;
	 }



	public void function saveProfile( required struct data ) {
		/* This will save the logged in users profile */
	}

	public void function save( required struct data ) {
		/* this will save a manage user */
	}

	public void function ResetPassword( required string email ) {
		/* this will reset a users password */
	}

	public struct function getUserCompanies( required numeric user_id ) {
		var companies = {};
		var data = {};
        companies = getUserDAO().userCompaniesGet( arguments.user_id ).result.companies;
        data['companies'] = queryToArray(
			recordSet=companies,
		    map=function( row, index, columns, data ){
		    	return row;
	     	}
	     );
	    data['count'] = arrayLen( data.companies);
        return data;
	}


}

