let form_link = location.href + "/musics/new"
document.getElementById('copy-form-link').addEventListener('click', ()=>{
  navigator.clipboard.writeText(form_link)
  alert('インデックス情報登録フォームのリンクをコピーしました')
})
