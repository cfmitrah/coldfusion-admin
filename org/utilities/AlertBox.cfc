/**
*	a generic container/renderer for alert messages
*/
component accessors="true"
{
	/**
	*	Initializes the object
	*/
	public AlertBox function init ()
	{
		setAlertStorageKey('MP_Alert');
		setAlertStorageScope('session');
		return this;
	}
	
	/**
	*	adds an error alert to the queue
	*/
	public void function addErrorAlert (
				required string message,
				string name=""
			)
	{
		addAlert("danger",arguments.message,arguments.name);
	}
	/**
	*	adds a success alert to the queue
	*/
	public void function addSuccessAlert (
				required string message,
				string name=""
			)
	{
		addAlert("success",arguments.message,arguments.name);
	}
	/**
	*	adds an info alert to the queue
	*/
	public void function addInfoAlert (
				required string message,
				string name=""
			)
	{
		addAlert("info",arguments.message,arguments.name);
	}
	/**
	*	adds a warning alert to the queue
	*/
	public void function addWarningAlert (
				required string message,
				string name=""
			)
	{
		addAlert("warning",arguments.message,arguments.name);
	}
	
	/**
	*	returns the alert message query
	*/
	public query function getAlerts (
			)
	{
		var storage = getAlertStorageScope();
		if ( structKeyExists(storage,getAlertStorageKey()) && isQuery(storage[getAlertStorageKey()]) )
		{
			return storage[getAlertStorageKey()];
		}
		else
		{
			return getNewAlertQuery();
		}
	}
	
	/**
	*	clears the alert storage key from the storage scope
	*/
	public void function clear (
			)
	{
		structDelete(getAlertStorageScope(),getAlertStorageKey());
	}
	
	/**
	*	renders the queued messages
	*/
	public string function render (
				boolean doClear=true, boolean nostyle=false
			)
	{
		var alerts = getAlerts();
		var rtn = "";
		var i = 0;
		for ( i=1; i <= alerts.recordCount; i++ )
		{
			if( nostyle ){
				rtn = rtn & '<div>#alerts.alertmessage[i]#</div>';
			}else{
				rtn = rtn & '<div class="alert alert-#lcase(alerts.alerttype[i])#"><a class="close" data-dismiss="alert" href="##">×</a>#alerts.alertmessage[i]#</div>';
			}
		}
		if ( arguments.doClear )
		{
			clear();
		}
		return rtn;
	}
	
	/**
	*	Returns the non-persistent AlertStorageKey property
	*/
	private string function getAlertStorageKey (
			)
	{
	}
	/**
	*	Sets the non-persistent AlertStorageKey property
	*/
	private void function setAlertStorageKey (
				required string AlertStorageKey
			)
	{
		variables.AlertStorageKey = arguments.AlertStorageKey;
	}
	
	/**
	*	Returns the non-persistent AlertStorageScope property
	*/
	private struct function getAlertStorageScope (
			)
	{
		if ( variables.alertStorageScope IS "session" )
		{
			return session;
		}
		else if ( variables.alertStorageScope IS "client" )
		{
			return client;
		}
		else
		{ // default to session
			return session;
		}
	}
	/**
	*	Sets the non-persistent AlertStorageScope property
	*/
	private void function setAlertStorageScope (
				required string AlertStorageScope
			)
	{
		variables.AlertStorageScope = arguments.AlertStorageScope;
	}
	
	/**
	*	adds an alert message to the queue
	*/
	private void function addAlert (
				required string type,
				required string message,
				string name=""
			)
	{
		var alerts = "";
		var storage = "";
		if ( reFindNoCase("(info|success|warning|error|danger)",arguments.type) == 0 )
		{
			throw(
				type="kuubd.com.model.util.AlertBox.addAlert.invalidType", 
				message="The alert type provided (" & arguments.type & ") is invalid.  Valid values are: 'info', 'success, 'warning', and 'error'."
			);
		}
		storage = getAlertStorageScope();
		if ( !structKeyExists(storage,getAlertStorageKey()) )
		{
			initAlerts();
		}
		alerts = storage[getAlertStorageKey()];
		queryAddRow(alerts);
		querySetCell(alerts,"alerttype",arguments.type);
		querySetCell(alerts,"alertmessage",arguments.message);
		querySetCell(alerts,"alertname",arguments.name);
	}
	public boolean function hasAlerts() {
		var alerts = getAlerts(); 
		return alerts.recordCount;
	}
	/**
	*	returns a fresh alert query
	*/
	private query function getNewAlertQuery (
			)
	{
		return queryNew("AlertType,AlertMessage,AlertName");
	}
	
	/**
	*	initializes the alerts query
	*/
	private void function initAlerts (
			)
	{
		var storage = getAlertStorageScope();
		storage[getAlertStorageKey()] = getNewAlertQuery();
	}
	
}
