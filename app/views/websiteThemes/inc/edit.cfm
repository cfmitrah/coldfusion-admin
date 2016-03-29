<cfoutput>
<!--//FORM START //-->
<form action="#buildURL( 'websiteThemes.doSave' )#" method="post" enctype="multipart/form-data">
	<input type="hidden" name="theme.logo_id" value="#rc.media.logo_id#" />
	<input type="hidden" name="theme.event_id" value="#rc.event_id#" />
	<div class="white-panel">
		<!--//GLOBAL PROPERTIES START //-->
		<h3 class="form-section-title">Logo, Lead Graphic, and Font Family <small>(Your logo and lead graphic will display in the preview once you save your theme)</small></h3>
		<div class="row">
			<div class="form-group col-md-4">
				<label for="logo_id">Logo - <small class="text-danger">200px wide - 80px tall</small></label>
				<input name="theme.logo" id="logo" type="file" class="form-control">
				<cfif len( rc.media.filename )>
					<p class="help-block"><strong>Current Logo:</strong> <a href="/assets/media/#rc.media.filename#">#rc.media.filename#</a></p>
				<cfelse>
					<p class="help-block">No image on file.</p>
				</cfif>
			</div>

			<div class="form-group col-md-4">
				<label for="hero_graphic">Lead Graphic - <small class="text-danger">1200px wide - 400px tall</small></label>
				<!--- We will need to make sure it retains that file value so if they don't want to change it when editing, it won't try to validate --->
				<input id="hero_graphic" name="theme.hero_graphic" type="file" class="form-control">
				<p class="help-block">
				<cfif rc.theme.hero.hero_media_id >
					<strong>Current Lead Graphic: </strong><a href="/assets/media/#rc.theme.hero.hero_filename#" target="_blank">#rc.theme.hero.hero_filename#</a>
				<cfelse>
					<p class="help-block">No image on file.</p>
				</cfif>
				</p>
			</div>

			<div class="form-group col-md-4">
				<label for="font_family_id">Default Font Family</label>
				<select name="theme.font_family_id" id="font_family_id" class="form-control">
					#rc.font_opts#
				</select>
				<p class="help-block">Used in the most common areas.</p>
			</div>
		
		</div>
		<!--//GLOBAL PROPERTIES START //-->
		

		<!--//Color PROPERTIES START //-->
		<h3 class="form-section-title">Background and Text Colors <small>(Click a square to pick your color)</small></h3>
		<div class="row text-center color-block-wrapper">
			<div class="form-group col-md-2">
				<label>Header<br> Background</label>
				<input name="theme.hdr_bkg_c" id="hdr_bkg_c_block_input" type="hidden" class="form-control" value="#rc.theme.hdr_bkg_c#">
				<div id="hdr_bkg_c_block" class="color-block color-input" style="background: ###rc.theme.hdr_bkg_c#"></div>
			</div>

			<div class="form-group col-md-2">
				<label>Navigation<br> Background</label>
				<input name="theme.nav_bkg_c" id="nav_bkg_c_block_input" type="hidden" class="form-control"  value="#rc.theme.nav_bkg_c#">
				<div id="nav_bkg_c_block" class="color-block color-input" style="background: ###rc.theme.nav_bkg_c#"></div>
			</div>

			<div class="form-group col-md-2">
				<label>Navigation<br> Font Color</label>
				<input name="theme.nav_link_text_c" id="nav_link_text_c_block_input" type="hidden" class="form-control" value="#rc.theme.nav_link_text_c#">
				<div id="nav_link_text_c_block" class="color-block color-input" style="background: ###rc.theme.nav_link_text_c#"></div>
			</div>

			<div class="form-group col-md-2">
				<label>Active Navigation<br> Background</label>
				<input name="theme.active_nav_link_bkg_c" id="active_nav_link_bkg_c_block_input" type="hidden" class="form-control" value="#rc.theme.active_nav_link_bkg_c#">
				<div id="active_nav_link_bkg_c_block" class="color-block color-input" style="background: ###rc.theme.active_nav_link_bkg_c#"></div>
			</div>

			<div class="form-group col-md-2">
				<label>Active Navigation<br> Font Color</label>
				<input name="theme.active_nav_link_txt_c" id="active_nav_link_txt_c_block_input" type="hidden" class="form-control" value="#rc.theme.active_nav_link_txt_c#">
				<div id="active_nav_link_txt_c_block" class="color-block color-input" style="background: ###rc.theme.active_nav_link_txt_c#"></div>
			</div>

			<div class="form-group col-md-2">
				<label>Lead Banner<br> Background Color</label>
				<input name="theme.btm_ban_c" id="btm_ban_c_block_input" type="hidden" class="form-control" value="#rc.theme.btm_ban_c#">
				<div id="btm_ban_c_block" class="color-block color-input" style="background: ###rc.theme.btm_ban_c#"></div>
			</div>

			<div class="form-group col-md-2">
				<label>Lead Banner<br> Font Color</label>
				<input name="theme.btm_ban_txt_c" id="btm_ban_txt_c_block_input" type="hidden" class="form-control" value="#rc.theme.btm_ban_txt_c#">
				<div id="btm_ban_txt_c_block" class="color-block color-input" style="background: ###rc.theme.btm_ban_txt_c#"></div>
			</div>
			<div class="form-group col-md-2">
				<label>Lead Graphic<br> Background Color</label>
				<input name="theme.bkg_behind_graphic_c" id="bkg_behind_graphic_c_block_input" type="hidden" class="form-control" value="#rc.theme.bkg_behind_graphic_c#">
				<div id="bkg_behind_graphic_c_block" class="color-block color-input" style="background: ###rc.theme.bkg_behind_graphic_c#"></div>
			</div>
			<div class="form-group col-md-2">
				<label>Bottom Area<br> Background Color</label>
				<input name="theme.btm_area_bkg_c" id="btm_area_bkg_c_block_input" type="hidden" class="form-control" value="#rc.theme.btm_area_bkg_c#">
				<div id="btm_area_bkg_c_block" class="color-block color-input" style="background: ###rc.theme.btm_area_bkg_c#"></div>
			</div>
			<!--- Removed Bottom area standard font color - irrelevant --->
			<div class="form-group col-md-2">
				<label>Location / Time<br> Icon Color</label>
				<input name="theme.loc_time_icon_c" id="loc_time_icon_c_block_input" type="hidden" class="form-control" value="#rc.theme.loc_time_icon_c#">
				<div id="loc_time_icon_c_block" class="color-block color-input" style="background: ###rc.theme.loc_time_icon_c#"></div>

			</div>
			<div class="form-group col-md-2">
				<label>Location / Time<br> Font Color</label>
				<input name="theme.loc_time_font_c" id="loc_time_font_c_block_input" type="hidden" class="form-control" value="#rc.theme.loc_time_font_c#">
				<div id="loc_time_font_c_block" class="color-block color-input" style="background: ###rc.theme.loc_time_font_c#"></div>
			</div>
			<div class="form-group col-md-2">
				<label>Form Header Font Color & Active Form Step BG</label>
				<input name="theme.active_step_bkg_c" id="active_step_bkg_c_block_input" type="hidden" class="form-control" value="#rc.theme.active_step_bkg_c#">
				<div id="active_step_bkg_c_block" class="color-block color-input" style="background: ###rc.theme.active_step_bkg_c#"></div>
			</div>
			<div class="form-group col-md-2">
				<label>Inactive Form Step<br> Background Color</label>
				<input name="theme.frm_step_bkg_c" id="frm_step_bkg_c_block_input" type="hidden" class="form-control" value="#rc.theme.frm_step_bkg_c#">
				<div id="frm_step_bkg_c_block" class="color-block color-input" style="background: ###rc.theme.frm_step_bkg_c#"></div>
			</div>
			<div class="form-group col-md-2">
				<label>Form Step<br> Font Color</label>
				<input name="theme.frm_step_font_c" id="frm_step_font_c_block_input" type="hidden" class="form-control" value="#rc.theme.frm_step_font_c#">
				<div id="frm_step_font_c_block" class="color-block color-input" style="background: ###rc.theme.frm_step_font_c#"></div>
			</div>
			<div class="form-group col-md-2">
				<label>Button<br> Background Color</label>
				<input name="theme.btn_bkg_c" id="btn_bkg_c_block_input" type="hidden" class="form-control" value="#rc.theme.btn_bkg_c#">
				<div id="btn_bkg_c_block" class="color-block color-input" style="background: ###rc.theme.btn_bkg_c#"></div>
			</div>
			<div class="form-group col-md-2">
				<label>Button<br> Font Color</label>
				<input name="theme.btn_font_c" id="btn_font_c_block_input" type="hidden" class="form-control" value="#rc.theme.btn_font_c#">
				<div id="btn_font_c_block" class="color-block color-input" style="background: ###rc.theme.btn_font_c#"></div>
			</div>
			<div class="form-group col-md-2">
				<label>Subpage Header<br> Background Color</label>
				<input name="theme.stbc" id="stbc_block_input" type="hidden" class="form-control" value="#rc.theme.stbc#">
				<div id="stbc_block" class="color-block color-input" style="background: ###rc.theme.stbc#"></div>
			</div>
			<div class="form-group col-md-2">
				<label>Subpage Title<br> Font Color</label>
				<input name="theme.stfc" id="stfc_block_input" type="hidden" class="form-control" value="#rc.theme.stfc#">
				<div id="stfc_block" class="color-block color-input" style="background: ###rc.theme.stfc#"></div>
			</div>
			<div class="form-group col-md-2">
				<label>Subpage Body<br> Background Color</label>
				<input name="theme.sbbc" id="sbbc_block_input" type="hidden" class="form-control" value="#rc.theme.sbbc#">
				<div id="sbbc_block" class="color-block color-input" style="background: ###rc.theme.sbbc#"></div>
			</div>
			<div class="form-group col-md-2">
				<label>Section Summary<br>Table Header Font Color</label>
				<input name="theme.dsrh_font_c" id="dsrh_font_c_block_input" type="hidden" class="form-control" value="#rc.theme.dsrh_font_c#">
				<div id="dsrh_font_c_block" class="color-block color-input" style="background: ###rc.theme.dsrh_font_c#"></div>

			</div>
			<!--- Removed Body Font Color - Irrelevant --->
		</div>
		<!--//Color PROPERTIES END //-->
		
		<div class="row">
			<div class="col-md-12" style="padding-left: 5px; padding-right: 5px;">
				<button type="submit" class="btn btn-success btn-block btn-lg" style="height: 80px; font-size: 1.3em;"><strong>Save Theme</strong></button>
			</div>
		</div>
	</div>
