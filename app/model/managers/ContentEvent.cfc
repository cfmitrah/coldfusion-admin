/**
*
* @file  /model/managers/events.cfc
* @author
* @description
*
*/ 

component output="false" displayname="" accessors="true" extends="app.model.base.Manager" {
	property name="ContentDAO" getter="true" setter="true";
	property name="CompanyPaymentDao" getter="true" setter="true";
	property name="EventDao" getter="true" setter="true";
	property name="companyDao" getter="true" setter="true";
	property name="venueDao" getter="true" setter="true";
	property name="mediaManager" setter="true" getter="true";
	property name="FormUtilities" setter="true" getter="true";
	/**
	* I save the contact for the contact page
	* @event_id the ID of the event
	* @event_contact_email The contact page email address
	* @contact_page_overview The contact page content
	*/
	public void function saveEventContactContent( required numeric event_id, string event_contact_email="", string contact_page_overview="" ) {
		var params = {'event_id':arguments.event_id, 'content_id':0 };
		var email_params = {'key':'event_contact_email', 'content':arguments.event_contact_email};
		var overview_params = {'key':'contact_page_overview', 'content':arguments.contact_page_overview};
		
		structAppend( email_params, params );
		structAppend( overview_params, params );
		getContentDAO().ContentSet( argumentCollection=email_params );
		getContentDAO().ContentSet( argumentCollection=overview_params );
		getCacheManager().purgeEventConfigCache( arguments.event_id );
		return;
	}
	/**
	* I save the landing page content 
	* @event_id the ID of the event
	* @hero_text Lead Copy
	* @dates Dates and Times Copy
	* @registration_closed_message Registration Closed Messaging
	* @location Location Copy
	* @overview Introduction Copy
	*/
	public void function saveLandingPageContent( 
		required numeric event_id, 
		string hero_text="", 
		string dates="", 
		string registration_closed_message="", 
		string location="", 
		string overview="", 
		string begin_registration_message="" 
		string confirmation_page_text=""
	) {
		var params = {'event_id':arguments.event_id, 'content_id':0 };
		var hero_text_params = {'key':'hero_text', 'content':arguments.hero_text };
		var dates_params = {'key':'dates', 'content':arguments.dates };
		var closed_params = {'key':'registration_closed_message', 'content':arguments.registration_closed_message };
		var location_params = {'key':'location', 'content':arguments.location };
		var overview_params = {'key':'overview', 'content':arguments.overview };
		var begin_reg_params = {'key':'begin_registration_message', 'content':arguments.begin_registration_message };
		var conf_page_text_params = {'key':'confirmation_page_text', 'content':arguments.confirmation_page_text };
		
		structAppend( hero_text_params, params );
		structAppend( dates_params, params );
		structAppend( closed_params, params );
		structAppend( location_params, params );
		structAppend( overview_params, params );
		structAppend( begin_reg_params, params );
		structAppend( conf_page_text_params, params );
		getContentDAO().ContentSet( argumentCollection=hero_text_params );
		getContentDAO().ContentSet( argumentCollection=dates_params );
		getContentDAO().ContentSet( argumentCollection=closed_params );
		getContentDAO().ContentSet( argumentCollection=location_params );
		getContentDAO().ContentSet( argumentCollection=overview_params );
		getContentDAO().ContentSet( argumentCollection=begin_reg_params );
		getContentDAO().ContentSet( argumentCollection=conf_page_text_params );
		getCacheManager().purgeEventConfigCache( arguments.event_id );
		return;
	}
	/**
	* I save the billing page content 
	* @event_id the ID of the event
	* @mop_check_text
	* @mop_po_text
	* @mop_invoice_text
	* @mop_on_site_text
	*/
	public void function saveBillingPageContent( 
		required numeric event_id, 
		string mop_check_text="", 
		string mop_po_text="", 
		string mop_invoice_text="", 
		string mop_on_site_text=""
	) {
		var params = {'event_id':arguments.event_id, 'content_id':0 };
		var check_params = {'key':'mop_check_text', 'content':arguments.mop_check_text };
		var po_params = {'key':'mop_po_text', 'content':arguments.mop_po_text };
		var invoice_params = {'key':'mop_invoice_text', 'content':arguments.mop_invoice_text };
		var onsite_params = {'key':'mop_on_site_text', 'content':arguments.mop_on_site_text };
		
		structAppend( check_params, params );
		structAppend( po_params, params );
		structAppend( invoice_params, params );
		structAppend( onsite_params, params );
		getContentDAO().ContentSet( argumentCollection=check_params );
		getContentDAO().ContentSet( argumentCollection=po_params );
		getContentDAO().ContentSet( argumentCollection=invoice_params );
		getContentDAO().ContentSet( argumentCollection=onsite_params );
		getCacheManager().purgeEventConfigCache( arguments.event_id );
		return;
	}
	
}