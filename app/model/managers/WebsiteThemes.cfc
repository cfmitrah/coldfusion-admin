/**
*
* @file  /model/managers/WebsiteThemes.cfc
* @author - JG
* @description - This will manage all Website Theming
*
*/
component output="false" displayname="WebsiteThemes" accessors="true" extends="app.model.base.Manager" {
	property name="WebsiteThemeDao" getter="true" setter="true";
	property name="mediaManager" setter="true" getter="true";
	property name="eventDAO" setter="true" getter="true";
	/**
	* save
	* This method will save the registration theme
	*/
	public void function save(
		required numeric event_id,
		string font_family_id="",
		string logo_id="",
		string logo="",
		string hdr_bkg_c="",
		string nav_bkg_c="",
		string nav_link_text_c="",
		string active_nav_link_bkg_c="",
		string active_nav_link_txt_c="",
		string btm_ban_c="",
		string btm_ban_txt_c="",
		string bkg_behind_graphic_c="",
		string btm_area_bkg_c="",
		string btm_area_standard_font_c="",
		string loc_time_icon_c="",
		string loc_time_font_c="",
		string active_step_bkg_c="",
		string frm_step_bkg_c="",
		string frm_step_font_c="",
		string btn_bkg_c="",
		string btn_font_c="",
		string hero_graphic=""
	) {
		var params = duplicate( arguments );
	 	var data = "";
	 	var media_file = "";
		var media_id = "";
		structDelete( params, 'event_id' );
	 	//if we have an logo upload it
	 	if( len( arguments.logo )){
			media_file = getMediaManager().upload( field_name="theme.logo" );
			media_id = getMediaManager().save( argumentCollection=media_file );	 		 	
			params.logo_id = media_id;
			getEventDao().EventLogoSet( event_id=arguments.event_id, media_id=media_id );
			getWebsiteThemeDao().RegistrationThemeMediaSet( event_id=arguments.event_id, element_type='logo_id', media_id=media_id );
			structDelete( params, "logo" );
	 	}
	 	if( len( arguments.hero_graphic ) ) {
		 	media_file =getMediaManager().upload( field_name="theme.hero_graphic" );
		 	media_id = getMediaManager().save( argumentCollection=media_file );
		 	getEventDao().EventHeroSet( event_id=arguments.event_id, media_id=media_id );
		 	structDelete( params, "hero_graphic" );
		}
		 
	 	data = serializeJSON( lowerStruct( params ) );
	 	getWebsiteThemeDao().RegistrationThemeElementsSet( event_id=arguments.event_id, elements_JSON=data );
	 	getCacheManager().purgeEventConfigCache( getSessionManageUserFacade().getValue('current_event_id') );
	 	return;
	}	
	/**
	* getRegistrationTheme
	* This method will get the registration theme
	*/
	public struct function getRegistrationTheme( required numeric event_id ) {
		var data = getWebsiteThemeDao().RegistrationThemeElementsGet( argumentCollection=arguments ).result;
		var ret = {};
		var media = queryToArray( recordset=data.media );

		ret['fonts'] = queryToArray( recordset=data.fonts );
		ret['theme'] = queryToStruct( recordset=data.theme ); 
		ret['media'] = {'logo_id' : "",'filename' : ""};
		ret['Hero'] = getEventDAO().EventHeroGet( arguments.event_id );
		if( arrayLen( media ) ){
			ret.media.logo_id = media[1].media_id;
			ret.media.filename = media[1].filename;
		}
		return ret;
	}
	/**
	* getFonts
	* This method will get all of the fonts
	*/
	public struct function getFonts() {
		var ret = getWebsiteThemeDao().FontFamiliesGet().result.fonts;
		return queryToStruct( recordset=ret );
	}
	/**
	* getFonts
	* This method will get all of the fonts
	*/
	public struct function getThemesTypes() {
		var ret = getWebsiteThemeDao().RegistrationThemeElementTypesGet().result.types;
		return queryToStruct( recordset=ret );
	}
	/**
	* getFonts
	* This method will get all of the fonts
	*/
	public struct function setDefaults( required struct data ){
		//get the defaulted keys from the db
		var defaults = getThemesTypes().element_type;
		var defaults_cnt = arrayLen( defaults );
		var data_cnt = arrayLen( data.element_type );
		var ret = {};
		var tmp = [];
		//lowercase all keys
		for( var i=1; i<=data_cnt;i++){ arrayAppend( tmp, lCase( data.element_type[i])); }		
		//run a match on the keys/values and set the matched values
		for(var i=1; i<=defaults_cnt;i++){
			if( arrayContains( tmp, defaults[i] )){
				ret[ defaults[i] ] = data.value[ arrayFindNoCase( tmp, defaults[i] ) ];
			}
			else{
				ret[ defaults[i] ] = '';	
			}			
		}
		return ret;		
	}
	/**
	* 
	*/
	public struct function getPreLoaded( required string theme_name ) {
		var themes = {};
		var rtn = {};
		themes['beach_sunset'] = {
			'hdr_bkg_c': "fff",
			'nav_bkg_c': "8c4646",
			'nav_link_text_c': "fff",
			'active_nav_link_bkg_c': "d96459",
			'active_nav_link_txt_c': "fff",
			'btm_ban_c': "f2ae72",
			'btm_ban_txt_c': "fff",
			'bkg_behind_graphic_c': "588c73",
			'btm_area_bkg_c': "f3efda",
			'btm_area_standard_font_c': "333",
			'loc_time_icon_c': "8c4646",
			'loc_time_font_c': "a69644",
			'active_step_bkg_c': "8c4646",
			'frm_step_bkg_c': "588c73",
			'frm_step_font_c': "fff",
			'btn_bkg_c': "8c4646",
			'btn_font_c': "fff",
			'stbc': "588c73",
			'stfc': "fff",
			'sbbc': "fff",
			'sbfc': " 333",
			'dsrh_font_c': "000"

		};

		themes['coffee_shop'] = {
			'hdr_bkg_c': "fff",
			'nav_bkg_c': "8c6954",
			'nav_link_text_c': "fff",
			'active_nav_link_bkg_c': "bfaf80",
			'active_nav_link_txt_c': "fff",
			'btm_ban_c': "59323c",
			'btm_ban_txt_c': "fff",
			'bkg_behind_graphic_c': "260126",
			'btm_area_bkg_c': "fbf2d9",
			'btm_area_standard_font_c': "333",
			'loc_time_icon_c': "260126",
			'loc_time_font_c': "8c6954",
			'active_step_bkg_c': "59323c",
			'frm_step_bkg_c': "bfaf80",
			'frm_step_font_c': "fff",
			'btn_bkg_c': "59323c",
			'btn_font_c': "fff",
			'stbc': " 260126",
			'stfc': "fff",
			'sbbc': "fff",
			'sbfc': " 333",
			'dsrh_font_c': "000"
		};

		themes['electric_night'] = {
			'hdr_bkg_c': "fff",
			'nav_bkg_c': "1f1f1f",
			'nav_link_text_c': "fff",
			'active_nav_link_bkg_c': "00ccd6",
			'active_nav_link_txt_c': "fff",
			'btm_ban_c': "ffd900",
			'btm_ban_txt_c': " 000",
			'bkg_behind_graphic_c': "1f1f1f",
			'btm_area_bkg_c': "efefef",
			'btm_area_standard_font_c': " 333",
			'loc_time_icon_c': "00ccd6",
			'loc_time_font_c': "1f1f1f",
			'active_step_bkg_c': "00ccd6",
			'frm_step_bkg_c': "424242",
			'frm_step_font_c': "fff",
			'btn_bkg_c': "00ccd6",
			'btn_font_c': "fff",
			'stbc': "1f1f1f",
			'stfc': "fff",
			'sbbc': "fff",
			'sbfc': " 333",
			'dsrh_font_c': "000"
		};

		themes['jungle_safari'] = {
			'hdr_bkg_c': "fff",
			'nav_bkg_c': "4d6684",
			'nav_link_text_c': "fff",
			'active_nav_link_bkg_c': "e74700",
			'active_nav_link_txt_c': "fff",
			'btm_ban_c': "3d3d3d",
			'btm_ban_txt_c': "fff",
			'bkg_behind_graphic_c': "83aa30",
			'btm_area_bkg_c': "efefef",
			'btm_area_standard_font_c': "333",
			'loc_time_icon_c': "e74700",
			'loc_time_font_c': "1f1f1f",
			'active_step_bkg_c': "1499d3",
			'frm_step_bkg_c': "424242",
			'frm_step_font_c': "fff",
			'btn_bkg_c': "1499d3",
			'btn_font_c': "fff",
			'stbc': "83aa30",
			'stfc': "fff",
			'sbbc': "fff",
			'sbfc': " 333",
			'dsrh_font_c': "000"
		};

		themes['to_the_point'] = {
			'hdr_bkg_c': "fff",
			'nav_bkg_c': "021542",
			'nav_link_text_c': "fff",
			'active_nav_link_bkg_c': "ff534b",
			'active_nav_link_txt_c': "fff",
			'btm_ban_c': "aaaaaa",
			'btm_ban_txt_c': "fff",
			'bkg_behind_graphic_c': "000",
			'btm_area_bkg_c': "efefef",
			'btm_area_standard_font_c': "333",
			'loc_time_icon_c': "ff534b",
			'loc_time_font_c': "1f1f1f",
			'active_step_bkg_c': "0241e2",
			'frm_step_bkg_c': "aaaaaa",
			'frm_step_font_c': "fff",
			'btn_bkg_c': "0241e2",
			'btn_font_c': "fff",
			'stbc': " 000",
			'stfc': "fff",
			'sbbc': "fff",
			'sbfc': " 333",
			'dsrh_font_c': "000"
		};

		themes['blank_canvas'] = {
			'hdr_bkg_c': "1e3866",
			'nav_bkg_c': "ffffff",
			'nav_link_text_c': "383838",
			'active_nav_link_bkg_c': "00aeff",
			'active_nav_link_txt_c': "ffffff",
			'btm_ban_c': "1e3866",
			'btm_ban_txt_c': "ffffff",
			'bkg_behind_graphic_c': "1a1a1a",
			'btm_area_bkg_c': "f0f0f0",
			'btm_area_standard_font_c': "666",
			'loc_time_icon_c': "008f56",
			'loc_time_font_c': "383838",
			'active_step_bkg_c': "1e3866",
			'frm_step_bkg_c': "6b6b6b",
			'frm_step_font_c': "ffffff",
			'btn_bkg_c': "008f56",
			'btn_font_c': "ffffff",
			'stbc': "008f56",
			'stfc': "ffffff",
			'sbbc': "f0f0f0",
			'sbfc': "666",
			'dsrh_font_c': "1e3866"
		};
		if( structKeyExists( themes, arguments.theme_name ) ) {
			rtn = themes[ arguments.theme_name ];
		}else {
			rtn = themes[ 'blank_canvas' ];
		}
		return rtn;
	}
	
}