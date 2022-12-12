function setButton (){
  document.getElementById("open-side-bar").addEventListener("click", ()=>{
    document.querySelector(".side-bar").style.display = "block";
    document.getElementById("close-side-bar").style.display = "inline-block";
  })
  document.getElementById("close-side-bar").addEventListener("click", ()=>{
    document.querySelector(".side-bar").style.display = "none";
    document.getElementById("close-side-bar").style.display = "none";
  })
}

setButton();