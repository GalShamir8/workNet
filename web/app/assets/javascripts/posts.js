// Option for pictures preview
function previewImages(input) {
  var preview = document.querySelector('.preview');
  preview.innerHTML = "";
  if (input.files) {
    var filesAmount = input.files.length;
    for (i = 0; i < filesAmount; i++) {
      var reader = new FileReader();
      reader.onload = function(event) {
        var img = document.createElement("img");
        img.setAttribute("src", event.target.result);
        preview.appendChild(img);
      }
      reader.readAsDataURL(input.files[i]);
    }
  }
}
