component extends="$base" accessors="true" {
	property name="mediaManager" setter="true" getter="true";
	/**
	* Before Action
	*/
	public void function before( rc ) {
		//JG - YOU AT LEAST NEED A COMPANY ID TO SEE A MEDIA LIST. 
		if( !getCurrentCompanyID() ){
			redirect('company.select');
		}
		super.before( rc );
		return;
	}
	/**
	* Returns a listing based on a given id
	*/
	public void function listing( rc ) {
		var params = {
			"order_index" : ( structKeyExists( rc, 'order[0][column]') ? rc['order[0][column]']:0)
			, "order_dir" : ( structKeyExists( rc, 'order[0][dir]') ? rc['order[0][dir]']:"ASC")
			, "search_value" : ( structKeyExists( rc, 'search[value]') ? rc['search[value]']:"")
			, "start_row" : ( structKeyExists( rc, 'start') ? rc.start:0)
			, "total_rows" : ( structKeyExists( rc, 'length') ? rc.length:0)
			, "draw" : ( structKeyExists( rc, 'draw') ? rc.draw:0)
			, "company_id" : rc.company_id
		};
		var data = {};
		data = getMediaManager().getCompanyMedia( argumentCollection = params );
		data['cnt'] = arrayLen(data.data);
		//create the options links
		for( var i = 1; i <= data.cnt; i++ ) {
			data['data'][i]['options'] = "<a href=""/media/edit/media_id/" & data.data[i].media_id & """><strong>Manage Media</strong> <span class=""glyphicon glyphicon-arrow-right""></span></a>";
			data['data'][i]['options'] &= " <a href=""javascript:void(0)""  class=""copy-media"" data-clipboard-text=" & data.data[i].filename & "><strong>Copy To Clipboard</strong>  <span class=""glyphicon glyphicon-share""></span></a>";
		}
		getFW().renderData( "json", data );
		request.layout = false;
	}
	/**
	-JG - THESE METHODS DO NOT EXIST, LEAVING THIS HERE FOR REFERENCE IF IN CASE WE NEED TO ADD THE SPECIFIC LISTINGS PER SESSION/EVENT ID	
	* Returns a listing based on a given id
	public any function listing( rc ) {
		var params = {
			'start' = 0,
			'length' = 10
		};
		var data = {};
		structAppend(params, rc);
		if(structKeyExists( rc, "company_id") ){
			data = getMediaManager().getCompanyMedia( argumentCollection = params );
		}
		else if( structKeyExists( rc, "event_id" ) ){
			data = getMediaManager().getEventMedia( argumentCollection = params );
		}
		else if( structKeyExists( rc, "session_id" ) ){
			data = getMediaManager().getSessionMedia( argumentCollection = params );
		}
		data['cnt'] = arrayLen(data.data);
		for( var i = 1; i <= data.cnt; i++ ) {
			data['data'][i]['options'] = "<a href=""/media/edit/media_id/" & data.data[i].media_id & """><strong>Manage Media</strong> <span class=""glyphicon glyphicon-arrow-right""></span></a>";
			data['data'][i]['options'] &= " <a href=""javascript:void(0)""  class=""copy-media"" data-clipboard-text=" & data.data[i].filename & "><strong>Copy To Clipboard</strong>  <span class=""glyphicon glyphicon-share""></span></a>";
		}
		getFW().renderData( "json", data );
		return;
	}
	*/
	/**
	* Uploads media
	*/
	public any function upload( rc ) {
		var data = rc;
		structAppend(data, getMediaManager().upload() );
		data['media_id'] = getMediaManager().save( argumentCollection=data );
		// associate the media to a company, event, session
		if( structKeyExists( rc, "company_id") || structKeyExists( rc, "event_id" ) || structKeyExists( rc, "session_id" ) || structKeyExists( rc, "venue_id" ) ) {
			getMediaManager().associate( argumentCollection=data );
		}
		structAppend( data, getMediaManager().getMedia( media_id=data.media_id ) );
		getFW().renderData( "json", lowerStruct( data ) );
		return;
	}
	/**
	* disassociate media from company, event, session
	*/
	public any function disassociate( rc ) {
		// disassociate the media to a company, event, session
		if( structKeyExists( rc, "media_id" ) && ( structKeyExists( rc, "company_id") || structKeyExists( rc, "event_id" ) || structKeyExists( rc, "session_id" ) || structKeyExists( rc, "venue_id" ) ) ) {
			getMediaManager().disassociate( argumentCollection=rc );
		}
		getFW().renderData( "json", { 'success': true } );
		return;
	}
	/**
	* I am an ajax call to get a list of media for a company
	*/
	public any function ajaxCompanyListing( rc ) {

		getFW().renderData( 'json', getmediaManager().getCompanyAggregateMediaList( company_id=getCurrentCompanyID(), event_id=getCurrentEventID(), total_rows=100 ) );
		request.layout = false;
		return;
	}
	/**
	* I associate media to from the assets library
	*/
	public any function associateassets( rc ) {
		var media_ids = [];
		var cnt = 1;
		var data = rc;
		if( structKeyExists( rc, "ids" ) ){
			media_ids = listToArray( rc.ids );
			for ( var media_id in media_ids ) {
				data.media_id = media_id;
				data.session_media_type = "";
				if( structKeyExists( rc, "types" ) && listLen( rc.types ) gte cnt ){
					if( listLast( listgetat( rc.types, cnt ), '-' ) == 'picture'){
						data.session_media_type = 'image';
					}else{
						data.session_media_type = 'file';
					}
				}
				// associate the media to a company, event, session
				if( structKeyExists( rc, "company_id") || structKeyExists( rc, "event_id" ) || structKeyExists( rc, "session_id" ) ) {
					getMediaManager().associate( argumentCollection=data );
				}
				cnt = cnt + 1;
			}
		}

		getFW().renderData( "json", {} );
		return;
	}
	/**
	* I am an ajax save a media
	*/
	public any function ajaxSave( rc ) {
		var media_id = ( structKeyExists(rc,'media_id')? rc.media_id:0);
		var media = {};

		if( val( media_id ) && structKeyExists( rc, "media_asset") && isStruct( rc.media_asset ) ){
			media = getmediaManager().getMedia( media_id );
			structAppend( media, rc.media_asset, true );
			if( structKeyExists(media, "publish") && !isdate( media.publish ) ){
				structdelete( media, "publish" );
			}
			if( structKeyExists(media, "expire") && !isdate( media.expire ) ){
				structdelete( media, "expire" );
			}

			getmediaManager().save( argumentCollection:media );
		}
		getFW().renderData( 'json', {} );
		request.layout = false;
		return;
	}
	/**
	* I am an ajax call to get a media
	*/
	public any function ajaxGet( rc ) {

		getFW().renderData( 'json', getmediaManager().getMedia( ( structKeyExists(rc,'media_id')? rc.media_id:0) ) );
		request.layout = false;
		return;
	}




}