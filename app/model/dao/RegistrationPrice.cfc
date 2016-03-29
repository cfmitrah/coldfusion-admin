/**
* 
* I am the DAO for the Registration Types object
* @file  /model/dao/RegistrationTypes.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/**
	* 
	* I save a price for a registration type
	* @registration_type_id The ID of the registration type you are sacing a price for
	* @price The price
	* @valid_from The start date for a price
	* @valid_to The end date for a price
	* @is_default Make a price a default price or not
	*/
	public numeric function RegistrationPriceSet( 
		numeric registration_price_id=0, 
		required numeric registration_type_id, 
		required numeric price, 
		required date valid_from, 
		required date valid_to, 
		required boolean is_default) {

		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "RegistrationPriceSet"
		});
		sp.addParam( type="inout", dbvarname="@registration_price_id", cfsqltype="cf_sql_integer", value=arguments.registration_price_id, null=( !arguments.registration_price_id ), variable="registration_price_id" );
		sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );
		sp.addParam( type="in", dbvarname="@price", cfsqltype="cf_sql_money", value=arguments.price );
		sp.addParam( type="in", dbvarname="@valid_from", cfsqltype="cf_sql_date", value=arguments.valid_from );
		sp.addParam( type="in", dbvarname="@valid_to", cfsqltype="cf_sql_date", value=arguments.valid_to );
		sp.addParam( type="in", dbvarname="@is_default", cfsqltype="cf_sql_bit", value=int( arguments.is_default == 1 ) );

		result = sp.execute();
		return result.getProcOutVariables().registration_price_id;
	}
	/**
	* I remove an Registration Price
	* @registration_price_id The ID of the pricing that you want to remove
	* @registration_type_id The ID of the registration type that you want to remove the pricing from 
	*/
	public void function RegistrationPriceRemove( required numeric registration_price_id, required numeric registration_type_id ) {
		var sp = new StoredProc();
		var result = {};
		
		sp.setAttributes({
			datasource = getDSN(),
			procedure = "RegistrationPriceRemove"
		});

		sp.addParam( type="in", dbvarname="@registration_price_id", cfsqltype="cf_sql_integer", value=arguments.registration_price_id );
		sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );

		result 	= sp.execute();
		
		return;
	}
	/**
	* I save a price for a registration type
	* @registration_price_id The ID of the price that you want to save
	* @registration_type_id The ID of the registration type you are sacing a price for
	* @price The price
	* @valid_from The start date for a price
	* @valid_to The end date for a price
	*/
	public numeric function RegistrationPriceQuickSet( 
		required numeric registration_price_id, 
		required numeric registration_type_id,
		numeric price,
		string valid_from="",
		string valid_to="" ) {
		var sp = new StoredProc();
		var result = {};
		
		sp.setAttributes({
			datasource = getDSN(),
			procedure = "RegistrationPriceQuickSet"
		});
		sp.addParam( type="in", dbvarname="@registration_price_id", cfsqltype="cf_sql_integer", value=arguments.registration_price_id );
		sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );
		sp.addParam( type="in", dbvarname="@price", cfsqltype="cf_sql_money", value=( structKeyExists( arguments, 'price' )? arguments.price : 0 ), null=( !structKeyExists( arguments, 'price' ) ) );
		sp.addParam( type="in", dbvarname="@valid_from", cfsqltype="cf_sql_timestamp", value=arguments.valid_from, null=( !isdate(arguments.valid_from) ) );
		sp.addParam( type="in", dbvarname="@valid_to", cfsqltype="cf_sql_timestamp", value=arguments.valid_to, null=( !isdate(arguments.valid_to) ) );

		result = sp.execute();
		return arguments.registration_price_id;
	}
}
 