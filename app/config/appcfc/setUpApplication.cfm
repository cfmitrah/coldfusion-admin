<cfscript>
	try {
		//set up Bean factory
		loc.Dformd_Renderer = new org.dformd.model.cfml.renderers.DformdRenderer( skinFilePath=expandPath( "/assets/skins/mp_reg.Dformd" ) );
		xbf =  new org.corfield.ioc( "/org/utilities,/app/model/managers,/app/model/dao,/app/model/facades", {
			transients = [ "/app/model/facades" ]
		});
		xbf.addBean("framework", this);
		xbf.addBean("dsn", application.config.datasource );
		
		application['config']['expiration_month_options'] = { 'value':[], 'display':[] };
		loc.year = year( now() );
		for ( loc.i=1; loc.i lte 12; loc.i=loc.i+1){
			loc.dt = loc.i & '/1/' & loc.year;
			arrayAppend( application['config']['expiration_month_options']['value'], dateformat( loc.dt, "mm" ) );
			arrayAppend( application['config']['expiration_month_options']['display'], dateformat( loc.dt, "MMMM" ) );
		}
		application['config']['expiration_year_options'] = { 'value':[], 'display':[] };
		loc.year = year( now() );
		for ( loc.i=loc.year; loc.i lte loc.year+8; loc.i=loc.i+1){
			arrayAppend( application['config']['expiration_year_options']['value'], right( loc.i, 2 ) );
			arrayAppend( application['config']['expiration_year_options']['display'], loc.i );
		}
		
		application['config']['detail_types'] = xbf.getBean("registrationManager").getDetailTypes();
		
		xbf.addBean("config", application.config );
		xbf.addBean("cache", new org.utilities.Cache() );

		//create application/url variable to override min-rules
		if( !structKeyExists( application, "cfstatic" ) || listfindnocase('local,dev-qa', getEnvironment()) || structKeyExists( url, "reload") ) {
			loc['CfStatic_param'] = {
				'staticDirectory'="assets/",
				'staticUrl'="/assets/",
				'outputDirectory'="compiled", 
				'includeAllByDefault'=false,
				'addCacheBusters'=true,
				'minifyMode'=( listFindNoCase( "local,dev-qa", getEnvironment() ) ? "none" : "none" ) 
			};
			application['cfstatic'] = new org.cfstatic.CfStatic( argumentCollection=loc.CfStatic_param );
		}
		xbf.addBean("CfStatic", application.cfstatic );
		xbf.addBean("Dformd_Renderer", loc.Dformd_Renderer );
		xbf.addBean("Dformd", new org.dformd.model.cfml.services.DformdService( defaultrenderer:loc.Dformd_Renderer ) );
		application['BeanFactory'] = xbf;
		setBeanFactory( xbf );
		
	}
	catch( any e) {
		writeDump(e);	abort;
	}
</cfscript>