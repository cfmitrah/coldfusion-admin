
component extends="$base" accessors="true"
{

	public void function default( rc ) {
		if( !structKeyExists( rc, "event") ){
			rc.event = "UnknownError";
		}
		if( !structKeyExists( rc, "message") ){
			rc.message = "Unknown%20error";
		}
		rc['mailto'] = "lisa.vann@meetingplay.com,matt.g@excelaweb.com,joshua.g@excelaweb.com";
		rc.mailto &= "?subject=Application Error - " & uCase( rc.event );
		rc.mailto &= "&body=" & uCase( URLDecode( rc.message ) );
		return;
	}
	
	
	public void function testError(){
		var t = 1/0;
	}
}