/**
* @file  /model/managers/Company.cfc
*/

component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="companiesDao" getter="true" setter="true";
	property name="companyDao" getter="true" setter="true";
	property name="companyUsersDao" getter="true" setter="true";
	property name="eventDao" getter="true" setter="true";
	property name="hotelDao" getter="true" setter="true";
	property name="paymentsDao" getter="true" setter="true";
	property name="companyPaymentDao" getter="true" setter="true";
	property name="usersDao" getter="true" setter="true";
	property name="geographyManager" setter="true" getter="true";
	property name="eventsManager" setter="true" getter="true";
	property name="AttendeeManager" setter="true" getter="true";
	property name="userManager" setter="true" getter="true";
	property name="FormUtilities" setter="true" getter="true";
	/**
	* Gets all of the companies and creates selectbox options
	*/
	public string function getCompanySelectOptions( numeric selected_company_id=0 ) {
		var companies = queryToStruct( getCompaniesDao().companiesGet().result.companies );
		var opts = getFormUtilities().buildOptionList( companies.company_id, companies.company_name, arguments.selected_company_id );
		return opts;
	}
	/**
	* I get all companies
	*
	*/
	public struct function getCompanies() {
		var companies = {};
		var data = {};
        companies = getCompaniesDao().companiesGet().result.companies;
        data['companies'] = queryToArray(
			recordSet=companies,
		    map=function( row, index, columns, data ){
		    	return row;
	     	}
	     );
	    data['count'] = arrayLen( data.companies);
        return data;
    }

	/**
	* I get a list of all companies
	*
	*/
	public struct function getCompanyList() {
		var companies = {};
		var data = {};
        companies = getCompaniesDao().companiesGet().result.companies;
        var data = queryToStruct( recordset=companies);
	    return data;
    }

   /**
	* I get default company details
	*
	*/
	public struct function getCompanyDefaultDetails(){
		var accountManagers = {
				'count':0,
				'managers': []
			};
		var amusers = {};
		var companyusers = {
				'count':0,
				'companyusers': []
			};
		var details = {};
		var domains = {};
		var hotels = {
				'count':0,
				'hotels': []
			};
		var payments = {
				'processorscount':0,
				'processors': [],
				'creditcardsexcludedcount': 0,
				'creditcardsexcluded': []
			};
		var venues = {
				'count':0,
				'venues': []
			};
		var creditcard_list = getCreditCardsList();
		var processor_list = getPaymentProcessorsList();
		var user_list = getUserManager().getUsers();
		// Get the Excelaweb users for the account managers list
		amusers['users'] = getUserManager().getCompanyUsers( company_id=2 );
		amusers['count'] = arrayLen( amusers.users.user_id );
		companies = getCompanyList();
		details['accountmanagers'] = accountmanagers;
		details['amusers'] = amusers;
		details['company'] = getCompany( company_id=0 );
		details['company_id'] = 0;
		details['companyusers'] = companyusers;
		details['countries'] = getGeographyManager().getCountries( has_regions=1 );
		details['creditcard_list'] = creditcard_list;
		details['domains'] = domains;
		details['hotels'] = hotels;
		details['payments'] = payments;
		details['regions'] = getGeographyManager().getRegions( country_code="US" );
		details['venues'] = venues;
		details['sidebar_company_list'] = getFormUtilities().buildOptionList(
			values = companies.company_id,
			display = companies.company_name,
			selected = 0
		);
		details['companyusers_options'] = "";
		details['amusers_options'] = getFormUtilities().buildOptionList(
			values = details.amusers.users.user_id,
			display = details.amusers.users.displayname,
			selected = 0
		);
		details['countries']['opts'] = getFormUtilities().buildOptionList(
			values=details.countries.country_code,
			display=details.countries.country_name,
			selected="US"
		);
		details['creditcard_options'] = getFormUtilities().buildOptionList(
			values = creditcard_list.credit_card_id,
			display = creditcard_list.vendor,
			selected = 0
		);
		details['domain_opts'] = "";
		details['regions']['opts'] = getFormUtilities().buildOptionList(
			values=details.regions.region_code,
			display=details.regions.region_name,
			selected=0
		);
		details['payment_processors'] = getFormUtilities().buildOptionList(
			values = processor_list.processor_id,
			display = processor_list.processor_name,
			selected = 0
		);
		details['users_options'] = getFormUtilities().buildOptionList(
			values = user_list.user_id,
			display = user_list.displayname,
			selected = 0
		);
		return details;
	}

