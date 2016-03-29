/**
 *
 * @depends /plugins/dropzone/dropzone.min.js
 */
Dropzone.autoDiscover = false;

$(document).ready(function(){
	var $dropzone = $(".has_dropzone"),
		$tables = $("table.data-table");
	

	$dropzone.each(function(i, v){
		$(this)
			.addClass("dropzone")
			.dropzone({
				url: "/media/upload",
				maxFilesize: 25,
				params: $(this).data(), // pass any data attribute along as form post files i.e. company_id
				paramName: "media",
				uploadMultiple: false,
				addRemoveLinks: false
			});

		$dropzone[i].dropzone.on("success", function(file, data){
			if(data.success){
				console.log("The file was successfully uploaded.");
			}
			else{
				console.log("There was a problem when trying to upload the file. It is possible that the file is corrupt.");
			}
		});
		$dropzone[i].dropzone.on("error", function(file, data){
			console.log("There was a problem when trying to upload the file.");
		});
		$dropzone[i].dropzone.on("complete", function(file, data){
			$tables.each(function(i, v){
				$(this).dataTable()._fnAjaxUpdate();
			});

		});
	});
});