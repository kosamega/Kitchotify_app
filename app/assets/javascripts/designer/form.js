// 削除ボタン
for(let el of document.querySelectorAll('.ownership-delete-btn')){
  el.addEventListener('click', addDelete)
}

function addFlashMessage(message){
  const flash = document.getElementById('flash')
  const p = document.createElement('p')
  p.innerText = message
  const div = document.createElement('div')
  div.appendChild(p)
  flash.appendChild(div)
  setTimeout(()=>{
    flash.firstElementChild.remove()
  },3000)
}

function addDelete(e){
  let ownershipId = e.currentTarget.dataset.ownershipId
  fetch(`/user_designer_ownerships/${ownershipId}`, {
    method: 'DELETE',
    credentisls: 'include',
    headers: {
    'X-CSRF-Token': getCsrfToken(),
    }        
  })
  .then( response => response.json())
  .then(data=>{
    const option = document.createElement('option')
    option.value = data.user_id
    option.innerText = data.user
    document.getElementById('user_designer_ownership_user_id').appendChild(option)  
    addFlashMessage(data.message)
  })
  document.getElementById(`ownership${ownershipId}`).remove()
}
