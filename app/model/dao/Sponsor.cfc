/**
* 
* I am the DAO for the Sponsor object
* @file  /model/dao/Sponsor.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/**
	* I check to see if an sponsor slug exists for an event
	* @event_id The ID of the event that you are checking the sponsor slug for
	* @slug The slug that you are checking
	*/
	public boolean function sponsorSlugExists( required numeric event_id, required string slug ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SponsorSlugExists"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", maxlength=300, value=trim( arguments.slug ) );
		sp.addParam( type="out", dbvarname="@in_use", cfsqltype="cf_sql_bit", variable="exists" );
		result = sp.execute();
		return result.getProcOutVariables().exists;
	}

}