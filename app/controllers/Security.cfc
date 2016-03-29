/**
*
* @Author Matt Graf
*
*/
component name="Security" extends="$base" output="false" accessors="true"{
	property name="ManageUsersManager" setter="true" getter="true";

	public void function before( rc ) {
		super.before( rc );
	}


	public any function accessCheck( rc ){

		if( !structKeyExists( application[getFWSettings().applicationKey].cache.controllers, getSection()))
		{
			return;
		}
		
		var _section 	= application[getFWSettings().applicationKey].cache.controllers[  getSection() ];
	    var stController	= GetMetaData( _section );
	    var stAction = {};
	    if( structKeyExists( _section, getItem() ) ){
			stAction = GetMetaData(_section[ getItem() ]);
	    }
	    var isAuthorised 	= false;
		var securityroles	= '';
		var isLoggedIn		= getSessionManageUserFacade().isLoggedIn();

	   	param name="request.context.message" 	default="";
	   	if( structKeyExists( stAction, "securityroles") && Len( stAction.securityroles )){
			securityroles = stAction.securityroles;
		}
		if( structKeyExists( stController, "securityroles") && Len( stController.securityroles )){
			securityroles = listAppend( securityroles, stController.securityroles );
		}
	
	   	//We only run role check for NON public pages
		if( refindNoCase( '^security', rc.action ) || listfindnocase(securityroles,"public") ){

			return;
		}
		
		if( !isLoggedIn) {
	        redirect( action:'security.login' );
	    }
	    if( !len(securityroles) ){
			securityroles = 'Public';
		}
		
		//Check the roles
		if( !listfindnocase(securityroles,"public") ) {
			securityroles = listToArray( securityroles );
		    for( var role in securityroles){
		    	if( ListFindNoCase( getSessionManageUserFacade().getSecurityRoles(), role) || role eq '*'){
		            isAuthorised = true;
		        	break;
		    	}
		    }
		    if( structKeyExists( stController, 'securityRolesJson' ) && isJSON( stController.securityRolesJson ) ){
				var stActionRoles = deserializeJSON( stController.securityRolesJson );
		    	if( !isAuthorised && structKeyExists( stActionRoles, getItem() ) ){
			        for( var role in listToArray( stActionRoles[ getItem() ] ) ){
				    	if( ListFindNoCase( getSessionAdminUserFacade().getSecurityRoles(), role) || role eq '*'){
				            isAuthorised = true;
				        	break;
				    	}
				    }
			    }
		    }
			//If not authorised throw them to the applications home page
		    if( !isAuthorised){
		        request.context['message'] = "You are not authorised to view that request.";
		        redirect( action:getFWSettings().home, preserve:'message' );
		    }
		}
	}

	public void function default( rc ) {
		redirect( action:'security.login' );
	}

	public void function login( rc ) {
		rc.has_topnav 	= false;
        rc.has_sidebar 	= false;
		getCfStatic().include('/css/pages/login/login.css');
		if( getSessionManageUserFacade().isLoggedIn() ){
			redirect('dashboard');
		}
	}

	public void function doLogin( rc ){
		getManageUsersManager().authenticate( argumentCollection:rc.login );
		redirect('dashboard');
	}

	public void function doLogout( rc ) {
		getSessionManageUserFacade().stopSession();
		redirect('dashboard');
	}

	public void function doResetPassword( rc ){ }



	/* Refresh user session */
	public void function refreshSession( rc ){ request.layout = false; }

	public void function after( rc ){

        super.after( rc );
	}


}


