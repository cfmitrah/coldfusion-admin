/**
*
* I am the DAO for the Slug object
* @file  /model/dao/Slug.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/**
	* I create a slug.
	* @slug The slug that you want to create
	*/
	public boolean function slugSet( required string slug ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "SlugSet"
		});
		sp.addParam( type="in", dbvarname="@slug", cfsqltype="cf_sql_varchar", maxlength=300, value=trim( arguments.slug ) );
		sp.addParam( type="out", dbvarname="@slug_id", cfsqltype="cf_sql_integer", variable="slug_id" );
		result = sp.execute();
		return result.getProcOutVariables().slug_id;
	}

}