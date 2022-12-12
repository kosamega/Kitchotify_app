console.log(document.querySelectorAll(".add_playlist-point"))
for(const el of document.querySelectorAll(".add_playlist-point")){
  el.addEventListener('click', ()=>{
    el.parentNode.querySelector(".select-playlists").classList.remove("d-none");
  })
}

for(const el of document.querySelectorAll(".select-playlists-close")){
  el.addEventListener('click', ()=>{
    el.parentNode.classList.add("d-none");
  })
}

document.getElementById('new-playlist').addEventListener('click', ()=>{
  document.querySelector('.new-playlist-bg').classList.replace("d-none", "d-flex")
})

for(const el of document.querySelectorAll(".x")){
  el.addEventListener('click', (e)=>{
    document.querySelector('.new-playlist-bg').classList.replace("d-flex", "d-none")
  })
}


