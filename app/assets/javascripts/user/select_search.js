const userOptions = document.querySelectorAll('#select-div-user option')
console.log(userOptions)
const userSearchField = document.getElementById('search-field-user')
userSearchField.addEventListener('input', (e)=>{
  const word = e.target.value
  userOptions.forEach((option)=>{
    console.log(option.innerText)
    if(option.innerText.includes(word)){
      option.style.display = ''
    }else{
      option.style.display = 'none'
    }
  })
})
