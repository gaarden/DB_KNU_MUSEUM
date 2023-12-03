var artifacts = document.querySelectorAll(".artifact");

for(let i=0; i<artifacts.length; i++){
	artifacts[i].addEventListener("click", popUpInfo);
}

/*function popUpInfo(){
	window.open(page,name,"width=300, height=400, left=0, top=0");
}*/
