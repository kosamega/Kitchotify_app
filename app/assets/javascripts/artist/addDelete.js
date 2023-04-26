function addDelete(e){
  let ownershipId = e.currentTarget.dataset.ownershipId
  fetch(`/user_artist_ownerships/${ownershipId}`, {
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
    document.getElementById('user_artist_ownership_user_id').appendChild(option)  
    addFlashMessage(data.message)
  })
  document.getElementById(`ownership${ownershipId}`).remove()
}
