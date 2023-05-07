const artistUserOptions = document.querySelectorAll('#select-div-artist-user option')
console.log(artistUserOptions)
const artistSearchField = document.getElementById('search-field-artist-user')
artistSearchField.addEventListener('input', (e)=>{
  const word = e.target.value
  artistUserOptions.forEach((option)=>{
    console.log(option.innerText)
    if(option.innerText.includes(word)){
      option.style.display = ''
    }else{
      option.style.display = 'none'
    }
  })
})
