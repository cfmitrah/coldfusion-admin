/**
* @file  /controllers/Company.cfc
*/

component extends="$base" accessors="true" securityroles="System Administrator"{
	property name="companyManager" setter="true" getter="true";
	property name="userManager" setter="true" getter="true";
	property name="ManageUsersManager" setter="true" getter="true";
	property name="geographyManager" setter="true" getter="true";
	property name="eventsManager" setter="true" getter="true";
	property name="config" setter="true" getter="true";
	/**
	* Before Action
	*/
	public void function before( rc ) {
		rc['sidebar'] = "sidebar.company";
		super.before( rc );
		return;
	}
	/**
	* Default Action
	*/
	public any function default( rc ) {
		var listing_config = {
		    'table_id': "company_listing",
		    'ajax_source': "company.getCompanies",
		    'columns': "Name,Options",
		    'aoColumns':[
		         {'data':"company_name"},
		         {'data':"options"}
		    ]
		};
		listing_config['ajax_source'] = buildURL( listing_config.ajax_source );
		rc['has_sidebar'] = false;
		rc['table_id'] = listing_config.table_id;
		rc['columns'] = listing_config.columns;
		getCfStatic().includeData( listing_config )
			.include( "/js/pages/common/listing.js" )
			.include( "/css/pages/common/listing.css" );
		return;
	}
	/**
	* Create
	* This method set the creates a new company
	**/
	public void function create( rc ) {
		redirect("company/details");
		return;
	}
	/**
	* Details
	* This method set the details for the event
	**/
	public void function details( rc ) {
        var company_config = {};
        structAppend( rc, {"manage_company_id":0}, false );
		getSessionManageUserFacade().setCurrentCompanyID( rc.manage_company_id );
        rc['company_details'] = getCompanyManager().getCompanyDefaultDetails();

		var users_action = "none";
		if ( structKeyExists( rc, "view_all_users" ) ) {
			users_action = "view_all_users";
		} else if ( structKeyExists( rc, "add_new_user" ) ) {
			users_action = "add_new_user";
		}

        var cfrequest = {
			'save_new_user_url': buildURL("company.ajaxSaveNewUser"),
			'save_existing_user_url': buildURL("company.ajaxSaveUser"),
			'user_events_url': buildURL("company.ajaxUserEvents"),
			'user_add_events': buildUrl("company.ajaxAddUserToEventStaff"),
			'user_remove_event': buildUrl("company.ajaxRemoveUserFromEventStaff"),
			'users_action': users_action
		};

        if ( rc.manage_company_id ){
            rc['company_details'] = getCompanyManager().getCompanyDetails( details=rc.company_details, company_id=rc.manage_company_id );

			var params = {};
			structAppend( params,{
					'company_id': rc.manage_company_id,
					'data_type': "array"
				},
				false
			);
			cfrequest['company_events'] = getEventsManager().getCompanyEventSelectList( argumentCollection=params );

			var company_users_params = getUserManager().getCompanyUsersParams( company_id=rc.manage_company_id );
			rc['missing_users'] = company_users_params.missing;
			rc['missing_users_cnt'] = arrayLen( rc.missing_users );

			company_config = {
                'ajax_remove_processor_url' = buildURL( "company.ajaxRemoveProcessor" ),
                'ajax_remove_excludedcreditcard_url' = buildURL( "company.ajaxRemoveExcludedCreditCard" ),
                'ajax_remove_accountmanager_url' = buildURL( "company.ajaxRemoveAccountManager" ),
                'ajax_remove_user_url' = buildURL( "company.ajaxRemoveUser" ),
				'ajax_remove_attendee_url' = buildURL( "company.ajaxGetEvents" )
            };
            getCfStatic()
                .includeData( company_config )
                .include("/js/plugins/parsley/parsley.js")
                .include("/js/pages/company/remove_accountmanager_modal.js")
                .include("/js/pages/company/remove_excludedcreditcard_modal.js")
                .include("/js/pages/company/remove_processor_modal.js")
                .include("/js/pages/company/user_events.js")
                .include("/js/pages/company/manage_users_modals.js")
				.include("/js/pages/company/see_attendee_modal.js");
        }

		var cfrequest = {
			'save_new_user_url': buildURL("company.ajaxSaveNewUser"),
			'save_existing_user_url': buildURL("company.ajaxSaveUser")
		};

        getCfStatic()
				.includeData (cfrequest)
                .include( "/css/pages/common/media.css" )
                .include( "/js/pages/common/media.js" );

        rc['sidebar_company_list'] = rc.company_details.sidebar_company_list;
        rc['has_sidebar'] = true;
        rc['sidebar'] = "sidebar.company.details";
        return;
    }
	/**
	* I save a Company
	*/
	public void function doSave( rc ) {
		// If a structure named "company" exists in the request collection, do the following:
		if( structKeyExists( rc, "company" ) && isStruct( rc.company ) ){
			if( !structKeyExists( rc.company, "company_id" ) ) {
				structAppend( rc.company, {'company_id':0}, false );
			}
			structAppend( rc, getCompanyManager().save( argumentCollection=rc.company ) );
			rc['manage_company_id'] = getCurrentCompanyID();
			if( val( rc.manage_company_id ) ){
				redirect( action="company.details", queryString="manage_company_id=" & rc.manage_company_id );
			}
		}
		redirect("company.default");
		return;
	}
	/**
	* doSaveEventDate
	* This method will process the saving of event dates
	*/
	public void function doSaveExcludedCard( rc ) {
		if( structKeyExists( rc, "company") && isStruct( rc.company ) && structKeyExists( rc, "payment") && isStruct( rc.payment )){
			getCompanyManager().setExcludedCreditCard( company_id:rc.company.company_id, credit_card_id:rc.payment.credit_card_id );
			addSuccessAlert( 'The credit card exclusion for this company has been set..' );
			redirect( action="company.details", queryString="manage_company_id=" & rc.company.company_id );
		}
		redirect("company.default");
		return;
	}
	/**
	* doSaveManager
	* This method will process the saving of account managers
	*/
	public void function doSaveManager( rc ) {
		if( structKeyExists( rc, "company") && isStruct( rc.company ) && structKeyExists( rc, "accountmanager") && isStruct( rc.accountmanager )){
			// Store the account manager
			getCompanyManager().setAccountManager( company_id:rc.company.company_id, user_id:rc.accountmanager.user_id );
			// Add a success alert
			addSuccessAlert( 'The user was set as an account manager.' );
			// Redirect user to the company's details page
			redirect( action="company.details", queryString="manage_company_id=" & rc.company.company_id );
		}
		redirect("company.default");
		return;
	}
	/**
	* doSaveUser
	* This method will process the saving of a new user and relate it to this company
	*/
	public void function ajaxSaveNewUser( rc ) {
		request.layout = false;

		var params = {};
		var	user = {};
		if( structKeyExists( rc, "user" ) ) {
			params = rc.user;
			structAppend( params, {
				'user_id': 0,
				'username': "",
				'first_name': "",
				'last_name': "",
				'active': false,
				'is_system_admin': false,
				'companies': rc.company_id,
				'password': ""
			}, false );

			rc['user_id'] = getUserManager().save( argumentCollection=params );
			if (rc.user_id > 0) {
				user = {
					'user_id': rc.user_id,
					'username': params.username,
					'displayname': params.last_name & ', ' & params.first_name
				};
			}
		}

		getFW().renderData( "json", {
			"success": true,
			"user": user,
			"company_id": rc.company_id
		} );
		return;

	}

	/**
	* ajaxSaveUser
	* This method will process the saving of users
	*/
	public void function ajaxSaveUser( rc ) {
		request.layout = false;

		var user = {};
		var success = false;
		if ( structKeyExists( rc, "user") && isStruct( rc.user )) {
			getCompanyManager().setUser( company_id:rc.company_id, user_id:rc.user.user_id );

			user = getUserManager().getUser( argumentCollection = {user_id:rc.user.user_id} );
			success = true;
		}

		getFW().renderData( "json", {
			"success": success,
			"user": user,
			"company_id": rc.company_id
		} );
		return;
	}

	/**
	* ajaxUserEvents
	* This method will get the events of a user for the current company
	*/
	public void function ajaxUserEvents( rc ) {
		request.layout = false;

		var events = {};
		var success = false;
		if ( structKeyExists( rc, "user") && isStruct( rc.user )) {
			events = getUserManager().getUserEventsByCompany( argumentCollection: {user_id: rc.user.user_id, company_id: rc.company_id} );
			success = true;
		}

		getFW().renderData( "json", {
			"success": success,
			"events": events,
			"company_id": rc.company_id
		} );
		return;
	}

	/**
	* doSaveUser
	* This method will process the saving of users
	*/
	public void function doSaveUser( rc ) {
		if( structKeyExists( rc, "company") && isStruct( rc.company ) && structKeyExists( rc, "user") && isStruct( rc.user )){
			getCompanyManager().setUser( company_id:rc.company.company_id, user_id:rc.user.user_id );
			addSuccessAlert( 'The user was associated to this company.' );
			redirect( action="company.details", queryString="manage_company_id=" & rc.company.company_id );
		}
		redirect("company.default");
		return;
	}
	/**
	* Manage Company Users
	*/
	public any function manageUser( rc ) {
		return;
	}
	/**
	* Add a Company User
	*/
	public any function addUser( rc ) {
		return;
	}
	/**
	* Remove a Company User
	*/
	public any function removeUser( rc ) {
		return;
	}
	/**
	* Companies Media Library
	* @securityroles *
	*/
	public any function media( rc ) {
		var listing_config = {};
		rc['company_id'] = getCurrentCompanyID();
		listing_config = {
			"table_id": "media_listing",
			"ajax_source": "media.listing?company_id=" & rc.company_id,
			"columns": "filename,label,filesize,tags,uploaded",
			"aoColumns": [
				{
					'data': "filename"
				},
				{
					'data': "label"
				},
				{
					'data': "filesize"
				},
				{
					'data': "tags"
				},
				{
					'data': "uploaded"
				},
				{
					'data': "options"
				}
			]
		};
		listing_config['ajax_source'] = buildURL( (structKeyExists(listing_config,'ajax_source') ? listing_config.ajax_source: '') );
		listing_config['media_url'] = getConfig().urls.wysiwyg_media;
		rc['table_id'] = listing_config.table_id;
		rc['columns'] = listing_config.columns;
		rc['has_sidebar'] = true;
		getCfStatic()
			.includeData( listing_config )
			.include( "/css/pages/common/listing.css" )
			.include( "/css/pages/common/media.css" )
			.include( "/js/pages/media/mediaListing.js" )
			.include( "/js/pages/common/listing.js" )
			.include( "/js/pages/common/media.js" );
		return;
	}
	/**
	* AjaxListing
	* - This method will return the ajax JSON for company list
	*/
	public void function getCompanies( rc ) {
		var params = {
			"order_index" : ( structKeyExists( rc, 'order[0][column]') ? rc['order[0][column]']:0)
			, "order_dir" : ( structKeyExists( rc, 'order[0][dir]') ? rc['order[0][dir]']:"ASC")
			, "search_value" : ( structKeyExists( rc, 'search[value]') ? rc['search[value]']:"")
			, "start_row" : ( structKeyExists( rc, 'start') ? rc.start:0)
			, "total_rows" : ( structKeyExists( rc, 'length') ? rc.length:0)
			, "draw" : ( structKeyExists( rc, 'draw') ? rc.draw:0)
			, "company_id" : getCurrentCompanyID()
		};
		getFW().renderData( "json", getCompanyManager().getListing( argumentCollection=params ) );
		request.layout = false;
		return;
	}
	/**
	* Select your Company
	* @securityroles *
	*/
	public any function select( rc ) {
		if( getSessionManageUserFacade().isSystemAdmin() ){
			rc.user_companies = getCompanyManager().getCompanies();
		}
		else{
			rc.user_companies = getManageUsersManager().getUserCompanies( getSessionManageUserFacade().getValue('UserID') );
			if( rc.user_companies.count == 1 ) {
				rc['company']['select'] = rc.user_companies.companies[1].company_id;
				redirect( action="company.doselect", preserve="company");
			}
		}
		getCfStatic()
			.include( "/js/pages/common/chosen-init.js" );
		return;
	}
	/**
	* Set the current company ID into the session
	* @securityroles *
	*/
	public any function doselect( rc ) {
		if( structKeyExists( rc, "company") && isNumeric( rc.company.select ) ){
			// Store that company id in the user's facade
			getSessionManageUserFacade().setCurrentCompanyID( rc.company.select  );
			// Redirect to the events page.
			redirect( "event");
		}
		else{
			redirect( "company.select");
		}
		return;
	}
	/**
	* AjaxRemoveProcessor
	* - This method will remove a payment processor from a company
	*/
	public void function ajaxRemoveProcessor( rc ) {
		request.layout = false;
		getCompanyManager().companyRemoveProcessor( rc.company_id, rc.processor_id );
		getFW().renderData( "json", {
			"success": true
		} );
		return;
	}
	/**
	* AjaxRemoveVenue
	* - This method will remove a company venue
	*/
	public void function ajaxRemoveVenue( rc ) {
		request.layout = false;
		getCompanyManager().companyRemoveVenue( rc.company_id, rc.venue_id );
		getFW().renderData( "json", {
			"success": true
		} );
		return;
	}
	/**
	* AjaxRemoveExcludedCreditCard
	* - This method will remove a company venue
	*/
	public void function AjaxRemoveExcludedCreditCard( rc ) {
		request.layout = false;
		getCompanyManager().companyRemoveExcludedCreditCard( rc.company_id, rc.credit_card_id );
		getFW().renderData( "json", {
			"success": true
		} );
		return;
	}
	/**
	* AjaxRemoveAccountManager
	* - This method will remove a company account manager
	*/
	public void function AjaxRemoveAccountManager( rc ) {
		request.layout = false;
		getCompanyManager().companyRemoveAccountManager( rc.company_id, rc.user_id );
		getFW().renderData( "json", {
			"success": true
		} );
		return;
	}
	/**
	* AjaxRemoveUser
	* - This method will remove a company account manager
	*/
	public void function AjaxRemoveUser( rc ) {
		request.layout = false;
		getCompanyManager().companyRemoveUser( rc.company_id, rc.user_id );
		getFW().renderData( "json", {
			"success": true
		} );
		return;
	}

	public void function ajaxGetEvents( rc ) {
		request.layout = false;
		getCompanyManager().companyRemoveUser( rc.company_id, rc.user_id );
		getFW().renderData( "json", getEventsManager().getCompanyEventSelectList( argumentCollection=params ) );
		return;
	}

	/*
	* Puts in a restriction for a User to an Event
	*/
	public void function ajaxAddUserToEventStaff( rc ) {
		request.layout = false;

		var params = rc;
		var status = false;
		var	user_events = {};

		structAppend( params, {
				'er_event_id':"",
				'user_id':0,
				'er_company_id': rc.company_id
			},
			false
		);
		if( len(params.er_event_id) && params.user_id ) {
			getUserManager().addUserToEventStaff( argumentCollection:params );
			status = true;

			user_events = getUserManager().getUserEventsByCompany( argumentCollection: {user_id: params.user_id, company_id: rc.company_id} );
		}
		getFW().renderData( "json", {'success':status, 'events':user_events} );
		return;
	}

	/*
	* Remove a User from an Event Restriction
	*/
	public void function ajaxRemoveUserFromEventStaff( rc ) {
		request.layout = false;

		var params = rc;
		var status = false;
		var user_events = {};

		structAppend( params, {'er_event_id':"", 'user_id':0}, false );
		if( params.er_event_id && params.user_id ) {
			getUserManager().removeUserFromEventStaff( argumentCollection:params );
			status = true;

			user_events = getUserManager().getUserEventsByCompany( argumentCollection: {user_id: params.user_id, company_id: rc.company_id} );
		}
		getFW().renderData( "json", {'success':status, 'events':user_events} );
		return;
	}

	public void function eventsList( rc ) {
		var params = rc;
		structAppend( params
			,{
			'company_id': getCurrentCompanyID()
			,'data_type': "array"}
			,false
		);
		getFW().renderData( "json", getEventsManager().getCompanyEventSelectList( argumentCollection=params ) );
		return;
	}

}
