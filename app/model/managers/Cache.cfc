/**
*
* @file  /model/managers/Cache.cfc
* @author - AB
* @description - This will manage all event caching
*
*/


component output="false" displayname="CacheManager" accessors="true" extends="app.model.base.Manager" {
	property name="companyDao" getter="true" setter="true";
	property name="eventDao" getter="true" setter="true";
	property name="formUtilities" getter="true" setter="true";

	/**
	* Gets all of the Caches for a given event
	*/
	public struct function getAvailableEventCaches( string event_cache_key="" ){
		var keys = getCache().keys();
		var cnt = arrayLen( keys );
		var event = [];
		var tmp = {
			'domains' = [],
			'slugs' = []
		};
		var events = {};
		// parse the keys
		for( var i = 1; i <= cnt; i++ ){
			// only grab the cache key if it is an event config as that is called on every page
			if( keys[i].startsWith("EVENT_") && keys[i].endsWith("_CONFIG") ){
				event = listToArray( keys[i], "_" );
				arrayAppend( tmp.domains, event[2] );
				arrayAppend( tmp.slugs, event[3] );
			}
		}
		structAppend( events, getEventDao().EventsByDomainCacheGet( event_domains=arrayToList( tmp.domains ), event_slugs=arrayToList( tmp.slugs ) ) );
		events['opts'] = getFormUtilities().buildGroupOptionList( recordset=events.result, group="company_name", value="event_cache_key", display="event_name", selected=arguments.event_cache_key );
		return events;
	}
	/**
	* Gets all of the Caches for a given event
	*/
	public struct function getEventCache( required string event_cache_key ){
		var cache_data = {};
		var cache_key = arguments.event_cache_key;
		cache_data['key_list'] = arrayFilter( getCache().keys(), function( value ){ // get all of the existing cache keys
			return value.indexOf( cache_key ) != -1;
		});
		cache_data['key_cnt'] = arrayLen( cache_data.key_list );
		cache_data['keys'] = [];
		for( var i = 1; i <= cache_data.key_cnt; i++ ){
				arrayAppend( cache_data.keys, {
					'key' = cache_data.key_list[i]
				} );
				// get the key metadata
				structAppend( cache_data.keys[i], getCache().metadata( key=cache_data.key_list[i] ) );
				// general formatting
				cache_data['keys'][i]['expires'] = dateAdd( "s", cache_data.keys[i].timespan, cache_data.keys[i].createdtime );
				cache_data['keys'][i]['expires'] = datetimeFormat( cache_data.keys[i].expires, "mm/dd/yyyy h:mmtt" );
				cache_data['keys'][i]['createdtime'] = datetimeFormat( cache_data.keys[i].createdtime, "mm/dd/yyyy h:mmtt" );
				cache_data['keys'][i]['lasthit'] = datetimeFormat( cache_data.keys[i].lasthit, "mm/dd/yyyy h:mmtt" );
				cache_data['keys'][i]['lastupdated'] = datetimeFormat( cache_data.keys[i].lastupdated, "mm/dd/yyyy h:mmtt" );
				cache_data['keys'][i]['timespan'] = cache_data.keys[i].timespan / 60;
				cache_data['keys'][i]['idletime'] = cache_data.keys[i].idletime / 60;
		}
		return cache_data;
	}
	/**
	* Removes a Cache Key
	*/
	public void function removeCache( required string cache_key ){
		getCache().remove( key=arguments.cache_key );
		return;
	}
	/**
	* Purges all keys containing the passed key string
	*/
	public void function purgeCache( required string cache_key ){
		getCache().remove( key=arguments.cache_key, exact=false );
		return;
	}
	/**
	* Gets a cache
	*/
	public any function getCacheData( required string cache_key ){
		var data = getCache().get( key=arguments.cache_key );
		if( isNull( data ) ){
			data = {
				'message' = "Key not found"
			};
		}
		return data;
	}

	/**
	* removes the company config cache
	* @company_id The id of the event
	*/
	public void function purgeCompanyConfigCache( required numeric company_id ) {
		var domain_info = querytoArray( getCompanyDao().companyGet( company_id ).result.domain );
		var cache_key = "";
		if( arrayLen( domain_info ) ) {
			cache_key = "company_" & domain_info[1].domain_name & "_config";
			getCache().remove( key=cache_key );
		}
		return;
	}
	/**
	* removes the hotel config cache
	* @event_id The id of the event
	*/
	public void function purgeEventHotelCache( required numeric event_id ) {
		var cache_key = "event_" & arguments.Event_ID & "_hotel_";
		getCache().remove( key=cache_key );
		return;
	}

	/**
	* removes the event config cache
	* @event_id The id of the event
	*/
	public void function purgeEventConfigCache( required numeric event_id ) {
		var event_info = querytoArray( getEventDao().getEvent( arguments.event_id, getSessionManageUserFacade().getCurrentCompanyID() ).result.event_info );
		var cache_key = "";
		if( arrayLen( event_info ) ) {
			cache_key = "event_" & event_info[1].domain_name & "_" & event_info[1].slug & "_config";
			getCache().remove( key=cache_key );
		}
		return;
	}
	/**
	* removes event registration cache for an event
	* @event_id The id of the event
	*/
	public void function purgeEventRegistrationFieldsCache( required numeric event_id ) {
		var cache_key = "event_" & arguments.event_id & "_registration_fields";
		getCache().remove( key=cache_key );
		purgeEventSectionCache( arguments.event_id );
		return;
	}
	/**
	* removes section cache for a registration_type_id
	* @event_id The id of the event
	* @registration_type_id The id of the event
	*/
	public void function purgeEventSectionCache( required numeric event_id, numeric registration_type_id=0 ) {
		var cache_key = "event_" & arguments.Event_ID & "_section_";
		if( arguments.registration_type_id ) {
			cache_key = cache_key & arguments.registration_type_id;
		}
		getCache().remove( key=cache_key );
		return;
	}
	/**
	* removes agenda cache for a registration_type_id
	* @event_id The id of the event
	*/
	public void function purgeAgendaCache( required numeric event_id ) {
		var cache_key = "event_" & event_id & "_agenda_";
		getCache().remove( key=cache_key );
		return;
	}

}