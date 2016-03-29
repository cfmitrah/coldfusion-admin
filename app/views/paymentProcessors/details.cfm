<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="##">Dashboard</a></li>
  <li><a href="#buildURL( 'event.default' )#">Payment Processor</a></li>
  <li class="active">#rc.payment_processor.processor_name# Details</li>
</ol>
<!--// BREAD CRUMBS END //-->
</cfoutput>
<h2 class="page-title color-02">Payment Processor Details</h2>
<p class="page-subtitle">Set information pertaining to a payment processor.</p>
<!--// the tabs //-->
<ul class="nav nav-tabs mt-medium" role="tablist">
		</ul>

<!--// the tabs //-->
<ul class="nav nav-tabs mt-medium" role="tablist">
	<li class="active"><a href="#paymentprocessor-essentials" role="tab" data-toggle="tab">Essentials</a></li>
	<li><a href="#paymentprocessor-creditcards" role="tab" data-toggle="tab">Credit Cards</a></li>
</ul>


<div class="tab-content">
<!--- start of paymentprocessor essentials --->
<cfinclude template="inc/tab.essentials.cfm" />
<!--- end of paymentprocessor essentials --->
<!--- start of paymentprocessor creditcards--->
<cfinclude template="inc/tab.creditcards.cfm" />
<!--- end of paymentprocessor creditcards --->

<!--- start of paymentprocessor creditcard remove modal --->
<cfinclude template="inc/modal.remove_creditcard.cfm" />
<!--- end of paymentprocessor creditcard remove modal --->

</div>