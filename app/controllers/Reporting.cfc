
component extends="$base" accessors="true"
{

	public void function after( rc ) {
		rc.has_sidebar 	= false; 
		super.after( rc );
	}

}