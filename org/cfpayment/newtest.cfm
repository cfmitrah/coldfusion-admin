

<cfoutput>
<cfsavecontent variable="sig"><CreditTransaction><Total>1.00</Total><CustomerData><Email>demo@demo.com</Email><CustId>12345</CustId><BillingAddress><Address1>5030 Olean St</Address1><FirstName>Matthew</FirstName><LastName>Graf</LastName><City>Fair Oaks</City><State>CA</State><Zip>95628</Zip><Country>USA</Country><Phone>916-961-5146</Phone></BillingAddress></CustomerData><AccountInfo><CardAccount><AccountNumber>4111111111111111</AccountNumber><ExpirationMonth>11</ExpirationMonth><ExpirationYear>2011</ExpirationYear></CardAccount></AccountInfo></CreditTransaction></cfsavecontent>
<!--- ZGEbpZSbwoc24560lQYtRpo6PJ8= --->
<cfscript>
	my_key='7FUcX49w8Gr7VS4mkb3M';
	sig = sig.Trim();
	secret = createObject('java', 'javax.crypto.spec.SecretKeySpec' ).Init(my_key.GetBytes(), 'HmacSHA1');
	mac = createObject('java', "javax.crypto.Mac");
	mac = mac.getInstance("HmacSHA1");
	mac.init(secret);
	digest = mac.doFinal(sig.GetBytes());

</cfscript>
<cfdump var="#binaryEncode(digest,'base64')#">
<!--- <cfscript>
	sigLoad = "<RecurDetails><OperationXID>12345</OperationXID></RecurDetails>";
	my_key='12345678901234567890';
	secret = createObject('java', 'javax.crypto.spec.SecretKeySpec' ).Init(my_key.GetBytes(), 'HmacSHA1');
	mac = createObject('java', "javax.crypto.Mac");
	mac = mac.getInstance("HmacSHA1");
	mac.init(secret);
	digest = mac.doFinal(sigLoad.GetBytes());

</cfscript>

<cfdump var="#binaryEncode(digest,'base64')#">

<cfabort> --->

<!--- 
#binaryEncode(digest,'base64')#
<cfdump var="#digest#"><cfabort>

 --->

<cfsavecontent  variable="xmlRequest"><?xml version="1.0"?><GatewayInterface><APICredentials><Username>gama_- origins games_VjkVrtd9</Username><PayloadSignature>#binaryEncode(digest,'base64')#</PayloadSignature><TargetGateway>58373</TargetGateway></APICredentials>#sig.Trim()#</GatewayInterface></cfsavecontent>
</cfoutput>

<cfhttp url="https://secure.paymentclearing.com/cgi-bin/rc/xmltrans2.cgi" method="post"  useragent="#CGI.http_user_agent#" result="objGET" >
	<cfhttpparam type="xml" value="#xmlRequest.Trim()#">
	<!--- <cfhttpparam type="formfield" name="username" value="58373">
	<cfhttpparam type="formfield" name="password" value="C0ldt035"> --->
	
</cfhttp>

<cfdump var="#objGET.Filecontent#">

