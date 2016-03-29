/**
 *
 * @depends /plugins/chosen/chosen.jquery.js
 * @depends /plugins/jquery.multi-select.js
 * @depends /pages/common/listing.js
 * @depends /pages/agendaRules/rule_group.js
 * @depends /pages/agendaRules/rule_dependency.js
 */
var $agenda_rules_datatable;
var agenda_rule = function() {

    makeMultiSelect = function( $object, options ) {
		$object.show();
		$object
		.html( options )
		.multiSelect({
			keepOrder: true,
			afterInit: function( container ) {
                $("#" + $object.attr("id") + "_loading" ).hide();
			}
		});

		$object.multiSelect('refresh');
		$("#ms_" + $object.attr("id") ).show();
	}

    removeRule = function( rule_id ) {
        var promise = $.ajax({
            url: cfrequest.delete_agenda_rule_url,
            data: { agenda_rule_id: rule_id }
        });

        promise.always(function( data ) {
            $agenda_rules_datatable.fnDraw();
        });
    }

    agendaItemsGet = function( $object, selected_items ) {
        return $.ajax({ url: cfrequest.get_agenda_items_url });

    }
    buildAgendaOptions = function( data, selected_items ) {
        var option=[],options="";
        for ( var i = 0, cnt = data.cnt; i < cnt; i++ ) {
            var row = data.data[ i ];
            var selected = "";

            if( $.ListFind( selected_items, row.agenda_id ) ) {
                selected = " selected=true ";
            }
            option.push( "<option value=\"" ); option.push( row.agenda_id ); option.push( "\"" ); option.push( selected ); option.push("\">" );
                option.push( row.agendarules_display );
            option.push( "</option>" );
        }
        options = option.join( "" );
        return options;
    }
    buildMultiSelectAgendaItem = function( $object, selected_items ) {
        var items_result = agendaItemsGet();

        items_result.always(function( data ){
            var options = buildAgendaOptions( data, selected_items );
            makeMultiSelect( $object, options );
        });
    }

    getRule = function( rule_id ) {
        return $.ajax({
            url: cfrequest.get_agenda_rule_url,
            data: { agenda_rule_id: rule_id }
        });

    }

    return {
		 getAgendaItems: agendaItemsGet,
         setMultiSelect: makeMultiSelect,
         buildMultiSelectAgendaItem: buildMultiSelectAgendaItem,
         buildAgendaOptions:buildAgendaOptions,
         remove: removeRule,
         getRule: getRule
	 }
};
 $(function(){
 	var $agenda_rules_listing = $("#agenda_rules_listing");

	$agenda_rules_datatable = setDataTables( cfrequest.rules_table.ajax_source, cfrequest.rules_table.aoColumns, cfrequest.rules_table.table_id, 1000 );
    var group_rule = agenda_group_rule().init();
    var dependency_rule = agenda_dependency_rule().init();

    $agenda_rules_listing.on("click", "button[data-remove]", function( event ){
        var $elem = $(this);
        agenda_rule().remove( $elem.data("rule_id") );
    }).on("click", "button[data-manage=\"required_group\"]", function( event ){
        var $elem = $(this);
        group_rule.get( $elem.data("rule_id") );
    }).on("click", "button[data-manage=\"dependency\"]", function( event ){
        var $elem = $(this);
        dependency_rule.get( $elem.data("rule_id") );
    });

 });