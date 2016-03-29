/**
* 
* I am the DAO for the Registration Fields object
* @file  /model/dao/RegistrationField.cfc
* @author
*/
component accessors="true" extends="app.model.base.Dao" {

	/**
	* I get a Standard List of Registration Fields
	*/
	public struct function RegistrationStandardFieldsList() {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "RegistrationStandardFieldsList"
		});

		sp.addProcResult( name="fields", resultset=1 );

		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
			};
	}
	/**
	* I get a Standard List of Registration Fields for an event
	*/
	public struct function RegistrationFieldsStandardList( required numeric event_id, numeric standard_field=1, boolean in_use ) {
		var sp = new StoredProc();
		var result = {};
		var in_use_null = isnull( arguments.in_use );
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "RegistrationFieldsStandardList"
		});
		if( in_use_null ) {
			arguments.in_use = 0;
		}
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addParam( type="in", dbvarname="@standard_field", cfsqltype="cf_sql_integer", value=arguments.standard_field );
		sp.addParam( type="in", dbvarname="@in_use", cfsqltype="cf_sql_bit", value=arguments.in_use, null=in_use_null );
		sp.addProcResult( name="fields", resultset=1 );

		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().fields
			};
	}
	/**
	* I get a registration field
	* @field_id The ID of the field that you want to get
	*/
	public struct function RegistrationFieldGet( required numeric field_id, required numeric event_id ) {
        var sp = new StoredProc();
        var result = {};
        var data = {};
        sp.setAttributes({
            'datasource' = getDSN(),
            'procedure' = "RegistrationFieldGet"
        });
        sp.addParam( type="inout", dbvarname="@field_id", cfsqltype="cf_sql_integer", value=arguments.field_id, variable="field_id" );
        sp.addParam( type="inout", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id, variable="event_id" );
        sp.addParam( type="out", dbvarname="@field_type", cfsqltype="cf_sql_varchar", variable="field_type" );
        sp.addParam( type="out", dbvarname="@field_type_name", cfsqltype="cf_sql_varchar", variable="field_type_name" );
        sp.addParam( type="out", dbvarname="@label", cfsqltype="cf_sql_varchar", variable="label" );
        sp.addParam( type="out", dbvarname="@field_name", cfsqltype="cf_sql_varchar", variable="field_name" );
        sp.addParam( type="out", dbvarname="@required", cfsqltype="cf_sql_bit", variable="required" );
        sp.addParam( type="out", dbvarname="@standard_field", cfsqltype="cf_sql_integer", variable="standard_field" );
        sp.addParam( type="out", dbvarname="@attributes", cfsqltype="cf_sql_longvarchar", variable="attributes" );
        sp.addParam( type="out", dbvarname="@narrative", cfsqltype="cf_sql_longvarchar", variable="narrative" );
        
        sp.addProcResult( name="choices", resultset=1 );
        sp.addProcResult( name="dependencies", resultset=2 );
        result = sp.execute();


        data['prefix'] = result.getPrefix();
        structAppend( data, result.getProcOutVariables() );
        structAppend( data, result.getProcResultSets() );
        return data;
    }
	/**
	* I set a registration field for an event
	* @field_id The id of the field that you are saving
	* @event_id The ID of the event that you are adding the field to 
	* @field_type The field type 
	* @label The label for the field
	* @field_name The field name
	* @required Is the field required
	* @standard_field Is the field a standard field
	* @attributes The attributes of the field
	*/
	public numeric function RegistrationFieldSet( 
		numeric field_id=0,
		required numeric event_id,
		required string field_type,
		required string label,
		required string field_name,
		boolean required=false,
		numeric standard_field=0,
		string attributes= ""
		string narrative="" ) {

		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "RegistrationFieldSet"
		});
		
		sp.addParam( type="inout", dbvarname="@field_id", cfsqltype="cf_sql_integer", value=arguments.field_id, variable="field_id", null=( !arguments.field_id ) );
        sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
        sp.addParam( type="in", dbvarname="@field_type", cfsqltype="cf_sql_varchar", maxlength=25, value=trim(arguments.field_type) );
        sp.addParam( type="in", dbvarname="@label", cfsqltype="cf_sql_varchar", maxlength=150, value=trim(arguments.label) );
        sp.addParam( type="in", dbvarname="@field_name", cfsqltype="cf_sql_varchar", maxlength=150, value=trim(arguments.field_name) );
        sp.addParam( type="in", dbvarname="@required", cfsqltype="cf_sql_bit", value=int( !!arguments.required ) );
        sp.addParam( type="in", dbvarname="@standard_field", cfsqltype="cf_sql_integer", value=int( arguments.standard_field ) );
        sp.addParam( type="in", dbvarname="@attributes", cfsqltype="cf_sql_longvarchar", value=arguments.attributes, null=( !len(arguments.attributes) ) );
        sp.addParam( type="in", dbvarname="@narrative", maxlength=1000, cfsqltype="cf_sql_longvarchar", value=arguments.narrative, null=( !len(arguments.narrative) ) );


		result = sp.execute();
		return result.getProcOutVariables().field_id;
	}
	/**
	* I get a choice list for a registration field
	* @field_id The ID of the field that you want to get the choice list for
	*/
	public struct function RegistrationFieldChoicesList( required numeric field_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "RegistrationFieldChoicesList"
		});
		
		sp.addParam( type="in", dbvarname="@field_id", cfsqltype="cf_sql_integer", value=arguments.field_id );
		sp.addProcResult( name="Choices", resultset=1 );
		
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
			};
	}
	/**
	* I get a choice 
	* @choice_id The ID of the choice that you want to get
	*/
	public struct function RegistrationFieldChoiceGet( required numeric choice_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "RegistrationFieldChoiceGet"
		});
		
		sp.addParam( type="in", dbvarname="@field_id", cfsqltype="cf_sql_integer", value=arguments.field_id );
		sp.addProcResult( name="Choices", resultset=1 );
		
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
			};
	}
	/**
	* I set a choice for a registration field
	* @choice_id The ID of the choice that you want to save
	* @field_id The id of the field that you are adding a choice to.
	* @choice The choice
	* @value The value of the choice
	* @sort The sort order for the choice
	*/
	public numeric function RegistrationFieldChoiceSet( 
		numeric choice_id=0, 
		required numeric field_id, 
		required string choice, 
		required string value,
		numeric sort=0 ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "RegistrationFieldChoiceSet"
		});
		
		sp.addParam( type="inout", dbvarname="@choice_id", cfsqltype="cf_sql_integer", value=arguments.choice_id, variable="choice_id", null=( !arguments.choice_id ) );
        sp.addParam( type="in", dbvarname="@field_id", cfsqltype="cf_sql_integer", value=arguments.field_id );
        sp.addParam( type="in", dbvarname="@choice", cfsqltype="cf_sql_varchar", maxlength=200, value=trim(arguments.choice) );
        sp.addParam( type="in", dbvarname="@value", cfsqltype="cf_sql_varchar", maxlength=200, value=trim(arguments.value) );
        sp.addParam( type="in", dbvarname="@sort", cfsqltype="cf_sql_integer", value=arguments.sort, null=( !arguments.sort ) );
		
		result = sp.execute();
		return result.getProcOutVariables().choice_id;
	}
	/**
	* I get the max sort for a field's choices
	* @field_id The id of the field that you you want to get the max sort for.
	*/
	public numeric function RegistrationFieldChoiceMaxSortGet( required numeric field_id ) {
		var sp = new StoredProc();
		var result = {};
		sp.setAttributes({
			'datasource' = getDSN(),
			'procedure' = "RegistrationFieldChoiceMaxSortGet"
		});
		
		sp.addParam( type="inout", dbvarname="@sort", cfsqltype="cf_sql_integer", variable="sort" );
        sp.addParam( type="in", dbvarname="@field_id", cfsqltype="cf_sql_integer", value=arguments.field_id );
		
		result = sp.execute();
		return result.getProcOutVariables().sort;
	}
	/**
	* I get a standard registration field
	* @standard_field_id The ID of the standard field that you want to get
	*/
	public struct function RegistrationStandardFieldGet( required numeric standard_field_id ) {
        var sp = new StoredProc();
        var result = {};
        var data = {};
        sp.setAttributes({
            'datasource' = getDSN(),
            'procedure' = "RegistrationStandardFieldGet"
        });
        sp.addParam( type="inout", dbvarname="@standard_field_id", cfsqltype="cf_sql_integer", value=arguments.standard_field_id, variable="standard_field_id" );
        sp.addParam( type="out", dbvarname="@field_type", cfsqltype="cf_sql_varchar", variable="field_type" );
        sp.addParam( type="out", dbvarname="@field_type_name", cfsqltype="cf_sql_varchar", variable="field_type_name" );
        sp.addParam( type="out", dbvarname="@label", cfsqltype="cf_sql_varchar", variable="label" );
        sp.addParam( type="out", dbvarname="@field_name", cfsqltype="cf_sql_varchar", variable="field_name" );
        sp.addParam( type="out", dbvarname="@attributes", cfsqltype="cf_sql_longvarchar", variable="attributes" );
        sp.addParam( type="out", dbvarname="@sort", cfsqltype="cf_sql_integer", variable="sort" );
        sp.addParam( type="out", dbvarname="@narrative", cfsqltype="cf_sql_longvarchar", variable="narrative" );
        sp.addParam( type="out", dbvarname="@standard_field", cfsqltype="cf_sql_integer", variable="standard_field" );
        sp.addProcResult( name="choices", resultset=1 );result = sp.execute();

        data['prefix'] = result.getPrefix();
        structAppend( data, result.getProcOutVariables() );
        structAppend( data, result.getProcResultSets() );
        return data;
    }
    /**
	* I get a list of registration fields for an event
	* @event_id The ID of the event that you want to a list of registration fields for
	* @standard_field do you want the standard fields or custom fields
	*/
	public struct function RegistrationFieldsList( required numeric event_id, boolean standard_field ) {
        var sp = new StoredProc();
        var result = {};
        var params = arguments;
        var standard_field_null = isnull( arguments.standard_field );
        sp.setAttributes({
            'datasource' = getDSN(),
            'procedure' = "RegistrationFieldsList"
        });
        if( standard_field_null ) {
        	params.standard_field = false;
        }
        sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=params.event_id );
        sp.addParam( type="in", dbvarname="@standard_field", cfsqltype="cf_sql_bit", value=int( !!params.standard_field ), null=standard_field_null );
        sp.addProcResult( name="fields", resultset=1 );result = sp.execute();

        result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
			};
    }
    /**
	* I get a list of registration field types
	*/
	public struct function RegistrationFieldTypesGet( ) {
        var sp = new StoredProc();
        var result = {};
        sp.setAttributes({
            'datasource' = getDSN(),
            'procedure' = "RegistrationFieldTypesGet"
        });
        sp.addProcResult( name="field_types", resultset=1 );result = sp.execute();

        result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
			};
    }
    /**
    * I remove a choice
    * @choice_id The ID of the choice that you want to remove
    */
    public any function RegistrationFieldChoiceRemove( required numeric choice_id ) {
    	var sp = new StoredProc();
        var result = {};
        sp.setAttributes({
            'datasource' = getDSN(),
            'procedure' = "RegistrationFieldChoiceRemove"
        });
        sp.addParam( type="in", dbvarname="@choice_id", cfsqltype="cf_sql_integer", value=arguments.choice_id );

        result = sp.execute();
		return;
    }
    /**
    * I remove a registration field
    * @field_id The ID of the field that you want to remove
    */
    public any function RegistrationFieldRemove( required numeric field_id ) {
    	var sp = new StoredProc();
        var result = {};
        sp.setAttributes({
            'datasource' = getDSN(),
            'procedure' = "RegistrationFieldRemove"
        });
        sp.addParam( type="in", dbvarname="@field_id", cfsqltype="cf_sql_integer", value=arguments.field_id );

        result = sp.execute();
		return;
    }
    /**
    * I get a list of un-used fields for an registration type
    * @event_id I ID of the event that you want un-used fields for
    * @registration_type_id The registration type id that you want un-used fields for
    */
    public struct function RegistrationTypeUnusedFieldsList( required numeric event_id, required numeric registration_type_id ) {
        var sp = new StoredProc();
        var result = {};
        sp.setAttributes({
            'datasource' = getDSN(),
            'procedure' = "RegistrationTypeUnusedFieldsList"
        });
        
        sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
        sp.addParam( type="in", dbvarname="@registration_type_id", cfsqltype="cf_sql_integer", value=arguments.registration_type_id );
        sp.addProcResult( name="fields", resultset=1 );
        
        result = sp.execute();
        return {
            'prefix' = result.getPrefix(),
            'result' = result.getProcResultSets().fields
            };
    }
    /*
	* Gets all of the field choices for a standard field
	* @standard_field_id The standard field id
	*/
	public struct function RegistrationStandardFieldChoicesGet( required numeric standard_field_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationStandardFieldChoicesGet"
		});
		sp.addParam( type="in", dbvarname="@standard_field_id", cfsqltype="cf_sql_smallint", value=arguments.standard_field_id );
		sp.addProcResult( name="choices", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets().choices
		};
	}
	/*
	* Copies a field and creates a new field just like it
	* @field_id The id of the field
	*/
 	public numeric function RegistrationFieldCopy( required numeric field_id, required string label, required string field_name ) {
        var sp = new StoredProc();
        var result = {};
        sp.setAttributes({
            'datasource' = getDSN(),
            'procedure' = "RegistrationFieldCopy"
        });
        
        sp.addParam( type="in", dbvarname="@field_id", cfsqltype="cf_sql_integer", value=arguments.field_id );
        sp.addParam( type="out", dbvarname="@field_id_new", cfsqltype="cf_sql_bigint", variable="field_id_new" );
        sp.addParam( type="in", dbvarname="@label", cfsqltype="cf_sql_varchar", value=arguments.label );
        sp.addParam( type="in", dbvarname="@field_name", cfsqltype="cf_sql_varchar", value=arguments.field_name );
        
        result = sp.execute();
        return result.getProcOutVariables().field_id_new;
    }
	/*
	* Gets all of the custom fields for an event
	* @event_id The id of the Field
	*/
	public struct function RegistrationFieldsCustomList( required numeric event_id ) {
		var sp = new StoredProc();
		var result = {}; 
		sp.setAttributes({
			'datasource': getDSN(),
			'procedure': "RegistrationFieldsCustomList"
		});
		sp.addParam( type="in", dbvarname="@event_id", cfsqltype="cf_sql_integer", value=arguments.event_id );
		sp.addProcResult( name="fields", resultset=1 );
		result = sp.execute();
		return {
			'prefix' = result.getPrefix(),
			'result' = result.getProcResultSets()
		};
	}    
}