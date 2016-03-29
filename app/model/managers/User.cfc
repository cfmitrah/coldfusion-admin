/**
*
* @file  /model/managers/user.cfc
* @author
* @description
*
*/

component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="CompanyDao" getter="true" setter="true";
	property name="CompanyUsersDao" getter="true" setter="true";
	property name="UserDao" getter="true" setter="true";
	property name="UsersDao" getter="true" setter="true";
	property name="SystemAdminDAO" getter="true" setter="true";
	property name="Crypto" getter="true" setter="true";
	property name="EventStaffDao" getter="true" setter="true";
	property name="EventDao" getter="true" setter="true";

	public boolean function usernameExists( required string username ){
		return getUserDao().usernameExists(arguments.username);
	}

	public any function create(){
		return getUserDao().userCreate(argumentCollection:arguments);
	}
	/**
	* Get Accountant Managers
	*/
	public struct function getAccountManagers( required numeric company_id, string return_type="array" ) {
		var recordset = getCompanyUsersDao().CompanyAccountManagersGet( argumentCollection = arguments ).result;
		var rtn = {
			'count': recordset.recordCount
		};
		if( arguments.return_type == "array" ) {
			rtn['data'] = queryToArray( recordset );
		}else {
			rtn['data'] = queryToStruct( recordset );
		}

		return rtn;
	}
	/**
	* Get All Users
	*/
	public any function getUsers(){
		var users = {};	// Holds the users list
		users = queryToStruct( recordset=getUsersDao().usersGet().result.result1 );
		return users;
	}
	/**
	* Get Company Users
	*/
	public struct function getCompanyUsers( required numeric company_id ) {
		var companyUsers = {};
		companyUsers = queryToStruct( recordset=getCompanyUsersDao().CompanyUsersGet( argumentCollection = arguments ).result );
		return companyUsers;
	}

	/**
	* Get a list of an event's speakers that are not related to the entered session.
	*/
	public struct function getCompanyUsersParams (
		required numeric company_id
	) {
		var all_users = getUsers( argumentCollection = {company_id: company_id} );
		var all = [];
		for (var idx = 1; idx lte arrayLen(all_users.displayname); idx = idx + 1) {
			all[idx] = {
				user_id: all_users.user_id[idx],
				username: all_users.username[idx],
				first_name: all_users.first_name[idx],
				last_name: all_users.last_name[idx],
				displayname: all_users.displayname[idx]
			};
		}

		var company_users = getCompanyUsers( argumentCollection = {company_id: company_id} );
		var related = [];
		for (var idx = 1; idx lte arrayLen(company_users.displayname); idx = idx + 1) {
			related[idx] = {
				user_id: company_users.user_id[idx],
				username: company_users.username[idx],
				first_name: company_users.first_name[idx],
				last_name: company_users.last_name[idx],
				displayname: company_users.displayname[idx]
			};
		}

		var missing = [];
		for (var idx = 1; idx lte arrayLen(all); idx = idx +1) {
			var user = all[idx];
			var in_company = false;
			for (var idx2 = 1; idx2 lte arrayLen(related); idx2 = idx2 +1) {
				var company_user = related[idx2];
				if (user.user_id == company_user.user_id) {
					in_company = true;
				}
			}

			if (!in_company) {
				missing[arrayLen(missing) + 1] = user;
			}
		}

		return {
			"available" : all,
			"related" : related,
			"missing" : missing
		};
	}

	/*
	* Gets all of the Users
	* @start The row to start on
	* @results The number of results to return
	* @sort_column The column to sort by - valid values ('label','subject','from_email_id','from_email')
	* @sort_direction The direction to sort
	* @search a Keyword to filter the results on
	*/
	public struct function UsersList(
		numeric order_index=0,
		string order_dir="asc",
		string search_value="",
		numeric start_row=0,
		numeric total_rows=10,
		numeric draw=1
	) {
		var columns = [ 'user_id','username','first_name','last_name','active' ];
		var users = "";
		var params = {
		 	'start': (arguments.start_row+1)
		 	,'results': arguments.total_rows
		 	,'sort_column': columns[ arguments.order_index + 1 ]
		 	,'sort_direction': arguments.order_dir
		 	,'search': arguments.search_value
		};

		users = getUsersDao().UsersList( argumentCollection:params ).result;
		return {
			'draw': arguments.draw,
			'recordsTotal': users.total,
			'recordsFiltered': users.total,
			'data': queryToArray(
				recordset=users,
				columns= listAppend( users.columnList, "options" ),
				map= function( row, index, columns ) {
					var options = "<a href=""/system/user/user_id/" & row.user_id & "/"" class=""btn btn-sm btn-primary"">Manage User</a>";
			    	row['options'] = options;
			        return row;
				return row;
			})
		};
	}
	/**
	* I get a user by their ID
	*/
	public struct function getUser( required numeric user_id ) {
		var user_details = getUserDao().userGet( arguments.user_id ).result;
		var user = {
			'companies': {'data':queryToArray(user_details.companies), 'count':user_details.companies.recordCount }
			,'emails': {'data':queryToArray(user_details.emails), 'count':user_details.emails.recordCount }
			,'phone_numbers': {'data':queryToArray(user_details.phone_numbers), 'count':user_details.phone_numbers.recordCount }
			,'addresses': {'data':queryToArray(user_details.addresses), 'count':user_details.addresses.recordCount }
		};
		var temp_user = queryToArray(user_details.details);
		if( arrayLen( temp_user ) ) {
			structAppend( user, temp_user[1] );
		}else {
			structAppend( user, {
				'active':0
				,'user_id':0
				,'first_name':""
				,'is_account_manager':0
				,'is_system_admin':0
				,'last_name':""
				,'username':""
			} );
		}
		user['label'] = user.first_name & " " & user.last_name;
		user['displayname'] = user.last_name & ", " & user.first_name;
		return user;
	}
	/**
	* I save a user
	*/
	public numeric function save(
		numeric user_id=0,
		required string username,
		required string first_name,
		required string last_name,
		boolean active=false,
		boolean is_system_admin=false,
		string companies="",
		string password="" ) {
		var params = arguments;
		var company_count = listLen( arguments.companies );
		var user_companies = "";
		var user_companies_id = "";
		var user_companies_ids = "";
		var usernameExists = getUserDao().usernameExists( username );
		//Save User details
		//writedump( arguments );abort;
		if( params.user_id ) {
			getUserDao().userDetailSet( argumentCollection=params );
			user_companies = getUserDao().UserCompaniesGet( params.user_id ).result.companies;
			user_companies_ids = valueList( user_companies.company_id );
		}else {
			if( !usernameExists ) {
				params['salt'] = getCrypto().salt();
				params['password'] = getCrypto().compute( arguments.password, params.Salt );
				params['user_id'] = getUserDao().userCreate( argumentCollection=params );
			}else{
				addErrorAlert("Sorry that username is already in use.");
				return 0;
			}
		}
		//Add companies to user
		if( company_count && params.user_id ) {
			for (var i=1; i LTE company_count; i=i+1 ) {
				getCompanyDao().companyUserAdd( listGetAt( arguments.companies, i ), params.user_id );
			}
		}
		//Remove any companies that don't belong
		if( len( user_companies_ids ) && isQuery( user_companies ) ) {
			for (var i=1; i LTE user_companies.recordCount; i=i+1 ) {
				user_companies_id = listGetAt( user_companies_ids, i );
				if( !listFindNoCase( arguments.companies, user_companies_id ) ) {
					getCompanyDao().CompanyUserRemove( user_companies_id, params.user_id );
				}
			}
		}
		//save system admin role
		if( arguments.is_system_admin ) {
			getSystemAdminDAO().SystemAdminAdd( params['user_id'] );
		}else {
			getSystemAdminDAO().systemAdminRemove( params['user_id'] );
		}

		addSuccessAlert("User has been saved.");
		return params.user_id;
	}
	/**
	* I save a users password
	*/
	public void function savePassword(
		required numeric user_id,
		required string password ) {
		var params = {
			'salt': getCrypto().salt()
			,'user_id': arguments.user_id
		};
		params['password'] = getCrypto().compute( arguments.password, params.Salt );
		getUserDao().userPasswordSet( argumentCollection:params );

		addSuccessAlert("Password has been updated");
		return;
	}
	/*
	* Puts in a restriction for a User to an Event
	* @event_id The id of the event
	* @user_id The id of the user
	*/
	public void function addUserToEventStaff(
		required string er_event_id,
		required numeric user_id
	) {
		var event_ids = listToArray( arguments.er_event_id );
		var event_id_count = arrayLen( event_ids );
		var params = arguments;
		params['event_id'] = arguments.er_event_id;
		if( event_id_count ) {
			for (var i=1; i LTE event_id_count; i=i+1 ) {
				params['event_id'] = event_ids[i];
				getEventStaffDao().EventStaffAdd( argumentCollection:params );
			}
		}
		return;
	}
	/*
	* Remove a User from an Event Restriction
	* @event_id The id of the event
	* @user_id The id of the user
	*/
	public void function removeUserFromEventStaff(
		required numeric er_event_id,
		required numeric user_id
	) {
		var params = arguments;
		params['event_id'] = arguments.er_event_id;
		getEventStaffDao().EventStaffRemove( argumentCollection:arguments );
		return;
	}
	/*
	* Gets all of the events a user has access to
	*/
	public struct function getUserEvents( required numeric user_id ) {
		var events = getEventStaffDao().EventStaffByUserGet( argumentCollection:arguments ).result;
		var rtn = {'count':events.recordCount, 'data':queryToArray(events), 'event_ids':valueList(events.event_id) };

		return rtn;
	}

	/*
	* Gets all of the events a user has access to for the given company
	*/
	public struct function getUserEventsByCompany( required numeric user_id, required numeric company_id ) {
		var user_events = getEventStaffDao().EventStaffByUserGet( argumentCollection:arguments ).result;
		user_events = {'count':user_events.recordCount, 'data':queryToArray(user_events), 'event_ids':valueList(user_events.event_id) };

		var events = [];
		for (var idx = 1; idx lte user_events.count; idx = idx + 1) {
			var current = user_events.data[idx];

			var company_event = getEventDao().getEvent(event_id:current.event_id,company_id:company_id);

			if (company_event.result.event_info.event_id != '') {
				events[arrayLen(events) + 1] = current;
			}
		}

		var rtn = {'count':arrayLen(events), 'data': events};

		return rtn;
	}
}