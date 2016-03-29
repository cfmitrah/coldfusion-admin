/**
* I am the DAO for the Email object
* @file  /model/dao/Email.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {
	/*
	* Gets all of the Communications for an Event
	* @event_id The id of the event
	* @start The row to start on
	* @results The number of results to return
	* @sort_column The column to sort by - valid values ('comm_type','label','subject','from_email','send_on','sent','recipients')
	* @sort_direction The direction to sort
	* @search a Keyword to filter the results on
	*/
	public struct function EmailCommSchedulesList(
		required numeric event_id,
		numeric start=1,		
		numeric results=10,
		string sort_column="comm_type",
		string sort_direction="ASC",
		string search=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EmailCommSchedulesList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", value=arguments.sort_column, maxlength=50, null=( !len( arguments.sort_column ) ) );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", value=arguments.sort_direction, maxlength=4, null=( !len( arguments.sort_direction ) ) );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", value=arguments.search, maxlength=200, null=( !len( arguments.search ) ) );
		sp.addProcResult( name="history", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Gets all of the Invitations and Communicaitons Schedules for an Event
	* @event_id The id of the event
	*/
	public struct function EmailCommSchedulesGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EmailCommSchedulesGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="invitations", resultset=1 );
		sp.addProcResult( name="communications", resultset=2 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}	
	/**
	* I get an email record by email.
	* @email The email of the record that you want to get.
	*/
	public boolean function emailByAddressGet( required string email ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EmailByAddressGet"
		});
		sp.addParam( type="in", dbvarname="@email", cfsqltype="cf_sql_varchar", maxlength=300, value=trim( arguments.email ) );
		
		sp.addProcResult( name="email", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* I check to see if an email exists.
	* @email The email that you are checking.
	*/
	public boolean function EmailExists( required string email ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "UsernameExists"
		});
		sp.addParam( type="in", dbvarname="@email", cfsqltype="cf_sql_varchar", maxlength=300, value=trim( arguments.email ) );
		sp.addParam( type="out", dbvarname="@in_use", cfsqltype="cf_sql_bit", variable="exists" );
		result = sp.execute();
		return result.getProcOutVariables().exists;
	}
	/**
	* I get an email record.
	* @email_id The ID of the email record that you want to get.
	*/
	public boolean function emailGet( required numeric email_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EmailGet"
		});
		sp.addParam( type="in", dbvarname="@email_id", cfsqltype="cf_sql_int", value=arguments.email_id, variable="email_id" );
		sp.addProcResult( name="email", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* 
	* @email_id
	* @opt_out
	*/
	public boolean function EmailOptOutSet( required numeric email_id, required boolean opt_out ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EmailOptOutSet"
		});
		sp.addParam( type="in", dbvarname="@email_id", cfsqltype="cf_sql_bigint", value=arguments.email_id, variable="email_id" );
		sp.addParam( type="in", dbvarname="@opt_out", cfsqltype="cf_sql_bit", value=int( arguments.opt_out == 1 ) );
		result = sp.execute();
		return;
	}
	/**
	* I remove an email.
	* @email_id The ID of the email that you want remove
	*/
	public void function emailRemove( required numeric email_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EmailRemove"
		});
		sp.addParam( type="in", dbvarname="@email_id", cfsqltype="cf_sql_bigint", value=arguments.email_id );
		result = sp.execute();
		return;
	}
	/**
	* 
	* @email_id 
	* @email_type
	* @email 
	* @opt_out 
	* @verified
	*/
	public numeric function emailSet( numeric email_id=0, required string email_type, required string email, required boolean opt_out, required boolean verified=0 ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EmailSet"
		});
		sp.addParam( type="inout", dbvarname="@email_id", cfsqltype="cf_sql_bigint", value=arguments.email_id, variable="email_id" );
		sp.addParam( type="in", dbvarname="@email_type", cfsqltype="cf_sql_varchar", maxlength=50, value=trim( arguments.email_type ) );
		sp.addParam( type="in", dbvarname="@email", cfsqltype="cf_sql_varchar", maxlength=300, value=trim( arguments.email ) );
		sp.addParam( type="in", dbvarname="@opt_out", cfsqltype="cf_sql_bit", value=int( arguments.opt_out == 1 ) );
		sp.addParam( type="in", dbvarname="@verified", cfsqltype="cf_sql_bit", value=int( arguments.verified == 1 ) );
		
		result = sp.execute();
		return result.getProcOutVariables().email_id;
	}
	/**
	* I get all of the email types.
	*/
	public struct function emailTypesGet() {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EmailTypesGet"
		});
		sp.addProcResult( name="email_types", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/**
	* 
	* @email_id
	* @verified
	*/
	public void function emailVerifiedSet( required numeric email_id, required boolean verified ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EmailVerifiedSet"
		});
		sp.addParam( type="in", dbvarname="@email_id", cfsqltype="cf_sql_bigint", value=arguments.email_id );
		sp.addParam( type="in", dbvarname="@verified", cfsqltype="cf_sql_bit", value=arguments.verified );
		result = sp.execute();
		return ;
	}

}