/**
	* I get actual company details
	*
	*/
	public struct function getCompanyDetails(required struct details, required numeric company_id){
		var accountManagers = {};
		var companyusers = {};
		var domains = {};
		var hotels = {};
		var payments = {};
		var venues = {};
		var attendees = {};

		accountmanagers = getUserManager().getAccountManagers( company_id=arguments.company_id, return_type="struct" );
		accountmanagers['managers'] = accountmanagers.data;
		details['company_id'] = company_id;
		companyusers['users'] = getUserManager().getCompanyUsers( company_id=arguments.company_id  );
		companyusers['count'] = arrayLen( companyusers.users.user_id );
		domains = getCompanyDomains( company_id=arguments.company_id );
		hotels['hotels'] = getHotelList( company_id=arguments.company_id );
		hotels['count'] = arrayLen( hotels.hotels.hotel_id );
		payments['creditcardsexcluded'] = getExcludedCreditCardsList( company_id=arguments.company_id );
		payments['creditcardsexcludedcount'] = arrayLen( payments.creditcardsexcluded.credit_card_id );
		payments['processors'] = getCompanyPaymentProcessorsList( company_id=arguments.company_id );
		payments['processorscount'] = arrayLen( payments.processors.active );
		venues['venues'] = getEventsManager().getVenueList( company_id=arguments.company_id );
		venues['count'] = arrayLen( venues.venues.venue_id );
		details['company'] = getCompany( company_id=arguments.company_id );
		details['accountmanagers'] = accountmanagers;
		details['companyusers'] = companyusers;
		details['domains'] = domains;
		details['hotels'] = hotels;
		details['payments'] = payments;
		details['venues'] = venues;
		details['events'] = getEventsManager().getCompanyEventList( company_id );

		var count = StructFind(details['events'], 'event_id');
		var index = 0;

		attendeesList = {};

		if (ArrayIsEmpty(count)) {
			details['attendees']['count'] = index;
		} else {
			for (eventId in details['events'].event_id) {
				index++;

				details['Allattendees'][index] = getAttendeeManager().getAttendees( eventId );

				for (attendee in details['Allattendees'][index]['data']) {
					attendeesList[attendee.attendee_id]['event'][eventId] = details['events'].name[index];
					attendeesList[attendee.attendee_id]['user'] = attendee.first_name & " " & attendee.last_name;
				}

			}

		}

		details['attendees'] = attendeesList;
		details['attendees']['count'] = index;
		details['companyusers_options'] = getFormUtilities().buildOptionList(
			values = details.companyusers.users.user_id,
			display = details.companyusers.users.displayname,
			selected = 0
		);

		details['sidebar_company_list'] = getFormUtilities().buildOptionList(
			values = companies.company_id,
			display = companies.company_name,
			selected = arguments.company_id
		);
		details['countries']['opts'] = getFormUtilities().buildOptionList(
			values=details.countries.country_code,
			display=details.countries.country_name,
			selected=details.company.company.data[1].country_code
		);
		details['regions']['opts'] = getFormUtilities().buildOptionList(
			values=details.regions.region_code,
			display=details.regions.region_name,
			selected=details.company.company.data[1].region_code
		);
		return details;
	}


	/**
	* I get all company domains
	*
	*/
	public struct function getCompanyDomains(company_id){
		return queryToStruct( recordset=getCompanyDao().companyDomainsGet( argumentCollection=arguments ).result.domains );
	}
	/**
	* Get the details for an individual company
	*
	*/
	public struct function getCompany( required numeric company_id, boolean company_only=false ) {
		var company_info = {};
		var company_domains= {};
		var company_domain = {};
		var company_users = {};
		company_info['data'] = [{
			address_1: "",
			address_2: "",
			address_id: 0,
			address_type: "Default",
			city: "",
			company_id: 0,
			company_name: "",
			country_code: "US",
			extension: "",
			latitude: "",
			longitude: "",
			phone_id: 0,
			phone_number: "",
			phone_typ: "Default",
			postal_code: "",
			region_code: "",
			verified: 0
		}];
		company_info['count'] = 0;
		company_domain['data'] = [];
		company_domain['count'] = 0;
		company_domains['data'] = [];
		company_domains['count'] = 0;
		company_users['data'] = [];
		company_users['count'] = 0;
		if (company_id > 0){
			company_query = getCompanyDAO().companyGet( arguments.company_id ).result;
			company_info['data'] = queryToArray( company_query.company );
			company_info['count'] = company_query.company.recordCount;
			company_domain['data'] = queryToArray( company_query.domain );
			company_domain['count'] = company_query.domain.recordCount;
			company_users['data'] = queryToArray( company_query.users );
			company_users['count'] = company_query.users.recordCount;
			company_domains['data'] = querytostruct( getCompanyDao().companyDomainsGet( arguments.company_id ).result.domains );

			company_users = querytostruct( company_query.users );
		}
		data ={
			'company':company_info,
			'domains': company_domains
		};
		// If we aren't' looking only for the company information do the following:
		if( !company_only ) {
			data['users'] = company_users;
			data['domain'] = company_domain;
		}
		return data;
	}
	/*
	* Gets all of the Credit Cards for a Companies Payment Processor
	* @company_id The company_id id
	* @processor_id The id of the payment processor
	*/

	public struct function getCompanyProcessorCreditCards(
		required numeric company_id,
		required numeric event_id
	) {
		var event_processor = {};	// Holds the event's processor information
		var params = {};			// Holds the passed parameters
		var data = {};				// Holds the information to return
		params = arguments;
		event_processor = getEventDAO().EventProcessorGet( arguments.event_id );
		params['processor_id'] = event_processor.processor_id;
		data['credit_card_types']['data'] = [];
		if( len( params['processor_id'] ) ) {
			data['credit_card_types']['data'] = queryToArray( getCompanyDAO().CompanyPaymentProcessorCreditCardsGet( argumentCollection=params ).result );
		}
		data['credit_card_types']['count'] = arrayLen( data.credit_card_types.data );
		data['processor_id'] = event_processor.processor_id;
		data['processor_name'] = event_processor.processor_name;
		return data;
	}

	/**
	 * Get Company events
	 */
	public struct function getEventsList(required numeric company_id) {
		var events = {};
		events = getEventsManager().getCompanyEventList( company_id=2 ).result;
		return events;
	}

	/**
	* Get Company hotels
	*/
	public struct function getHotelList( required numeric company_id ) {
		var hotels = {};
		hotels = queryToStruct( recordset=getHotelDao().CompanyHotelsGet( argumentCollection = arguments ).result );
		return hotels;
	}

  /**
	* Get Company payment processors
	*/
	public struct function getCompanyPaymentProcessorsList( required numeric company_id ) {
		var paymentProcessors = {};
		paymentProcessors = queryToStruct( recordset=getCompanyPaymentDao().CompanyPaymentProcessorList( argumentCollection = arguments ).result );
		return paymentProcessors;
	}

   /**
	* Get Payment processor list
	*/
	public struct function getPaymentProcessorsList() {
		var paymentProcessors = {};
		paymentProcessors = queryToStruct( recordset=getPaymentsDao().PaymentProcessorsGet().result.result1 );
		return paymentProcessors;
	}

  /**
	* Get Company excluded credit cards
	*/
	public struct function getExcludedCreditCardsList( required numeric company_id ) {
		var excludedCreditCards = {};
		excludedCreditCards = queryToStruct( recordset=getCompanyPaymentDao().CompanyExcludedCreditCardList( argumentCollection = arguments ).result );
		return excludedCreditCards;
	}

 /**
	* Get credit card list
	*/
	public struct function getCreditCardsList() {
		var creditCards = {};
		creditCards = queryToStruct( recordset=getPaymentsDao().PaymentCreditCardsGet().result );
		return creditCards;
	}

	/**
	* Multi line method description
	*
	*/
	public struct function getListing(
		required numeric order_index=0,
		string sort_direction="asc",
		string search_value="",
		numeric start_row=0,
		numeric total_rows=10,
		numeric draw=1
	) {
		var columns = [];
		var companies = getCompaniesDao().companiesList( argumentCollection=arguments ).result.companies;
		var data = {};

		data['data'] = queryToArray(
				recordSet=companies,
				columns=listAppend( companies.columnList, "options" ),
				map=function(  row, index, columns  ){
				row['options'] = "<div class=""btn-group"">";
				row['options'] &= "<a class=""btn btn-sm btn-primary"" href=""/company/details/manage_company_id/"  & row.company_id  & """>Manage</a>";
				row['options'] &= "</div>";
				return row;
			});

		data['count'] = companies.recordCount;

		return {
			"draw" : arguments.draw,
			"recordsTotal" : len( companies.total ) ? companies.total : 0,
			"recordsFiltered" : len( companies.total ) ? companies.total : 0,
			"data": data.data
		};
	 }

  /**
	* Set Account Manager
	*/
		public void function setAccountManager(required numeric company_id, required numeric user_id ){
			getCompanyDao().CompanyAccountManagerSet(company_id:arguments.company_id, user_id:arguments.user_id);
			return;
		}

  /**
	* Set Excluded Credit Card
	*/
	public void function setExcludedCreditCard(required numeric company_id, required numeric credit_card_id ){
		getCompanyDao().CompanyExcludedCreditCardSet(company_id:arguments.company_id, credit_card_id:arguments.credit_card_id);
		return;
	}

   /**
	* Set User
	*/
	public void function setUser(required numeric company_id, required numeric user_id ) {
		getCompanyDao().CompanyUserAdd(company_id:arguments.company_id, user_id:arguments.user_id);
		return;
	}

  /**
	*	Remove a processor from a company
	*/
	public void function companyRemoveProcessor( required numeric company_id, required numeric processor_id ){
		getCompanyDao().companyProcessorRemove(argumentCollection:arguments);
		getCacheManager().purgeCompanyConfigCache( arguments.company_id );
		return;
	}

   /**
	*	Remove an excluded credit card from a company
	*/
	public void function companyRemoveExcludedCreditCard( required numeric company_id, required numeric credit_card_id ){
		getCompanyDao().companyExcludedCreditCardRemove(argumentCollection:arguments);
		getCacheManager().purgeCompanyConfigCache( arguments.company_id );
		return;
	}

   /**
	*	Remove an account manager from a company
	*/
	public void function companyRemoveAccountManager( required numeric company_id, required numeric user_id ){
		getCompanyDao().companyAccountManagerRemove(argumentCollection:arguments);
		getCacheManager().purgeCompanyConfigCache( arguments.company_id );
		return;
	}

  /**
	*	Remove a user from a company
	*/
	public void function companyRemoveUser( required numeric company_id, required numeric user_id ){
		getCompanyDao().companyUserRemove(argumentCollection:arguments);
		getCacheManager().purgeCompanyConfigCache( arguments.company_id );
		return;
		}

  /**
	*	Remove a venue from an event
	*/
	public void function companyRemoveVenue( required numeric company_id, required numeric venue_id ){
		getCompanyDao().companyVenueRemove(argumentCollection:arguments);
		getCacheManager().purgeCompanyConfigCache( arguments.company_id );
		 return;
	}
	/*
	* Sets a Company's Information
	* @company_id The id of the company
	* @name The name of the company
	* @domain_id A url of the venue
	* @address_id (optional) The id of the address if updating, 0 means add
	* @address_type (optional) The address type
	* @address_1 The address line
	* @address_2 (optional) Additional address information
	* @city The city of the address
	* @region_code The region / state / province of the address
	* @postal_code The postal / zip code of the address
	* @country_code The 2 letter iso country code
	* @latitude (optional) The latitude of the address
	* @longitude (optional) The longitude of the address
	* @verified (optional) Whether or not the address has been verified
	* @phone_id (optional) The id of the phone if updating, 0 means add
	* @phone_type (optional) The phone type
	* @phone_number The phone number
	* @extension (optional) An extension for the phone
	*/
	public struct function save(
		// company details
		required numeric company_id,
		required string company_name,
		numeric domain_id=0,
		// address details
		numeric address_id=0,
		string address_type="Default",
		required string address_1,
		string address_2="",
		required string city,
		required string region_code,
		required string postal_code,
		required string country_code,
		numeric latitude=0,
		numeric longitude=0,
		boolean verified=false,
		// phone details
		string phone_type="Default",
		numeric phone_id=0,
		required string phone_number,
		string extension=""
	) {
		return getCompanyDao().CompanySet( argumentCollection = arguments );
	}
}
