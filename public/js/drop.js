$(function(){
	dropzone = $("#dropzone");
	dropzone.on("dragover",allowDrop);
	dropzone.on("drop",drop);
});

function drop(event) {
	event.preventDefault();
	
	var files = event.originalEvent.dataTransfer.files;
	
	console.log("Dropped files:");
	for(i = 0; i< files.length; i++)
		console.info(files[i].name);
		
	// Read files with FileReader
	if(!window.FileReader){
		console.error("FileReader API not supported by this browser");
		return;
	}
		
	var reader = new FileReader();
	reader.onloadend = function(e){
		$("#data").val(e.target.result);
		$("#meta").submit();
	}
	reader.readAsText(files[0]);
}

function allowDrop(event){
	event.preventDefault();
}