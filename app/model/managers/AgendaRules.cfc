/**
*
* @file  /model/managers/AgendaRules.cfc
* @author - MG
* @description - This will manage all things Agenda Rules.
*
*/

component output="false" displayname="Agenda" accessors="true" extends="app.model.base.Manager" {
	property name="AgendaRuleDao" getter="true" setter="true";

	/**
	* I get all of the Agenda Rule Types
	*/
	public struct function getAgendaRuleTypes() {
		var rule_types = getAgendaRuleDao().AgendaRuleTypesGet().result;
		return {
			"count": rule_types.recordCount,
			"data": queryToArray( rule_types )
		};
	}
	/**
	* I get Agenda Rule Types struct
	*/
	public struct function getRuleTypes() {
		var rule_types = getAgendaRuleTypes();
		var rtn = {};
		for( var i=1; i LTE rule_types.count; i=i+1 ) {
			var row = rule_types.data[ i ];
			rtn[ row.type ] = row.rule_type_id;
		}
		return rtn;
	}
	/*
	* @agenda_rule_id (output) The id of the rule, NULL means add
	* @event_id The id of the event
	* @rule_type_id The id of the rule type
	* @name The name of the rule
	* @definition The JSON definition of the rule
	*/
	public numeric function saveRule(
		numeric agenda_rule_id=0,
		required numeric event_id,
		required numeric rule_type_id,
		required numeric registration_type_id,
		required string name,
		required string definition
	) {
		return getAgendaRuleDao().AgendaRuleSet( argumentCollection=arguments );
	}

	/*
	* Gets all of the AgendaRuleTypesGet
	* @event_id The id of the event to get rules for
	*/
	public struct function getRules(
		required numeric event_id,
		numeric order_index=0,
		string order_dir="asc",
		string search_value="",
		numeric start_row=0,
		numeric total_rows=10,
		numeric draw=1
	) {
		var columns = [ "agenda_rule_id", "event_id", "rule_type_id", "type", "registration_type", "name", "definition" ];
		var params = {
			event_id : arguments.event_id,
			start : ( start_row + 1 ),
			results : arguments.total_rows,
			sort_column : columns[ order_index + 1 ],
			sort_direction : arguments.order_dir,
			search : arguments.search_value
		};
		var agenda_rules = getAgendaRuleDao().AgendaRulesGet( argumentCollection=params ).result;
		var recordsTotal = agenda_rules.recordCount;
		var data = { 'rule_type_def': { 'required_group': "Required Group", 'dependency': "Dependency" } };
		return {
			"draw" : arguments.draw,
			"recordsTotal" : val( recordsTotal ),
			"recordsFiltered" : val( recordsTotal ),
			"data": queryToArray(
				recordset= agenda_rules,
				columns= listAppend( agenda_rules.columnList, "options" ),
				map= function( row, index, columns, data ) {
                    row['original_type'] = row.type;
					row['type'] = data.rule_type_def[ row.type ];
					row['options'] = "<button class=""btn btn-sm btn-danger"" data-remove=""true"" data-rule_id=""" & row.agenda_rule_id & """>Remove</button>";
					row['options'] &= "  <button class=""btn btn-sm btn-primary"" data-manage=""" & row.original_type & """ data-rule_id=""" & row.agenda_rule_id & """>Manage</button>";
					return row;
				},
				data=data
			)
		};
	}
	/*
	* Removes an AgendaRule
	* @agenda_rule_id The id of the rule to remove
	*/
	public void function removeRule( required numeric agenda_rule_id ) {
		return getAgendaRuleDao().AgendaRuleRemove( argumentCollection=arguments );
	}
	/*
	* Gets an Agenda Rule
	* @agenda_rule_id The agenda_rule_id
	*/
	public struct function getRule( required numeric agenda_rule_id ) {
		var data = getAgendaRuleDao().AgendaRuleGet( argumentCollection=arguments );
		data['definition'] = deserializeJSON( data.definition );
		return data;
	}

}