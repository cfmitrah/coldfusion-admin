component extends="$base" accessors="true" securityroles="public"{
	property name="EmailManager" setter="true" getter="true";
	property name="ScheduledReportsManager" setter="true" getter="true";	
	property name="CSVUtilities" setter="true" getter="true";


	public void function readCSV(){
		var path  = GetDirectoryFromPath( GetCurrentTemplatePath() );
				
		var file = deserializeJSON( fileRead( path & 'parser.csv' ) );
		var file_cnt = arrayLen( file );
		for( var i = 1; i<=file_cnt; i++ ){
			var data = file[ i ];
			var columns_fields = listToArray( structKeyList( data ) );
			var columns_cnt = arrayLen( columns_fields );
			writeoutput( '<p><b>' );
			writeoutput( data[ 'first_name' ] & ' ' & data[ 'last_name' ] );
			writeoutput( '</b></p>' );
			
			writeoutput( '<ul>' );
			for( var k=1; k<=columns_cnt; k++ ){
				writeoutput( '<li>' );
				if( columns_fields[ k ] == 'custom' ){
					var custom = deSerializeJSON( data[ 'custom' ] );
					var custom_fields = listToArray( structKeyList( custom ) );
					var custom_fields_cnt = arrayLen( custom_fields );
					
					writeoutput( '<b>Custom Fields</b><br /><br />' );					
					writeoutput( '<ul>' );
						for( var x=1; x<=custom_fields_cnt; x++ ){
							writeoutput( '<li>' );
							writeoutput( lcase( custom_fields[ x ] ) & ': "' & custom[ custom_fields[ x ] ] & '"');
							writeoutput( '</li>' );
						}
					writeoutput( '</ul><br /><br />' );
					
				}else{
					writeoutput( columns_fields[ k ] & ': ' & data[ columns_fields[ k ] ] );				
				}
				writeoutput( '</li>' );
			}
			writeoutput( '</ul><br /><hr /><br />' );

		}
		



		abort;
	}

		
	public void function sendScheduledReports(){
		getScheduledReportsManager().sendScheduledReports( send_date=now() );
		abort;
	}	
	
	/** 
	* sendScheduledEmails 		
	* This method will queue up and send out the scheduled emails
	**/
	public void function sendScheduledEmails() {		
		getEmailManager().sendScheduledEmails( send_date=now() );
		abort;		
	}
	/**
	* declineInvite 		
	* This method will execute the declining of an invitation
	**/
	public void function declineInvite( rc ) {
		structAppend( rc, {'invitation_id': 0}, false );
		var params = {
			'invite_id' : rc.invite_id,
			'invitation_schedule_id' : rc.invitation_schedule_id,
			'event_id' : rc.event_id,
			'response_type' : 'decline',
			'company_id' : rc.company_id,
			'invitation_id': rc.invitation_id
		};
		//TODO - need to run a call to decline the invitee and need to redirect the the decline page of that domain. 
		var redirect_url = getEmailManager().setInvitationEmailResponse( argumentCollection=params );
		location( url=redirect_url, addToken="no" );
		abort;
	}
	/**
	* acceptInvite 		
	* This method will execute the appepting of an invitation
	**/
	public void function acceptInvite( rc ) {
		structAppend( rc, {'invitation_id': 0}, false );
		var params = {
			'invite_id' : rc.invite_id,
			'invitation_schedule_id' : rc.invitation_schedule_id,
			'event_id' : rc.event_id,
			'response_type' : 'accept',
			'company_id' : rc.company_id,
			'invitation_id': rc.invitation_id
		};		
		//TODO - need to run a call to decline the invitee and need to redirect the the decline page of that domain. 
		var redirect_url = getEmailManager().setInvitationEmailResponse( argumentCollection=params );

		location( url=redirect_url, addToken="no" );
		abort;
	}
}
