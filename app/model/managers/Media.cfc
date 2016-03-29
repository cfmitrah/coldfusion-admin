/**
* @file  /model/managers/Media.cfc
* @author
* @description
*/
component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="mediaDAO" getter="true" setter="true";
	property name="slugManager" getter="true" setter="true";
	property name="Crypto" getter="true" setter="true";
	property name="BaseX" getter="true" setter="true";
	/**
	* Initialization Method
	*/
	public struct function init() {
		variables['path'] = expandPath(application.config.paths.media);
		// ensure the directory exists
		if( !directoryExists( variables.path ) ) {
			directoryCreate( variables.path );
		}
		return this;
	}
	/**
	* Gets Media
	*/
	public struct function getMedia( required numeric media_id ) {
		var data = getMediaDAO().mediaGet( media_id=arguments.media_id );
		var media = queryToStruct( recordset=data.result.detail, single=true );
		media['uploaded'] = "" & dateTimeFormat( media.uploaded, "mm/dd/yyyy h:mm tt" );
		media['publish'] = "" & dateTimeFormat( media.publish, "mm/dd/yyyy h:mm tt" );
		media['expire'] = "" & dateTimeFormat( media.expire, "mm/dd/yyyy h:mm tt" );
		media['logs'] = data.result.logs;
		media['tags'] = valuelist( data.result.tags.tag);
		return media;
	}
	/**
	* Uploads Media
	*/
	public struct function upload( string field_name="media", string accepted=getMediaDAO().mimetypesAllowedList() ) {
		var upload = fileUpload( getTempDirectory(), arguments.field_name, arguments.accepted, "makeunique" );
		var generated = false; // whether or not the thumbnail has been generated
		var file_separator = createObject("java", "java.lang.System").getProperty("file.separator");
		var info = {
			'original_name' = upload.serverFilename,
			'original_filename' = upload.serverFile,
			'name' = getSlugManager().generate(upload.serverFileName) & "-" & getBaseX().epoch(), // generate a friendly slug for the file
			'extension' = lCase(upload.serverFileExt),
			'path' = variables.path,
			'url' = application.config.urls.media,
			'filesize' = upload.fileSize,
			'success' = true,
			'uploaded' = dateTimeFormat(now(), "mm/dd/yyyy h:mm tt")
		};
		info['filename'] = info.name & "." & info.extension;
		info['thumbnail'] = info.name & "-thumb." & info.extension;
		// move it to the new location
		fileMove(upload.serverDirectory & file_separator & info.original_filename, info.path & info.filename);
		info['mimetype'] = fileGetMimeType(info.path & info.filename);
		info['mimetype_id'] = getMediaDAO().mimetypeGetID( info.mimetype );
		// generate a thumbnail
		if(!thumbnail(
			input=info.path & info.filename,
			output=info.path & info.thumbnail,
			height=200,
			width=200
		)){
			info['thumbnail'] = "no-thumbnail.jpg";
		}
		return info;
	}
	/**
	* Saves Media
	* @media_id The media id, if null it is added
	* @mimetype_id The mimetype of the media being added
	* @filename The name of the file
	* @thumbnail The name of the thumbnail
	* @filesize The size of the media in kilobytes
	* @label A friendly label for the media
	* @publish A date to publish the media on
	* @password An SHA-512 hashed password
	* @salt The salt used to generate the password hash
	* @downloadable Whether or not the media can be downloaded
	*/
	public numeric function save(
		numeric media_id = 0,
		required numeric mimetype_id,
		required string filename,
		required string thumbnail,
		required numeric filesize,
		string label,
		date publish,
		date expire,
		string password,
		string salt,
		boolean downloadable,
		string tags=""
	) {
		if( structKeyExists( arguments, "password" ) && len( arguments.password ) ){
			arguments.salt = getCrypto().salt();
			arguments.password = getCrypto().compute( arguments.password, arguments.salt );
		}
		arguments.media_id = getMediaDAO().mediaSet( argumentCollection=arguments );
		getMediaDAO().MediaTagsSet( arguments.media_id, arguments.tags );
		return arguments.media_id;
	}
	/**
	* Associates Media to an Element
	* @media_id The media id
	* @company_id The company id to associate
	* @event_id The event id to associate
	* @session_id The session id to asssociate
	* @session_media_type The type of session media
	* @venue_id The venue id to associate
	* @page_id The page id to associate
	*/
	public void function associate(
		required numeric media_id,
		numeric company_id,
		numeric event_id,
		numeric session_id,
		string session_media_type
		numeric venue_id,
		numeric page_id
	 ) {
		if( structKeyExists( arguments, "company_id") && isNumeric( arguments.company_id ) && arguments.company_id ){
			getMediaDAO().CompanyMediaAssociate( media_id=arguments.media_id, company_id=arguments.company_id );
		}
		if( structKeyExists( arguments, "event_id") && isNumeric( arguments.event_id ) && arguments.event_id ){
			getMediaDAO().EventMediaAssociate( media_id=arguments.media_id, event_id=arguments.event_id );
		}
		if( structKeyExists( arguments, "session_id") && structKeyExists( arguments, "session_media_type") && isNumeric( arguments.session_id ) && arguments.session_id ){
			if( session_media_type == 'file' ){
				getMediaDAO().SessionFileAssociate( media_id=arguments.media_id, session_id=arguments.session_id );
			}else if( session_media_type == 'image' ){
				getMediaDAO().SessionPhotoAssociate( media_id=arguments.media_id, session_id=arguments.session_id );
			}
		}
		if( structKeyExists( arguments, "venue_id") && isNumeric( arguments.venue_id ) && arguments.venue_id ){
			getMediaDAO().VenuePhotoAssociate( media_id=arguments.media_id, venue_id=arguments.venue_id );
		}
		if( structKeyExists( arguments, "page_id") && isNumeric( arguments.page_id ) && arguments.page_id ){
			getMediaDAO().PageMediaAssociate( media_id=arguments.media_id, page_id=arguments.page_id );
		}
		return;
	}
	/**
	* Disassociate Media to an Element
	* @media_id The media id
	* @company_id The company id to disassociate
	* @event_id The event id to disassociate
	* @session_id The session id to disassociate
	* @session_media_type The type of session media
	* @venue_id The venue id to disassociate
	( @page_id The page id to disassociate
	*/
	public void function disassociate(
		required numeric media_id,
		numeric company_id,
		numeric event_id,
		numeric session_id,
		string session_media_type,
		numeric venue_id,
		numeric page_id
	 ) {
		if( structKeyExists( arguments, "company_id") ){
			getMediaDAO().CompanyMediaDisassociate( media_id=arguments.media_id, company_id=arguments.company_id );
		}
		if( structKeyExists( arguments, "event_id") ){
			getMediaDAO().EventMediaDisassociate( media_id=arguments.media_id, event_id=arguments.event_id );
		}
		if( structKeyExists( arguments, "session_id") && structKeyExists( arguments, "session_media_type") ){
			if( session_media_type == 'file' ){
				getMediaDAO().SessionFileDisassociate( media_id=arguments.media_id, session_id=arguments.session_id );
			}else if( session_media_type == 'image' ){
				getMediaDAO().SessionPhotoDisassociate( media_id=arguments.media_id, session_id=arguments.session_id );
			}
		}
		if( structKeyExists( arguments, "venue_id") && isNumeric( arguments.venue_id ) && arguments.venue_id ){
			getMediaDAO().VenuePhotoDisassociate( media_id=arguments.media_id, venue_id=arguments.venue_id );
		}
		if( structKeyExists( arguments, "page_id") ){
			getMediaDAO().PageMediaDisassociate( media_id=arguments.media_id, page_id=arguments.page_id );
		}
		return;
	}
	/**
	* Checks to make sure all of the requested fields in given scope exist
	* @param input The full path to the file to generate a thumbnail from
	* @param output The full path to where the output file should be stored
	* @param height The height of the thumbnail
	* @param width The width
	* @param the Quality of the Thumbnail
	*/
	public boolean function thumbnail(
		required string input,
		required string output,
		numeric height=100,
		numeric width=100,
		numeric quality=1
	){
		var format = listLast(arguments.output, ".");
		var image = "";
		var dir = "";
		var thumbnail = "";
		var prefix = "";
		var pdf = "";
		var success = false;
		try {
			arguments['width'] = arguments.width ? arguments.width : "";
			arguments['height'] = arguments.height ? arguments.height : "";
			if( isImageFile( arguments.input ) ) { // the input is an image
				image = imageNew( arguments.input );
				imageResize( image, arguments.width, arguments.height, "mediumQuality" );
				imageWrite( image, arguments.output, arguments.quality, true );
				success = true;
			}
			else if( isPDFFile( arguments.input ) ){ // the input is a pdf
				dir = arguments.output.replaceAll( "\\[^\\]+$", "\\" );
				// create a unique id to use as our prefix
				// this needs to be done because we can't use the file name, as the pdf generator will strip characters
				// particularly when there are multiple periods
				prefix = createUUID();
				pdf = new com.adobe.coldfusion.Pdf();
				pdf.setAttributes({
					'source' = arguments.input,
					'destination' = dir,
					'format' = format,
					'pages' = 1,
					'imagePrefix' = prefix,
					"overwrite" = true
				});
				pdf.thumbnail(); // generate the thumbnail
				thumbnail = prefix & "_page_1." & format; // set the thumbnail name
				thumbnail(
					input=dir & thumbnail,
					output=arguments.output,
					height=arguments.height,
					width=arguments.width,
					quality=arguments.quality
				); // regenerate the thumbnail based on arguments
				fileDelete(dir & thumbnail); // delete the thumbnail
				success = true;
			}
		}
		catch(any e){
			success = false;
		}
		return success;
	}
	/**
	* Gets the company media
	*/
	public struct function getCompanyMedia( 
		required numeric company_id, 
		numeric order_index=0, 
		string order_dir="asc", 
		string search_value="", 
		numeric start_row=0, 
		numeric total_rows=10, 
		numeric draw=1
	) {
		var columns = [ 'filename','label','filesize','tags','uploaded' ];
		var params = {
			company_id : arguments.company_id,
			start : ( start_row + 1 ),
			results : arguments.total_rows,
			sort_column : columns[ order_index + 1 ],
			sort_direction : arguments.order_dir,
			search : arguments.search_value
		};
		var listing = getMediaDAO().companyMediaList( argumentCollection=params ).result.listing;
		return {
			"draw" : arguments.draw,
			"recordsTotal" : len( listing.total ) ? listing.total : 0,
			"recordsFiltered" : len( listing.total ) ? listing.total : 0,
			"data": queryToArray( listing )
		};
	}
	/**
	* Returns a parsed representation of the query
	*/
	private struct function parseListing(required query recordset){
		return {
			"recordsTotal": isDefined("arguments.recordset.total") ? arguments.recordset.total : arguments.recordset.recordCount,
			"recordsFiltered": isDefined("arguments.recordset.total") ? arguments.recordset.total : arguments.recordset.recordCount,
			"data": queryToArray(arguments.recordset)
		};
	}
	/**
	* Gets the company media
	*/
	public struct function getCompanyAggregateMediaList( required numeric company_id, required numeric event_id, numeric order_index=0, string order_dir="asc", string search_value="", numeric start_row=0, numeric total_rows=10, numeric draw=1 ) {
		var rtn = { "data"=[] };
		var params = {company_id=arguments.company_id,event_id=arguments.event_id,start=(start_row+1),results=arguments.total_rows,sort_column="",sort_direction=arguments.order_dir,search=arguments.search_value};
		var Media_List = getMediaDAO().CompanyAggregateMediaList( argumentCollection=params ).result.listing;
		var opt = "";
		queryAddColumn( Media_List, "options", [] );

		for ( var i=1; i <= Media_List.RecordCount; i++) {
			opt="";

			querySetCell(Media_List, "options", opt, i);
			arrayappend( rtn['data'], queryRowToStruct( Media_List, i, true ));
		}



		rtn['recordsTotal'] = val(Media_List.row);//qResult.RecordCount;
		rtn['recordsFiltered'] =val(Media_List.row);// qResult.RecordCount;

		return rtn;
	}

}