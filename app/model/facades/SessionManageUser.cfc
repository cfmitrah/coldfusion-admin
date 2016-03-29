component output="false" accessors="true"
{
	variables.userBean 	= "";
	/**
	* I init this cfc
	*/
	public any function init() {
		if(!isDefined("session.mp.manage")) session.mp.manage 	= {};
		return this;
	}
	/**
	* I get a value from the user's session
	*/
	public any function getValue(required string property ) {
		var theValue = "";
		if(!hasSession()) return theValue;

		if( isDefined('get#arguments.property#') )
		{
			return evaluate('get#arguments.property#()');
		}
		else if( !structKeyExists( session.mp.manage, arguments.property )
				or structKeyExists( session.mp.manage, arguments.property )
				and isSimpleValue(session.mp.manage[ arguments.property ]) 
				and !len( session.mp.manage[ arguments.property ] ) )
		{
			var oBean = getUserBean();

			if(isobject(oBean))theValue=oBean.getValue(arguments.property);
			if( isSimpleValue( theValue ) )
			{
				session.mp.manage[ arguments.property ] = theValue;
			}
			return theValue;
		}
		else
		{
			return session.mp.manage[ arguments.property ];
		}
	}
	/**
	* I set a single value.
	*/
	public void function setValue( required string property, any propertyValue="") {
		session.mp.manage[arguments.property]=arguments.propertyValue;
	}
	/**
	* I setvalues from a struct
	*/
	public void function setValues( required struct props ) {
		for( var prop in arguments.props ){
			session.mp.manage[ prop ] = arguments.props[ prop ];
		}
	}
	/**
	* I get the userbean from the session
	*/
	public any function getUserBean() {
		var rtn = "";
		//This is where we will get the user bean
		if( hasSession() && structKeyExists( session.mp.manage, "userBean" )) {
			rtn = session.mp.manage.userBean;
		}
		return rtn;
	}
	/**
	* I check access base on role
	*/
	public boolean function IsAccessible( required string access ) {
		return listFindNoCase( getSecurityRoles(), access );
	}
	/**
	* I get the user's full name
	*/
	public string function getFullName() {
		return ( hasSession() ? trim("#getValue('firstname')# #getValue('lastname')#") : "");
	}
	/**
	* Multi line method description
	*
	*/
	public string function getSecurityRoles() {
		return ( hasSession() ? getUserBean().getRole() : 'public');
	}
	/**
	* I check to see if the logged in user is a system admin
	*/
	public boolean function isSystemAdmin() {
		return ( hasSession() AND listFindNoCase( getSecurityRoles(), "System Administrator" )  ? true : false);
	}
	/**
	* I check to see if the logged in user is an admin
	*/
	public boolean function isAdmin() {
		return ( hasSession() AND (listFindNoCase( getSecurityRoles(), "Administrator" ) or isSystemAdmin()) ? true : false);
	}
	/**
	* I check to see if the logged in user is a client admin
	*/
	public boolean function isClientAdmin() {
		return ( hasSession() AND (listFindNoCase( getSecurityRoles(), "Company Administrator" ) or isSystemAdmin() or isAdmin()) ? true : false);
	}
	/**
	* I check to see if the logged in user is a Account Manager
	*/
	public boolean function isAccountManager() {
		return ( hasSession() AND listFindNoCase( getSecurityRoles(), "Account Manager" ) ? true : false);
	}
	/**
	* I check to see if the logged in user is a Event Staff
	*/
	public boolean function isEventStaff() {
		return ( hasSession() AND listFindNoCase( getSecurityRoles(), "Event_Staff" ) ? true : false);
	}
	/**
	* I check to see if a user is logged in
	*/
	public boolean function isLoggedIn(){
		return ( hasSession() ? session.mp.manage.isLoggedIn:false);
	}
	/**
	* I check to see if a user has a session
	*/
	public boolean function hasSession() {
		return isDefined("session.mp.manage.isLoggedIn");
	}
	/**
	* I get the current company ID
	*/
	public numeric function getCurrentCompanyID() {
		return val( getValue( "current_company_id" ) );
	}
	/**
	* I set the current company ID
	*/
	public void function setCurrentCompanyID( required numeric current_company_id ) {
		var companies = listToArray(getValue("companies"));
		var company_cnt = arraylen(companies);
		var companies_details = getValue("companies_details");
		//Todo: Maybe add logic to make sure that a user does not set a company that they are not allowed to set...
		if( isSystemAdmin() ) {
			setValue( "current_company_id", arguments.current_company_id );
		}else {
			if( company_cnt ) {
				for (var i=1; i LTE company_cnt;i=i+1 ) {
					if( companies_details.company_id[i] == arguments.current_company_id ) {
						setValue( "current_company_id", arguments.current_company_id );
						setValue( "role", companies_details.role[i] );
						getUserBean().setRole( companies_details.role[i] );
						break;
					}
				}
			}
		}
		
	}
	/**
	* I return the session scope
	*/
	public any function getSession() {
		return session;
	}
	/**
	* I start the a user's session
	*/
	public void function startSession( struct defaults={} ) {
		// New Session
		session.mp.manage.lastLogin		= "";
		session.mp.manage.isLoggedIn	= false;
		session.mp.manage.userID		= "";
		refreshSession();
		structAppend( session.mp.manage, arguments.defaults, false );
	}
	/**
	* I validate the user's session with the defaults in the config file
	*/
	public void function validateSession( required struct defaults={} ) {
		if( !structKeyExists( session,"mp" ) || ( structKeyExists( session,"mp" ) && !structKeyExists( session.mp, "manage" )) ){
			session.mp.manage = {};
		}
		structAppend( session.mp.manage, arguments.defaults, false );
	}
	/**
	* I populate the session.
	*/
	public void function populateSession( required any userBean, required any clientID=0, required string clientIDs="" ) {
		//New Session
		session.mp.manage.lastLogin		= now();
		session.mp.manage.isLoggedIn	= true;
		session.mp.manage.userID		= userBean.getuserid();
		session.mp.manage.userBean		= userBean;
		session.mp.manage.role = userBean.getRole();
	}

	/**
	* I stop a user's session
	*/
	public void function stopSession() {
		if(isDefined("session.mp.manage") )structDelete( session.mp, "manage" );
	}
}
