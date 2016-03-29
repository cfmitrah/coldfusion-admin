<script id="options-template" type="text/x-handlebars-template"><option value="{{value}}" {{selected}} data-index="{{index}}" {{data_attrs}}>{{display}}</option></script>


<script id="select-template" type="text/x-handlebars-template">
<select name="{{name}}" id="{{id}}" class="form-control" required data-field_id="{{data_field_id}}" {{data_attrs}}>
	{{options}}
</select>
</script>

<script id="display-template" type="text/x-handlebars-template">
<input type="hidden" name="{{name}}" id="{{id}}" class="form-control" required data-field_id="{{data_field_id}}" value="{{value}}" {{data_attrs}} />
<p class="form-control-static" id="{{id}}_display">{{display}}</p>
</script>