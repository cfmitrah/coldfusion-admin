/**
* I am the DAO for the Address object
* @file  /model/dao/Address.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/**
	* I set the location coorindates for an address 
	* @address_id The ID of the address that you want set coorindates on
	* @latitude The latitude of the address that you want set coorindates on
	* @longitude The longitude of the address that you want set coorindates on
	*/
	public void function addressCoorindatesSet( required numeric address_id, required numeric latitude, required numeric longitude ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "AddressCoorindatesSet"
		});
		sp.addParam( type="in", dbvarname="@address_id", cfsqltype="cf_sql_integer", value=arguments.address_id );
		sp.addParam( type="in", dbvarname="@latitude", cfsqltype="cf_sql_decimal", scale=9, value=arguments.latitude );
		sp.addParam( type="in", dbvarname="@longitude", cfsqltype="cf_sql_decimal", scale=9, value=arguments.longitude );
		
		result = sp.execute();
		return;
	}
	/**
	* I get an address
	* @address_id The ID of the addres that you want to get
	*/
	public struct function AddressGet( required numeric address_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "AddressGet"
		});
		sp.addParam( type="in", dbvarname="@address_id", cfsqltype="cf_sql_integer", value=arguments.address_id );
		sp.addProcResult( name="address", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I set the verified flag on an address
	* @address_id The ID of the address that you are setting the verified flag on 
	* @verified Is the address verified? Either true or false.
	*/
	public void function AddresslVerifiedSet( required numeric address_id, required boolean verified ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "AddresslVerifiedSet"
		});
		sp.addParam( type="in", dbvarname="@address_id", cfsqltype="cf_sql_integer", value=arguments.address_id );
		sp.addParam( type="in", dbvarname="@verified", cfsqltype="cf_sql_bit", value=int( arguments.verified == 1 ) );
		
		result = sp.execute();
		return;
	}
	/**
	* I remove an address
	* @address_id The ID of the address that you want to remove
	*/
	public void function AddressRemove( required numeric address_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "AddressRemove"
		});
		sp.addParam( type="in", dbvarname="@address_id", cfsqltype="cf_sql_integer", value=arguments.address_id );
		
		result = sp.execute();
		return;
	}
	/**
	* I set an address
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
	public numeric function addressSet(
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
			'procedure' = "AddressSet"
		});
		sp.addParam( type="inout", dbvarname="@address_id", cfsqltype="cf_sql_bigint", value=arguments.address_id, variable="address_id", null=( !arguments.address_id ) );
		sp.addParam( type="in", dbvarname="@address_type", cfsqltype="cf_sql_varchar", maxlength=50, value=trim( arguments.address_type ) );
		sp.addParam( type="in", dbvarname="@address_1", cfsqltype="cf_sql_varchar", maxlength=200, value=trim( arguments.address_1 ) );
		sp.addParam( type="in", dbvarname="@address_2", cfsqltype="cf_sql_varchar", maxlength=200, value=arguments.address_2, null=( !len( trim( arguments.address_2 ) ) ) );
		sp.addParam( type="in", dbvarname="@city", cfsqltype="cf_sql_varchar", maxlength=150, value=trim( arguments.city ) );
		sp.addParam( type="in", dbvarname="@region_code", cfsqltype="cf_sql_varchar",  maxlength=6, value=trim( arguments.region_code ) );
		sp.addParam( type="in", dbvarname="@postal_code", cfsqltype="cf_sql_varchar",  maxlength=15, value=trim( arguments.postal_code ) );
		sp.addParam( type="in", dbvarname="@country_code", cfsqltype="cf_sql_char", maxlength=2, value=trim( arguments.country_code ) );
		sp.addParam( type="in", dbvarname="@latitude", cfsqltype="cf_sql_float", value=arguments.latitude, scale=9, null=( !arguments.latitude ) );
		sp.addParam( type="in", dbvarname="@longitude", cfsqltype="cf_sql_float", value=arguments.longitude, scale=9, null=( !arguments.longitude ) );
		sp.addParam( type="in", dbvarname="@verified", cfsqltype="cf_sql_bit", value=int( arguments.verified == 1 ) );
		result = sp.execute();
		return result.getProcOutVariables().address_id;
	}

	/**
	* I get all of the address types
	*/
	public query function addressTypesGet() {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "AddressTypesGet"
		});
		sp.addProcResult( name="address_types", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}	
}