</form>
<!--// fORM END //-->


<div id="preview-theme-overlay">
	<br>
	<div id="layout-nav-btns">
		<a href="##" class="btn btn-default btn-primary" rel="layout-one">Layout One</a>
		<a href="##" class="btn btn-default" rel="layout-two">Layout Two</a>
		<a href="##" class="btn btn-default" rel="layout-three">Layout Three</a>
	</div>
	<a href="##" id="close-theme-preview">&times;</a>
	<div id="theme-container">
		<div id="layout-one" class="layout-changer">
		    <div id="theme-header">
		        <div class="content">
			        <cfif len( rc.media.filename )>
	                	<img src="/assets/media/#rc.media.filename#" alt="" id="logo">
	                <cfelse>
	                	<img src="/assets/img/theme-demo-logo.jpg" alt="" id="logo">
	                </cfif>
		            <ul id="navigation">
		                <li><a href="##" class="active">Registration</a></li>
		                <li><a href="##">Sub Page</a></li>
		                <li><a href="##">Contact</a></li>
				    </ul>
		        </div>
		    </div>
		    <div id="hero-image">
		        <div class="content">
		            <div id="hero-container" class="relative">
		                
		                <cfif rc.theme.hero.hero_media_id >
		                	<img src="/assets/media/#rc.theme.hero.hero_filename#" alt="">
		                <cfelse>
		                	<img src="/assets/img/lead-img-demo.jpg" alt="">
		                </cfif>
		            </div>
		            <div id="hero-text">
		                Welcome to Your Theme Preview!
		            </div>
		        </div>
		    </div>
		    <div id="bottom-wrap">
				<div id="event-details">
		            <div class="content clearfix">
		                <p class="relative"><span class="glyphicon glyphicon-map-marker"></span> Set event location will display here</p>
		                <p class="relative"><span class="glyphicon glyphicon-time"></span> Set event dates will display here</p>
		                <a href="##form-steps" class="btn btn-primary btn-lg pull-right" id="begin-btn">Begin Registration</a>
		            </div>
		        </div>
		        <div id="event-description">
					<div class="content">
						<p>This is where your landing page copy would display! You can set landing page copy, event location copy, and event date copy from the landing page content tab within the <a href="#buildURL( 'event.details?event_id=' & rc.event_id )#" target="_blank">main details section</a>.  Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus voluptatum quo fugit adipisci sequi repellat laborum temporibus quia! Earum amet velit quis officia consequatur minus ut corporis aut quia assumenda. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sit exercitationem aliquam a, minima sed adipisci vitae mollitia deserunt, quaerat blanditiis quos commodi odit eum unde et repellat! Praesentium, deleniti, eos?</p>
					</div>
		        </div>
		        <div id="form-steps">
	        	    <div class="content">
	        	        <div id="form-wrap" class="relative">
	        	            <div id="form-navigation" class="cf">
        	                    <a class="step-nav-1 active" data-toggle="tooltip" data-placement="top" title="" id="Begin" data-original-title="Begin">
        		                    1<span class="form-nav-copy"> Begin</span>
        		                </a>
        	                    <a class="step-nav-1 " data-toggle="tooltip" data-placement="top" title="" id="Confirmation" data-original-title="Confirmation">
        		                    2<span class="form-nav-copy"> Confirmation</span>
        		                </a>
	        	            </div>
	        	            
				        	<form id="registration-form">		        	    
						        <div id="step-1" class="step">
						            <div id="fake-step-one"> 
						                <a href="##">Step One - Begin Registration</a>
						            </div>
						            <h3>Begin Registration</h3>
						            <div class="container-fluid form-horizontal">
						                <div class="row">
						                    <div class="form-group form-group-sm">
						                        <label for="" class="required control-label col-md-4">First name</label>
						                        <div class="col-md-8">
						                            <input type="text"  class="form-control">
						                        </div>
						                    </div>
						                    <div class="form-group form-group-sm">
						                        <label for="" class="required control-label col-md-4">Last Name</label>
						                        <div class="col-md-8">
						                            <input type="text" class="form-control">
						                        </div>
						                    </div>
						                    <div class="form-group form-group-sm">
						                        <label for="" class="required control-label col-md-4">Email Address</label>
						                        <div class="col-md-8">
						                            <input type="text" class="form-control">
						                        </div>
						                    </div>
						                    <div class="form-group form-group-sm">
						                        <label for="" class="required control-label col-md-4">Create a Password</label>
						                        <div class="col-md-8">
						                            <input type="text" class="form-control">
						                        </div>
						                    </div>
						                    <div class="form-group form-group-sm">
						                        <label for="" class="required control-label col-md-4">Attendee Type</label>
						                        <div class="col-md-8">
						                            <select name="" id="" class="form-control">
														<option value="">Guest</option>
						                            </select>
						                        </div>
						                    </div>
						                    <div class="form-group form-group-sm">
						                    	<div class="col-md-4 col-md-offset-8">
													<button class="btn btn-lg btn-success btn-block next pull-right" type="submit">Next</button>
						                    	</div>
							                </div>
						                </div>
						                
						            </div>
						        </div>

				        	</form>

	        	        </div>
	        	    </div>
	        	</div>
		    </div>
	    </div>
	</div>
</div>

</cfoutput>