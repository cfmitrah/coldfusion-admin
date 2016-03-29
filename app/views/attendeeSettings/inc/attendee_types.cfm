
<br />
<h3 class="form-section-title">
  Attendee Types
  <a href="##" data-toggle="modal" data-target="#EditAttendeTypeModal" class="btn btn-lg btn-info pull-right">Add Attendee Type</a>
</h3>

<cfoutput>
	#view('common/Listing')#
</cfoutput>

<!-- Modal -->
<div class="modal fade" id="EditAttendeTypeModal" tabindex="-1" role="dialog" aria-labelledby="EditAttendeTypeModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title">Edit Attendee Type</h4>
      </div>
      <div class="modal-body">
     <form id="attendee_type_form" method="post" enctype="multipart/form-data"
		data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], [data-hidden='true']">
      	<input type="hidden" id="registration_type_id" value="" />
	      	<input type="hidden" id="registration_type_id" value="" />
	        <p>
				<div class="form-group">
					<label for="">Attendee Type</label>
					<input type="text" class="form-control" id="registration_type" name="registration_type" placeholder="Attendee Type">
				</div>
				<div class="form-group">
					<label for="">Access Code</label>
					<input type="text" class="form-control" id="access_code" name="access_code" placeholder="Access Code">
				</div>
				<div class="form-group">
					<label for="" class="required">Sort</label>
					<input data-parsley-type="number" required type="number" class="form-control" id="sort" name="sort" placeholder="Sort">
				</div>
				<div class="form-group">
					<label for="">Active</label>
					<select name="registration_active" id="registration_active" class="form-control">
						<option value="1">Yes</option>
						<option value="0">No</option>
					</select>
				</div>
			<div class="form-group">
				<label for="">Group Allowed</label>
				<select name="group_allowed" id="group_allowed" class="form-control">
					<option value="1">Yes</option>
					<option value="0">No</option>
				</select>
			</div>
	  	</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="btn_save_attendee_type">Save changes</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- Modal -->
<div class="modal fade" id="EditAttendeTypePricingModal" tabindex="-1" role="dialog" aria-labelledby="EditAttendeTypePricingModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title">Attendee Type Pricing</h4>
      </div>
      <div class="modal-body">
      	<input type="hidden" id="registration_pricing_type_id" value="" />
        <p>
			<table class="table table-striped table-hover data-table tm-large no-footer">
				<thead>
					<th>Valid From</th><th>Valid To</th><th>Price</th><th>Is Default</th><th>Options</th>
				</thead>
				<tbody id="new_type_pricing_table">
          <tr>
            <td><input type="text" id="new_reg_pricing_valid_from" size="12" class="dateonly-datetime" /></td>
            <td><input type="text" id="new_reg_pricing_valid_to" size="12" class="dateonly-datetime" /></td>
            <td><input type="text" id="new_reg_pricing_price" size="5" /></td>
            <td><input type="checkbox" id="new_reg_pricing_is_default" /></td>
            <td><button type="button" class="btn btn-sm btn-primary" id="new_reg_pricing_save" >Save</button></td>
          </tr>
        </tbody>
        <tbody id="type_pricing_table">
				</tbody>
			</table>
        </p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
