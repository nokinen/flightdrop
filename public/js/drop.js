$(function(){
	
	// Read files with FileReader
	if(!window.FileReader){
		$("#main .page-header").after('<div class="alert alert-block"><h4>Unsupported Browser!</h4>Use the latest version of Chrome, Safari or Firefox to access this page.</div>');
		console.error("FileReader API not supported by this browser");
		return;
	}
	
	var dropzone = $("#dropzone");
	dropzone.on("dragover",allowDrop);
	dropzone.on("drop",drop);
});

function drop(event) {
	event.preventDefault();
	
	var file = event.originalEvent.dataTransfer.files[0];
	console.log("Dropped file:" + file.name);
		
	var reader = new FileReader();
	reader.onloadend = function(e){
		$("#data").val(e.target.result);
		$("#filename").val(file.name);
		$("form").submit();
	}
	reader.readAsText(file);
}

function allowDrop(event){
	event.preventDefault();
}