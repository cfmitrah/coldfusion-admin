component extends="$base" accessors="true"{
 	property name="clientReportManager";
	property name="config";

 	//**************
 	// METHOD NAME - before
 	//**************
	public void function before( rc ) {
		//we need to make sure we do in fact have a company ID		
		if( ! getCurrentCompanyID() ){
			redirect('company.select');
		}
		if( !getCurrentEventID() ){
			redirect('event.select');
		}
		rc['sidebar'] = "sidebar.event.details";
		super.before( rc );
		return;
	}
 	//**************
 	// METHOD NAME - default
 	//**************
	public void function default(rc) {
		rc.reports = getClientReportManager().getClientReportList(argumentCollection={
			'event_id' : rc.event_id
		});
		return;
	}
	//**************
	// METHOD NAME - downloadReport
	//**************
	public void function downloadReport( rc ){
		var file = getClientReportManager().downloadReport(argumentCollection={
			'client_report_id' : rc.client_report_id,
			'event_id' : rc.event_id
		});
		//force download
		location( file );
		return;
	}
	
}