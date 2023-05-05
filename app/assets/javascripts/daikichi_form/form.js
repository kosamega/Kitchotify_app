document.querySelectorAll('.check-all').forEach((checkAll)=>{
  checkAll.addEventListener('change',(e)=>{
    console.log(e)
    if(checkAll.checked){
      document.querySelectorAll(`.album${e.currentTarget.dataset.albumId}`).forEach((checkMusic)=>{
        checkMusic.checked = true
      })
    }else{
      document.querySelectorAll(`.album${e.currentTarget.dataset.albumId}`).forEach((checkMusic)=>{
        checkMusic.checked = false
      })
    }
  })
})
