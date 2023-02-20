// likeを削除
function setDeleteLikeBtn(){
  for(let el of document.querySelectorAll('.delete-like-btn')){
    el.addEventListener('click', deleteLike)
  }
}

async function deleteLike(evt){
  const likeBtn = evt.currentTarget 
  let likeId = likeBtn.parentNode.dataset.likeId
  const token = document.getElementsByName('csrf-token')[0].content;
  await fetch(`/likes/${likeId}`, {
    method: 'DELETE',
    credentisls: 'include',
    headers: {
      'X-CSRF-Token': token
    }
  })
  likeBtn.removeEventListener('click', deleteLike)
  likeBtn.addEventListener('click', createLike)
  likeBtn.classList.replace('liked-btn', 'unliked-btn')
  likeBtn.classList.replace('delete-like-btn', 'create-like-btn')
  likeBtn.parentNode.dataset.likeId = ''
}

setDeleteLikeBtn();

function setCreateLikeBtn(){
  for(let el of document.querySelectorAll('.create-like-btn')){
    el.addEventListener('click', createLike)
  }
}

async function createLike(evt){
  const likeBtn = evt.currentTarget 
  let musicId = likeBtn.parentNode.dataset.musicId
  const token = document.getElementsByName('csrf-token')[0].content;
  const response = await fetch(`/likes?music_id=${musicId}`, {
    method: 'POST',
    credentisls: 'include',
    headers: {
      'X-CSRF-Token': token
    }
  })
  const json = await response.json()
  likeBtn.removeEventListener('click', createLike)
  likeBtn.addEventListener('click', deleteLike)
  likeBtn.classList.replace('unliked-btn', 'liked-btn')
  likeBtn.classList.replace('create-like-btn', 'delete-like-btn')
  likeBtn.parentNode.dataset.likeId = json.like_id
}

setCreateLikeBtn();
