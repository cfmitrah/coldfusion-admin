<cfoutput>
<!DOCTYPE html>
<!--[if lt IE 7]><html lang="en-us" class="no-js lt-ie9 lt-ie8 lt-ie7"><![endif]-->
<!--[if IE 7]><html lang="en-us" class="no-js lt-ie9 lt-ie8"><![endif]-->
<!--[if IE 8]><html lang="en-us" class="no-js lt-ie9"><![endif]-->
<!--[if IE 9 ]><html lang="en-us" class="no-js ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html lang="en-us" class="no-js"><!--<![endif]-->
<head>
	<meta charset="utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	<title>MeetingPlay Registration</title>
	<!-- start: Prefetch -->
	<meta http-equiv="x-dns-prefetch-control" content="on"/>
	<link rel="dns-prefetch" href="//cdnjs.cloudflare.com"/>
	<link rel="dns-prefetch" href="//ajax.googleapis.com"/>
	<link rel="dns-prefetch" href="//maxcdn.bootstrapcdn.com"/>
	<link rel="dns-prefetch" href="//fonts.googleapis.com"/>
	<link rel="dns-prefetch" href="//www.google-analytics.com"/>
	<!-- end: Prefetch -->
	<!-- start: css -->
	<!--- <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet"/> --->
	#getBeanFactory().getBean("CfStatic").renderIncludes("css")#
	<!-- end: css -->
	<!-- start: js -->
	<script src="//cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.2/modernizr.min.js"></script>
	<!-- end: js -->
</head>
<body>
<div id="header" class="container-fluid">
	<div class="row">
		<div class="col-md-2">
			<h1><a href="/" class="text-hide">Meeting Play</a></h1>
		</div>
		<cfif structKeyExists( rc, "has_topnav") && rc.has_topnav >
			<div class="col-md-5">
				<ul id="navigation-tier-one" class="clearfix">
					<cfif ListFindNoCase( rc.SessionManageUserFacade.getSecurityRoles(), "System Administrator") >
					<li><a href="#buildUrl('company')#">Company</a></li>
					</cfif>
					<li><a href="#buildUrl('event')#" >Events</a></li>
					<cfif val( rc.SessionManageUserFacade.getValue("current_event_id") )>
					<li><a href="#buildUrl(action="event.details", querystring="event_id=" & rc.SessionManageUserFacade.getValue("current_event_id") )#" >Event Details</a></li>
					</cfif>
					<li><a href="#buildUrl('attendee')#">Attendees</a></li>
					<!---<li><a href="#buildUrl('configuration')#">Config</a></li>--->
					<cfif val( rc.SessionManageUserFacade.getValue("current_event_id") )>
					<li><a href="#buildUrl('standardReports.default')#" >Reports</a></li>
					</cfif>
				</ul>
			</div>
			<!--- <div class="col-md-2">
				<form action="" id="search-form">
					<input type="text" class="form-control" placeholder="Search...">
					<button type="submit"><span class="glyphicon glyphicon-search"></span></button>
				</form>
			</div> --->
			<cfif structKeyExists(rc, "SessionManageUserFacade") && rc.SessionManageUserFacade.isLoggedIn() >
				<div class="col-md-5">
				<p id="welcome-drop">Hello, <a href="#buildUrl('account')#" class="color-01">#rc.SessionManageUserFacade.getFullName()#</a> | <a href="/security/doLogout" class="color-01">Logout</a> </p>
				</div>
			</cfif>
			<!--- <cfif val( rc.SessionManageUserFacade.getValue("current_event_id") )>
				<cfset local.prefix = "https" />
				<cfif cgi.SERVER_PORT EQ 80>
					<cfset local.prefix = "http" />
				</cfif>
				<div class="col-md-2">
					<a href="#local.prefix#://#rc.event.details.domain_name#/#rc.event.details.slug#/register/" target="_blank" class="btn btn-block btn-info" style="margin: 5px 0 0 0">View Live Reg Site</a>
				</div>
			</cfif> --->
		</cfif>
	</div>
</div>
<div id="page">
	<cfif rc.has_sidebar >
		<div id="sidebar">
			<cfinclude template="_inc/#rc.sidebar#.cfm"/>
		</div>
	</cfif>
	<div id="main-content-wrapper">
		<div id="main-content" class="#( rc.has_sidebar ? 'has-sidebar' : 'no-sidebar' )#">
			<cfif structKeyExists(rc, "notification") >#rc.notification#</cfif>
			#body#
		</div>
	</div>
</div>
<br class="cf"/>
<!--- <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script> --->
#getBeanFactory().getBean("CfStatic").renderIncludes("js")#
</body>
</html>
</cfoutput>