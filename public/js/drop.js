$(function(){
	var dropzone = $("#dropzone");
	dropzone.on("dragover",allowDrop);
	dropzone.on("drop",drop);
});

function drop(event) {
	event.preventDefault();
	
	var file = event.originalEvent.dataTransfer.files[0];
	console.log("Dropped file:" + file.name);
		
	// Read files with FileReader
	if(!window.FileReader){
		console.error("FileReader API not supported by this browser");
		return;
	}
		
	var reader = new FileReader();
	reader.onloadend = function(e){
		$("#data").val(e.target.result);
		$("#filename").val(file.name);
		$("#meta").submit();
	}
	reader.readAsText(file);
}

function allowDrop(event){
	event.preventDefault();
}