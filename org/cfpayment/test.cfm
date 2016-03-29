
	<cfset  gw = structNew() />

	<cfscript>  
		variables.svc = createObject("component", "cfpayment.api.core");
		
		gw.path = "itransact.itransact_cc";
		// THESE TEST CREDENTIALS ARE PROVIDED AS A COURTESY BY ITRANSACT TO THE CFPAYMENT PROJECT
		// THERE IS NO GUARANTEE THEY WILL REMAIN ACTIVE
		// CONTACT SUPPORT@ITRANSACT.COM FOR YOUR OWN TEST ACCOUNT
		gw.MerchantAccount = 58373;
		gw.Username = 'gama_- origins games_VjkVrtd9';
		gw.Password = '7FUcX49w8Gr7VS4mkb3M';
		gw.TestMode = false;		// defaults to true anyways

		// create gw and get reference			
		variables.svc.init(gw);
		variables.gw = variables.svc.getGateway();
		r = gw.void(transactionid = 33170367);
	</cfscript>
<cfdump var="#r.GETMEMENTO()#"><cfabort>




<cffunction name="testAuthorizeOnly" access="public" returntype="void" output="true">

	<cfset var account = variables.svc.createCreditCard() />
		<cfset var money = variables.svc.createMoney(100) /><!--- in cents, $50.00 --->
		<cfset var response = "" />
		<cfset var options = structNew() />
		
		<cfset account.setAccount(4011080000385295) />
		<cfset account.setMonth(08) />
		<cfset account.setYear(2020) />
		<cfset account.setVerificationValue(510) />
		<cfset account.setFirstName("Matthew") />
		<cfset account.setLastName("graf") />
		<cfset account.setAddress("5030 olean St.") />
		<cfset account.setPostalCode("95628") />
		<cfset account.setregion('CA')>
		<cfset account.setCity('Fair Oaks')>
		<cfset account.setCountry('US')>
		<cfset options.ExternalID = createUUID() />
		<cfset options.reg_id = "221" />

		<!--- do some debugging --->

		<!--- 5454 card will result in an error for bogus gateway --->
		<cfset response = gw.purchase(money = money, account = account, options = options) />
<cfdump var="#response.getMemento()#">
<cfdump var="#response.getSuccess()#">

</cffunction>

<cfset testAuthorizeOnly()>
<>
017261
<AuthCode>017261</AuthCode>
<XID>33170367</XID>