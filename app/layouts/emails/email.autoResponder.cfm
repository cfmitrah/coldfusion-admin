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
							<Cfif len( local.header_filename )>
	                        	<tr>
	                            	<td align="center" valign="top">
	                                    <!-- // Begin Template Header \\ -->
	                                	<table border="0" cellpadding="0" cellspacing="0" width="600" id="templateHeader">
	                                        <tr>
	                                            <td class="headerContent">
	                                            	<!-- // Begin Module: Standard Header Image \\ -->
	                                            	<img src="#local.media_path##local.header_filename#" style="max-width:600px;" id="headerImage campaign-icon"/>
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
                                                                #local.before_body#
                                                            </div>
															<cfif structkeyexists( local, 'body' ) && len( local.body )>
																<div>#local.body#</div>
															</cfif>
                                                            <div>
                                                                #local.after_body#
                                                            </div>
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
																<em>Copyright &copy; 2015 Meeting Play, All rights reserved.</em>
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