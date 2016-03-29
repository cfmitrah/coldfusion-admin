<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'attendee.default' )#">Attendees</a></li>
  <li class="active">Create Attendee</li>
</ol>
<h2 class="page-title color-02">Create Attendee</h2>
<p class="page-subtitle"></p>
<!--// BREAD CRUMBS END //-->
<form id="registration-form" action="#buildURL("attendee.docreate")#" method="post" data-parsley-validate="" data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden" novalidate="">
	<input type="hidden" name="register_field.parent_attendee_id" id="parent_attendee_id" value="#val( rc.parent_id )#"/>
	<input type="hidden" name="register_field.registration_id" id="registration_id" value="#val( rc.registration_id )#"/>
    <div class="container-fluid">
        <div class="row">
            <div class="form-group col-md-6 col-md-offset-3">
                <label for="" class="required">First Name</label>
                <input type="text" name="register_field.first_name" class="form-control" required />
            </div>
            <div class="form-group col-md-6 col-md-offset-3">
                <label for="" class="required">Last Name</label>
                <input type="text" name="register_field.last_name" class="form-control" required />
            </div>
            <div class="form-group col-md-6 col-md-offset-3">
                <label for="" class="required">Email Address</label>
                <input type="email" name="register_field.email" class="form-control" required />
            </div>
            <div class="form-group col-md-6 col-md-offset-3">
                <label for="" class="required">Password</label>
                <input type="password" name="register_field.password" class="form-control" required />
            </div>
            <cfif val( rc.registration_type_id ) >
	            <input type="hidden" name="register_field.registration_type" id="registration_type" value="#rc.registration_type_id#" />
            <cfelse>
            <div class="form-group col-md-6 col-md-offset-3">
                <label for="" class="required">Attendee Type</label>
                <select name="register_field.registration_type" id="registration_type" class="form-control" required placeholder_text_single="Choose Your Type">
	                <option value="" data-has_access_code="false"></option>
                    <cfloop from="1" to="#rc.registration_type.count#" index="local.type_idx">
                        <cfset local.type = rc.registration_type.types[ local.type_idx ] />
                        <option value="#local.type.registration_type_id#" data-has_access_code="#local.type.has_access_code#">#local.type.registration_type#</option>
                    </cfloop>
                    <!---<optgroup label="Choose Your Type"></optgroup>--->
                </select>
            </div>
             <div class="form-group col-md-6 col-md-offset-3" id="access_code_wrapper">
                <label for="" class="required">Access Code</label>
                <input type="text" name="register_field.access_code" class="form-control" required="" />
                <input type="hidden" name="register_field.check_code" id="check_code" value="false"/>
            </div>
            </cfif>
           
        </div>
        <div class="row mt-large">
            <div class="col-md-12">
                <button class="btn btn-lg btn-success next pull-right" type="submit">Next</button>
            </div>
        </div>
    </div>

</form>
</cfoutput>