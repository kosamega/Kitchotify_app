const designerUserOptions = document.querySelectorAll('#select-div-designer-user option')
console.log(designerUserOptions)
const designerUserSearchField = document.getElementById('search-field-designer-user')
designerUserSearchField.addEventListener('input', (e)=>{
  const word = e.target.value
  designerUserOptions.forEach((option)=>{
    console.log(option.innerText)
    if(option.innerText.includes(word)){
      option.style.display = ''
    }else{
      option.style.display = 'none'
    }
  })
})
