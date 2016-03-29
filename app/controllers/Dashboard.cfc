component extends="$base" accessors="true"
{
	property name="UserDao" setter="true" getter="true";
	property name="EventsManager" setter="true" getter="true";

	public any function before( rc ) {
		rc.sidebar = 'sidebar.dashboard';
		if( !getSessionManageUserFacade().getCurrentCompanyID() ){
			redirect('company.select');
		}
		super.before( rc );
		return;
	}
	public any function default(rc) {
		rc.sidebar = "sidebar.event.details";
		rc['dashboard_stats'] = getEventsManager().getDashboardStats( getCurrentEventID() );
		return;
	}
}