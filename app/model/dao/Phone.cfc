/**
* I am the DAO for the Airline object
* @file  /model/dao/Hotel.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/**
	* I check to see if a phone number exists.
	* @phone_number The phone number that you want to check.
	*/
	public boolean function phoneExists( required string phone_number ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "phoneExists"
		});
		
		sp.addParam( type="in", dbvarname="@phone_number", cfsqltype="cf_sql_varchar", maxlength=15, value=trim( arguments.phone_number ) );
		sp.addParam( type="out", dbvarname="@in_use", cfsqltype="cf_sql_bit", variable="exists" );
		result = sp.execute();
		return result.getProcOutVariables().exists;
	}
	/**
	* I get a phone record.
	* @phone_id The ID of the phone record that you want to get.
	*/
	public struct function phoneGet( required numeric phone_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "PhoneGet"
		});
		sp.addParam( type="in", dbvarname="@phone_id", cfsqltype="cf_sql_integer",value=arguments.phone_id );
		sp.addProcResult( name="phone", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I remove a phone record.
	* @phone_id The ID of the phone record that you want to remove.
	*/
	public void function phoneRemove( required numeric phone_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "PhoneRemove"
		});
		sp.addParam( type="in", dbvarname="@phone_id", cfsqltype="cf_sql_bigint",value=arguments.phone_id );
		
		result = sp.execute();
		return;
	}
	/**
	* I save a phone record.
	* @phone_id The ID of the phone number that you want to save.
	* @phone_type The type of phone number that you are saving.
	* @phone_number The phone number that you are saving.
	* @extension The extension of the phone number that you are saving.
	*/
	public numeric function phoneSet( numeric phone_id, required string phone_type, required string phone_number, string extension=""  ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "PhoneSet"
		});
		sp.addParam( type="inout", dbvarname="@phone_id", cfsqltype="cf_sql_bigint", value=arguments.phone_id, null=( !arguments.phone_id ), variable="phone_id" );
		sp.addParam( type="in", dbvarname="@phone_type", cfsqltype="cf_sql_varchar", maxlength=50, value=trim( arguments.phone_type ) );
		sp.addParam( type="in", dbvarname="@phone_number", cfsqltype="cf_sql_varchar", maxlength=15, value=trim( arguments.phone_number ) );
		sp.addParam( type="in", dbvarname="@extension", cfsqltype="cf_sql_varchar", maxlength=10, value=trim( arguments.extension ), null=(!len(trim(extension))) );

		result = sp.execute();
		return result.getProcOutVariables().phone_id;
	}
	
}