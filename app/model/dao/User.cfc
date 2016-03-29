/**
* I am the DAO for the User object
* @file  /model/dao/User.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {
	/**
	* Checks to see if a user is a manage user by their username
	* @username the username of the user trying to authenicate 
	*/
	public struct function UserManageCredentialsGet( required string username ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "UserManageCredentialsGet"
		});
		sp.addParam( type="in", dbvarname="@username", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.username ) );
		sp.addProcResult( name="auth", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I get all of a user's details, phone numbers, emails, properties and adresses 
	* @user_id The user ID of the user that you want to get detals on.
	*/
	public struct function userGet( required numeric user_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "UserGet"
		});
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		sp.addProcResult( name="details", resultset=1 );
		sp.addProcResult( name="properties", resultset=2 );
		sp.addProcResult( name="emails", resultset=3 );
		sp.addProcResult( name="phone_numbers", resultset=4 );
		sp.addProcResult( name="addresses", resultset=5 );
		sp.addProcResult( name="companies", resultset=6 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* Check to see if a username exists or not
	* @username the username that you want to see if it exists or not
	*/
	public boolean function usernameExists( required string username ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "UsernameExists"
		});
		sp.addParam( type="in", dbvarname="@username", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.username ) );
		sp.addParam( type="out", dbvarname="@in_use", cfsqltype="cf_sql_bit", variable="exists" );
		result = sp.execute();
		return result.getProcOutVariables().exists;
	}
	/**
	* I get all of a user's companies
	* @user_id The user ID of the user that you want to get companies for.
	*/
	public struct function userCompaniesGet( required numeric user_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "UserCompaniesGet"
		});
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		sp.addProcResult( name="companies", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I get all of a user's emails
	* @user_id The user ID of the user that you want to get emails for.
	*/
	public struct function userEmailsGet( required numeric user_id, string email_type='' ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "userGetEmails"
		});
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		sp.addParam( type="in", dbvarname="@email_type", cfsqltype="cf_sql_varchar", value=trim(arguments.email_type), null=(!len(trim(arguments.email_type))) );
		sp.addProcResult( name="emails", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I check to see if a phone number is in use
	* @phone_number Argument description
	*/
	public boolean function PhoneExists( required string phone_number ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "PhoneExists"
		});
		sp.addParam( type="in", dbvarname="@username", cfsqltype="phone_number", value=trim( arguments.phone_number ) );
		sp.addParam( type="out", dbvarname="@in_use", cfsqltype="cf_sql_bit", variable="exists" );
		result = sp.execute();
		return result.getProcOutVariables().exists;
	}
	/**
	* Multi line method description
	* @user_id The ID of the user that we are adding a phone to 
	* @phone_type The type of phone number that we are adding
	* @phone_number The phone number
	* @phone_id The phone ID if we are updating 
	* @extension The extension of the user's phone number
	*/
	public numeric function userPhoneSet( required numeric user_id, required string phone_type, required string phone_number, numeric phone_id=0, string extension="" ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "UserPhoneSet"
		});
		
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		sp.addParam( type="inout", dbvarname="@phone_id", cfsqltype="cf_sql_integer", value=arguments.phone_id, null=( !arguments.phone_id ), variable="phone_id" );
		sp.addParam( type="in", dbvarname="@phone_type", cfsqltype="cf_sql_varchar", maxlength=50, value=trim( arguments.phone_type ) );
		sp.addParam( type="in", dbvarname="@phone_number", cfsqltype="cf_sql_varchar", maxlength=15, value=trim( arguments.phone_number ) );
		sp.addParam( type="in", dbvarname="@extension", cfsqltype="cf_sql_varchar", maxlength=10, value=trim( arguments.extension ) );
		sp.addParam( type="in", dbvarname="@active", cfsqltype="cf_sql_bit", value=int( arguments.active == 1 ) );
		result = sp.execute();
		return result.getProcOutVariables().phone_id;
	}
	/**
	* I get all of a user's phone numbers
	* @user_id The user ID of the user that you want to get phone numbers for.
	* @phone_type The type of phone number you would like to return 
	*/
	public struct function userPhonesGet( required numeric user_id, string phone_type='' ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "UserPhonesGet"
		});
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		sp.addParam( type="in", dbvarname="@phone_type", cfsqltype="cf_sql_varchar", value=trim(arguments.phone_type), null=(!len(trim(arguments.phone_type))) );
		sp.addProcResult( name="phones", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I set the details of a user
	* @user_id The ID of the user that we want to update
	* @first_name The first name of the user that we want to update
	* @last_name The last name of the user that we want to update
	* @active The active flag of the user that we want to update
	*/
	public void function userDetailSet( required numeric user_id, required string first_name, required string last_name, numeric active=1 ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "UserDetailSet"
		});
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		sp.addParam( type="in", dbvarname="@first_name", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.first_name ) );
		sp.addParam( type="in", dbvarname="@last_name", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.last_name ) );
		sp.addParam( type="in", dbvarname="@active", cfsqltype="cf_sql_bit", value=int( arguments.active == 1 ) );
		result = sp.execute();
		return;
	}
	/**
	* I add a company to a user
	* @company_name The company name that we adding to a user
	* @address_id 
	* @phone_id 
	* @company_id The ID of the company if we are updating
	*/
	public numbe function CompanySet( required string company_name, required numeric address_id, numeric phone_id=0, numeric company_id=0 ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "setCompany"
		});
		sp.addParam( type="inout", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id, variable="company_id", null=( !arguments.company_id ) );
		sp.addParam( type="in", dbvarname="@company_name", cfsqltype="cf_sql_varchar", maxlength=150, value=trim( arguments.company_name ) );
		sp.addParam( type="in", dbvarname="@address_id", cfsqltype="cf_sql_integer", value=arguments.address_id );
		sp.addParam( type="in", dbvarname="@phone_id", cfsqltype="cf_sql_bigint", value=arguments.phone_id, null=( !arguments.address_id ) );
		result 	= sp.execute();
		return result.getProcOutVariables().company_id;
	}
	/**
	* I set an address to a user 
	* @user_id The ID of the user that you want to set an address to 
	* @address_id The address ID if you are updating an address
	* @address_type The type of address that you are setting to a user
	* @address_1 The address_1 of address that you are setting to a user
	* @address_2 The address_2 of address that you are setting to a user
	* @city The city of address that you are setting to a user
	* @region_code The region_code of address that you are setting to a user
	* @postal_code The postal_code of address that you are setting to a user
	* @country_code The country_code of address that you are setting to a user
	* @latitude The latitude of address that you are setting to a user
	* @longitude The longitude of address that you are setting to a user
	* @verified The verified flag of address that you are setting to a user
	*/
	public numeric function userAddressSet(
		required string user_id,
		numeric address_id=0,
		required string address_type,
		required string address_1,
		string address_2="",
		required string city,
		required string region_code,
		required string postal_code,
		required string country_code,
		numeric latitude=0,
		numeric longitude=0,
		boolean verified=0
		
		
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "UserAddressSet"
		});
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		sp.addParam( type="inout", dbvarname="@address_id", cfsqltype="cf_sql_bigint", value=arguments.address_id, variable="address_id", null=( !arguments.address_id ) );
		sp.addParam( type="in", dbvarname="@address_type", cfsqltype="cf_sql_varchar", maxlength=50, value=trim( arguments.address_type ) );
		sp.addParam( type="in", dbvarname="@address_1", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.address_1 ) );
		sp.addParam( type="in", dbvarname="@address_2", cfsqltype="cf_sql_varchar", maxlength=200, value=arguments.address_2, null=( !len( trim( arguments.address_2 ) ) ) );
		sp.addParam( type="in", dbvarname="@city", cfsqltype="cf_sql_varchar", maxlength=150, value=trim( arguments.city ) );
		sp.addParam( type="in", dbvarname="@region_code", cfsqltype="cf_sql_varchar",  maxlength=6, value=trim( arguments.region_code ) );
		sp.addParam( type="in", dbvarname="@postal_code", cfsqltype="cf_sql_varchar",  maxlength=15, value=trim( arguments.postal_code ) );
		sp.addParam( type="in", dbvarname="@country_code", cfsqltype="cf_sql_char", maxlength=2, value=trim( arguments.country_code ) );
		sp.addParam( type="in", dbvarname="@latitude", cfsqltype="cf_sql_float", value=arguments.latitude, null=( !arguments.latitude ) );
		sp.addParam( type="in", dbvarname="@longitude", cfsqltype="cf_sql_float", value=arguments.longitude, null=( !arguments.longitude ) );
		sp.addParam( type="in", dbvarname="@verified", cfsqltype="cf_sql_bit", value=int( arguments.verified == 1 ) );
		result = sp.execute();
		return result.getProcOutVariables().address_id;
	}
	/**
	* I remove an address from a user
	* @user_id The ID of the user that you want to remove the address from 
	* @address_id The address ID of the address that you want to remove the user from 
	*/
	public void function userRemoveAddress( required numeric user_id, required numeric address_id ) {
		var sp = new StoredProc();
		var result = {};
		
		sp.setAttributes({
			datasource = getDSN(),
			procedure = "UserRemoveAddress"
		});

		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		sp.addParam( type="in", dbvarname="@address_id", cfsqltype="cf_sql_integer", value=arguments.address_id );

		result 	= sp.execute();
		
		return;
	}
	/**
	* I set the password for a user
	* @user_id The ID of the user that you are setting the password on
	* @password The password of the user that you are setting the password on
	* @salt The salt of the user that you are setting the password on
	*/
	public void function userPasswordSet( required numeric user_id, required string password, required string salt ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "UserPasswordSet"
		});
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		sp.addParam( type="in", dbvarname="@password", cfsqltype="cf_sql_varchar", value=trim( arguments.password ) );
		sp.addParam( type="in", dbvarname="@salt", cfsqltype="cf_sql_varchar", value=trim( arguments.salt ) );
		result = sp.execute();
		return;
	}
	/**
	* I generarte a password token for a user so that this can reset their password
	* @user_id The ID of the user that you want to generate a token for 
	* @expires When the does the token expire
	*/
	public string function userGeneratePasswordToken( required numeric user_id, expires ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "UserGeneratePasswordToken"
		});
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=trim( arguments.username ) );
		sp.addParam( type="in", dbvarname="@expires", cfsqltype="cf_sql_timestamp", value=arguments.expires,null=(!isdate(trim(arguments.expires))) );
		sp.addParam( type="out", dbvarname="@reset_token", cfsqltype="cf_sql_char", variable="reset_token" );

		result = sp.execute();
		
		return result.getProcOutVariables().reset_token;
	}
	/**
	* I Validate a password token 
	* @reset_token The token that needs to be validated
	*/
	public struct function userGetPasswordToken( required string reset_token ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "UserGetPasswordToken"
		});
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", maxlength=200, value=trim( arguments.username ) );
		sp.addProcResult( name="reset_token", resultset=1 );

		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'info' = result.getProcResultSets()
		};
	}
	/**
	* Checks to see if a user is a manage user by their username
	* @email the email of the user trying to get of the ID for 
	*/
	public numeric function userGetIdByEmail( required string email ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "UserGetPasswordToken"
		});
		sp.addParam( type="in", dbvarname="@email", cfsqltype="cf_sql_varchar", maxlength=300, value=trim( arguments.email ) );
		sp.addParam( type="out", dbvarname="@user_id", cfsqltype="cf_sql_integer", variable="user_id" );

		result = sp.execute();
		return result.getProcOutVariables().user_id;
	}
	/**
	* I get an ID of a user by the username
	* @username the email of the user trying to get of the ID for 
	*/
	public numeric function userGetIdByUsername( required string username ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "UserGetPasswordToken"
		});
		sp.addParam( type="in", dbvarname="@email", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.username ) );
		sp.addParam( type="out", dbvarname="@user_id", cfsqltype="cf_sql_integer", variable="user_id" );

		result = sp.execute();
		return result.getProcOutVariables().user_id;
	}
	/**
	* I create a user
	* @username The username of the user that you are creating
	* @password The password of the user that you are creating
	* @salt The salt of the user of the that you are creating
	* @first_name The first name of the user that you are creating
	* @last_name The last name of the user that you are creating
	* @active The username of the user of that you are creating
	*/
	public numeric function userCreate( required string username, required string password, required string salt, string first_name="", string last_name="", required boolean active ) {
		var sp = new StoredProc();

		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "UserCreate"
		});			
		sp.addParam( type="in", dbvarname="@username", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.username ) );
		sp.addParam( type="in", dbvarname="@password", cfsqltype="cf_sql_varchar", maxlength=128, value=trim( arguments.password ) );
		sp.addParam( type="in", dbvarname="@salt", cfsqltype="cf_sql_varchar", maxlength=24, value=trim( arguments.salt ) );
		sp.addParam( type="in", dbvarname="@first_name", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.first_name ), null=(!len(trim(arguments.first_name))) );
		sp.addParam( type="in", dbvarname="@last_name", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.last_name ), null=(!len(trim(arguments.last_name))) );
		sp.addParam( type="in", dbvarname="@active", cfsqltype="cf_sql_bit", value=int( arguments.active == 1 ) );
		sp.addParam( type="out", dbvarname="@user_id", cfsqltype="cf_sql_integer", variable="user_id" );
		result = sp.execute();
		return result.getProcOutVariables().user_id;
	}	
}