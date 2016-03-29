/**
*
* @file  /model/dao/AgendaRule.cfc
* @author - MG
* @description
*
*/

component accessors="true" extends="app.model.base.Dao" {
	/*
	* @agenda_rule_id (output) The id of the rule, NULL means add
	* @event_id The id of the event
	* @rule_type_id The id of the rule type
	* @name The name of the rule
	* @definition The JSON definition of the rule
	*/
	public numeric function AgendaRuleSet(
		numeric agenda_rule_id=0,
		required numeric event_id,
		required numeric rule_type_id,
		required numeric registration_type_id,
		required string name,
		required string definition
	) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendaRuleSet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@agenda_rule_id", cfsqltype="cf_sql_integer", value=arguments.agenda_rule_id, null=( !arguments.agenda_rule_id ), variable="agenda_rule_id" );
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@rule_type_id", cfsqltype="cf_sql_integer", value=arguments.rule_type_id );
		sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );
		sp.addParam( type="in", dbvarname="@name", cfsqltype="cf_sql_varchar", value=arguments.name, maxlength=150 );
		sp.addParam( type="in", dbvarname="@definition", cfsqltype="cf_sql_longvarchar", value=arguments.definition );

		result = sp.execute();
		return result.getProcOutVariables().agenda_rule_id;
	}
	
	/*
	* Gets all of the AgendaRuleTypesGet
	* @event_id The id of the event to get rules for
	*/
	public struct function AgendaRulesGet( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendaRulesGet"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="result1", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result1
		};
	}
	/*
	* Removes a AgendaRuleType
	* @agenda_rule_id The id of the rule to remove
	*/
	public void function AgendaRuleRemove( required numeric agenda_rule_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendaRuleRemove"
		});
		sp.addParam( type="in", dbvarname="@agenda_rule_id", cfsqltype="cf_sql_integer", value=arguments.agenda_rule_id );
		
		result = sp.execute();
		return;
	}
	/*
	* Gets a Agenda Rule
	* @agenda_rule_id The agenda_rule_id
	*/
	public struct function AgendaRuleGet( required numeric agenda_rule_id ) {
		var sp = new StoredProc();
		var result = {}; 
		var data = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendaRuleGet"
		});
		trim_fields( arguments );  // trim all of the inputs
		sp.addParam( type="inout", dbvarname="@agenda_rule_id", cfsqltype="cf_sql_integer", value=arguments.agenda_rule_id, null=( !arguments.agenda_rule_id ), variable="agenda_rule_id" );
		sp.addParam( type="out", dbvarname="@event_id", cfsqltype="cf_sql_integer", variable="event_id" );
		sp.addParam( type="out", dbvarname="@rule_type_id", cfsqltype="cf_sql_integer", variable="rule_type_id" );
		sp.addParam( type="out", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", variable="registration_type_id" );
		sp.addParam( type="out", dbvarname="@type", cfsqltype="cf_sql_varchar", variable="type" );
		sp.addParam( type="out", dbvarname="@name", cfsqltype="cf_sql_varchar", variable="name" );
		sp.addParam( type="out", dbvarname="@definition", cfsqltype="cf_sql_longvarchar", variable="definition" );

		result = sp.execute();
		data['prefix'] = result.getPrefix();
		structAppend( data, result.getProcOutVariables() );
		return data;
	}
	/*
	* Gets all of the AgendaRuleTypesGet
	*/
	public struct function AgendaRuleTypesGet() {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "AgendaRuleTypesGet"
		});
		sp.addProcResult( name="result", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().result
		};
	}
}