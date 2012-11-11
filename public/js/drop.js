var dropzone = false;

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
		console.log(files[i].name);
}

function allowDrop(event){
	event.preventDefault();
}