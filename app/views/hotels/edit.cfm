<cfoutput>
<!--// BREAD CRUMBS START //-->
<ol class="breadcrumb">
  <li><a href="/index.cfm">Dashboard</a></li>
  <li><a href="#buildURL('hotels.default')#">Hotels and Booking</a></li>
  <li class="active">Add New Hotel</li>
</ol>
<!--// BREAD CRUMBS END //-->
<cfif rc.hotel_id>
	<h2 class="page-title color-03">Edit Event Hotel</h2>
	<p class="page-subtitle"></p>
<cfelse>
	<h2 class="page-title color-03">Add Another Hotel</h2>
	<p class="page-subtitle">Add a new hotel where you have allocated room space for attendees.</p>
</cfif>

<form class="form-horizontal" id="hotel-creation" method="post" action="#buildURL("hotels.save")#">
	<div class="well">
		<div class="form-padding-fix" style="padding-bottom: 0;">
			<div class="row">
				<!--- I think that phone / address / and website are associated to hotel and carry through, custom description and photo for each hotel --->
				<!--- Description custom because it may relate to the registration section it's nested in --->
				<!--- Hotel photo custom because if they are picking from the media library... it would be an overlay in an overlay - not cool. Also they may want a unique photo? --->
				<div class="col-md-6">
					<div class="form-group">
						<cfif rc.hotel_id>
							<label for="" class="control-label col-sm-4" id="hotel_id_label">Hotel</label>
							 <div class="col-sm-5">
								 <p class="form-control-static" id="hotel_dispaly_name"></p>
							 </div>
							 <input type="hidden" name="eventhotel.hotel_id" id="hotel_id" value="#rc.hotel_id#" />
						<cfelse>
							<label for="" class="control-label col-sm-4 required" id="hotel_id_label">Select Hotel</label>
							<div class="col-sm-5">
								<select name="eventhotel.hotel_id" id="hotel_id" class="form-control">
									<option value=""></option>
								</select>
							</div>
							<div class="col-sm-3">
								<a href="##new-hotel-modal" data-toggle="modal" data-target="##new-hotel-modal" class="btn btn-block btn-primary">Add New</a>
							</div>
						</cfif>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="" class="control-label col-sm-4">Hotel Phone</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" id="hotel_phone" disabled>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="" class="control-label col-sm-4">Hotel Address</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" id="hotel_address" disabled>
						</div>
					</div>
				</div>
				
				<div class="col-md-6">
					<div class="form-group">
						<label for="" class="control-label col-sm-4">Hotel Website</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="eventhotel.url" id="hotel_url" />
						</div>
					</div>
				</div>
				<div class="col-md-12">
					<div class="form-group">
						<label for="" class="control-label col-sm-4">Hotel Description</label>
						<div class="col-sm-8">
							<textarea class="form-control" name="eventhotel.description" id="hotel_description" maxlength="1000"></textarea>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="" class="control-label col-sm-4">Sort</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="eventhotel.sort" id="hotel_sort" value="#rc.next_sort#" />
						</div>
					</div>
				</div>
				
				
				<!---
				<div class="col-md-6">
					<div class="form-group">
						<label for="" class="control-label col-sm-4">Hotel Photo</label>
						<div class="col-sm-8">
							<a href="" class="btn btn-sm btn-primary">Choose from Media Library</a>
							<p class="help-block">Use a jpg 500px wide by 350px tall</p>
						</div>
					</div>
				</div>
				--->
			</div>
		</div>
		<h4 class="modal-title" id="room_type_label">Room Types</h4>
		<div id="room-types-wrapper"></div>
		
		<div class="clearfix">
			<button type="button" id="add-date-btn" class="btn btn-primary pull-right">Add Another Reserved Date</button>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-3  pull-right">
			<button type="submit" class="btn btn-lg btn-success btn-block">Save</button>
		</div>
	</div>
	
</form>


<script id="options-template" type="text/x-handlebars-template"><option value="{{value}}" {{selected}}>{{display}}</option></script>


<script id="eventhotelroom-template" type="text/x-handlebars-template">
<input type="hidden" name="eventhotelroom[{{index}}].hotel_room_id" value="{{hotel_room_id}}" class="form-control" />
<div class="check-in-individual" data-parent_link="{{index}}">
	<div class="form-group">
		<label for="" class="control-label col-sm-2 required">Check In Date</label>
		<div class="col-sm-10">
			<input type="text" name="eventhotelroom[{{index}}].block_date" value="{{block_date}}" class="form-control datepicker" />
		</div>
	</div>
	<div class="room-types">
		<div class="row">
			<div class="col-md-6">
				<div class="form-group">
					<label for="" class="control-label col-sm-4 required">Room Type</label>
					<div class="col-sm-8">
						<select name="eventhotelroom[{{index}}].room_type_id" id="room_type_id" data-room_type_id="{{room_type_id}}" class="form-control">
						<cfloop from="1" to="#rc.room_types.count#" index="local.idx">
							<cfset local['room_type'] = rc.room_types.data[ local.idx ] />
							<option value="#local.room_type.room_type_id#">#local.room_type.room_type#</option>
						</cfloop>
						</select>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="form-group">
					<label for="" class="control-label col-sm-4 required">Number of Rooms</label>
					<div class="col-sm-8">
						<input type="text" name="eventhotelroom[{{index}}].rooms_allocated" value="{{rooms_allocated}}" class="form-control" />
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			{{##ifin_use in_use}}
			<button type="button" data-action="remove" class="btn btn-danger pull-right" data-link="{{index}}" >Remove</button>
			{{/ifin_use}}
		</div>
	</div>
</div>
</script>

<cfif !rc.hotel_id>
<div class="modal fade" id="new-hotel-modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Add a New Hotel</h4>
			</div>
			<div class="modal-body">
				<form action="" method="post" id="new_hotel" data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], [data-hidden='true']">
					<div class="form-group col-md-6">
						<label for="" class="required">Hotel Name</label>
						<input type="text" name="hotel.name" class="form-control required" Maxlength="200">
					</div>
					<div class="form-group col-md-6">
						<label for="" class="required">Hotel Address</label>
						<input type="text" name="hotel.address_1" class="form-control required" Maxlength="200">
					</div>
					<div class="form-group col-md-6">
						<label for="" class="required">Hotel City</label>
						<input type="text" name="hotel.city" class="form-control required" Maxlength="150">
					</div>
					<div class="form-group col-md-6">
						<label for="" class="required">Hotel State</label>
						<select name="hotel.state" class="form-control required">
							#rc.regions_opts#
						</select>
					</div>
					<div class="form-group col-md-6">
						<label for="" class="required">Hotel Postal Code</label>
						<input type="text" name="hotel.postal_code" class="form-control required" Maxlength="15">
					</div>
					
					<div class="form-group col-md-6">
						<label for="" class="required">Hotel Phone</label>
						<input type="text" name="hotel.phone_number" class="form-control required" Maxlength="15">
					</div>
					<div class="form-group col-md-6">
						<label for="">Hotel Website URL</label>
						<input type="text" name="hotel.url" class="form-control" maxlength="300">
						<p class="help-block">Insert the full URL</p>
					</div>
				</form>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
       			<button type="button" class="btn btn-success" id="btn_save_hotel">Save Hotel</button>
			</div>
		</div>
	</div>
</div>
</cfif>
</cfoutput>