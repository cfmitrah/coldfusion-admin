<cfxml variable="sig"><CreditTransaction><Total>1.00</Total><CustomerData><Email>demo@demo.com</Email><CustId>12345</CustId><BillingAddress><Address1>5030 Olean St</Address1><FirstName>Matthew</FirstName><LastName>Graf</LastName><City>Fair Oaks</City><State>CA</State><Zip>95628</Zip><Country>USA</Country><Phone>916-961-5146</Phone></BillingAddress></CustomerData><AccountInfo><CardAccount><AccountNumber>4111111111111111</AccountNumber><ExpirationMonth>11</ExpirationMonth><ExpirationYear>2011</ExpirationYear></CardAccount></AccountInfo></CreditTransaction></cfxml>
<cfoutput>
<cfset sig = replaceNoCase(tostring(sig),'<?xml version="1.0" encoding="UTF-8"?>','')>
#sig.trim()#
</cfoutput>
<!--- 

<?xml version="1.0"?>
<GatewayInterface>
<APICredentials>
<Username>username</Username>
<PayloadSignature>signature</PayloadSignature>
<TargetGateway>12345</TargetGateway>
</APICredentials>
<AuthTransaction>
<!-- Optional. Suplying AuthCode results in Force transaction -->
<AuthCode>12345</AuthCode>
<!-- Optional. Supplying Preauth results in Pre-Auth transaction -->
<Preauth/>
<CustomerData>
<Email>kevin@itransact.com</Email>
<BillingAddress>
<Address1>test</Address1>
<Address2>test2</Address2>
<FirstName>John</FirstName>
<LastName>Smith</LastName>
<City>Bountiful</City>
<State>UT</State>
<Zip>84032</Zip>
<Country>USA</Country>
<Phone>801-555-1212</Phone>
</BillingAddress>
<!-- Optional ShippingAddress -->
<ShippingAddress>
<Address1>test</Address1>
<Address2>test2</Address2>
<FirstName>John</FirstName>
<LastName>Smith</LastName>
<City>Bountiful</City>
<State>UT</State>
<Zip>84032</Zip>
<Country>USA</Country>
<Phone>801-555-1212</Phone>
</ShippingAddress>
<!-- Optional Customer ID -->
<CustId>12345</CustId>
</CustomerData>
<!-- Can either supply OrderItems or Total and Description -->
<OrderItems>
<Item>
<Description>test</Description>
<Cost>10.00</Cost>
<Qty>1</Qty>
</Item>
</OrderItems>
<Total>10.00</Total>
<Description>desc</Description>
<AccountInfo>
<!-- Can supply either CardAccount or CheckAccount -->
<CardAccount>
<!-- Supply AccountNumber, ExpirationMonth and ExpirationYear or TrackData -->
<AccountNumber>5454545454545454</AccountNumber>
<ExpirationMonth>01</ExpirationMonth>
<ExpirationYear>2000</ExpirationYear>
<!-- Optional -->
<CVVNumber>123</CVVNumber>
<!-- Track Data if running swipe transaction -->
<TrackData>TRACK DATA</TrackData>
<!-- Supply Ksn, Pin along with TrackData for Debit transactions -->
<Ksn>12345</Ksn>
<Pin>1234</Pin>
</CardAccount>
<CheckAccount>
<AccountNumber>123456</AccountNumber>
<ABA>124000054</ABA>
<SecCode>PPD</SecCode>
</CheckAccount>
</AccountInfo>
<!-- Optional -->
<RecurringData>
<Recipe>text</Recipe>
<RemReps>1</RemReps>
<OrderItems>
<Item>
<Description>test</Description>
<Cost>10.00</Cost>
<Qty>1</Qty>
</Item>
</OrderItems>
<Total>10.00</Total>
<Description>desc</Description>
</RecurringData>
<!-- Optional -->
<TransactionControl>
<SendCustomerEmail>TRUE</SendCustomerEmail> <!-- TRUE/FALSE -->
<SendMerchantEmail>TRUE</SendMerchantEmail> <!-- TRUE/FALSE -->
<TestMode>TRUE</TestMode> <!-- TRUE/FALSE -->
<EmailText>
<EmailTextItem>test1</EmailTextItem>
<EmailTextItem>test1</EmailTextItem>
<EmailTextItem>test1</EmailTextItem>
<EmailTextItem>test1</EmailTextItem>
<EmailTextItem>test1</EmailTextItem>
<EmailTextItem>test1</EmailTextItem>
<EmailTextItem>test1</EmailTextItem>
<EmailTextItem>test1</EmailTextItem>
<EmailTextItem>test1</EmailTextItem>
<EmailTextItem>test1</EmailTextItem>
</EmailText>
</TransactionControl>
<!-- Optional. This information will be saved on our
servers and is available in the XML transaction report. This is
useful if you want to save your own transaction meta-data with a
transaction. -->
<VendorData>
<Element>
<Name>repId</Name>
<Value>1234567</Value>
</Element>
</VendorData>
</AuthTransaction>
</GatewayInterface> --->