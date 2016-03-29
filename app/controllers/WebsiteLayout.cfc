component extends="$base" accessors="true" {
	property name="eventSettingManager" setter="true" getter="true";

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
		rc['event_layout'] = geteventSettingManager().getEventSettingByKey( rc.event_id, "event_layout" );

		if( !len( rc.event_layout.s_value ) ) {
			rc.event_layout.s_value = "layout-01";
		}

		getCfStatic().include( "/css/pages/websiteLayout/main.css" );
		return;	
	}
	//Save layout
	public void function doSave( rc ) {
		var params = {'event_id':rc.event_id, 'key': "event_layout"};
		structAppend( rc, {'event_layout':"layout-01"}, false);
		params['s_value'] = rc.event_layout;
		geteventSettingManager().saveEventSetting( argumentCollection=params );
		
		redirect("websiteLayout");
		return;	
	}
}