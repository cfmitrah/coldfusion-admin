component output="false"{
	/**
		@created on 09/21/2013 by Aaron Benton :: Mailer init method
		@return Mailer
	*/
	public struct function init(struct values={}){
		if(!structKeyExists(variables, "options")){
			variables['options'] = {
				'env' = "dev",
				'from' = "noreply@excelaweb.com",
				'to' = "",
				'cc' = "",
				'bcc' = "",
				'subject' = "",
				'type' = "html",
				'priority' = 5,
				'body' = "",
				'template' = "",
				'data' = {},
				'attachments' = [],
				'separate' = false
			};
		}
		structAppend(variables.options, arguments.values);
		type(value=variables.options.type); // ensure type is text or html
		if(len(variables.options.template)){
			template(path=variables.options.template, data=variables.options.data);
		}
		return this;
	}
	/**
		@created on 09/21/2013 by Aaron Benton :: Generic Getting to get any of the set options
		@param field Which field to return
		@return null
	*/
	public void function get(required string field){
		return structKeyExists(variables.options, arguments.field) ? variables.options[arguments.field] : "";
	}
	/**
		@created on 09/21/2013 by Aaron Benton :: Generic Setter to set the "from" field
		@param value Who the email is from
		@return null
	*/
	public void function from(required string value){
		variables['options']['from'] = arguments.value;
		return;
	}
	/**
		@created on 09/21/2013 by Aaron Benton :: Generic Setter to set the "to" field
		@param value Who the email is to
		@return null
	*/
	public void function to(required string value){
		variables['options']['to'] = arguments.value;
		return;
	}
	/**
		@created on 09/21/2013 by Aaron Benton :: Generic Setter to set the "cc" field
		@param value Who should be CC'd on the email
		@return null
	*/
	public void function cc(required string value){
		variables['options']['cc'] = arguments.value;
		return;
	}
	/**
		@created on 09/21/2013 by Aaron Benton :: Generic Setter to set the "bcc" field
		@param value Who should be BCC'd on the email
		@return null
	*/
	public void function bcc(required string value){
		variables['options']['bcc'] = arguments.value;
		return;
	}
	/**
		@created on 09/21/2013 by Aaron Benton :: Generic Setter to set the "subject" field
		@param value The subject of the email
		@return null
	*/
	public void function subject(required string value){
		variables['options']['subject'] = arguments.value;
		return;
	}
	/**
		@created on 09/21/2013 by Aaron Benton :: Generic Setter to set the "type" field
		@param value The type of the email, can be "html" or "text"
		@return null
	*/
	public void function type(required string value){
		variables['options']['type'] = arguments.value == "html" ? arguments.value : "text";
		return;
	}
	/**
		@created on 11/07/2013 by Aaron Benton :: Generic Setter to set the "priority" field
		@param value The priority of the email, can be 1-5 w/ 1 being the highest priority
		@return null
	*/
	public void function priority(required numeric value){
		variables['options']['priority'] = arguments.value;
		return;
	}
	/**
		@created on 09/21/2013 by Aaron Benton :: Generic Setter to set the "body" field
		@param value THe body of the email
		@return null
	*/
	public void function body(required string value){
		variables['options']['body'] = arguments.value;
		return;
	}
	/**
		@created on 09/21/2013 by Aaron Benton :: Templating method
		@param path The Relative path to the template to be used
		@param data Any data that the template should have access to via local.whatever
		@return null
	*/
	public void function template(required string path, any data={}){
		var local = arguments.data;
		variables['options']['template'] = arguments.path;
		if(!structIsEmpty(arguments.data)){ // only build if we have data
			variables['options']['data'] = arguments.data;
			build();
		}
		return;
	}
	/**
		@created on 09/21/2013 by Aaron Benton :: Generic Setter to set the "data" field
		@param data Any data that the template should have access to via local.whatever
		@return null
	*/
	public void function data(required any data){
		variables['options']['data'] = arguments.data;
		build(); // always try to rebuild the template after new data is set
		return;
	}
	/**
		@created on 10/26/2013 by Aaron Benton :: Builds the Email template
		@return null
	*/
	public void function build(){
		var local = variables.options.data;
		if(len(variables.options.template)){
			savecontent variable="variables.options.body"{
				include variables.options.template;
			}
		}
		return;
	}
	/**
		@created on 10/13/2013 by Aaron Benton :: Adds a single attachment
		@param path The full path to the attachment
		@return null
	*/
	public void function attachment(required string path){
		arrayAppend(variables.options.attachments, arguments.path);
		return;
	}
	/**
		@created on 09/21/2013 by Aaron Benton :: Sends sends the email
		@return null
	*/
	public void function send(){
		var mail = new Mail();
		var emails = "";
		var cnt = 0;
		var fileCnt = arrayLen(variables.options.attachments);
		if( variables.options.env == "dev"){
			mail.setAttributes({ // this information doesn't change
				'to' = structKeyExists(application.config, "mail") && structKeyExists(application.config.mail, "dev_emails") ? application.config.mail.dev_emails : "joshua.g@excelaweb.com,lisa.vann@meetingplay.com",
				'from' = variables.options.from,
				'subject' = "DEV: " & variables.options.subject,
				'type' = variables.options.type,
				'priority' = variables.options.priority,
				'body' = variables.options.body & "<br /><br /><p>This email would have been sent to the following recipients (TO:) " & variables.options.to & " (CC:) " & variables.options.cc & " (BCC:)" & variables.options.bcc & "</p>"
			});
			for(var a = 1; a <= fileCnt; a++){ // add all of the attachments
				mail.addParam(file=variables.options.attachments[a]);
			}	
			mail.addParam( name="X-Priority", value=3 );					
			mail.send();
		}
		else{
			mail.setAttributes({ // this information doesn't change
				'from' = variables.options.from,
				'cc' = variables.options.cc,
				'bcc' = variables.options.bcc,
				'subject' = variables.options.subject,
				'type' = variables.options.type,
				'priority' = variables.options.priority,
				'body' = variables.options.body
			});
			
			if(variables.options.separate){ // check to see if we need to send each of the emails separately
				emails = listToArray(variables.options.to);
				cnt = arrayLen(emails);
				for(var a = 1; a <= fileCnt; a++){ // add all of the attachments
					mail.addParam(file=variables.options.attachments[a]);
				}
				for(var i = 1; i <= cnt; i++){ // loop over each email address and send it
					mail.setTo(emails[i]);
					mail.send();
				}
			}
			else{ // we don't need to send the email separately so just sent it all at once
				mail.setTo(variables.options.to);
				for(var a = 1; a <= fileCnt; a++){ // add all of the attachments
					mail.addParam(file=variables.options.attachments[a]);
				}
				mail.addParam( name="X-Priority", value=3 );				
				mail.send();
			}
		}
		return;
	}
}