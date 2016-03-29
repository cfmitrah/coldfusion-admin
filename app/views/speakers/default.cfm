<cfoutput>
<div id="action-btns" class="pull-right adjust-m">
	<a href="#buildURL('speakers.create')#" class="btn btn-lg btn-info">Create New Speaker</a>
</div>
<h2 class="page-title color-02">Speakers</h2>
<p class="page-subtitle">Assign a speaker to a session by clicking the 'manage' link in the related table row below.</p>
#view("common/listing")#
</cfoutput>