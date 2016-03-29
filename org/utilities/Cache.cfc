component output="false"{
	/**
	* Cache init method
	* @prefix (optional) A value that will automatically be prepended to any cache key that gets set
	* @interval (optional) The default interval for how to measure the ttl, can be "days", "hours", "minutes", or "seconds"
	* @ttl (optional) The time to live ( time until the key expires )
	* @region (optional) The name of the Cache Region to use for all requests
	*/
	public struct function init( ) {
		this['prefix'] = "";
		this['interval'] = "minutes"; // set default timing
		this['ttl'] = 5;
		this['region'] = "";
		this['properties'] = {};
		structAppend(this, application.config.cache);
		if( len( this.region ) && !regionExists( region=this.region ) ) {
			regionCreate( region=this.region, properties=this.properties );
		}
		return this;
	}
	/**
	* Adds an Element into Cache
	* @key The name of the Cache Key
	* @value The value / variable to be added to cache
	* @ttl (optional) The time to live ( time until the key expires )
	* @interval (optional) A string of "days", "hours", "minutes", "seconds".  This is used with the ttl parameter to create a time span
	* @region (optional) The Cache Region to put the value into, if empty the default cache is used
	*/
	public void function put( required string key, required any value, numeric ttl=this.ttl, string interval=this.interval, string region=this.region ) {
		var timeout = time( interval=arguments.interval, duration=arguments.ttl );
		if( len( arguments.region ) ) {
			cachePut( clean( key=this.prefix & arguments.key ), arguments.value, timeout, timeout, arguments.region );
		}
		else{
			cachePut( clean( key=this.prefix & arguments.key ), arguments.value, timeout, timeout );
		}
		return;
	}
	/**
	* Gets an Element from Cache
	* @key The name of the Cache Key
	* @region (optional) The Cache Region to put the value into, if empty the default cache is used
	*/
	public any function get( required string key, string region=this.region ) {
		return duplicate( len( arguments.region ) ? cacheGet( clean( key=this.prefix & arguments.key ), arguments.region ) : cacheGet( clean( key=this.prefix & arguments.key ) ) );
	}
	/**
	* Checks to see if a Cache Key Exists
	* @key The name of the Cache Key
	* @region (optional) The Cache Region to put the value into, if empty the default cache is used
	*/
	public boolean function exists( required string key, string region=this.region ) {
		return len( arguments.region ) ? cacheIdExists( clean( key=this.prefix & arguments.key ), arguments.region ) : cacheIdExists( clean( key=this.prefix & arguments.key ) );
	}
	/**
	* Removes an Element from Cache
	* @key (optional) The name of the Cache Key
	* @keys (optional) An array of cached keys to remove
	* @region (optional) The Cache Region remove the key from, if empty the default cache is used
	* @exact (optional) Whether or only exact matches should be removed, if false partial matches will also be removed
	*/
	public void function remove( string key="", array keys=[], string region=this.region, boolean exact=true ) {
		var cnt = 0;
		if( len( arguments.key ) ) { // a single key was passed in use it
			arguments['keys'] = [arguments.key];
			cnt = 1;
		}
		else{ // set the cnt to that of the keys
			cnt = arrayLen( keys );
		}
		try{
			if( len( arguments.region ) ) {
				for( var i = 1; i <= cnt; i++ ) { // loop over each key and remove it
					cacheRemove( clean( key=this.prefix & arguments.keys[i] ), arguments.exact, arguments.region, false );
				}
			}
			else{
				for( var i = 1; i <= cnt; i++ ) { // loop over each key and remove it
					cacheRemove( clean( key=this.prefix & arguments.keys[i] ), arguments.exact );
				}
			}
		}
		catch( any e ) {}
		return;
	}
	/**
	* Removes all of the Cached Keys from a given Region
	* @region (optional) The Cache Region to purge
	*/
	public void function purge( string region=this.region ) {
		if( len( arguments.region ) ) {
			cacheRemoveAll( arguments.region );
		}
		else{
			cacheRemoveAll(  );
		}
		return;
	}
	/**
	* Returns the metadata information for a Cached Key
	* @key The name of the Cache Key
	* @region (optional) The Cache Region remove the key from, if empty the default cache is used
	*/
	public struct function metadata( required string key, string region=this.region ) {
		return len( arguments.region ) ? cacheGetMetaData( clean( key=this.prefix & arguments.key ), "", arguments.region ) : cacheGetMetaData( clean( key=this.prefix & arguments.key ) );
	}
	/**
	* Gets the key the cache would have generated
	* @key The name of the Cache Key
	*/
	public string function key( required string key ) {
		return uCase( clean( key=this.prefix & arguments.key ) );
	}
	/**
	* Returns a list of all of the cache keys
	* @region (optional) The Cache Region to get the list of keys from
	*/
	public array function keys( string region=this.region ) {
		return len( arguments.region ) ? cacheGetAllIds( arguments.region ) : cacheGetAllIds(  );
	}
	/**
	* Sets and Gets or just Gets properties for a Cache Region
	* @region (optional) The Cache Region to get the list of properties for
	* @properties (optional) A structure of properties to set on a Cache Region
	*/
	public struct function properties( string region="", struct properties={} ) {
		var props = {};
		if( !structIsEmpty( arguments.properties ) ) { // check to see if new properties are being passed in, if so set them
			if( len( arguments.region ) ) { // properties are being set on a specific Cache Region
				cacheSetProperties( arguments.properties, arguments.region ); // set the properties on the Cache Region
				props = cacheGetProperties( arguments.region ); // get the Cache Region properties
			}
			else{ // properties are being set on the Default Cache
				cacheSetProperties( arguments.properties ); // set the properties on the default cache
				props = cacheGetProperties(  ); // get the Default Cache properties
			}
		}
		else{ // just get the properties for the Cache Region
			if( len( arguments.region ) ) {
				props = cacheGetProperties( arguments.region ); // get the Cache Region properties
			}
			else{
				props = cacheGetProperties(  ); // get the Default Cache properties
			}
		}
		return props;
	}
	/**
	* Gets a list of all of the cache regions
	*/
	public array function regions(  ) {
		return cacheGetSession( "object" ).getCacheManager(  ).getCacheNames(  );
	}
	/**
	* Checks to see if a Cache Region exists or not
	*/
	public boolean function regionExists( string region=this.region ) {
		return cacheRegionExists( arguments.region );
	}
	/**
	* Creates a new Cache Region
	* @region - The name of the Cache Region to create
	* @properties - A structure of properties for the new Cache Region.  See the defaults variables for a list of keys
	* @throwonerror (optional) - Whether or not to throw an error if the cache region already exists
	*/
	public void function regionCreate( required string region, struct properties={}, boolean throwonerror=true ) {
		var defaults  =  { // default Cache Region Properties
			"CACHELOADERTIMEOUTMILLIS" = 0,
			"MAXMEMORYOFFHEAP" = 0,
			"MAXBYTESLOCALDISKASSTRING" = 0,
			"DISKEXPIRYTHREADINTERVALSECONDS" = 3600,
			"OVERFLOWTOOFFHEAP" = false,
			"DISKSPOOLBUFFERSIZEMB" = 10,
			"MAXBYTESLOCALHEAPPERCENTAGESET" = false,
			"MAXENTRIESLOCALHEAP" = 1000,
			"MAXMEMORYOFFHEAPINBYTES" = 0,
			"DISKACCESSSTRIPES" = 1,
			"MAXENTRIESLOCALDISK" = 100000,
			"MAXBYTESLOCALOFFHEAPASSTRING" = 0,
			"MEMORYEVICTIONPOLICY" = "LRU",
			"LOGGING" = false,
			"COPYONWRITE" = false,
			"OVERFLOWTODISK" = true,
			"DISKPERSISTENT" = true,
			"MAXBYTESLOCALOFFHEAPPERCENTAGESET" = false,
			"MAXBYTESLOCALHEAPASSTRING" = 0,
			"MAXELEMENTSONDISK" = 100000,
			"OVERFLOWTOOFFHEAPSET" = false,
			"MAXBYTESLOCALOFFHEAP" = 0,
			"OBJECTTYPE" = "ANY",
			"STATISTICS" = false,
			"ETERNAL" = false,
			"MAXBYTESLOCALDISKPERCENTAGESET" = false,
			"TIMETOLIVESECONDS" = 720,
			"MAXBYTESLOCALHEAP" = 0,
			"CLEARONFLUSH" = true,
			"MAXBYTESLOCALDISK" = 0,
			"MAXELEMENTSINMEMORY" = 1000,
			"COPYONREAD" = false,
			"TIMETOIDLESECONDS" = 720
		};
		if( !regionExists( region=arguments.region ) ) {
			structAppend( arguments.properties, defaults, false ); // append the defaults onto the properties to ensure everything is set
			cacheRegionNew( arguments.region, arguments.properties, arguments.throwonerror ); // create the new region
		}
		return;
	}
	/**
	* Removes a Cache Region
	*/
	public void function regionRemove( required string region ) {
		if( regionExists( region=arguments.region ) ) {
			cacheRegionRemove( arguments.region ); // remove the Cache Region
		}
		return;
	}
	/**
	* Normalizes and Cleans Cache Key names
	*/
	private string function clean( required string key ) {
		// only allow cache key names to contain Alpha, Numeric, dashes and underscores
		return arguments.key.toString(  ).replaceAll( "[^A-Za-z0-9-_]+", "" );
	}
	/**
	* Generates a time span based on the passed interval
	*/
	private numeric function time( required string interval, required numeric duration ) {
		return createTimeSpan(
			arguments.interval == "days" ? arguments.duration : 0,
			arguments.interval == "hours" ? arguments.duration : 0,
			arguments.interval == "minutes" ? arguments.duration : 0,
			arguments.interval == "seconds" ? arguments.duration : 0
		 );
	}
}