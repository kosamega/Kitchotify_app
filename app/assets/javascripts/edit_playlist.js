document.getElementById('edit-playlist').addEventListener('click', ()=>{
  document.querySelector('.edit-playlist').classList.replace("d-none", "d-flex")
})

for(var el of document.querySelectorAll(".x")){
  el.addEventListener('click', (e)=>{
    document.querySelector('.edit-playlist').classList.replace("d-flex", "d-none")
  })
}