component extends="$base" accessors="true" securityroles="System Administrator"{
	property name="UserManager" setter="true" getter="true";
	property name="companyManager" setter="true" getter="true";

	public void function before( rc ) {
		rc.sidebar = 'sidebar.systemAdmin';
		if( !getSessionManageUserFacade().isSystemAdmin() ){
			redirect("company.default");
		}
		super.before( rc );
		return;
	}
	/**
	* Nothing
	*/
	public void function default( rc ) {

		return;
	}
	/**
	* I am the listing view for ll users
	*/
	public void function users( rc ) {
		var cfrequest = { 'users_url': buildURL("system.usersList") };
		cfrequest['user_list_columns'] =  [
			{ 'data': "user_id", 'sTitle': "ID" }
			,{ 'data': "username",'sTitle': "Username" }
			,{ 'data': "first_name", 'sTitle': "First Name" }
			,{ 'data': "last_name", 'sTitle': "Last Name" }
			,{ 'data': "active" ,'sTitle': "Active"	}
			,{ 'data': "options" ,'sTitle': "Options"	}
	    ];
		getCfStatic( )
			.includeData( cfrequest )
			.include("/js/pages/system/main.js");

		return;
	}
	/**
	*I return an ajax list of all users
	*/
	public void function usersList( rc ) {
		var params = {
			'order_index': ( structKeyExists( rc, 'order[0][column]') ? rc['order[0][column]']:0)
			,'order_dir': ( structKeyExists( rc, 'order[0][dir]') ? rc['order[0][dir]']:"asc")
			,'search_value': ( structKeyExists( rc, 'search[value]') ? rc['search[value]']:"")
		};
		structAppend( rc, { 'start': 0 ,'length':0 ,'draw':0 },false );
		params['start_row'] = rc.start;
		params['total_rows'] = rc.length;
		params['draw'] = rc.draw;

		getFW().renderData( 'json', getUserManager().UsersList( argumentCollection=params) );//
		request.layout = false;
		return;
	}
	/**
	* I edit an existing or new user
	*/
	public void function user( rc ) {
		var params = rc;
		var cfrequest = {
			'add_user_event_restriction_url': buildURL("system.addUserToEventStaff")
			,'remove_user_event_restriction_url': buildURL("system.removeUserFromEventStaff")
			,'user_event_restrictions_url': buildURL("system.userEvents")
			,'company_events_url': buildURL("company.eventsList")
			,'user_id': 0
		};
		structAppend( params, {'user_id':0}, false );
		rc['user'] = getUserManager().getUser( val( params.user_id ) );
		if( params.user_id ) {
			rc['companies'] = getCompanyManager().getCompanies();
			cfrequest['user_id'] = params.user_id;
		}
		getCfStatic( )
			.includeData( cfrequest )
			.include("/js/pages/system/user.js");
		return;
	}
	/**
	* I save a user
	*/
	public void function saveUser( rc ) {
		var params = {};
		if( structKeyExists( rc, "user" ) ) {
			params = rc.user;
			structAppend( params, {
				'user_id': 0
				,'username': ""
				,'first_name': ""
				,'last_name': ""
				,'active': false
				,'is_system_admin': false
				,'companies': ""
				,'password': ""
			}, false );
			rc['user_id'] = getUserManager().save( argumentCollection=params );
		}
		redirect( action="system.user", preserve="user_id");
		return;
	}
	/**
	* Saves a user's password
	*/
	public void function saveUserPassword( rc ) {
		var params = {};
		rc['tab'] = "password";
		structAppend( rc, {'user_id':0}, false);
		if( structKeyExists( rc, "user" ) ) {
			params = rc.user;
			structAppend( params, {'user_id':0,'password':""}, false);
			rc['user_id'] = params.user_id;
			getUserManager().savePassword( argumentCollection=params );
		}

		redirect( action="system.user", preserve="user_id,tab");
		return;
	}
	/*
	* Puts in a restriction for a User to an Event
	*/
	public void function addUserToEventStaff( rc ) {
		var params = rc;
		var status = false;
		structAppend( params, {'er_event_id':"", 'user_id':0}, false );
		if( len(params.er_event_id) && params.user_id ) {
			getUserManager().addUserToEventStaff( argumentCollection:params );
			status = true;
		}
		getFW().renderData( "json", {'success':status} );
		return;
	}
	/*
	* Remove a User from an Event Restriction
	*/
	public void function removeUserFromEventStaff( rc ) {
		var params = rc;
		var status = false;
		structAppend( params, {'er_event_id':"", 'user_id':0}, false );
		if( params.er_event_id && params.user_id ) {
			getUserManager().removeUserFromEventStaff( argumentCollection:params );
			status = true;
		}
		getFW().renderData( "json", {'success':status} );
		return;
	}
	/*
	* Gets all of the events a user has access to
	*/
	public void function userEvents( rc ) {
		structAppend( rc, {'user_id':0 }, false );

		getFW().renderData( "json", getUserManager().getUserEvents( argumentCollection:rc ) );

		return;
	}
}