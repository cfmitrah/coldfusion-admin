<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html> 
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <cfinclude template="email.css.cfm" />        
	</head>
	<cfoutput>
    <body leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" offset="0">
    	<center>
        	<table border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" id="backgroundTable">
            	<tr>
                	<td align="center" valign="top">
                        <!-- // End Template Preheader \\ -->
                    	<table border="0" cellpadding="0" cellspacing="0" width="600" id="templateContainer">
                            <Cfif structkeyexists( local, 'header_image' ) &&  len( local.header_image )>
	                        	<tr>
	                            	<td align="center" valign="top">
	                                    <!-- // Begin Template Header \\ -->
	                                	<table border="0" cellpadding="0" cellspacing="0" width="600" id="templateHeader">
	                                        <tr>
	                                            <td class="headerContent">
	                                            	
	                                            	<!-- // Begin Module: Standard Header Image \\ -->
	                                            	<img src="http://#cgi.server_name#/assets/media/#local.header_image#" style="max-width:600px;" id="headerImage campaign-icon"/>
	                                            	<!-- // End Module: Standard Header Image \\ -->                                            
	                                            </td>
	                                        </tr>
	                                    </table>
	                                    <!-- // End Template Header \\ -->
	                                </td>
	                            </tr>
                            </Cfif>	
                        	<tr>
                            	<td align="center" valign="top">
                                    <!-- // Begin Template Body \\ -->
                                	<table border="0" cellpadding="0" cellspacing="0" width="600" id="templateBody">
                                    	<tr>
                                            <td valign="top" class="bodyContent">
                                
                                                <!-- // Begin Module: Standard Content \\ -->
                                                <table border="0" cellpadding="20" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td valign="top">
                                                            <div>
                                                                #local.body#
                                                            </div>
															<Cfif structkeyExists( local, 'record' ) && structKeyExists( local, 'template_data' ) && local.template_data.response eq 1>
																<div>
																	<table style="width:100%" align="center" border="0">
																	    <tbody>
																	        <tr>
																	            <td width="50%" align="center">
																					<div style="float: left;margin-right: 10px;">
																						<!--[if mso]>
																							<v:roundrect xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="urn:schemas-microsoft-com:office:word" href="https://#cgi.server_name#/autoTask/acceptInvite?company_id=#local.record.company_id#&event_id=#local.record.event_id#&invite_id=#local.record.invite_id#&invitation_schedule_id=#local.email_data.invitation_schedule_id#&invitation_id=#local.email_data.invitation_id#" style="height:40px;v-text-anchor:middle;width:280px;" arcsize="10%" stroke="f" fillcolor="###rereplace( local.template_data.settings[ 'ACCEPT' ].btn_color, "[^\w]", "", "ALL" )#">
																								<w:anchorlock/>
																								<center style="color:##ffffff;font-family:sans-serif;font-size:16px;font-weight:bold;">
																									#local.template_data.settings[ 'ACCEPT' ].btn_text#
																								</center>
																							</v:roundrect>
																						<![endif]-->
																						<![if !mso]>
																							<table cellspacing="0" cellpadding="0"> 
																								<tr> 
																									<td align="center" width="280" height="40" bgcolor="###rereplace( local.template_data.settings[ 'ACCEPT' ].btn_color, "[^\w]", "", "ALL" )#" style="-webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px; color: ##ffffff; display: block;">
																										<a href="https://#cgi.server_name#/autoTask/acceptInvite?company_id=#local.record.company_id#&event_id=#local.record.event_id#&invite_id=#local.record.invite_id#&invitation_schedule_id=#local.email_data.invitation_schedule_id#&invitation_id=#local.email_data.invitation_id#" style="font-size:16px; font-weight: bold; font-family:sans-serif; text-decoration: none; line-height:40px; width:100%; display:inline-block">
																											<span style="color: ##ffffff;">
																											#local.template_data.settings[ 'ACCEPT' ].btn_text#
																											</span>
																										</a>
																									</td> 
																								</tr> 
																							</table> 
																						<![endif]>
																					</div>																
																	            </td>
																	            <td width="50%" align="center">
																					<div style="float: left;">
																						<!--[if mso]>
																							<v:roundrect xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="urn:schemas-microsoft-com:office:word" href="https://#cgi.server_name#/autoTask/declineInvite?company_id=#local.record.company_id#&event_id=#local.record.event_id#&invite_id=#local.record.invite_id#&invitation_schedule_id=#local.email_data.invitation_schedule_id#&invitation_id=#local.email_data.invitation_id#" style="height:40px;v-text-anchor:middle;width:280px;" arcsize="10%" stroke="f" fillcolor="###rereplace( local.template_data.settings[ 'DECLINE' ].btn_color, "[^\w]", "", "ALL" )#">
																								<w:anchorlock/>
																									<center style="color:##ffffff;font-family:sans-serif;font-size:16px;font-weight:bold;">
																										#local.template_data.settings[ 'DECLINE' ].btn_text#
																									</center>
																								</v:roundrect>
																						<![endif]-->
																						<![if !mso]>
																							<table cellspacing="0" cellpadding="0"> 
																								<tr> 
																									<td align="center" width="280" height="40" bgcolor="###rereplace( local.template_data.settings[ 'DECLINE' ].btn_color, "[^\w]", "", "ALL" )#" style="-webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px; color: ##ffffff; display: block;">
																										<a href="https://#cgi.server_name#/autoTask/declineInvite?company_id=#local.record.company_id#&event_id=#local.record.event_id#&invite_id=#local.record.invite_id#&invitation_schedule_id=#local.email_data.invitation_schedule_id#&invitation_id=#local.email_data.invitation_id#" style="font-size:16px; font-weight: bold; font-family:sans-serif; text-decoration: none; line-height:40px; width:100%; display:inline-block">
																											<span style="color: ##ffffff;">
																											#local.template_data.settings[ 'DECLINE' ].btn_text#
																											</span>
																										</a>
																									</td> 
																								</tr> 
																							</table> 
																						<![endif]>
																					</div>
																	            </td>
																	        </tr>
																	    </tbody>
																	</table>																																
																</div>
															</Cfif>
														</td>
                                                    </tr>
                                                </table>
                                                <!-- // End Module: Standard Content \\ -->
                                                
                                            </td>
                                        </tr>
                                    </table>
                                    <!-- // End Template Body \\ -->
                                </td>
                            </tr>
                        	<tr>
                            	<td align="center" valign="top">
                                    <!-- // Begin Template Footer \\ -->
                                	<table border="0" cellpadding="10" cellspacing="0" width="600" id="templateFooter">
                                    	<tr>
                                        	<td valign="top" class="footerContent">
                                            
                                                <!-- // Begin Module: Standard Footer \\ -->
                                                <table border="0" cellpadding="10" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td valign="top" width="350">
                                                            <div>
																<cfif structKeyExists( local,"footer") and len( local.footer )>
		                                                        	#local.footer#
		                                                        <cfelse>
																<em>Copyright &copy; #year(now())# Meeting Play, All rights reserved.</em>
	                                                            </cfif>
																<br />

																This email is automatically generated, please do not reply directly
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <!-- // End Module: Standard Footer \\ -->
                                            </td>
                                        </tr>
                                    </table>
                                    <!-- // End Template Footer \\ -->
                                </td>
                            </tr>
                    	</table>
                    	<br />
                	</td>
            	</tr>				
        	</table>
    	</center>	
    </body>
	</cfoutput>
</html>	    
