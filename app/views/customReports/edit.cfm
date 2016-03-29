<cfoutput>
<ol class="breadcrumb">
  <li><a href="#buildURL( 'dashboard.default' )#">At a Glance</a></li>
  <li><a href="#buildURL( 'event.default' )#">Events</a></li>
  <li><a href="#buildURL( 'event.details?event_id=' & rc.event_id )#">#rc.event_name#</a></li>
  <li><a href="#buildURL( 'customReports.default' )#">Custom Reports</a></li>
  <li class="active">Edit Custom Report #rc.report_params.label#</li>
</ol>

<h2 class="page-title color-01">Edit #rc.report_params.label# Custom Reporting</h2>
<p class="page-subtitle">Below you will find the custom report parameters.</p>
<div class="basic-wrap mt-small">
	<div class="container-fluid mt-small">
		<form class="validate-frm" action="#buildURL( 'customReports.doSave' )#" method="post" data-parsley-validate  data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden">
			<input type="hidden" name="report.event_id" value="#rc.event_id#" />
			<input type="hidden" name="report.custom_report_id" value="#rc.custom_report_id#" />
			<h3 class="form-section-title">Basic Information</h3>
			<div class="row">
				<div class="form-group col-md-6">
					<label for="report.report_name" class="required">Report Name:</label>
					<input id="report.report_name" name="report.report_name" type="text" class="form-control" value="#rc.report_params.label#" required>
				</div>
				<div class="form-group col-md-6">
					<label for="report.attendee_types">Choose Attendee Types: <small>Defaults to All</small></label>
					<select multiple name="report.attendee_types" id="report.attendee_types" class="form-control chosen" data-placeholder="Choose Attendee Types...">
						#rc.attendee_types_opts#
					</select>
				</div>
				<div class="form-group col-md-6">
					<label for="report.attendee_status">Choose Attendee Statuses: <small>Defaults to All</small></label>
					<select multiple name="report.attendee_status" id="report.attendee_status" class="form-control chosen" data-placeholder="Choose Attendee Statuses...">
						#rc.attendee_statuses_opts#
					</select>
				</div>
				<div class="form-group col-md-6">
					<label for="report.start_date">Choose Date Range: <small>Defaults to All</small></label>
					<div class="row">
						<div class="col-md-6">
							<input name="report.start_date" id="report.start_date" value="#dateFormat( rc.report_params.range_from, 'MM/DD/YYY' )#" type="text" class="datetime form-control">
						</div>
						<div class="col-md-6">
							<input name="report.end_date" id="report.end_date" value="#dateFormat( rc.report_params.range_to, 'MM/DD/YYY' )#" type="text" class="datetime form-control">
						</div>
					</div>
				</div>
			</div>
			<h3 class="form-section-title">Form Field Selection</h3>
			<div class="row">
				<div class="col-md-12">
					<div class="alert alert-info">
						<span class="glyphicon glyphicon-info-sign"></span> Fields moved to the right hand side will be shown in the report. Click a field to move it from side to side. Fields generate the order they are added.
					</div>
					<div class="cf" style="margin-bottom: 20px;">
						<a href="##" class="btn btn-primary" id="select-all-ff">Select All Fields</a>
						<a href="##" class="btn btn-danger" id="deselect-all-ff">Deselect All Fields</a>
					</div>
					<select required id="std-field-select" multiple>
						<!--- Custom and Standards outputted below, opt groups won't work because of "Keep Order" Functionality --->
						<!--- http://loudev.com/ --->
						#rc.registration_field_opts#
					</select>
					
					<input type="hidden" name="report.standard_fields"  id="report-standard-fields" value="#rc.report_standard_fields#" />
					
				</div>
			</div>
			<br>
			<br>
			<h3 class="form-section-title">Agenda Item Selection</h3>
			<div class="row">
				<div class="col-md-12">
					<div class="alert alert-info">
						<span class="glyphicon glyphicon-info-sign"></span> Items moved to the right hand side will be shown in the report. Click an item to move it from side to side.
					</div>
					<div class="cf" style="margin-bottom: 20px;">
						<a href="##" class="btn btn-primary" id="select-all-ai">Select All Fields</a>
						<a href="##" class="btn btn-danger" id="deselect-all-ai">Deselect All Fields</a>
					</div>
					<select name="report.agenda_items" id="agenda-item-select" multiple>
						#rc.agenda_grouped_opts#
					</select>	
				</div>
			</div>
			<br><br>
			<h3 class="form-section-title">Advanced Filters</h3>
			<div class="row">
				<div class="col-md-6">
					<label for="report.payment_methods">Select Payment Methods: <small>Defaults to All</small></label>
					<select multiple name="report.payment_methods" id="report.payment_methods" class="form-control chosen" data-placeholder="Choose Payment Methods...">
						#rc.payment_processors_opts#
					</select>
				</div>
				<div class="col-md-6">
					<label for="report.balances">Only Show Balances: <small>Defaults to All</small></label>
					<div class="row">
						<div class="col-md-4">
							<select name="report.operator" id="report.operator" class="form-control">
								#rc.balance_due_opts#
								<option value=""></option>
								<option value="<">Greater Than</option>
								<option value=">">Less Than</option>
								<option value="=">Equal To</option>
							</select>
						</div>
						<div class="col-md-8">
							<input type="text" name="report.balance" class="form-control" placeholder="$0.00" value="#rc.report_params.balance_due#">
						</div>
					</div>
				</div>
			</div>
			<div class="row mt-large">
				<div class="col-md-4 pull-right">
					<button type="submit" class="btn btn-lg btn-success btn-block">Save and Generate Report</button>
				</div>
			</div>
		</form>
	</div>


</div>
</cfoutput>