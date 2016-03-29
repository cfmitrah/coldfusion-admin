/**
* I am the DAO for the Company object
* @file  /model/dao/Company.cfc
* @author
* @description
*
*/

component accessors="true" extends="app.model.base.Dao" {

	/**
	* I get users for a company
	* @company_id The ID of the company that you want to retrieve user for
	*/
		public struct function companyUsersGet( required numeric company_id ) {
			// Declare local variables
				var sp = new StoredProc();  // Holds the store procedure object
				var result = {};			// Holds the stored procedure reults
			// Set the store procedure attributes
				sp.setAttributes({
					'datasource' = getDSN(),
					'procedure' = "CompanyUsersGet"
				});
			// Add the passed in parameter (company_id)
				sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
			// Set the proc result
				sp.addProcResult( name="company_users", resultset=1 );
			// Execute the stored procedure
				result = sp.execute();
			// Build the return structure and return
				return {
					'prefix' = result.getPrefix(),
					'result' = result.getProcResultSets()
				};
		}
	/**
	* I remove a user from a company.
	* @company_id The ID of the company that you want to remove a user from.
	* @user_id The ID of the user that you want to remove from a company.
	*/
		public void function companyUserRemove( required numeric company_id, required numeric user_id ) {
			// Declare local variables
					var sp = new StoredProc();  // Holds the store procedure object
					var result = {};			// Holds the stored procedure reults
			// Set the store procedure attributes
				sp.setAttributes({
					'datasource' = getDSN(),
					'procedure' = "CompanyUserRemove"
				});
			// Add the passed in parameters (company_id, user_id)
				sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
				sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
			// Execute the stored procedure
				result = sp.execute();
			// Return
				return;
		}
	/**
	* I add a user to a company.
	* @company_id The ID of the company that you want to add a user from.
	* @user_id The ID of the user that you want to add from a company.
	*/
		public void function companyUserAdd( required numeric company_id, required numeric user_id ) {
			// Declare local variables
					var sp = new StoredProc();  // Holds the store procedure object
					var result = {};			// Holds the stored procedure reults
			// Set the store procedure attributes
				sp.setAttributes({
					'datasource' = getDSN(),
					'procedure' = "CompanyUserAdd"
				});
			// Add the passed in parameter (company_id, user_id)
				sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
				sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
			// Execute the stored procedure
				result = sp.execute();
			// Return
			return;
		}
/*
	* Sets a Company's Information
	* @company_id The id of the venue
	* @company_name The name of the venue
	* @domain_id The id of the domain
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
		public struct function CompanySet(
			// company details
				required numeric company_id,
				required string company_name,
			// Domain id
				numeric domain_id,
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
				string string phone_number="",
				string extension=""
		) {
			// Declare local variables
				var sp = new StoredProc();  // Holds the store procedure object
				var result = {};			// Holds the stored procedure reults
				var data = {};				// Holds the data to return
			// Set the store procedure attributes
				sp.setAttributes({
					'datasource' = getDSN(),
					'procedure' = "CompanySet"
				});
			// Trim the arguments fields
				trim_fields( arguments ); // trim all of the inputs
			// Add the passed in parameters
				// company details
					sp.addParam( type="inout", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id, null=( !arguments.company_id ), variable="company_id" );
					sp.addParam( type="in", dbvarname="@company_name", cfsqltype="cf_sql_varchar", maxlength=150, value=arguments.company_name );
				// domain
					sp.addParam( type="inout", dbvarname="@domain_id", cfsqltype="cf_sql_bigint", value=arguments.domain_id, null=( !arguments.domain_id ), variable="domain_id" );
				// address
					sp.addParam( type="inout", dbvarname="@address_id", cfsqltype="cf_sql_bigint", value=arguments.address_id, null=( !arguments.address_id ), variable="address_id" );
					sp.addParam( type="in", dbvarname="@address_type", cfsqltype="cf_sql_varchar", value=arguments.address_type, maxlength=50 );
					sp.addParam( type="in", dbvarname="@address_1", cfsqltype="cf_sql_varchar", value=arguments.address_1, maxlength=200 );
					sp.addParam( type="in", dbvarname="@address_2", cfsqltype="cf_sql_varchar", value=arguments.address_2, maxlength=200, null=( !len( arguments.address_2 ) ) );
					sp.addParam( type="in", dbvarname="@city", cfsqltype="cf_sql_varchar", value=arguments.city, maxlength=150 );
					sp.addParam( type="in", dbvarname="@region_code", cfsqltype="cf_sql_varchar", value=arguments.region_code, maxlength=6 );
					sp.addParam( type="in", dbvarname="@postal_code", cfsqltype="cf_sql_varchar", value=arguments.postal_code, maxlength=15 );
					sp.addParam( type="in", dbvarname="@country_code", cfsqltype="cf_sql_char", value=arguments.country_code, maxlength=2 );
					sp.addParam( type="in", dbvarname="@latitude", cfsqltype="cf_sql_decimal", value=arguments.latitude, scale=9, null=( !arguments.latitude ) );
					sp.addParam( type="in", dbvarname="@longitude", cfsqltype="cf_sql_decimal", value=arguments.longitude, scale=9, null=( !arguments.longitude ) );
					sp.addParam( type="in", dbvarname="@verified", cfsqltype="cf_sql_decimal", value=int( arguments.verified ) );
				// phone
					sp.addParam( type="inout", dbvarname="@phone_id", cfsqltype="cf_sql_bigint", value=arguments.phone_id, null=( !arguments.phone_id ), variable="phone_id" );
					sp.addParam( type="in", dbvarname="@phone_type", cfsqltype="cf_sql_varchar", value=arguments.phone_type, maxlength=50 );
					sp.addParam( type="in", dbvarname="@phone_number", cfsqltype="cf_sql_varchar", value=arguments.phone_number.replaceAll("[^0-9]+", ""), maxlength=15, null=( !len( arguments.phone_number ) ) );
					sp.addParam( type="in", dbvarname="@extension", cfsqltype="cf_sql_varchar", value=arguments.extension, maxlength=10, null=( !len( arguments.extension ) ) );
			// Execute the stored procedure
				result = sp.execute();
			// Store the prefix in the return structure
				data['prefix'] = result.getPrefix();
			// Add the results to the return structure
	        	structAppend( data, result.getProcOutVariables() );
	        // Return the data structure
				return data;
		}
	/**
	* I get the details of a company.
	* @company_id The ID of the company that you want to get.
	*/
		public struct function companyGet( required numeric company_id ) {
			// Declare local variables
					var sp = new StoredProc();  // Holds the store procedure object
					var result = {};			// Holds the stored procedure reults
			// Set the store procedure attributes
				sp.setAttributes({
					'datasource' = getDSN(),
					'procedure' = "CompanyGet"
				});
			// Add the passed in parameter (company_id)
				sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
			// Set the proc results
				sp.addProcResult( name="company", resultset=1 );
				sp.addProcResult( name="users", resultset=2 );
				sp.addProcResult( name="domain", resultset=3 );
			// Execute the stored procedure
				result = sp.execute();
			// Build the results structure and return
				return {
					'prefix' = result.getPrefix(),
					'result' = result.getProcResultSets()
				};
		}
	/**
	* I get a companies account managers.
	* @company_id The ID of the company that you want to get account managers for.
	*/
		public struct function companyAccountManagersGet( required numeric company_id ) {
			// Declare local variables
					var sp = new StoredProc();  // Holds the store procedure object
					var result = {};			// Holds the stored procedure reults
			// Set the store procedure attributes
				sp.setAttributes({
					'datasource' = getDSN(),
					'procedure' = "CompanyAccountManagersGet"
				});
			// Add the passed in parameter (company_id)
				sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
			// Set the proc result
				sp.addProcResult( name="Company_account_managers", resultset=1 );
			// Execute the stored procedure
				result = sp.execute();
			// Build the return structure and return
				return {
					'prefix' = result.getPrefix(),
					'result' = result.getProcResultSets()
				};
		}
	/**
	* I remove an account manager to a company
	* @company_id The ID of the company that you want to remove an account manager from.
	* @user_id The ID of the user that you want remove from being an account manager.
	*/
		public void function companyAccountManagerRemove( required numeric company_id, required numeric user_id ) {
			// Declare local variables
				var sp = new StoredProc();  // Holds the store procedure object
				var result = {};			// Holds the stored procedure reults
			// Set the store procedure attributes
				sp.setAttributes({
					'datasource' = getDSN(),
					'procedure' = "CompanyAccountManagerRemove"
				});
			// Add the passed in parameter (company_id)
				sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
				sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
			// Execute the stored procedure
				result = sp.execute();
			// Return
				return;
		}

	/**
	* I add an account manager to a company
	* @company_id The ID of the company that you want to add an account manager to.
	* @user_id The ID of the user that you want to be an account manager.
	*/
		public void function companyAccountManagerAdd( required numeric company_id, required numeric user_id ) {
			// Declare local variables
				var sp = new StoredProc();  // Holds the store procedure object
				var result = {};			// Holds the stored procedure reults
			// Set the store procedure attributes
				sp.setAttributes({
					'datasource' = getDSN(),
					'procedure' = "CompanyAccountManagerAdd"
				});
			// Add the passed in parameters (company_id, user_id)
				sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
				sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
			// Execute the stored procedure
				result = sp.execute();
			// Return
				return;
		}

	/**
	* I get company domains
	* @company_id The ID of the company that you want to add retrieve domains for.
	*/
		public struct function companyDomainsGet( required numeric company_id ) {
			// Declare local variables
				var sp = new StoredProc();  // Holds the store procedure object
				var result = {};			// Holds the stored procedure reults
			// Set the store procedure attributes
				sp.setAttributes({
					'datasource' = getDSN(),
					'procedure' = "CompanyDomainsGet"
				});
			// Add the passed in parameter (company_id)
				sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
			// Set the proc result
				sp.addProcResult( name="domains", resultset=1 );
			// Execute the stored procedure
				result = sp.execute();
			// Build the return structure and return
				return {
					'prefix' = result.getPrefix(),
					'result' = result.getProcResultSets()
				};
		}

	/*
	* Gets all of the Credit Cards for a Companies Payment Processor
	* @company_id The company_id id
	* @processor_id The id of the payment processor
	*/
		public struct function CompanyPaymentProcessorCreditCardsGet(
			required numeric company_id,
			required numeric processor_id
		) {
			// Declare local variables
				var sp = new StoredProc();  // Holds the store procedure object
				var result = {};			// Holds the stored procedure results
			// Set the store procedure attributes
				sp.setAttributes({
					'datasource': getDSN(),
					'procedure': "CompanyPaymentProcessorCreditCardsGet"
				});
			// Add the passed in parameters (company_id, processor_id)
				sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
				sp.addParam( type="in", dbvarname="@processor_id", cfsqltype="cf_sql_tinyint", value=arguments.processor_id );
			// Set the proc result
				sp.addProcResult( name="ProcessorCreditCards", resultset=1 );
			// Execute the stored procedure
				result = sp.execute();
			// Build the return structure and return
				return {
					'prefix' = result.getPrefix(),
					'result' = result.getProcResultSets().ProcessorCreditCards
				};
		}

	/*
	* Gets an company payment processor
	* @company_processor_id The id of the company processor
	*/
		public struct function CompanyPaymentProcessorGet( required numeric company_processor_id ) {
			// Declare local variables
				var sp = new StoredProc();  // Holds the store procedure object
				var result = {};			// Holds the stored procedure reults
				var data = {};				// The the return data structure
			// Set the store procedure attributes
				sp.setAttributes({
					'datasource': getDSN(),
					'procedure': "CompanyPaymentProcessorGet"
				});
			// Trim the arguments
				trim_fields( arguments );  // trim all of the inputs
			// Add the passed in parameter (company_id)
				sp.addParam( type="inout", dbvarname="@company_processor_id", cfsqltype="cf_sql_integer", value=arguments.company_processor_id, variable="company_processor_id" );
				sp.addParam( type="out", dbvarname="@company_id", cfsqltype="cf_sql_integer", variable="company_id" );
				sp.addParam( type="out", dbvarname="@label", cfsqltype="cf_sql_varchar", variable="label" );
				sp.addParam( type="out", dbvarname="@config", cfsqltype="cf_sql_longvarchar", variable="config" );
				sp.addParam( type="out", dbvarname="@processor_id", cfsqltype="cf_sql_tinyint", variable="processor_id" );
				sp.addParam( type="out", dbvarname="@processor_name", cfsqltype="cf_sql_varchar", variable="processor_name" );
				sp.addParam( type="out", dbvarname="@api_url", cfsqltype="cf_sql_varchar", variable="api_url" );
				sp.addParam( type="out", dbvarname="@docs_url", cfsqltype="cf_sql_varchar", variable="docs_url" );
			// Execute the stored procedure
				result = sp.execute();
			// Store prefix in the return data structure
				data['prefix'] = result.getPrefix();
			// Append the stored procedure results to the data structure
				structAppend( data, result.getProcOutVariables() );
			// Return the data structure
				return data;
		}

   /*
	* Remove a Processor to a Company Association
	* @company_id The id of the company
	* @venue_id The id of the venue
	*/
		public void function CompanyProcessorRemove(
			required numeric company_id,
			required numeric processor_id
		) {// Declare local variables
				var sp = new StoredProc();  // Holds the store procedure object
				var result = {};			// Holds the stored procedure reults
			// Set the store procedure attributes
				sp.setAttributes({
					'datasource': getDSN(),
					'procedure': "CompanyPaymentProcessorRemove"
				});
			// Add the passed in parameter (company_id)
				sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
				sp.addParam( type="in", dbvarname="@processor_id", cfsqltype="cf_sql_integer", value=arguments.processor_id );
			// Execute the stored procedure
				result = sp.execute();
			// Return
				return;
		}

	/*
	* Remove a Venue to a Company Association
	* @company_id The id of the company
	* @venue_id The id of the venue
	*/
		public void function CompanyVenueRemove(
			required numeric event_id,
			required numeric venue_id
		) {// Declare local variables
				var sp = new StoredProc();  // Holds the store procedure object
				var result = {};			// Holds the stored procedure reults
			// Set the store procedure attributes
				sp.setAttributes({
					'datasource': getDSN(),
					'procedure': "CompanyVenueRemove"
				});
			// Add the passed in parameter (company_id)
				sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
				sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
			// Execute the stored procedure
				result = sp.execute();
			// Return
				return;
		}
/*
	* Set an account manager for a company.
	* @company_id The id of the company
	* @user_id The id of the user
	*/
		public void function CompanyAccountManagerSet(
			required numeric company_id,
			required numeric user_id
		) {// Declare local variables
				var sp = new StoredProc();  // Holds the store procedure object
				var result = {};			// Holds the stored procedure reults
			// Set the store procedure attributes
				sp.setAttributes({
					'datasource': getDSN(),
					'procedure': "CompanyAccountManagerAdd"
				});
			// Add the passed in parameter (company_id)
				sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
				sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
			// Execute the stored procedure
				result = sp.execute();
			// Return
				return;
		}

/*
	* Set a credit card to be excluded for a company's events.
	* @company_id The id of the company
	* @credit_card_id The id of the credit card
	*/
	public void function CompanyExcludedCreditCardSet(
		required numeric company_id,
		required numeric credit_card_id
	) {// Declare local variables
			var sp = new StoredProc();  // Holds the store procedure object
			var result = {};			// Holds the stored procedure reults
		// Set the store procedure attributes
			sp.setAttributes({
				'datasource': getDSN(),
				'procedure': "CompanyExcludedCreditCardAdd"
			});
		// Add the passed in parameter (company_id)
			sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
			sp.addParam( type="in", dbvarname="@credit_card_id", cfsqltype="cf_sql_integer", value=arguments.credit_card_id );
		// Execute the stored procedure
			result = sp.execute();
		// Return
			return;
	}

/*
	* Remove a credit card to be excluded for a company.
	* @company_id The id of the company
	* @credit_card_id The id of the credit card
	*/
	public void function CompanyExcludedCreditCardRemove(
		required numeric company_id,
		required numeric credit_card_id
	) {// Declare local variables
			var sp = new StoredProc();  // Holds the store procedure object
			var result = {};			// Holds the stored procedure reults
		// Set the store procedure attributes
			sp.setAttributes({
				'datasource': getDSN(),
				'procedure': "CompanyExcludedCreditCardRemove"
			});

		// Add the passed in parameter (company_id)
			sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
			sp.addParam( type="in", dbvarname="@credit_card_id", cfsqltype="cf_sql_integer", value=arguments.credit_card_id );
		// Execute the stored procedure
			result = sp.execute();
		// Return
			return;
	}


	/*
	* Gets all Payment Processor
	* @active If null all are returned, otherwise results are filtered on the active state
	*/
		public struct function CompanyPaymentProcessorList( boolean active ) {
			param name="arguments.active" default=1;
			// Declare local variables
				var sp = new StoredProc();  // Holds the store procedure object
				var result = {};			// Holds the stored procedure reults
			// Set the store procedure attributes
				sp.setAttributes({
					'datasource': getDSN(),
					'procedure': "CompanyPaymentProcessorList"
				});
			// Add the passed in parameter (company_id)
				sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
			// Set the proc result
				sp.addProcResult( name="result1", resultset=1 );
			// Execute the stored procedure
				result = sp.execute();
			// Build the return structure and return
				return {
					'prefix' = result.getPrefix(),
					'result' = result.getProcResultSets()
				};
		}
}