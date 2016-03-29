component extends="$base" accessors="true" {
	property name="WebsiteThemesManager" setter="true" getter="true";
	property name="eventsManager" setter="true" getter="true";
	property name="Crypto" setter="true" getter="true";

	public void function before( rc ) {
		rc.sidebar = "sidebar.event.details";
		if( !getSessionManageUserFacade().getCurrentCompanyID() ){
			redirect('company.select');
		}
		if( structKeyExists( rc, "event_id") && isNumeric( rc.event_id ) && rc.event_id gt 0 ){
			getSessionManageUserFacade().setValue( 'current_event_id', rc.event_id );
		}
		super.before( rc );
		return;
	}
	//PAGE VIEWS START
	public void function default( rc ) {
		//get the font data for the select
		var fonts = getWebsiteThemesManager().getFonts();
		//grab all them data
		var theme_data = getWebsiteThemesManager().getRegistrationTheme( event_id=rc.event_id );
		var cfrequest = {};
		rc['event_details'] = getEventsManager().getEventDetails( event_id=rc.event_id, company_id=rc.company_id ).details;
		//set defaults for theme data
		rc['theme'] = getWebsiteThemesManager().setDefaults( theme_data.theme );
		rc['theme']['hero'] = theme_data.hero;
		if( structKeyExists( rc, 'start_theme' ) ) {
			structAppend( rc['theme'], getWebsiteThemesManager().getPreLoaded( rc.start_theme ) );
		}
		//render selects
		rc['font_opts'] = getFormUtilities().buildOptionList(
			values = fonts.font_family_id,
			display = fonts.value,
			selected = arrayLen( theme_data.fonts ) ? theme_data.fonts[1].font_family_id : 0
		);
		rc['media'] = theme_data.media;
		structAppend( rc, {'tab':"themes"}, false );
		cfrequest = {
			'theme_template_url':buildURL("websiteThemes.themeTemplate"),
			'theme_a': rc['theme']['nav_bkg_c'],
			'theme_b': rc['theme']['active_nav_link_bkg_c'],
			'theme_c': rc['theme']['bkg_behind_graphic_c'],
			'theme_d': rc['theme']['btm_ban_c'],
			'theme_e': rc['theme']['btm_area_bkg_c']
		};
		
	
		getCfStatic()
			.includeData( cfrequest )
			.include( "/css/plugins/colorpicker/colorpicker.css" )
			.include( "/js/plugins/colorpicker/colorpicker.js" )
			.include( "/js/pages/websiteThemes/create.js" )
			.include( "/css/pages/websiteThemes/edit.css" )
			.include( "/css/pages/websiteThemes/start.css" );
		return;	
	}
	//PAGE VIEWS END
	//PAGE PROCESSING START
	public void function doSave( rc ) {
		if( structKeyExists( rc, "theme") && isStruct( rc.theme ) ){
			getWebsiteThemesManager().save( argumentCollection=rc.theme );
			addSuccessAlert( 'The theme was successfully saved.' );
			redirect( action="websiteThemes.default" );
		}
		redirect("websiteThemes.default");
		return;
	}
	/**
	* I am a AJAX call to pre-populate css styles
	*/
	public void function themeTemplate( rc ) {
		var params = rc;
		var data = {};
		var theme_data = "";
		structAppend( rc, { 'theme_tamplate': "blank_canvas" }, false );
		if( rc.theme_tamplate == "current" ) {
			theme_data = getWebsiteThemesManager().getRegistrationTheme( event_id=rc.event_id );
			data = getWebsiteThemesManager().setDefaults( theme_data.theme );
		}else {
			data = getWebsiteThemesManager().getPreLoaded( rc.theme_tamplate );	
		}
		
		getFW().renderData( "json", data );
		return;
	}
	

}