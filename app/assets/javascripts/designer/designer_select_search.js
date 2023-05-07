const designerOptions = document.querySelectorAll('#select-div-designer option')
console.log(designerOptions)
const designerSearchField = document.getElementById('search-field-designer')
designerSearchField.addEventListener('input', (e)=>{
  const word = e.target.value
  designerOptions.forEach((option)=>{
    console.log(option.innerText)
    if(option.innerText.includes(word)){
      option.style.display = ''
    }else{
      option.style.display = 'none'
    }
  })
})
