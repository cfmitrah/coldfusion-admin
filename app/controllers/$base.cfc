/**
*
* Matt Graf
*
*
*/

component accessors="true"
{
    property name="AlertBox" setter="true" getter="true";
    property name="FormUtilities" setter="true" getter="true";
	property name="SessionManageUserFacade" setter="true" getter="true";
    property name="CfStatic" setter="true" getter="true";
    property name="config" setter="true" getter="true";
    property name="Utilities" setter="true" getter="true";
	property name="Format" setter="true" getter="true";

	public void function init( required any FW ) {

        setFW( arguments.FW );
    }

 	public void function before( required rc ) {
 		structAppend( rc,{ 
	 		'company_id': getCurrentCompanyID(),
	 		'event_id': getCurrentEventID(),
	 		'event_name': getFW().getbeanFactory().getBean( "EventsManager" ).getEventName( getCurrentEventID() ),
	 		'checked':{
		 		'yes': "checked=""checked""",
		 		'no': ""
		 	},
		 	'selected':{
		 		'yes': " selected",
		 		'no': ""
		 	}
 		},
 		false );
 		
        getCfStatic().include('/js/app.js')
        	.include('/css/app.css')
        	.include('/js/pages/common/sidebar.js')
        	.include('/css/plugins/chosen/chosen.css');
        try {
            if( structKeyExists( variables, 'FormUtilities' ) ){
                getFormUtilities().buildFormCollections(rc,1);
            }else{
                getFW().getbeanFactory().getBean('FormUtilities').buildFormCollections(rc,1);
            }
        }
        catch( any e ) {writeDump(rc);writeDump(e);abort; }

    }

    public void function after( required rc ) {
	    var bean_factory = "";
	    try {
			bean_factory = getFW().getbeanFactory();
		} catch (any e) {
			bean_factory = application.beanFactory;
		}
	    
    	structAppend( rc, 
	    	{ 
	    		'has_topnav': true,
	    		'has_sidebar': true,
		    	'sidebar': "",
		    	'company_event_opts':""
	    	}, false );

        if( getAlertBox().hasAlerts() ) {
            rc.notification = getAlertBox().render();
        }
        rc.SessionManageUserFacade = getSessionManageUserFacade();
        if( rc.has_sidebar && isstruct( getSidebarConfig() ) && structKeyExists( getSidebarConfig(), getSection() ) ){
            rc.sidebar_config = getSidebarConfig()[getSection()];
        }
        //render the sidebar
        var path = expandPath( "/app/layouts/_inc/" );
        var sidebar = path & rc.sidebar & '.cfm';
        if( rc.has_sidebar && !fileExists( sidebar ) ){
	        rc.sidebar = 'sidebar.default';
        }
        rc['sidebar_companies'] = "";
        if( rc.company_id ) {
	        rc['company_event_opts'] = bean_factory.getBean("EventsManager").getCompanyEventSelectOptions( rc.company_id, rc.event_id );
        
	        if( getSessionManageUserFacade().isSystemAdmin() ) {
				rc.sidebar_companies = bean_factory.getBean( "CompanyManager" ).getCompanySelectOptions( rc.company_id );
	 		}else {
		 		rc.sidebar_companies = getFormUtilities().buildOptionList( getSessionManageUserFacade().getValue("companies_details").company_id, getSessionManageUserFacade().getValue("companies_details").company_name );
	 		}
 		}
 		rc['selected'] = { 'Yes': "selected", 'No':"" };
 		rc['checked'] =  { 'Yes': "checked", 'No':"" };
 		structAppend( rc, {'sidebar_companies':{'count':0, 'companies':{}}, 'active_class': { 'Yes': "active", 'No':"" } }, false );

    }
	public void function hasEventID() {
		if( !getCurrentEventID() ){
			redirect('event.select');
		}
	}	
    /* Facade functions */
    public any function getLoggedinUser(){ 
    	return getSessionManageUserFacade().getUserBean(); 
    }
    public any function getCurrentCompanyID() {
	    
    	return val(getFW().getbeanFactory().getBean( "SessionManageUserFacade" ).getCurrentCompanyID()); 
    }
    public any function getCurrentEventID() { 
    	return val(getSessionManageUserFacade().getValue('current_event_id')); 
    }
    public struct function getGenericListingParams() {
	    return {
			'start': 0,
			'length': 10,
			'SEARCH[VALUE]': "",
			'ORDER[0][COLUMN]': "0",
			'ORDER[0][DIR]': "ASC",
			'draw':1
		};
    }
    /* Framework helpers */
    public function setFW( required any FW ) {
        variables.FW = arguments.FW;
    }

    public function getFW() {
        if( NOT StructKeyExists( variables, 'FW' ) )
        {
          variables.FW = '';
        }
        return variables.FW;
    }

    function setLayout( string action ) {
        getFW().setLayout( argumentCollection:arguments );
    }

    function setView( string action ) {
        getFW().setView( argumentCollection:arguments );
    }

    public function redirect() {
        getFW().redirect( argumentCollection:arguments );
    }

    public function buildURL() {
        return getFW().buildURL( argumentCollection:arguments );
    }

    public function getFWSettings() {
        return getFW().getFWSettings();
    }

    public function getSubsystem() {
        return getFW().getSubsystem();
    }

    public function getSection() {
        return getFW().getSection();
    }

    public function getItem() {
        return getFW().getItem();
    }

    /* End Framework helpers */


    /* Aert box helpers */
    private void function addInfoAlert(required string message) {
        getAlertBox().addInfoAlert(argumentCollection=arguments);
    }

    /**
    *   Facade to the kuubd AlertBox addErrorAlert() method
    */
    private void function addErrorAlert(required string message) {
        getAlertBox().addErrorAlert(argumentCollection=arguments);
    }

    /**
    *   Facade to the kuubd AlertBox addWarningAlert() method
    */
    private void function addWarningAlert(required string message) {
        getAlertBox().addWarningAlert(argumentCollection=arguments);
    }

    /**
    *   Facade to the kuubd AlertBox addSuccessAlert() method
    */
    private void function addSuccessAlert(required string message) {
        getAlertBox().addSuccessAlert(argumentCollection=arguments);
    }

    /**
    *   Facade to the AlertBox clear() method
    */
    private void function clearAlert() {
        getAlertBox().clear();
    }


    private struct function getSidebarConfig() {
        var rtn = {};
        if( isStruct( getConfig() ) && structKeyExists( getConfig(), "sidebar") ){
            rtn = getConfig().sidebar;
        }
        return rtn;
    }


	/**
	* Converts structure keys to all lowercase
	* @from The struct to be lowered
	*/
	public struct function lowerStruct( required struct from ) {
		var cnt = 0;
		var to = {};
		for( var key in arguments.from ){
			if( isStruct( arguments.from[key] ) ) {
				to[lCase(key)] = lowerStruct( arguments.from[key] );
			}
			else if( isArray( arguments.from[key] ) ) {
				cnt = arrayLen( arguments.from[key] );
				for( var i = 1; i <= cnt; i++ ) {
					if( isStruct( arguments.from[key][i] ) ){
						arguments['from'][i] = lowerStruct( arguments.from[key][i] );
					}
					else{
						arguments['from'][key][i];
					}
				}
				to[lCase( key )] = arguments['from'][key];
			}
			else{
				to[lCase( key )] = arguments['from'][key];
			}
		}
		return to;
	}

	private void function die() {
        getFW().die( arguments );
    }
}
