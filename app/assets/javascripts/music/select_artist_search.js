const artistSelects = Array.from(document.querySelectorAll('.artist-select'))
const artistSearchFields = document.querySelectorAll('.search-field-artist')
artistSearchFields.forEach(artistSearchField=>{
  artistSearchField.addEventListener('input', (e)=>{
    const word = e.target.value
    const artistOptions = artistSelects.find(artistSelect=>artistSelect.dataset.number == artistSearchField.dataset.number).children
    Array.prototype.forEach.call(artistOptions, function(option) {
      if(option.innerText.includes(word)){
        option.style.display = ''
      }else{
        option.style.display = 'none'
      }
    })
  })
})
