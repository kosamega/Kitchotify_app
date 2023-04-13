const options = document.querySelectorAll('#album_designer_id option')
console.log(options)
const searchField = document.getElementById('search-field')
searchField.addEventListener('input', (e)=>{
  const word = e.target.value
  options.forEach((option)=>{
    console.log(option.innerText)
    if(option.innerText.includes(word)){
      option.style.display = ''
    }else{
      option.style.display = 'none'
    }
  })
})