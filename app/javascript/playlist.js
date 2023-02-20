// ドラッグアンドドロップで並び替え
document.querySelectorAll(".track").forEach(elm => {
    elm.ondragstart = function () {
        event.dataTransfer.setData('text/plain', event.target.id);
    };
    elm.ondragover = function() {
        event.preventDefault();
        let rect = this.getBoundingClientRect();
        if ((event.clientY - rect.top) < (this.clientHeight / 2)) {
            //マウスカーソルの位置が要素の半分より上
            this.style.borderTop = '2px solid black';
            this.style.borderBottom = '';
        } else {
            //マウスカーソルの位置が要素の半分より下
            this.style.borderTop = '';
            this.style.borderBottom = '2px solid black';
        }
    };
    elm.ondragleave = function () {
        this.style.borderTop = '';
        this.style.borderBottom = '';
    };
    elm.ondrop = async function(){
        event.preventDefault();
        let dragged_id = Number(event.dataTransfer.getData('text/plain'));
        let elm_drag = document.getElementById(dragged_id);
        let dropped_id = Number(this.getAttribute("id"));
        const info = infos.find(el => el.id == dragged_id)
        let dragged_position = infos.findIndex(el => el.id == dragged_id)
        let dropped_position = infos.findIndex(el => el.id == dropped_id)

        let rect = this.getBoundingClientRect();
        // 上から下
        if(dragged_position<dropped_position){
            //マウスカーソルの位置が要素の半分より上のとき
            if ((event.clientY - rect.top) < (this.clientHeight / 2)) {
                this.parentNode.insertBefore(elm_drag, this);
                infos.splice(dragged_position, 1)
                infos.splice(dropped_position - 1, 0, info)
                if (!(dragged_position - dropped_position == 1)){
                    await fetch(`/playlists/${gon.playlist_id}/position?drag=${dragged_position}&drop=${dropped_position - 1}`, {method: 'PUT'})
                }
            //マウスカーソルの位置が要素の半分より下
            } else {
                this.parentNode.insertBefore(elm_drag, this.nextSibling);
                infos.splice(dragged_position, 1)
                infos.splice(dropped_position, 0, info)
                await fetch(`/playlists/${gon.playlist_id}/position?drag=${dragged_position}&drop=${dropped_position}`, {method: 'PUT'})
            }
        // 下から上
        }else if(dragged_position>dropped_position){
            //マウスカーソルの位置が要素の半分より上
            if ((event.clientY - rect.top) < (this.clientHeight / 2)) {
                this.parentNode.insertBefore(elm_drag, this);
                infos.splice(dragged_position, 1)
                infos.splice(dropped_position, 0, info)
                await fetch(`/playlists/${gon.playlist_id}/position?drag=${dragged_position}&drop=${dropped_position}`, {method: 'PUT'})
            //マウスカーソルの位置が要素の半分より下
            } else {
                this.parentNode.insertBefore(elm_drag, this.nextSibling);
                infos.splice(dragged_position, 1)
                infos.splice(dropped_position + 1, 0, info)
                await fetch(`/playlists/${gon.playlist_id}/position?drag=${dragged_position}&drop=${dropped_position + 1}`, {method: 'PUT'})
            }
        }
        this.style.borderTop = '';
        this.style.borderBottom = '';
        document.querySelectorAll('.tr-number').forEach((el, index)=>{
            el.innerHTML = index+1;
        })
    };
});

// プレイリストから曲を削除
function setRelationDeleteBtn(){
    for(let el of document.querySelectorAll('.relation-delete-btn')){
      el.addEventListener('click', async ()=>{
        let relation_id = relations[trackId]['id']
        await fetch(`/music_playlist_relations/${relation_id}`, {method: 'DELETE'})
      })
    }
  }
  
  setRelationDeleteBtn();
