/**
*
* I am the DAO for the Venue object
* @file  /model/dao/Venue.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {
	/*
	* Sets a venue address and creates the venue to address association
	* @venue_id The venue id
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
	*/
	public numeric function VenueAddressSet(
		required numeric venue_id,
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
		boolean verified=false
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenueAddressSet"
		});
		trim_fields( arguments ); // trim all of the inputs
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
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
		result = sp.execute();
		return result.getProcOutVariables().address_id;
	}
	/*
	* Gets a Venue's Details by a slug
	* @slug The Slug for the Venue
	*/
	public struct function VenueBySlugGet( required string slug ) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenueBySlugGet"
		});
		trim_fields( arguments ); // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@slug", cfsqltype="cf_sql_varchar", value=arguments.slug, maxlength=300, variable="slug" );
		sp.addParam( type="out", dbvarname="@venue_id", cfsqltype="cf_sql_integer", variable="venue_id" );
		sp.addParam( type="out", dbvarname="@company_id", cfsqltype="cf_sql_integer", variable="company_d" );
		sp.addParam( type="out", dbvarname="@venue_name", cfsqltype="cf_sql_varchar", variable="venue_name" );
		sp.addParam( type="out", dbvarname="@url", cfsqltype="cf_sql_varchar", variable="url" );
		sp.addParam( type="out", dbvarname="@slug_id", cfsqltype="cf_sql_bigint", variable="slug_id" );
		sp.addParam( type="out", dbvarname="@address_id", cfsqltype="cf_sql_bigint", variable="address_id" );
		sp.addParam( type="out", dbvarname="@address_type", cfsqltype="cf_sql_varchar", variable="address_type" );
		sp.addParam( type="out", dbvarname="@address_1", cfsqltype="cf_sql_varchar", variable="address_1" );
		sp.addParam( type="out", dbvarname="@address_2", cfsqltype="cf_sql_varchar", variable="address_2" );
		sp.addParam( type="out", dbvarname="@city", cfsqltype="cf_sql_varchar", variable="city" );
		sp.addParam( type="out", dbvarname="@region_code", cfsqltype="cf_sql_varchar", variable="region_code" );
		sp.addParam( type="out", dbvarname="@postal_code", cfsqltype="cf_sql_varchar", variable="postal_code" );
		sp.addParam( type="out", dbvarname="@country_code", cfsqltype="cf_sql_varchar", variable="country_code" );
		sp.addParam( type="out", dbvarname="@latitude", cfsqltype="cf_sql_decimal", variable="latitude" );
		sp.addParam( type="out", dbvarname="@longitude", cfsqltype="cf_sql_decimal", variable="longitude" );
		sp.addParam( type="out", dbvarname="@verified", cfsqltype="cf_sql_decimal", variable="verified" );
		sp.addParam( type="out", dbvarname="@phone_id", cfsqltype="cf_sql_bigint", variable="phone_id" );
		sp.addParam( type="out", dbvarname="@phone_type", cfsqltype="cf_sql_varchar", variable="phone_type" );
		sp.addParam( type="out", dbvarname="@phone_number", cfsqltype="cf_sql_varchar", variable="phone_number" );
		sp.addParam( type="out", dbvarname="@extension", cfsqltype="cf_sql_varchar", variable="extension" );
		sp.addProcResult( name="photos", resultset=1 );
		sp.addProcResult( name="logs", resultset=2 );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
        structAppend( data, result.getProcOutVariables() );
        structAppend( data, result.getProcResultSets() );
		return data;
	}
	/*
	* Sets a Venues Information
	* @venue_name The name of the venue
	* @url A url of the venue
	* @company_id A company to associate the venue to
	* @slug A slug for the venue
	*/
	public numeric function VenueCreate(
		required string venue_name,
		string url="",
		numeric company_id=0,
		required string slug
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenueCreate"
		});
		trim_fields( arguments ); // trim all of the inputs
		sp.addParam( type="in", dbvarname="@venue_name", cfsqltype="cf_sql_varchar", maxlength=150, value=arguments.venue_name );
		sp.addParam( type="in", dbvarname="@url", cfsqltype="cf_sql_varchar", maxlength=300, value=arguments.url, null=( !len( arguments.url ) ) );
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id, null=( !arguments.company_id ) );
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", maxlength=300, value=arguments.slug );
		sp.addParam( type="inout", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id, variable="venue_id", null=( !arguments.venue_id ) );
		result = sp.execute();
		return result.getProcOutVariables().venue_id;
	}
	/*
	* Gets a Venue's Details
	* @venue_id The id of the venue
	*/
	public struct function VenueGet( required numeric venue_id ) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenueGet"
		});
		sp.addParam( type="inout", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id, variable="venue_id" );
		sp.addParam( type="out", dbvarname="@company_id", cfsqltype="cf_sql_integer", variable="company_d" );
		sp.addParam( type="out", dbvarname="@venue_name", cfsqltype="cf_sql_varchar", variable="venue_name" );
		sp.addParam( type="out", dbvarname="@url", cfsqltype="cf_sql_varchar", variable="url" );
		sp.addParam( type="out", dbvarname="@slug_id", cfsqltype="cf_sql_bigint", variable="slug_id" );
		sp.addParam( type="out", dbvarname="@slug", cfsqltype="cf_sql_varchar", variable="slug" );
		sp.addParam( type="out", dbvarname="@address_id", cfsqltype="cf_sql_bigint", variable="address_id" );
		sp.addParam( type="out", dbvarname="@address_type", cfsqltype="cf_sql_varchar", variable="address_type" );
		sp.addParam( type="out", dbvarname="@address_1", cfsqltype="cf_sql_varchar", variable="address_1" );
		sp.addParam( type="out", dbvarname="@address_2", cfsqltype="cf_sql_varchar", variable="address_2" );
		sp.addParam( type="out", dbvarname="@city", cfsqltype="cf_sql_varchar", variable="city" );
		sp.addParam( type="out", dbvarname="@region_code", cfsqltype="cf_sql_varchar", variable="region_code" );
		sp.addParam( type="out", dbvarname="@postal_code", cfsqltype="cf_sql_varchar", variable="postal_code" );
		sp.addParam( type="out", dbvarname="@country_code", cfsqltype="cf_sql_varchar", variable="country_code" );
		sp.addParam( type="out", dbvarname="@latitude", cfsqltype="cf_sql_decimal", variable="latitude" );
		sp.addParam( type="out", dbvarname="@longitude", cfsqltype="cf_sql_decimal", variable="longitude" );
		sp.addParam( type="out", dbvarname="@verified", cfsqltype="cf_sql_decimal", variable="verified" );
		sp.addParam( type="out", dbvarname="@phone_id", cfsqltype="cf_sql_bigint", variable="phone_id" );
		sp.addParam( type="out", dbvarname="@phone_type", cfsqltype="cf_sql_varchar", variable="phone_type" );
		sp.addParam( type="out", dbvarname="@phone_number", cfsqltype="cf_sql_varchar", variable="phone_number" );
		sp.addParam( type="out", dbvarname="@extension", cfsqltype="cf_sql_varchar", variable="extension" );
		sp.addProcResult( name="locations", resultset=1 );
		sp.addProcResult( name="photos", resultset=2 );
		sp.addProcResult( name="logs", resultset=3 );
		result = sp.execute();
		data['prefix'] = result.getPrefix();
        structAppend( data, result.getProcOutVariables() );
        structAppend( data, result.getProcResultSets() );
		return data;
	}
	/*
	* Gets a venue's id by the slug
	* @slug The Slug for the Venue
	*/
	public numeric function VenueIdBySlugGet( required string slug ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenueBySlugGet"
		});
		trim_fields( arguments ); // trim all of the inputs
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", value=arguments.slug, maxlength=300 );
		sp.addParam( type="out", dbvarname="@venue_id", cfsqltype="cf_sql_integer", variable="venue_id" );
		result = sp.execute();
		return result.getProcOutVariables().venue_id;
	}
	/*
	* Creates a venue log entry
	* @venue_id The id of the venue
	* @user_id The id of the user
	* @action The type of action performed on the venue
	* @message (optional) A message to store along w/ the log entry
	* @ip (optional) The IP Address where the action was initiated from
	*/
	public numeric function VenueLogSet(
		required numeric venue_id,
		required numeric user_id,
		required string action,
		string message="",
		string ip=""
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenueLogSet"
		});
		trim_fields( arguments ); // trim all of the inputs
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		sp.addParam( type="in", dbvarname="@user_id", cfsqltype="cf_sql_integer", value=arguments.user_id );
		sp.addParam( type="in", dbvarname="@action", cfsqltype="cf_sql_varchar", value=arguments.action, maxlength=50 );
		sp.addParam( type="in", dbvarname="@message", cfsqltype="cf_sql_varchar", value=arguments.message, maxlength=500, null=( !len( arguments.message ) ) );
		sp.addParam( type="in", dbvarname="@ip", cfsqltype="cf_sql_varchar", value=arguments.ip, maxlength=40, null=( !len( arguments.ip ) ) );
		sp.addParam( type="out", dbvarname="@log_id", cfsqltype="cf_sql_bigint", variable="log_id" );
		result = sp.execute();
		return result.getProcOutVariables().log_id;
	}
	/*
	* Gets the Venues logs
	* @venue_id The id of the venue
	*/
	public struct function VenueLogsGet( required numeric venue_id ){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenueLogsGet"
		});
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		sp.addProcResult( name="logs", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().logs
		};
	}
	/*
	* Sets a venue phone and creates the venue to phone association
	* @venue_id The venue id
	* @phone_id (optional) The id of the phone if updating, 0 means add
	* @phone_type (optional) The phone type
	* @phone_number The phone number
	* @extension (optional) An extension for the phone
	*/
	public numeric function VenuePhoneSet(
		required numeric venue_id,
		numeric phone_id=0,
		required string phone_number,
		string extension=""
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenuePhoneSet"
		});
		trim_fields( arguments ); // trim all of the inputs
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		sp.addParam( type="inout", dbvarname="@phone_id", cfsqltype="cf_sql_bigint", value=arguments.phone_id, null=( !arguments.address_id ), variable="address_id" );
		sp.addParam( type="in", dbvarname="@phone_type", cfsqltype="cf_sql_varchar", value=arguments.phone_type, maxlength=50 );
		sp.addParam( type="in", dbvarname="@phone_number", cfsqltype="cf_sql_varchar", value=arguments.phone_number.replaceAll("[^0-9]+", ""), maxlength=15 );
		sp.addParam( type="in", dbvarname="@extension", cfsqltype="cf_sql_varchar", value=arguments.extension, maxlength=10, null=( !len( arguments.extension ) ) );
		result = sp.execute();
		return result.getProcOutVariables().phone_id;
	}
	/*
	* Get's all of the phone numbers associated to a venue
	* @venue_id The venue id
	*/
	public struct function VenuePhonesGet( required numeric venue_id ){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenuePhonesGet"
		});
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		sp.addProcResult( name="phones", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().phones
		};
	}
	/*
	* Creates or Updates a Venue Photo / Media Item and Returns the Media ID
	* @venue_id The venue id
	* @media_id The media id, if null it is added
	* @mimetype_id The mimetype of the media being added
	* @filename The name of the file
	* @thumbnail The name of the thumbnail
	* @filesize The size of the media in kilobytes
	* @label A friendly label for the media
	* @publish A date to publish the media on
	* @expire A date to expire the media
	*/
	public numeric function VenuePhotoSet(
		required numeric venue_id,
		numeric media_id = 0,
		required numeric mimetype_id,
		required string filename,
		required string thumbnail,
		required numeric filesize,
		string label,
		date publish,
		date expire
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenuePhotoSet"
		});
		trim_fields( arguments );
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addParam( type="inout", dbvarname="@media_id", cfsqltype="cf_sql_bigint", value=arguments.media_id, null=( !arguments.media_id ), variable="media_id" );
		sp.addParam( type="in", dbvarname="@mimetype_id", cfsqltype="cf_sql_integer", value=arguments.mimetype_id );
		sp.addParam( type="in", dbvarname="@filename", cfsqltype="cf_sql_varchar", maxlength=200, value=arguments.filename );
		sp.addParam( type="in", dbvarname="@thumbnail", cfsqltype="cf_sql_varchar", maxlength=200, value=arguments.thumbnail );
		sp.addParam( type="in", dbvarname="@filesize", cfsqltype="cf_sql_integer", value=arguments.filesize);
		if( structKeyExists( arguments, "label" ) ) {
			sp.addParam( type="in", dbvarname="@label", cfsqltype="cf_sql_varchar", maxlength=200, value=arguments.label, null=( !len( arguments.label ) ) );
		}
		if( structKeyExists( arguments, "publish" ) ) {
			sp.addParam( type="in", dbvarname="@publish", cfsqltype="cf_sql_timestamp", value=arguments.publish );
		}
		if( structKeyExists( arguments, "expire" ) ) {
			sp.addParam( type="in", dbvarname="@expire", cfsqltype="cf_sql_timestamp", value=arguments.expire );
		}
		result = sp.execute();
		return result.getProcOutVariables().media_id;
	}
	/*
	* Gets all of the Venues Photos
	* @venue_id The venue id
	*/
	public struct function VenuePhotosGet( required numeric venue_id ){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenuePhotosGet"
		});
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		sp.addProcResult( name="photos", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().photos
		};
	}
	/*
	* Gets all of the photos for a venue, with searching / paging / sorting
	* @venue_id The venue id
	* @start The row to start at
	* @results The number of results to get
	* @sort_column The column to sort on
	* @sort_direction The direction to sort the results
	* @search A string to filter the results
	*/
	public struct function VenuePhotosList(
		required numeric venue_id,
		numeric start=1,
		numeric results=10,
		string sort_column="uploaded",
		string sort_direction="DESC",
		string search=""
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenuePhotosList"
		});
		trim_fields( arguments ); // trim all of the inputs
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", maxlength=50, value=arguments.sort_column );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", maxlength=4, value=arguments.sort_direction );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", maxlength=200, value=arguments.search, null=( !len( arguments.search ) ) );
		sp.addProcResult( name="photos", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().photos
		};
	}
	/*
	* Gets the current max sort value for the photos
	* @venue_id The venue id
	*/
	public numeric function VenuePhotosMaxSortGet( required numeric venue_id ){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenuePhotosMaxSortGet"
		});
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		sp.addParam( type="out", dbvarname="@sort", cfsqltype="cf_sql_integer", variable="sort" );
		result = sp.execute();
		return result.getProcOutVariables().sort;
	}
	/*
	* Sets a Venues Information
	* @venue_id The id of the venue
	* @venue_name The name of the venue
	* @url A url of the venue
	* @company_id A company to associate the venue to
	* @slug A slug for the venue
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
	public struct function VenueSet(
		// venue details
		required numeric venue_id,
		required string venue_name,
		string url="",
		numeric company_id=0,
		required string slug,
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
		numeric phone_id=0,
		string string phone_number="",
		string extension=""
	) {
		var sp = new StoredProc();
		var result = {};
		var data = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenueSet"
		});
		trim_fields( arguments ); // trim all of the inputs
		// venue details
		sp.addParam( type="inout", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id, null=( !arguments.venue_id ), variable="venue_id" );
		sp.addParam( type="in", dbvarname="@venue_name", cfsqltype="cf_sql_varchar", maxlength=150, value=arguments.venue_name );
		sp.addParam( type="in", dbvarname="@url", cfsqltype="cf_sql_varchar", maxlength=300, value=arguments.url, null=( !len( arguments.url ) ) );
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id, null=( !arguments.company_id ) );
		// slug
		sp.addParam( type="out", dbvarname="@slug_id", cfsqltype="cf_sql_bigint", variable="slug_id" );
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", maxlength=300, value=arguments.slug );
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
		result = sp.execute();
		data['prefix'] = result.getPrefix();
        structAppend( data, result.getProcOutVariables() );
		return data;
	}
	/**
	* Gets a List of Venues
	* @start What row do you want your results to sart on
	* @results How many results do you want to return max 100
	* @sort_column The column to sort on
	* @sort_direction sort direction 'ASC',
	* @search Search string to filter the results
	* @company_id The ID of the company that you want a list of Venues for
	*/
	public struct function VenuesList(
		numeric start=1,
		numeric results=100,
		string sort_column="venue_name",
		string sort_direction="ASC",
		string search="",
		numeric company_id=0
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenuesList"
		});
		trim_fields( arguments ); // trim all of the inputs
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", maxlength=50, value=arguments.sort_column );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", maxlength=4, value=arguments.sort_direction );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", maxlength=200, value=arguments.search, null=( !len(arguments.search) ) );
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id, null=( !arguments.company_id ) );
		sp.addProcResult( name="venues", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().venues
		};
	}
	/**
	* I check to see if an venue slug exists for an event
	* @event_id The ID of the event that you are checking the venue slug for
	* @slug The slug that you are checking
	*/
	public boolean function VenueSlugExists( required numeric venue_id, required string slug ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenueSlugExists"
		});
		trim_fields( arguments );
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", maxlength=300, value=arguments.slug );
		sp.addParam( type="out", dbvarname="@in_use", cfsqltype="cf_sql_bit", variable="exists" );
		result = sp.execute();
		return result.getProcOutVariables().exists;
	}
	/*
	* Gets all of the venue locations associated to an venue
	* @venue_id The venue id
	*/
	public struct function VenueLocationsGet( required numeric venue_id ){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenueLocationsGet"
		});
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		sp.addProcResult( name="venues", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().venues
		};
	}
	/*
	* Gets all of the venue locations associated to an venue w/ paging, sorting, searching
	* @venue_id The venue id
	* @start The row to start at
	* @results The number of results to get
	* @sort_column The column to sort on
	* @sort_direction The direction to sort the results
	* @search A string to filter the results
	*/
	public struct function VenueLocationsList(
		required numeric venue_id,
		numeric start=1,
		numeric results=10,
		string sort_column="location_name",
		string sort_direction="DESC",
		string search=""
	){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenueLocationsList"
		});
		trim_fields( arguments ); // trim all of the inputs
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", maxlength=50, value=arguments.sort_column );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", maxlength=4, value=arguments.sort_direction );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", maxlength=200, value=arguments.search, null=( !len(arguments.search) ) );
		sp.addProcResult( name="venues", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().venues
		};
	}
	/*
	* Gets the current max sort value for the venue location
	* @venue_id The venue id
	*/
	public numeric function VenueLocationsMaxSortGet( required numeric venue_id ){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenueLocationsMaxSortGet"
		});
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		sp.addParam( type="out", dbvarname="@sort", cfsqltype="cf_sql_integer", variable="sort" );
		result = sp.execute();
		return result.getProcOutVariables().sort;
	}
	/*
	* Adds a Location to an Venue
	* @location_id The location id, 0 means add
	* @venue_id The venue id
	* @location_name The name of the location
	* @slug A slug for the location
	* @sort The order in which to sort the venue for the event
	*/
	public numeric function VenueLocationSet(
		numeric location_id=0,
		required numeric venue_id,
		required string location_name,
		required string slug,
		numeric sort=0
	){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenueLocationSet"
		});
		sp.addParam( type="inout", dbvarname="@location_id", cfsqltype="cf_sql_integer", value=arguments.location_id, null=( !arguments.location_id), variable="location_id" );
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		sp.addParam( type="in", dbvarname="@location_name", cfsqltype="cf_sql_varchar", value=arguments.location_name, maxlength=200 );
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", value=arguments.slug, maxlength=300 );
		sp.addParam( type="in", dbvarname="@sort", cfsqltype="cf_sql_integer", value=arguments.sort, null=( !arguments.sort ) );
		result = sp.execute();
		return result.getProcOutVariables().location_id;
	}
	/*
	* Removes a Venue to an Event
	* @location_id The location_ id
	* @venue_id The venue id
	*/
	public void function VenueLocationRemove( required numeric location_id, required numeric venue_id ){
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "VenueLocationRemove"
		});
		sp.addParam( type="in", dbvarname="@location_id", cfsqltype="cf_sql_integer", value=arguments.location_id );
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		sp.execute();
		return;
	}
	/*
	* Gets a List of Venues
	* @company_id The company id that you want a list of Venues for
	*/
	public struct function CompanyVenuesGet( required numeric company_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "CompanyVenuesGet"
		});
		trim_fields( arguments ); // trim all of the inputs
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addProcResult( name="venues", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().venues
		};
	}
	/*
	* Gets a List of Venues
	* @company_id The company id that you want a list of Venues for
	* @start What row do you want your results to sart on
	* @results How many results do you want to return max 100
	* @sort_column The column to sort on
	* @sort_direction sort direction 'ASC',
	* @search Search string to filter the results
	*/
	public struct function CompanyVenuesList(
		required numeric company_id,
		numeric start=1,
		numeric results=10,
		string sort_column="venue_name",
		string sort_direction="ASC",
		string search=""
	) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "CompanyVenuesList"
		});
		trim_fields( arguments ); // trim all of the inputs
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", maxlength=50, value=arguments.sort_column );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", maxlength=4, value=arguments.sort_direction );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", maxlength=200, value=arguments.search, null=( !len(arguments.search) ) );
		sp.addParam( type="in", dbvarname="@company_id", cfsqltype="cf_sql_integer", value=arguments.company_id, null=( !arguments.company_id ) );
		sp.addProcResult( name="venues", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().venues
		};
	}
	/*
	* Adds a Venue to an Event
	* @event_id The event id
	* @venue_id The venue id
	* @sort The order in which to sort the venue for the event
	*/
	public void function EventVenueAdd( required numeric event_id, required numeric venue_id, numeric sort=0 ){
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventVenueAdd"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		sp.addParam( type="in", dbvarname="@sort", cfsqltype="cf_sql_integer", value=arguments.sort );
		sp.execute();
		return;
	}
	/*
	* Removes a Venue to an Event
	* @event_id The event id
	* @venue_id The venue id
	*/
	public void function EventVenueRemove( required numeric event_id, required numeric venue_id ){
		var sp = new StoredProc();
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventVenueRemove"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@venue_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		sp.execute();
		return;
	}
	/*
	* Gets all of the venues associated to an event
	* @event_id The event id
	*/
	public struct function EventVenuesGet( required numeric event_id ){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventVenuesGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="venues", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().venues
		};
	}
	/*
	* Gets the current max sort value for the event venues
	* @event_id The event id
	*/
	public numeric function EventVenuesMaxSortGet( required numeric event_id ){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventVenuesMaxSortGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="out", dbvarname="@sort", cfsqltype="cf_sql_integer", variable="sort" );
		result = sp.execute();
		return result.getProcOutVariables().sort;
	}
	/*
	* Gets all of the venue locations associated to an Events Venues
	* @venue_id The venue id
	*/
	public struct function EventVenueLocationsGet( required numeric venue_id ){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventVenueLocationsGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.venue_id );
		sp.addProcResult( name="venues", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().venues
		};
	}
	/*
	* Gets all of the venue locations associated to an Events Venues w/ paging, sorting, searching
	* @event_id The event id
	* @start The row to start at
	* @results The number of results to get
	* @sort_column The column to sort on
	* @sort_direction The direction to sort the results
	* @search A string to filter the results
	*/
	public struct function EventVenueLocationsList(
		required numeric venue_id,
		numeric start=1,
		numeric results=10,
		string sort_column="venue_name",
		string sort_direction="DESC",
		string search=""
	){
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "EventVenueLocationsList"
		});
		trim_fields( arguments ); // trim all of the inputs
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@start", cfsqltype="cf_sql_integer", value=arguments.start );
		sp.addParam( type="in", dbvarname="@results", cfsqltype="cf_sql_integer", value=arguments.results );
		sp.addParam( type="in", dbvarname="@sort_column", cfsqltype="cf_sql_varchar", maxlength=50, value=arguments.sort_column );
		sp.addParam( type="in", dbvarname="@sort_direction", cfsqltype="cf_sql_varchar", maxlength=4, value=arguments.sort_direction );
		sp.addParam( type="in", dbvarname="@search", cfsqltype="cf_sql_varchar", maxlength=200, value=arguments.search, null=( !len(arguments.search) ) );
		sp.addProcResult( name="venues", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().venues
		};
	}
}