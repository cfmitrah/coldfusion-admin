/**
 *
 * @depends /plugins/chosen/chosen.jquery.js
 * @depends /plugins/jquery.multi-select.js
 * @depends /pages/common/listing.js
 */
var agenda_dependency_rule = function( ) {
    var $modal = $("#dependency-rule")
    ,$loading = $("#dependency_rule_show_group_loading")
    ,$show_group = $("#dependency_rule_show_group")
    ,$rule_name = $("#dependency_rule_name")
    ,$rule_type_id = $("#dependency_rule_type_id")
    ,$agenda_rule_id = $("#dependency_agenda_rule_id")
    ,$registration_type_id = $("#dependency_rule_registration_type_id")
    ,$parent = $("#dependency_rule_dependency")
    ,$btn_save = $("#btn_save_dependency")
    ,$form = $("#form_dependency_rule")
    ,$btn_new = $("#btn_new_dependency");


    get = function( rule_id ) {
        var promise = agenda_rule().getRule( rule_id );

        promise.always(function( data ) {
            $loading.show();
            $show_group.hide();
            agenda_rule().buildMultiSelectAgendaItem( $show_group, data.definition.show_group );
            $("#ms" + $show_group.attr("id") ).hide();
            $rule_name.val( data.name );
            $rule_type_id.val( data.rule_type_id );
            $agenda_rule_id.val( data.agenda_rule_id )

            $registration_type_id.val( data.registration_type_id );
            $modal.modal("show");
        });
    }

    buildAgendaOptions = function(){

    }

    init = function() {
        var promise = agenda_rule().getAgendaItems();
        promise.always(function( data ){
            var options = agenda_rule().buildAgendaOptions( data );
            $parent.html( options );
        });

        $btn_new.on('click', function (e) {
            $loading.show();
            $show_group.hide();
            agenda_rule().buildMultiSelectAgendaItem( $show_group );
            $rule_name.val('');
            $rule_type_id.val( cfrequest.required_group_rule_type_id );
            $agenda_rule_id.val( 0 )
            $registration_type_id.val(1);


        });

        $btn_save.on( "click", function() {
            save();
        });

        $modal.on('hidden.bs.modal', function (e) {
            $loading.show();
            $show_group.show();
            $("#ms" + $show_group.attr("id") ).hide();
            $show_group.val(0).multiSelect('refresh');
            $rule_name.val('');
            $rule_type_id.val( cfrequest.required_group_rule_type_id );
            $agenda_rule_id.val( 0 )
            $registration_type_id.val(1);
        });

        return this;
    }

    save = function() {
        var promise = $.ajax({
            url: cfrequest.save_agenda_rule_url,
            data: $form.serialize()
        });

        promise.always(function( data ){
            $agenda_rules_datatable.fnDraw();
            $modal.modal("hide");
        });
    }

    return {
		 init: init,
         get: get
	 }
};
