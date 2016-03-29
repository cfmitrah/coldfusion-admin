	/**
*
* @file  /model/dao/Agenda.cfc
* @author - JG
* @description
*
*/

component accessors="true" extends="app.model.base.Dao" {
/*
	* Gets all of the data needed to populate an Autoresponder email
	* @event_id The event to get data for
	* @attendee_id The attendee to get data for
	* @location The location copy for the event
	* @dates The date copy for the event
	* @total_fees The sum of all Fees
	* @total_credits The sum of all Payments, Refunds and Voids
	* @total_due The total amount outstanding
	* @total_cancels The sum of all the cancels
	* @last_payment_amount The amount of the last payment
	* @last_payment_type The type of the last payment
	* @last_cancel_amount The amount of the last cancelled item
*/
public struct function AutoresponderDataGet(
		required numeric event_id,
		required numeric attendee_id,
		string location="",
		string dates="",
		numeric total_fees=0,
		numeric total_credits=0,
		numeric total_due=0,
		numeric total_cancels=0,
		numeric last_payment_amount=0,
		string last_payment_type="",
		numeric last_cancel_amount=0
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AutoresponderDataGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, null=( !arguments.event_id ) );
		sp.addParam( type="in", dbvarname="@attendee_id", cfsqltype="cf_sql_bigint", value=arguments.attendee_id, null=( !arguments.attendee_id ) );
		sp.addParam( type="inout", dbvarname="@location", cfsqltype="cf_sql_longvarchar", value=arguments.location, null=( !len( arguments.location ) ), variable="location" );
		sp.addParam( type="inout", dbvarname="@dates", cfsqltype="cf_sql_longvarchar", value=arguments.dates, null=( !len( arguments.dates ) ), variable="dates" );
		sp.addParam( type="inout", dbvarname="@total_fees", cfsqltype="cf_sql_money", value=arguments.total_fees, null=( !arguments.total_fees ), variable="total_fees" );
		sp.addParam( type="inout", dbvarname="@total_credits", cfsqltype="cf_sql_money", value=arguments.total_credits, null=( !arguments.total_credits ), variable="total_credits" );
		sp.addParam( type="inout", dbvarname="@total_due", cfsqltype="cf_sql_money", value=arguments.total_due, null=( !arguments.total_due ), variable="total_due" );
		sp.addParam( type="inout", dbvarname="@total_cancels", cfsqltype="cf_sql_money", value=arguments.total_cancels, null=( !arguments.total_cancels ), variable="total_cancels" );
		sp.addParam( type="inout", dbvarname="@last_payment_amount", cfsqltype="cf_sql_money", value=arguments.last_payment_amount, null=( !arguments.last_payment_amount ), variable="last_payment_amount" );
		sp.addParam( type="inout", dbvarname="@last_payment_type", cfsqltype="cf_sql_varchar", value=arguments.last_payment_type, maxlength=250, null=( !len( arguments.last_payment_type ) ), variable="last_payment_type" );
		sp.addParam( type="inout", dbvarname="@last_cancel_amount", cfsqltype="cf_sql_money", value=arguments.last_cancel_amount, null=( !arguments.last_cancel_amount ), variable="last_cancel_amount" );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		structAppend( data, result.getProcResultSets() );
		return data;
	}
	/*
	* Gets all of the autoresponder types
	*/
	public struct function AutoresponderTypesGet() {		
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AutoresponderTypesGet"
		});
		sp.addProcResult( name="types", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Gets all of the Autoresponder Information by event_id, autoresponder_type, registration_type_id
	* If registration_type_id does not match then returns the default record of registration_type_id = NULL
	* @event_id The id of the event
	* @autoresponder_type The type of the autoresponder
	* @registration_type_id The id of the registration_type
	*/
	public struct function AutoresponderEventTypeGet(
		required numeric event_id,
		required string autoresponder_type,
		required numeric autoresponder_id=0,
		string description="",
		string label="",
		required numeric from_email_id=0,
		string from_email="",
		string subject="",
		string before_body="",
		string after_body="",
		required numeric header_media_id=0,
		string header_filename="",
		string bcc="",
		numeric registration_type_id=0,
		string registration_type=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AutoresponderEventTypeGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@autoresponder_type", cfsqltype="cf_sql_varchar", value=arguments.autoresponder_type, maxlength=50 );
		sp.addParam( type="inout", dbvarname="@autoresponder_id", cfsqltype="cf_sql_integer", value=arguments.autoresponder_id, null=( !arguments.autoresponder_id ), variable="autoresponder_id" );
		sp.addParam( type="inout", dbvarname="@description", cfsqltype="cf_sql_varchar", value=arguments.description, maxlength=500, null=( !len( arguments.description ) ), variable="description" );
		sp.addParam( type="inout", dbvarname="@label", cfsqltype="cf_sql_varchar", value=arguments.label, maxlength=150, null=( !len( arguments.label ) ), variable="label" );
		sp.addParam( type="inout", dbvarname="@from_email_id", cfsqltype="cf_sql_bigint", value=arguments.from_email_id, null=( !arguments.from_email_id ), variable="from_email_id" );
		sp.addParam( type="inout", dbvarname="@from_email", cfsqltype="cf_sql_varchar", value=arguments.from_email, maxlength=300, null=( !len( arguments.from_email ) ), variable="from_email" );
		sp.addParam( type="inout", dbvarname="@subject", cfsqltype="cf_sql_varchar", value=arguments.subject, maxlength=300, null=( !len( arguments.subject ) ), variable="subject" );
		sp.addParam( type="inout", dbvarname="@before_body", cfsqltype="cf_sql_longvarchar", value=arguments.before_body, null=( !len( arguments.before_body ) ), variable="before_body" );
		sp.addParam( type="inout", dbvarname="@after_body", cfsqltype="cf_sql_longvarchar", value=arguments.after_body, null=( !len( arguments.after_body ) ), variable="after_body" );
		sp.addParam( type="inout", dbvarname="@header_media_id", cfsqltype="cf_sql_bigint", value=arguments.header_media_id, null=( !arguments.header_media_id ), variable="header_media_id" );
		sp.addParam( type="inout", dbvarname="@header_filename", cfsqltype="cf_sql_varchar", value=arguments.header_filename, maxlength=200, null=( !len( arguments.header_filename ) ), variable="header_filename" );
		sp.addParam( type="inout", dbvarname="@bcc", cfsqltype="cf_sql_varchar", value=arguments.bcc, maxlength=500, null=( !len( arguments.bcc ) ), variable="bcc" );
		sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id, null=( !arguments.registration_type_id ) );
		sp.addParam( type="inout", dbvarname="@registration_type", cfsqltype="cf_sql_varchar", value=arguments.registration_type, maxlength=150, variable="registration_type" );
		sp.addParam( type="inout", dbvarname="@active", cfsqltype="cf_sql_bit", value=arguments.active, variable="active" );
		sp.addParam( type="out", dbvarname="@company_name", cfsqltype="cf_sql_varchar", variable="company_name" );
		sp.addParam( type="inout", dbvarname="@footer", cfsqltype="cf_sql_longvarchar", value=arguments.footer, null=( !len( arguments.footer ) ), variable="footer" );
		sp.addProcResult( name="log", resultset=1 );
		sp.addProcResult( name="body_html", resultset=2 );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		structAppend( data, result.getProcResultSets() );
		if( data.body_html.recordcount ) {
			data['before_body'] = data.body_html.before_body;
			data['after_body'] = data.body_html.after_body;
		}
		return data;
	}
	/*
	* Creates or Updates a Autoresponder and Returns the Autoresponder ID
	* @autoresponder_id The id of the Autoresponder
	* @event_id The id of the event
	* @autoresponder_type The type of autoresponder
	* @label A friendly label for the Autoresponder
	* @from_email The From email address for the Autoresponder
	* @subject A subject for the email Autoresponder
	* @before_body Content to show before the body
	* @after_bdoy Content to show after the body
	* @header_media_id The media_id for the header image
	*/
	public numeric function AutoresponderSet(
		required numeric autoresponder_id,
		required numeric event_id,
		required string autoresponder_type,
		required string label,
		required string from_email,
		required string subject,
		required string before_body,
		required string after_body,
		numeric header_media_id=0,
		string bcc="",
		numeric registration_type_id=0,
		boolean active=1,
		string footer=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AutoresponderSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@autoresponder_id", cfsqltype="cf_sql_integer", value=arguments.autoresponder_id, null=( !arguments.autoresponder_id ), variable="autoresponder_id" );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@autoresponder_type", cfsqltype="cf_sql_varchar", value=arguments.autoresponder_type, maxlength=50 );
		sp.addParam( type="in", dbvarname="@label", cfsqltype="cf_sql_varchar", value=arguments.label, maxlength=150 );
		sp.addParam( type="in", dbvarname="@from_email", cfsqltype="cf_sql_varchar", value=arguments.from_email, maxlength=300 );
		sp.addParam( type="in", dbvarname="@subject", cfsqltype="cf_sql_varchar", value=arguments.subject, maxlength=300 );
		sp.addParam( type="in", dbvarname="@before_body", cfsqltype="cf_sql_longvarchar", value=arguments.before_body );
		sp.addParam( type="in", dbvarname="@after_body", cfsqltype="cf_sql_longvarchar", value=arguments.after_body );
		sp.addParam( type="in", dbvarname="@header_media_id", cfsqltype="cf_sql_bigint", value=arguments.header_media_id, null=( !arguments.header_media_id ) );
		sp.addParam( type="in", dbvarname="@bcc", cfsqltype="cf_sql_varchar", value=arguments.bcc, maxlength=500, null=( !len( arguments.bcc ) ) );
		sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id, null=( !arguments.registration_type_id ) );
		sp.addParam( type="in", dbvarname="@active", cfsqltype="cf_sql_bit", value=arguments.active );
		sp.addParam( type="in", dbvarname="@footer", cfsqltype="cf_sql_longvarchar", value=arguments.footer, null=( !len( arguments.footer ) ) );
		result = sp.execute();
		return result.getProcOutVariables().autoresponder_id;
	}
	/*
	* Gets all of the Autoresponder Information
	* @autoresponder_id The id of the Autoresponder
	*/
	public struct function AutoresponderGet(
		required numeric autoresponder_id,
		numeric event_id=0,
		string autoresponder_type="",
		string description="",
		string label="",
		numeric from_email_id=0,
		string from_email="",
		string subject="",
		string before_body="",
		string after_body="",
		numeric header_media_id=0,
		string header_filename="",
		string bcc="",
		numeric registration_type_id=0,
		string registration_type="",
		boolean active=1
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AutoresponderGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@autoresponder_id", cfsqltype="cf_sql_integer", value=arguments.autoresponder_id, variable="autoresponder_id" );
		sp.addParam( type="out", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, null=( !arguments.event_id ), variable="event_id" );
		sp.addParam( type="out", dbvarname="@autoresponder_type", cfsqltype="cf_sql_varchar", value=arguments.autoresponder_type, maxlength=50, null=( !len( arguments.autoresponder_type ) ), variable="autoresponder_type" );
		sp.addParam( type="out", dbvarname="@description", cfsqltype="cf_sql_varchar", value=arguments.description, maxlength=500, null=( !len( arguments.description ) ), variable="description" );
		sp.addParam( type="out", dbvarname="@label", cfsqltype="cf_sql_varchar", value=arguments.label, maxlength=150, null=( !len( arguments.label ) ), variable="label" );
		sp.addParam( type="out", dbvarname="@from_email_id", cfsqltype="cf_sql_bigint", value=arguments.from_email_id, null=( !arguments.from_email_id ), variable="from_email_id" );
		sp.addParam( type="out", dbvarname="@from_email", cfsqltype="cf_sql_varchar", value=arguments.from_email, maxlength=300, null=( !len( arguments.from_email ) ), variable="from_email" );
		sp.addParam( type="out", dbvarname="@subject", cfsqltype="cf_sql_varchar", value=arguments.subject, maxlength=300, null=( !len( arguments.subject ) ), variable="subject" );
		sp.addParam( type="out", dbvarname="@before_body", cfsqltype="cf_sql_longvarchar", value=arguments.before_body, null=( !len( arguments.before_body ) ), variable="before_body" );
		sp.addParam( type="out", dbvarname="@after_body", cfsqltype="cf_sql_longvarchar", value=arguments.after_body, null=( !len( arguments.after_body ) ), variable="after_body" );
		sp.addParam( type="out", dbvarname="@header_media_id", cfsqltype="cf_sql_bigint", value=arguments.header_media_id, null=( !arguments.header_media_id ), variable="header_media_id" );
		sp.addParam( type="out", dbvarname="@header_filename", cfsqltype="cf_sql_varchar", value=arguments.header_filename, maxlength=200, null=( !len( arguments.header_filename ) ), variable="header_filename" );
		sp.addParam( type="inout", dbvarname="@bcc", cfsqltype="cf_sql_varchar", value=arguments.bcc, maxlength=500, null=( !len( arguments.bcc ) ), variable="bcc" );
		sp.addParam( type="inout", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id, null=( !arguments.registration_type_id ), variable="registration_type_id" );
		sp.addParam( type="inout", dbvarname="@registration_type", cfsqltype="cf_sql_varchar", value=arguments.registration_type, maxlength=150, variable="registration_type" );
		sp.addParam( type="inout", dbvarname="@active", cfsqltype="cf_sql_bit", value=arguments.active, variable="active" );
		sp.addParam( type="out", dbvarname="@company_name", cfsqltype="cf_sql_varchar", variable="company_name" );
		sp.addParam( type="out", dbvarname="@footer", cfsqltype="cf_sql_longvarchar", variable="footer" );
		sp.addProcResult( name="log", resultset=1 );
		sp.addProcResult( name="body_html", resultset=2 );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		structAppend( data, result.getProcResultSets() );
		
		if( data.body_html.recordcount ) {
			data['before_body'] = data.body_html.before_body;
			data['after_body'] = data.body_html.after_body;
		}

		return data;
	}
	/*
	* Gets all of the Autoresponders for an Event
	* @event_id The id of the event
	* @start The row to start on
	* @results The number of results to return
	* @sort_column The column to sort by - valid values ('label','subject','from_email_id','from_email')
	* @sort_direction The direction to sort
	* @search a Keyword to filter the results on
	*/
	public struct function AutoRespondersList(
		required numeric event_id,
		numeric start=1,
		numeric results=10,
		string sort_column="a.label",
		string sort_direction="ASC",
		string search=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AutorespondersList"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start, null=( !arguments.start ) );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results, null=( !arguments.results ) );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", value=arguments.sort_column, maxlength=50, null=( !len( arguments.sort_column ) ) );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", value=arguments.sort_direction, maxlength=4, null=( !len( arguments.sort_direction ) ) );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", value=arguments.search, maxlength=200, null=( !len( arguments.search ) ) );
		sp.addProcResult( name="autoResponder", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}
	/*
	* Gets all of the Autoresponder Information by event_id, autoresponder_type, registration_type_id
	* If registration_type_id does not match then returns the default record of registration_type_id = NULL
	* @autoresponder_id The id of the Autoresponder
	*/
	public struct function AutoresponderByTypeGet(
		required numeric event_id,
		required string autoresponder_type,
		numeric autoresponder_id=0,
		string description="",
		string label="",
		numeric from_email_id=0,
		string from_email="",
		string subject="",
		string before_body="",
		string after_body="",
		numeric header_media_id=0,
		string header_filename="",
		string bcc="",
		numeric registration_type_id=0,
		string registration_type=""
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AutoresponderByTypeGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, variable="event_id" );
		sp.addParam( type="inout", dbvarname="@autoresponder_type", cfsqltype="cf_sql_varchar", value=arguments.autoresponder_type, maxlength=50, variable="autoresponder_type" );
		sp.addParam( type="inout", dbvarname="@autoresponder_id", cfsqltype="cf_sql_integer", value=arguments.autoresponder_id, null=( !arguments.autoresponder_id ), variable="autoresponder_id" );
		sp.addParam( type="inout", dbvarname="@description", cfsqltype="cf_sql_varchar", value=arguments.description, maxlength=500, null=( !len( arguments.description ) ), variable="description" );
		sp.addParam( type="inout", dbvarname="@label", cfsqltype="cf_sql_varchar", value=arguments.label, maxlength=150, null=( !len( arguments.label ) ), variable="label" );
		sp.addParam( type="inout", dbvarname="@from_email_id", cfsqltype="cf_sql_bigint", value=arguments.from_email_id, null=( !arguments.from_email_id ), variable="from_email_id" );
		sp.addParam( type="inout", dbvarname="@from_email", cfsqltype="cf_sql_varchar", value=arguments.from_email, maxlength=300, null=( !len( arguments.from_email ) ), variable="from_email" );
		sp.addParam( type="inout", dbvarname="@subject", cfsqltype="cf_sql_varchar", value=arguments.subject, maxlength=300, null=( !len( arguments.subject ) ), variable="subject" );
		sp.addParam( type="inout", dbvarname="@before_body", cfsqltype="cf_sql_longvarchar", value=arguments.before_body, null=( !len( arguments.before_body ) ), variable="before_body" );
		sp.addParam( type="inout", dbvarname="@after_body", cfsqltype="cf_sql_longvarchar", value=arguments.after_body, null=( !len( arguments.after_body ) ), variable="after_body" );
		sp.addParam( type="inout", dbvarname="@header_media_id", cfsqltype="cf_sql_bigint", value=arguments.header_media_id, null=( !arguments.header_media_id ), variable="header_media_id" );
		sp.addParam( type="inout", dbvarname="@header_filename", cfsqltype="cf_sql_varchar", value=arguments.header_filename, maxlength=200, null=( !len( arguments.header_filename ) ), variable="header_filename" );
		sp.addParam( type="inout", dbvarname="@bcc", cfsqltype="cf_sql_varchar", value=arguments.bcc, maxlength=500, null=( !len( arguments.bcc ) ), variable="bcc" );
		sp.addParam( type="inout", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id, null=( !arguments.registration_type_id ), variable="registration_type_id" );
		sp.addParam( type="inout", dbvarname="@registration_type", cfsqltype="cf_sql_varchar", value=arguments.registration_type, maxlength=150, variable="registration_type" );
		sp.addParam( type="out", dbvarname="@active", cfsqltype="cf_sql_bit", variable="active" );
		sp.addParam( type="out", dbvarname="@company_name", cfsqltype="cf_sql_varchar", variable="company_name" );
		sp.addParam( type="out", dbvarname="@footer", cfsqltype="cf_sql_longvarchar", variable="footer" );
		sp.addProcResult( name="log", resultset=1 );
		sp.addProcResult( name="body_html", resultset=2 );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		structAppend( data, result.getProcResultSets() );
		if( data.body_html.recordcount ) {
			data['before_body'] = data.body_html.before_body;
			data['after_body'] = data.body_html.after_body;
		}
		return data;
	}
}
