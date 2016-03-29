
component extends="$base" accessors="true"
{
	property name="attendeeSettingsManager" setter="true" getter="true";

	public void function before( rc ) {

		hasEventID();
		rc.sidebar = "sidebar.event.details";
		super.before( rc );
		return;
	}
	/**
	* I am the defautl listing event
	*/
	public void function default( rc ) {
		var cfrequest = {
		    'table_id': "event_listing",
		    'ajax_source': buildURL( "attendeesettings.registrationTypes" ),
		    'aoColumns':[
	            {
	            	'data':"registration_type",
	            	'sTitle': "Type"
				},
				{
	            	'data':"path_url",
	            	'sTitle': "URL"
				},
	            {
	            	'data':"valid_from",
	            	'sTitle': "Valid From"
				},
	            {
	            	'data':"valid_to",
	            	'sTitle': "Valid To"
				},
	            {
	            	'data':"active",
	            	'sTitle': "Active"
				},
				{
	            	'data':"sort",
	            	'sTitle': "Sort"
				},
	            {
	            	'data':"options",
					'bSortable': false,
	            	'sTitle': "Options"
				}
		    ]
		};
		structAppend( cfrequest, {
			'save_registration_type_url': buildURL("attendeesettings.saveAttendeeType"),
			'get_registration_type_url': buildURL("attendeesettings.getAttendeetype"),
			'get_registration_type_pricing_url': buildURL("attendeesettings.RegistrationTypePricing"),
			'save_registration_type_pricing_url' :buildURL("attendeesettings.SaveRegistrationTypePricing"),
			'remove_registration_type_pricing_url': buildURL("attendeesettings.RemoveRegistrationTypePricing")
		});
		rc['table_id'] = cfrequest.table_id;

		getCfStatic()
			.includeData( cfrequest )
			.include("/js/plugins/parsley/parsley.js")
			.include("/js/pages/attendeesettings/settings.js")
			.include("/css/pages/attendeesettings/settings.css");

		return;
	}
	/**
	* I get the requested Attendee type
	*/
	public any function getAttendeetype( rc ) {
		var params = rc;
		structAppend( params, {'registration_type_id':0},false );
		getFW().renderData( 'json', getAttendeeSettingsManager().getRegistrationType( getCurrentEventID(), rc.registration_type_id ).registration_type );
		return;
	}

	/**
	*I get all of the registration types
	*/
	public void function registrationTypes( rc ) {
		var params = rc;
		structAppend( params, {
				'event_id': getCurrentEventID(),
				'includeOptions': true,
				'draw': 0
			},false );

		rc.attendee_list = getAttendeeSettingsManager().getRegistrationTypeList( argumentCollection=params );

		getFW().renderData( 'json', rc.attendee_list );
		request.layout = false;
		return;

	}
	/**
	* I save an attendee type
	*/
	public void function saveAttendeeType( rc ) {
		var params = rc;
		var status = true;
		//todo: add validation
		structAppend( params, {
			'event_id'=getCurrentEventID(),
			'registration_type':"",
			'access_code':"",
			'registration_type_id':0,
			'active':0,
			'sort':0,
			'group_allowed':0
			},false );
		params['registration_type_id'] = val( params.registration_type_id );
		rc.registration_type_id = getAttendeeSettingsManager().saveRegistrationType( argumentCollection:params );

		getFW().renderData( 'json', {"status"=status, "registration_type_id"=rc.registration_type_id } );
		request.layout = false;
		return;
	}
	/**
	* I get a registration type pricing
	*/
	public void function registrationTypePricing( rc ) {
		structAppend( rc, {'registration_type_id':0},false);
		rc.reg_type_pricing = getAttendeeSettingsManager().getRegistrationTypePricing( getCurrentEventID(), rc.registration_type_id );
		getFW().renderData( 'json', rc.reg_type_pricing );
		request.layout = false;
		return;
	}
	/**
	* I save registration type pricing
	*/
	public void function saveRegistrationTypePricing( rc ) {
		var rtn = { 'reg_pricing'=0 };
		var regPrice = {};
		structAppend( rc, { 'registration_type_id':0, 'registration_pricing_type_id':0, 'fieldupdate':""}, false );
		if( isNumeric( rc.registration_type_id ) ){
			if( len( rc.fieldupdate ) && isNumeric( rc.registration_pricing_type_id ) ){
				regPrice[ 'registration_price_id' ] = rc.registration_pricing_type_id;
				if( rc.name == 'price' ){
					rc.value = REReplaceNoCase( rc.value, ",|\$","","ALL");
				}
				regPrice[ rc.name ] = rc.value;
				regPrice['registration_type_id'] = rc.registration_type_id;
				rtn['registration_pricing_type_id'] = getAttendeeSettingsManager().quickSaveRegistrationPrice( argumentCollection=regPrice );
			}else if( structKeyExists( rc, "reg_pricing") && isStruct( rc.reg_pricing ) ){
				rc.reg_pricing['registration_type_id'] = rc.registration_type_id;
				rtn['reg_pricing'] = getAttendeeSettingsManager().saveRegistrationPrice( argumentCollection=rc.reg_pricing );
			}
		}

		getFW().renderData( 'json', rtn );
		request.layout = false;
		return;
	}
	/**
	* I remove registration type pricing
	*/
	public void function removeRegistrationTypePricing( rc ) {
		structAppend(rc, {'registration_type_id':0,'registration_price_id':0},false);
		getAttendeeSettingsManager().removeRegistrationPrice( rc.registration_price_id, rc.registration_type_id );

		getFW().renderData( 'json', { 'success':1 } );
		request.layout = false;
		return;
	}

}