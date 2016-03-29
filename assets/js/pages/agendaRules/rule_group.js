/**
 *
 * @depends /plugins/chosen/chosen.jquery.js
 * @depends /plugins/jquery.multi-select.js
 * @depends /pages/common/listing.js
 */
var agenda_group_rule = function( ) {
    var $form_group_rule = $("#form_group_rule"),
		$group_rule_definition_group = $("#group_rule_definition_group"),
		$group_rule_name = $("#group_rule_name"),
		$group_rule_definition_minimum = $("#group_rule_definition_minimum"),
		$btn_save_grouping = $("#btn_save_grouping"),
		$btn_new_grouping = $("#btn_new_grouping"),
		$group_loading = $("#group_rule_definition_group_loading"),
		$grouping_rule_modal = $("#grouping-rule")
		$agenda_rules_listing = $("#agenda_rules_listing"),
		$ms_group_rule_definition_group = $("#ms-group_rule_definition_group"),
		$group_rule_type_id = $("#group_rule_type_id"),
		$group_agenda_rule_id = $("#group_agenda_rule_id"),
		$group_rule_registration_type_id = $("#group_rule_registration_type_id");

        getRule = function( rule_id ) {
    		var promise = agenda_rule().getRule( rule_id );

    		promise.always(function( data ) {
    			$grouping_rule_modal.modal("show");
    			$group_loading.show();

                agenda_rule().buildMultiSelectAgendaItem( $group_rule_definition_group, data.definition.group );

    			$group_rule_definition_group.hide();
    			$ms_group_rule_definition_group.hide();
    			$group_rule_name.val( data.name );
    			$group_rule_type_id.val( data.rule_type_id );
    			$group_agenda_rule_id.val( data.agenda_rule_id )
    			$group_rule_definition_minimum.val( data.definition.minimum );
    			$group_rule_registration_type_id.val( data.registration_type_id );
    			$grouping_rule_modal.modal("show");
    		});
    	}

        saveGroupRule  = function() {
    		var promise = $.ajax({
    			url: cfrequest.save_agenda_rule_url,
    			data: $form_group_rule.serialize()
    		});

    		promise.always(function( data ){
    			$agenda_rules_datatable.fnDraw();
    			$grouping_rule_modal.modal("hide");
    		});
    	}


        init = function() {

            $btn_save_grouping.on( "click", function() {
        		saveGroupRule();
        	});
            $btn_new_grouping.on('click', function (e) {
        		$group_loading.show();
        		$group_rule_definition_group.hide();
        		$ms_group_rule_definition_group.hide();
        		$group_rule_definition_group.val(0);
        		$group_rule_name.val('');
        		$group_rule_definition_minimum.val(1);
        		$group_rule_registration_type_id.val(1);

                agenda_rule().buildMultiSelectAgendaItem( $group_rule_definition_group );
        	});
            $grouping_rule_modal.on('hidden.bs.modal', function (e) {
        	 	$group_loading.show();
        		$group_rule_definition_group.hide();
        		$ms_group_rule_definition_group.hide();
        		$group_rule_definition_group.val(0).multiSelect('refresh');;
        		$group_rule_name.val('');
        		$group_rule_type_id.val( cfrequest.required_group_rule_type_id );
        		$group_agenda_rule_id.val( 0 )
        		$group_rule_definition_minimum.val(1);
        		$group_rule_registration_type_id.val(1);
        	});

            return this;
        }

        return {
    		 init: init,
             get:getRule,
             save:saveGroupRule
    	 }
};
