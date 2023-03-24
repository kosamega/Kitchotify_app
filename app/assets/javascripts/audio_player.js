const audio = document.getElementById('audio');
const audioPlayer = document.getElementById("foot-audio-player");
const infos = gon.infos_j
const indexIncoContent = document.getElementById('index-info-content')
let max = infos.length

function changeInfo(index){
  let artistElement = document.getElementById("track-artist");
  artistElement.innerHTML = infos[index]['artist'];

  let nameElement = document.getElementById("track-name");
  nameElement.innerHTML = infos[index]['name'];

  indexIncoContent.innerText = infos[index]['index_info']
}

function nowPlay(id){
  let track = document.getElementById(id);
  if(track == null) return;
  track.classList.add("now-play");
}


function endPlay(){
  let track = document.querySelector('.now-play');
  if(track == null) return;
  track.classList.remove("now-play");
}

audio.volume = gon.user.volume;
audio.controls = true;
// サファリでバグる？
// audio.controlsList.add("nodownload");

audio.src = infos[0]['url'];
let index = 0
changeInfo(index);
nowPlay(0);

// 再生が終わったら
audio.addEventListener('ended', async function(){
  endPlay();
  index++
  if ( index < max) {
      audio.src = infos[index]['url'];
      changeInfo(index);
      nowPlay(infos[index]['id']);
      await audio.play();
  }else{
      audio.src = infos[0]['url'];
      index = 0;
      changeInfo(index);
      nowPlay(infos[index]['id']);
  }
});


// audio player関連
async function prev(){
    endPlay();
    if (0 < index) {
        index--;
    }
    else{
        index = 0;
    }
    audio.src = infos[index]['url'];
    changeInfo(index);
    nowPlay(infos[index]['id']);
    await audio.play();
}

prevBtn = document.getElementById("prev")
if(prevBtn != null){
  prevBtn.addEventListener('click', prev);
}

async function next(){
  endPlay();
    if ( index < (max - 1) ) {
      index++;
    }
    else {
      index = 0;
    }
    audio.src = infos[index]['url'];
    nowPlay(infos[index]['id']);
    changeInfo(index);
    await audio.play();
}
      
nextBtn = document.getElementById('next')
if(nextBtn != null){
  nextBtn.addEventListener('click', next)
}

function loop(){
  audio.loop = !audio.loop;
  let loopbtn = document.getElementById("loop-btn");
  if (audio.loop) {
    loopbtn.classList.add("loop-true");
  }
  else{
    loopbtn.classList.remove("loop-true");
  }
}
    
document.getElementById('loop-btn').addEventListener('click', loop)

// トラックナンバーと再生ボタン
function setPlayBtn(){
  for(let el of document.querySelectorAll('.track')){
    el.addEventListener('dblclick', playBtn)
  }
  for(let el of document.querySelectorAll('.tr-number-play')){
    el.addEventListener('click', playBtn)
  }
}

setPlayBtn();

async function playBtn(evt){
  endPlay();
  const id = Number(evt.currentTarget.closest('.track').id);
  const info = infos.find(el => el.id == id);
  audio.src = info['url'];
  index = infos.indexOf(info)
  changeInfo(index);
  nowPlay(id);
  await audio.play();
}

// プレイリストからトラックを削除したとき、like一覧でunlikeしたときにつじつまを合わせる
function setDeleteBtn(){
  for(let el of document.querySelectorAll('.delete-btn')){
    el.addEventListener('click', trDelete)
  }
}

setDeleteBtn();

async function trDelete(evt){
  let track = evt.currentTarget.closest('.track')
  let trackId = track.id
  let trackPosition = infos.findIndex(info => info.id == trackId)
  track.remove()
  infos.splice(trackPosition, 1);

  
  if(trackPosition == index){
    if(index == (max-1)){
      index--;
    }
    audio.src = infos[index]['url'];
    audio.load();
    changeInfo(index);
    nowPlay(infos[index+1]['id']);
  }
  max--;
  trackPosition++;
  document.querySelectorAll('.tr-number').forEach((el, index)=>{
    el.innerHTML = index+1;
  })
  setPlayBtn();
  setDeleteBtn();
}

// インデックス情報
const infoBtn = document.getElementById('index-info-btn')
const indexInfo = document.getElementById('index-info')
const indexCloseBtn = document.getElementById('close-index-info')

function indexShow (){
  indexInfo.classList.remove('d-none')
  infoBtn.removeEventListener('click', indexShow)
  infoBtn.addEventListener('click', indexHide)
}

function indexHide (){
  indexInfo.classList.add("d-none")
  infoBtn.removeEventListener('click', indexHide)
  infoBtn.addEventListener('click', indexShow)
}

infoBtn.addEventListener('click', indexShow)
indexCloseBtn.addEventListener('click', indexHide)

// volume
audio.addEventListener('volumechange', async function(event){
  const url = `/users/${gon.user.id}`
  const params = {user: {volume: event.target.volume}};
  await fetch(url, {method: 'PUT', headers: {'Content-Type': 'application/json', 'X-CSRF-Token': getCsrfToken()}, body: JSON.stringify(params)})
});
