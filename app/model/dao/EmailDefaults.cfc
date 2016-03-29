/**
* I am the DAO for the Airline object
* @file  /model/dao/Airline.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/*
	* Gets the email defaults for an event
	* @event_id The id of the event
	*/
	public struct function EmailDefaultsGet(
		required numeric event_id,
		boolean has_from_email=0,
		numeric from_email_id=0,
		string from_email="",
		boolean has_subject=0,
		string subject="",
		boolean has_header=0,
		numeric header_media_id=0,
		string header_filename="",
		string header_thumbnail=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EmailDefaultsGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="inout", dbvarname="@has_from_email", cfsqltype="cf_sql_bit", value=arguments.has_from_email, null=( !len( arguments.has_from_email ) ), variable="has_from_email" );
		sp.addParam( type="inout", dbvarname="@from_email_id", cfsqltype="cf_sql_bigint", value=arguments.from_email_id, null=( !arguments.from_email_id ), variable="from_email_id" );
		sp.addParam( type="inout", dbvarname="@from_email", cfsqltype="cf_sql_varchar", value=arguments.from_email, maxlength=300, null=( !len( arguments.from_email ) ), variable="from_email" );
		sp.addParam( type="inout", dbvarname="@has_subject", cfsqltype="cf_sql_bit", value=arguments.has_subject, null=( !len( arguments.has_subject ) ), variable="has_subject" );
		sp.addParam( type="inout", dbvarname="@subject", cfsqltype="cf_sql_varchar", value=arguments.subject, maxlength=300, null=( !len( arguments.subject ) ), variable="subject" );
		sp.addParam( type="inout", dbvarname="@has_header", cfsqltype="cf_sql_bit", value=arguments.has_header, null=( !len( arguments.has_header ) ), variable="has_header" );
		sp.addParam( type="inout", dbvarname="@header_media_id", cfsqltype="cf_sql_bigint", value=arguments.header_media_id, null=( !arguments.header_media_id ), variable="header_media_id" );
		sp.addParam( type="inout", dbvarname="@header_filename", cfsqltype="cf_sql_varchar", value=arguments.header_filename, maxlength=200, null=( !len( arguments.header_filename ) ), variable="header_filename" );
		sp.addParam( type="inout", dbvarname="@header_thumbnail", cfsqltype="cf_sql_varchar", value=arguments.header_thumbnail, maxlength=200, null=( !len( arguments.header_thumbnail ) ), variable="header_thumbnail" );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		structAppend( data, result.getProcResultSets() );
		return data;
	}	
	/*
	* Creates or Updates the email defaults for an event
	* @event_id The id of the event
	* @from_email The default from email address
	* @subject The default subject
	* @header_media_id The default media id for the header
	*/
	public struct function EmailDefaultsSet(
		required numeric event_id,
		string from_email="",
		string subject="",
		required numeric header_media_id=0
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "EmailDefaultsSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@from_email", cfsqltype="cf_sql_varchar", value=arguments.from_email, maxlength=300, null=( !len( arguments.from_email ) ) );
		sp.addParam( type="in", dbvarname="@subject", cfsqltype="cf_sql_varchar", value=arguments.subject, maxlength=300, null=( !len( arguments.subject ) ) );
		sp.addParam( type="in", dbvarname="@header_media_id", cfsqltype="cf_sql_bigint", value=arguments.header_media_id, null=( !arguments.header_media_id ) );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	
}