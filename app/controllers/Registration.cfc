component extends="$base" accessors="true"
{
	property name="RegistrationFieldManager" setter="true" getter="true";
	property name="RegistrationFieldDependencyManager" setter="true" getter="true";
	property name="RegistrationSectionManager" setter="true" getter="true";
	property name="attendeeSettingsManager" setter="true" getter="true";
	property name="geographyManager" getter="true" setter="true";
	/**
	* I run before any of the other methods
	*/
	public void function before( rc ) {
		hasEventID();
		rc.sidebar = "sidebar.event.details";

		super.before( rc );
		
		return;
	}
	
	/**
	* I registration settings for an event
	*/
	public void function settings( rc ) {
		var cf_js = {};
		rc['field_types'] = getRegistrationFieldManager().getRegistrationFieldTypes();
		rc['country_codes'] = getGeographyManager().getCountryCodes();
		rc['standard_field_table_id'] = "standard_field_listing";
		rc['custom_field_table_id'] = "custom_field_listing";
		rc['dependencies_table_id'] = "dependencies_field_listing";
		rc['login_table_id'] = "login_field_listing";
		rc['hotel_field_table_id'] = "hotel_field_listing";
		
		cf_js['standard_field_listing_config'] = getRegistrationFieldManager().getListingConfig( "standard" );
		cf_js['custom_field_listing_config'] = getRegistrationFieldManager().getListingConfig( "custom" );
		cf_js['dependencies_listing_config'] = getRegistrationFieldManager().getListingConfig( "dependencies" );
		cf_js['login_field_listing_config'] = getRegistrationFieldManager().getListingConfig( "login" );
		cf_js['hotel_field_listing_config'] = getRegistrationFieldManager().getListingConfig( "hotel" );

		structAppend( cf_js, {
				'field_save_url': buildURL( 'registration.saveField' ),
				'standard_field_get_url': buildURL( 'registration.standardfield' ),
				'login_field_get_url': buildURL( 'registration.loginFields' ),
				'registration_field_get_url': buildURL( 'registration.registrationfield' ),
				'field_remove_url': buildURL( 'registration.removeField' ),
				'get_dependency_url': buildURL( 'registration.getdependency' ),
				'save_dependency_url': buildURL( 'registration.savedependency' ),
				'remove_dependency_url': buildURL( 'registration.removedependency' ),
				'get_event_fields_url': buildURL( 'registration.getalleventregistrationfields' ),
				'get_field_choices_url': buildURL( "registration.getfieldchoices" ),
				'quick_assign_url': buildURL( "registration.quickSaveStandardField" ),
				'field_duplicate_url': buildURL( "registration.duplicateField" )
			} );
 
			
		structAppend( rc, {'tab':"standard-fields"}, false );
		getCfStatic()
			.includeData( cf_js )
			.include( "/js/pages/registration/settings.js" )
			.include( "/css/pages/registration/settings.css" );
		return;
	}
	/**
	* I save a registration field for an event
	*/
	public void function saveField( rc ) {
		var field_id = 0;
		structAppend( rc, {
			'field_id': 0,
			'event_id': getCurrentEventID(),
			'field_type': "",
			'label': "",
			'required': false,
			'standard_field': 0,
			'attributes': "",
			'narrative':"",
			'choices': [],
			'delete_choices': []
		}, false );
		if( structKeyExists( rc, "attributes") && isStruct( rc.attributes ) ) {
			rc.attributes = serializeJSON( lowerStruct( rc.attributes ) );
		}
		if( !isNumeric( rc.field_id ) ) {
			rc.field_id = 0;
		}

		field_id = getRegistrationFieldManager().saveRegistrationField( argumentCollection=rc );
		getFW().renderData( "json", { "success": true } );
		return;
	}
	/**
	* I remove a registration field for an event
	*/
	public void function removeField( rc ) {
		var params = {
			'field_id': 0
		};
		structAppend(params, rc);
		getRegistrationFieldManager().removeRegistrationField( argumentCollection=params );

		getFW().renderData( "json", {
			"success": true
		} );
		return;
	}
	/**
	* I get a standard field list
	*/
	public void function standardFields( rc ) {
		var params = {
			'event_id': getCurrentEventID(),
			'standard_field': 1,
			'draw': ( structKeyExists( rc, 'draw') ? rc.draw:0 )
		};
		var data = getRegistrationFieldManager().getStandardRegistrationFields( argumentCollection=params );

		getFW().renderData( "json", data );
		return;
	}
	/**
	* I get a login field list
	*/
	public void function loginFields( rc ) {
		var params = {
			'event_id': getCurrentEventID(),
			'standard_field': 2,
			'draw': ( structKeyExists( rc, 'draw') ? rc.draw:0 )
		};
		var data = getRegistrationFieldManager().getStandardRegistrationFields( argumentCollection=params );

		getFW().renderData( "json", data );
		return;
	}
	/**
	* I get a hotel field list
	*/
	public void function hotelFields( rc ) {
		var params = {
			'event_id': getCurrentEventID(),
			'standard_field': 3,
			'draw': ( structKeyExists( rc, 'draw') ? rc.draw:0 )
		};
		var data = getRegistrationFieldManager().getStandardRegistrationFields( argumentCollection=params );

		getFW().renderData( "json", data );
		return;
	}
	/**
	* I get a custom field list
	*/
	public void function customFields( rc ) {
		var params = {
			'event_id': getCurrentEventID(),
			'standard_field': false,
			'draw': ( structKeyExists( rc, 'draw' ) ? rc.draw:0 )
		};
		var data = getRegistrationFieldManager().getRegistrationFields( argumentCollection=params );

		getFW().renderData( "json", data );
		return;
	}
	/**
	* I get a standard field
	*/
	public void function standardField( rc ) {
		var params = {
			'standard_field_id': 0
		};
		structAppend(params, rc);

		getFW().renderData( "json", getRegistrationFieldManager().getStandardRegistrationField( argumentCollection=params ) );
		return;
	}
	/**
	* I get a standard field
	*/
	public void function quickSaveStandardField( rc ) {
		var params = {
			'standard_field_id': 0,
			'event_id': getCurrentEventID()
		};
		structAppend(params, rc);

		getFW().renderData( "json", getRegistrationFieldManager().quickSaveStandardField( argumentCollection=params ) );
		return;
	}
	
	/**
	* I get Event field dependencies
	*/
	public void function dependencies( rc ) {
		
		getFW().renderData( "json", getRegistrationFieldDependencyManager().getEventDependencies( getCurrentEventID() ) );
		return;
	}
	
	/**
	* I get a registration field
	*/
	public void function registrationField( rc ) {
		structAppend( rc, {
			'field_id': 0,
			'event_id': getCurrentEventID()
		}, false );
		getFW().renderData( "json", getRegistrationFieldManager().getRegistrationField( argumentCollection=rc ) );
		return;
	}
	/**
	* I display all of the current attendee/reg forms.
	*/
	public void function forms( rc ) {
		rc['forms'] = getRegistrationSectionManager().getEventRegistrationSections( getCurrentEventID() );
		getCfStatic()
			.include( "/js/pages/registration/viewSections.js" );
		return;
	}
	/**
	* I create an attendee/reg Form
	*/
	public void function createAttendeeForm( rc ) {
		rc['registration_types'] = getAttendeeSettingsManager().getRegistrationTypeList( getCurrentEventID() );
		setLayout( "registration.createForm" );
		return;
	}
	/**
	* I create a section from an attendee/reg Form
	*/
	public void function createFormSections( rc ) {
		var cf_js = {};
		if( !structKeyExists( rc, "registration_type_id" ) ) {
			redirect( "registration.createAttendeeForm" );
		}
		cf_js = {
			'sections_get': buildURL( "registration.sections" ),
			'section_save': buildURL( "registration.saveSection" ),
			'section_delete': buildURL( "registration.deleteSection" ),
			'section_edit': buildURL( "registration.Section" ),
			'section_types_get': buildURL("registration.sectionTypes"),
			'sections_sort_update': buildURL( "registration.updateSectionSort" ),
			'registration_type_id': rc.registration_type_id
		};
		
		getCfStatic()
			.includeData( cf_js )
			.include( "/js/pages/registration/createFormSections.js" );

		setLayout( "registration.createForm" );
		return;
	}
	/**
	* I assign fields to a section 
	*/
	public void function assignSectionFields( rc ) {
		var cf_js = { 
			'field_save_url': buildURL( "registration.addFieldToSection" ),
			'field_remove_url': buildURL( "registration.removeFieldToSection" ),
			'field_sort_update_url': buildURL( "registration.updateSectionFieldSort" )
		};
		if( !structKeyExists( rc, "registration_type_id" ) ) {
			redirect( "registration.createAttendeeForm" );
		}
		rc['sections'] = getRegistrationSectionManager().getRegistrationSections( rc.registration_type_id, true );
		rc['fields'] = getRegistrationFieldManager().getUnusedRegistrationFields( getCurrentEventID(), rc.registration_type_id );

		getCfStatic()
			.includeData( cf_js )
			.include( "/js/pages/registration/assignSectionFields.js" );
		setLayout( "registration.createForm" );
		return;
	}
	/**
	* I am an AJAX call to get a list of sections
	*/
	public void function sections( rc ) {
		var params = {
			'registration_type_id': ( structKeyExists( rc, "registration_type_id" ) ? rc.registration_type_id:0 )
		};
		var data = getRegistrationSectionManager().getRegistrationSections( argumentCollection=params );

		getFW().renderData( "json", data );
		return;
	}
	/**
	* Multi line method description
	* @argument_name Argument description
	*/
	public void function section( rc ) {
		var data = {};
		structAppend( rc, {
			'section_id': 0
		}, false );
		data = getRegistrationSectionManager().getSection( argumentCollection=rc );

		getFW().renderData( "json", data );
		return;
	}
	
	
	/**
	* I am an AJAX call to save a section
	*/
	public void function saveSection( rc ) {
		var data = { 'success': true };
		structAppend( rc, {
			'section_id': 0,
			'registration_type_id': 0,
			'label': "",
			'layout': "",
			'title': "",
			'summary': "",
			'sort': 0,
			'section_type_id':0,
			'settings':{}
		}, false );
		if( !isstruct( rc.settings ) ) {
			rc['settings'] = {};
		}
		structAppend( rc['settings'], {'group_allowed':false}, false );
		rc['settings'] = lowerStruct( rc.settings );
		rc['settings'] = serializeJSON( rc.settings );
		data['section_id'] = getRegistrationSectionManager().saveSection( argumentCollection=rc );
		getFW().renderData( "json", data );
		return;
	}
	/**
	* I am an AJAX call to delete a section
	*/
	public void function deleteSection( rc ) {
		structAppend( rc, {
		    'registration_type_id': 0,
		    'section_id': 0
		}, false );
		getRegistrationSectionManager().removeSection( argumentCollection=rc );

		getFW().renderData( "json", {
			"success": true
		} );
		return;
	}	
	/**
	* I am an AJAX call to update the sort order of sections
	*/
	public void function updateSectionSort( rc ) {
		structAppend( rc, {
		    'registration_type_id': 0,
		    'section_ids': ""
		}, false );
		getRegistrationSectionManager().updateSectionSort( argumentCollection=rc );

		getFW().renderData( "json", {
			"success": true
		} );
		return;
	}
	/**
	* I am an AJAX call to add a field to a section
	*/
	public void function addFieldToSection( rc ) {
		var data = {};
		structAppend( rc, {
			    'field_id': 0,
			    'section_id': 0,
			    'sort': 1
			}, false );
		getRegistrationSectionManager().RegistrationSectionFieldSet( argumentCollection:rc );
		getFW().renderData( "json", {
			"success": true
		} );
		return;
	}
	/**
	* I am an AJAX call to remove a field from a section
	*/
	public void function removeFieldToSection( rc ) {
		var data = {};
		structAppend( rc, {
			    'field_id': 0,
			    'section_id': 0
			}, false );

		getRegistrationSectionManager().RegistrationSectionFieldRemove( argumentCollection:rc );
		getFW().renderData( "json", {
			"success": true
		} );
		return;
	}
	/**
	* I am an AJAX call to update the sort order of the fields in a section 
	*/
	public void function updateSectionFieldSort( rc ) {
		structAppend( rc, {
		    'section_id': 0,
		    'field_ids': ""
		}, false );
		getRegistrationSectionManager().updateSectionFieldSort( argumentCollection=rc );

		getFW().renderData( "json", {
			"success": true
		} );
		return;
	}
	/**
	* 
	*/
	public void function getDependency( rc ) {
		structAppend( rc, {
		    'field_dependency_id': 0
		}, false );
		
		
		getFW().renderData( "json", getRegistrationFieldDependencyManager().getDependencyByID( argumentCollection=rc ) );

		return;
	}
	/**
	* 
	*/
	public void function saveDependency( rc ) {
		structAppend( rc, {
		    'field_dependency_id': 0,
			'field_id': 0,
			'dependency': 0,
			'value': "",
			'confirm_field':0
		}, false );
		if( val( rc.confirm_field ) ) {
			rc['value']="[confirm_field]";
		}

		getRegistrationFieldDependencyManager().saveDependency( argumentCollection=rc );

		getFW().renderData( "json", { 'success': true } );
		return;
	}
	/**
	* 
	*/
	public void function removeDependency( rc ) {
		structAppend( rc, {
		    'field_dependency_id': 0
		}, false );
		
		getRegistrationFieldDependencyManager().removeDependency( argumentCollection=rc );

		getFW().renderData( "json", { 'success': true } );
		return;
	}
	/** 
	* 
	*/	
	public void function getAllEventRegistrationFields( rc ) {
		getFW().renderData( "json", getRegistrationFieldManager().getAllEventRegistrationFields( getCurrentEventID() ) );
		return;
	}
	/** 
	* 
	*/	
	public void function getFieldChoices( rc ) {
		structAppend( rc, {
		    'field_id': 0
		}, false );
		getFW().renderData( "json", getRegistrationFieldManager().getFieldChoices( argumentCollection:rc ) );
		return;
	}
	/**
	* 
	*/
	public void function duplicateField( rc ) {
		structAppend( rc, { 'duplicate_field': {} }, false );
		structAppend( rc['duplicate_field'], { 'field_id': 0, 'label':"" }, false );
		getFW().renderData( "json", getRegistrationFieldManager().duplicateField( argumentCollection:rc.duplicate_field ) );
		return;
	}
	/**
	* 
	*/
	public void function duplicatePath( rc ) {
		structAppend( rc, { 'registration_type_id': 0, 'registration_type_id_copy_to': 0 }, false );
		getRegistrationSectionManager().duplicateSection( argumentCollection:rc );
		getFW().renderData( "json", {} );
		return;
	}		
	/**
	* I Get all of the available section types
	*/
	public void function sectionTypes(rc) {
		structAppend( rc, { 'registration_type_id': 0, 'type': "all" }, false );
		getFW().renderData( "json", getRegistrationSectionManager().getSectionTypes( rc.registration_type_id, rc.type ) );
		return;
	}
	
}