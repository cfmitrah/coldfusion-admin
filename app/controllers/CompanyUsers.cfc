component extends="$base" accessors="true"
{
	property name="CompanyManager" setter="true" getter="true";
	property name="EmailManager" setter="true" getter="true";
	property name="UserManager" setter="true" getter="true";
	/**
	* Before Action
	*/
	public void function before( rc ) {
		rc.sidebar = 'sidebar.companyUsers';
		super.before( rc );
		return;
	}
	/**
	* Create an company user
	*/
	public void function create(rc) {	
		
		rc['thisCompanyID'] = SessionManageUserFacade.getCurrentCompanyID();
		
		if (structKeyExists(rc,'email')){
			
			checkUsernameExists = getUserManager().usernameExists(rc.username);
			checkEmailExists = getEmailManager().emailExists(rc.email);
			
			rc.flag_message = "";
			if (checkEmailExists){
				rc.flag_error = true;
				rc.flag_message &= " Email already exists: " & rc.email & ".";
			}
			if (checkUsernameExists){
				rc.flag_error = true;
				rc.flag_message &= " Username already exists. ";
			}
			

			if (!checkUsernameExists && !checkEmailExists){
				
				rc.flag_error = false;
				rc.flag_message &= " New administrative account created for: #rc.first_name# #rc.last_name#";
				
				var userCreateProps = {
					 username = rc.username
					,first_name = rc.first_name
					,last_name = rc.last_name
					,password = 'testing' 	// !!!!!
					,salt = 'testing'  		// !!!!!
					,active = 1
				};			
				
				var emailProps = {
					 email = rc.email
					,opt_out = 0
					,verified = 0
				};
							
				result_userCreate = getUserManager().create(argumentCollection:userCreateProps);
				result_emailSet  = getEmailManager().emailSet(argumentCollection:emailProps);
				getEmailManager().emailNewUser(rc.email, rc.username, userCreateProps.password);
				
				// clear out these values so we dont repopulate the form with the same data after a success
				rc.first_name	=	"";
				rc.last_name	=	"";
				rc.username		=	"";
				rc.email		=	"";
								
			}
			
		}
				
		rc.has_sidebar = true;		
				
		param name="rc.flag_error" default="false";
		param name="rc.first_name" default="";
		param name="rc.last_name" default="";
		param name="rc.username" default="";
		param name="rc.email" default="";
		
		// includes slugify options for display
		getCfStatic()
			.include( "/css/main.css" );		
					
		return;
	}
	
	public any function usernamexists(rc){
		
		var username_exists = getUserManager().usernameExists( rc.username );
		
		getFW().renderData( 'json', username_exists);
		request.layout = false;
		return;
		
	}
}