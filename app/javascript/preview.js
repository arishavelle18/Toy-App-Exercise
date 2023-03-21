
// target the file type input
let fileInput = document.getElementById("file-input");
// targe the div images so that it append the image to view the image before uploading
let imageContainer = document.getElementById("images");
// target the length of the file in terms of uploading
let numOfFiles = document.getElementById("num-of-files");
console.log(imageContainer)

function preview(){
    imageContainer.innerHTML = "";
    // check the length of file input
    numOfFiles.textContent = `${fileInput.files.length} Files Selected`;

    // loop the file you upload
    // append the image in the image container so that we can view
    for(i of fileInput.files){
        let reader = new FileReader();
        let figure = document.createElement("figure");
        let figCap = document.createElement("figcaption");
       
        figure.appendChild(figCap);
        reader.onload=()=>{
            let img = document.createElement("img");
            img.setAttribute("src",reader.result);
            img.setAttribute("alt","Not an image");
            figure.insertBefore(img,figCap);
        }
        imageContainer.appendChild(figure);
        reader.readAsDataURL(i);
    }
}
