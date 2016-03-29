<cfinclude template="shared/header.cfm"/>
<cfinclude template="shared/navigation.cfm"/>

<div id="page">
	<cfinclude template="shared/event-sidebar.cfm"/>

	<!--- Sidebar Ends Content Starts --->
	<div id="main-content-wrapper" class="has-sidebar">
		<div id="main-content">
			<ol class="breadcrumb">
			  <li><a href="#">Dashboard</a></li>
			  <li><a href="#">Events</a></li>
			  <li><a href="#">Event Name</a></li>
			  <li class="active">Site Theme</li>
			</ol>
			<div id="action-btns" class="pull-right">
				<a href="##" class="btn btn-lg btn-info">Preview Theme</a>
			</div>
			<h2 class="page-title color-02">Registration Site Theme</h2>
			<p class="page-subtitle">Here you can manage the colors and backgrounds of your registration website. Once finished be sure to save.</p>
			<form action="" class="basic-wrap mt-medium">
			<div class="container-fluid">
				<h3 class="form-section-title">Global Properties</h3>
				<div class="row">
					<div class="form-group col-md-6">
						<label for="">Logo <small>(No taller than 120px)</small></label>
						<input type="file" class="form-control">
						<p class="help-block">The logo will appear in the top left corner of the page.</p>
					</div>
					<div class="form-group col-md-6">
						<label for="">Font Family</label>
						<select name="" id="" class="form-control">
							<option value=""></option>
						</select>
						<p class="help-block">The global font which will display in the most common areas.</p>
					</div>
				</div>
				<h3 class="form-section-title">Header &amp; Navigation Properties</h3>
				<div class="row">
					<div class="col-md-6">
						<div class="alert alert-info">
							<strong>Color Pickers:</strong><br>
							Once you've chosen the color you'd like to use, press the small colored circle icon in the bottom right hand corner of the color picker to save the chosen color.
						</div>
					</div>
					<div class="form-group col-md-6">
						<label for="">Header Background Color</label>
						<input type="text" class="form-control color-input">
						<p class="help-block">This color will be behind the logo and navigation filling the width of the page</p>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-6">
						<label for="">Navigation Background Color</label>
						<input type="text" class="form-control color-input">
						<p class="help-block">Will sit on top of the header background color</p>
					</div>
					<div class="form-group col-md-6">
						<label for="">Navigation Link Text Color</label>
						<input type="text" class="form-control color-input">
						<p class="help-block">Will sit on top of the navigation background color</p>
					</div>
					<div class="form-group col-md-6">
						<label for="">Active Navigation Link Background Color</label>
						<input type="text" class="form-control color-input">
					</div>
					<div class="form-group col-md-6">
						<label for="">Active Navigation Link Text Color</label>
						<input type="text" class="form-control color-input">
					</div>
				</div>
				<h3 class="form-section-title">Hero Image / Graphic Properties</h3>
				<div class="row">
					<div class="form-group col-md-6">
						<label for="">Bottom Banner Background Color</label>
						<input type="text" class="form-control color-input">
						<p class="help-block">Will lay on top of the image stretched across the bottom</p>
					</div>
					<div class="form-group col-md-6">
						<label for="">Bottom Banner Text Color</label>
						<input type="text" class="form-control color-input">
						<p class="help-block">The color of the font sitting on top of the banner</p>
					</div>
					<div class="form-group col-md-6">
						<label for="">Background Behind Graphic Color</label>
						<input type="text" class="form-control color-input">
						<p class="help-block">This color will be behind the graphic filling the width of the page</p>
					</div>
				</div>
				<h3 class="form-section-title">Content Properties</h3>
				<div class="row">
					<div class="form-group col-md-6">
						<label for="">Bottom Area Background Color</label>
						<input type="text" class="form-control color-input">
						<p class="help-block">The main background color of the page.</p>
					</div>
					<div class="form-group col-md-6">
						<label for="">Bottom Area Standard Font Color</label>
						<input type="text" class="form-control color-input">
						<p class="help-block">The main font color for your event overview.</p>
					</div>
					<div class="form-group col-md-6">
						<label for="">Location / Time Icon Color</label>
						<input type="text" class="form-control color-input">
					</div>
					<div class="form-group col-md-6">
						<label for="">Location / Time Font Color</label>
						<input type="text" class="form-control color-input">
					</div>
				</div>
				<h3 class="form-section-title">Form Properties</h3>
				<div class="row">
					<div class="form-group col-md-6">
						<label for="">Header Section Font Color & Active Step Background Color</label>
						<input type="text" class="form-control color-input">
					</div>
					<div class="form-group col-md-6">
						<label for="">Form Step Background Color</label>
						<input type="text" class="form-control color-input">
					</div>
					<div class="form-group col-md-6">
						<label for="">Form Step Font Color</label>
						<input type="text" class="form-control color-input">
					</div>
					<div class="form-group col-md-6">
						<label for="">Button Background Color</label>
						<input type="text" class="form-control color-input">
					</div>
					<div class="form-group col-md-6">
						<label for="">Button Font Color</label>
						<input type="text" class="form-control color-input">
					</div>
				</div>
				<div class="cf">
					<button type="submit" class="btn btn-success btn-lg"><strong>Save Theme Settings</strong></button>
				</div>
			</div>
			</form>
			
		</div>
	</div>
</div>

<script>
	$(function(){
		$('.color-input').ColorPicker({
			onSubmit: function(hsb, hex, rgb, el) {
				$(el).val(hex);
				$(el).ColorPickerHide();
			},
			onBeforeShow: function () {
				$(this).ColorPickerSetColor(this.value);
			}
		})
		.bind('keyup', function(){
			$(this).ColorPickerSetColor(this.value);
		});
	});
</script>

<cfinclude template="shared/footer.cfm"/>