var infos = gon.infos_j
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
        let elm_drop = document.getElementById(dropped_id);

        let rect = this.getBoundingClientRect();
        // 上から下
        if(dragged_id<dropped_id){
            //マウスカーソルの位置が要素の半分より上のとき
            if ((event.clientY - rect.top) < (this.clientHeight / 2)) {
                for(let i=dragged_id+1; i<dropped_id; i++){
                    document.getElementById(i).querySelector(".tr-number").innerText = i;
                    document.getElementById(i).setAttribute("id", `${i-1}`);
                }
                this.parentNode.insertBefore(elm_drag, this);
                elm_drag.querySelector(".tr-number").innerHTML = dropped_id
                elm_drag.setAttribute("id", dropped_id - 1);
                info = infos[dragged_id]
                infos.splice(dragged_id, 1)
                infos.splice(dropped_id - 1, 0, info)
                if (!(dragged_id - dropped_id == 1)){
                    await fetch(`/playlists/#{@playlist.id}/sort?drag=${dragged_id}&drop=${dropped_id - 1}`, {method: 'POST'})
                }
            //マウスカーソルの位置が要素の半分より下
            } else {
                for(let i=dragged_id+1; i<=dropped_id; i++){
                    document.getElementById(i).querySelector(".tr-number").innerText = i;
                    document.getElementById(i).setAttribute("id", `${i-1}`);
                }
                this.parentNode.insertBefore(elm_drag, this.nextSibling);
                elm_drag.setAttribute("id", dropped_id);
                elm_drag.querySelector(".tr-number").innerHTML = dropped_id + 1;
                info = infos[dragged_id]
                infos.splice(dragged_id, 1)
                infos.splice(dropped_id, 0, info)
                await fetch(`/playlists/#{@playlist.id}/sort?drag=${dragged_id}&drop=${dropped_id}`, {method: 'POST'})
            }
        // 下から上
        }else if(dragged_id>dropped_id){
            //マウスカーソルの位置が要素の半分より上
            if ((event.clientY - rect.top) < (this.clientHeight / 2)) {
                for(let i=dragged_id-1; dropped_id<=i; i--){
                    document.getElementById(i).querySelector(".tr-number").innerText = i + 2;
                    document.getElementById(i).setAttribute("id", i + 1);
                }
                this.parentNode.insertBefore(elm_drag, this);
                elm_drag.setAttribute("id", dropped_id);
                elm_drag.querySelector(".tr-number").innerHTML = dropped_id + 1;
                info = infos[dragged_id]
                infos.splice(dragged_id, 1)
                infos.splice(dropped_id, 0, info)
                await fetch(`/playlists/#{@playlist.id}/sort?drag=${dragged_id}&drop=${dropped_id}`, {method: 'POST'})
            //マウスカーソルの位置が要素の半分より下
            } else {
                for(let i=dragged_id-1; dropped_id<i; i--){
                    document.getElementById(i).querySelector(".tr-number").innerText = i + 2;
                    document.getElementById(i).setAttribute("id", i + 1);
                }
                this.parentNode.insertBefore(elm_drag, this.nextSibling);
                elm_drag.setAttribute("id", dropped_id + 1);
                elm_drag.querySelector(".tr-number").innerHTML = dropped_id + 2;
                info = infos[dragged_id]
                infos.splice(dragged_id, 1)
                infos.splice(dropped_id + 1, 0, info)
                await fetch(`/playlists/#{@playlist.id}/sort?drag=${dragged_id}&drop=${dropped_id + 1}`, {method: 'POST'})
            }
        }
        this.style.borderTop = '';
        this.style.borderBottom = '';
    };
});