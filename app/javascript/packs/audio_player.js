var audio = document.getElementById('audio');
var audioPlayer = document.getElementById("foot-audio-player");
var infos = gon.infos_j
var max = infos.length
function changeInfo(){
  var artistElement = document.getElementById("track-artist");
  artistElement.innerHTML = infos[index]['artist'];

  var nameElement = document.getElementById("track-name");
  nameElement.innerHTML = infos[index]['name'];
}

function nowPlay(trackNum){
  var track = document.getElementById(trackNum);
  if(track == null) return;
  track.classList.add("now-play");
}


function endPlay(trackNum){
  var track = document.querySelector('.now-play');
  if(track == null) return;
  track.classList.remove("now-play");
}

audio.volume = 0.08;
audio.controls = true;
audio.controlsList.add("nodownload");

audio.src = infos[0]['url'];
var index = 0
changeInfo();
nowPlay(0);

audio.addEventListener('ended', async function(){
  endPlay(index);
  index++
  if ( index < max) {
      audio.src = infos[index]['url'];
      changeInfo();
      nowPlay(index);
      await audio.play();
  }else{
      audio.src = infos[0]['url'];
      index = 0;
      changeInfo();
      nowPlay(index);
  }
});


// audio player関連
async function prev(){
    endPlay(index);
    if (0 < index) {
        index--;
    }
    else{
        index = 0;
    }
    audio.src = infos[index]['url'];
    changeInfo();
    nowPlay(index);
    await audio.play();
}

prevBtn = document.getElementById("prev")
if(prevBtn != null){
  prevBtn.addEventListener('click', prev);
}

async function next(){
  endPlay(index);
    if ( index < (max - 1) ) {
      index++;
    }
    else {
      index = 0;
    }
    audio.src = infos[index]['url'];
    nowPlay(index);
    changeInfo();
    await audio.play();
}
      
nextBtn = document.getElementById('next')
if(nextBtn != null){
  nextBtn.addEventListener('click', next)
}

function loop(){
  audio.loop = !audio.loop;
  var loopbtn = document.getElementById("loop-btn");
  if (audio.loop) {
    loopbtn.classList.add("loop-true");
  }
  else{
    loopbtn.classList.remove("loop-true");
  }
}
    
document.getElementById('loop-btn').addEventListener('click', loop)

// トラックナンバーと再生ボタン
function setPlayButton(){
  for(var el of document.querySelectorAll('.track')){
    el.addEventListener('dblclick', playButton)
  }
  for(var el of document.querySelectorAll('.tr-number-play')){
    el.addEventListener('click', playButton)
  }
}

setPlayButton();

async function playButton(evt){
  endPlay(index);
  index = evt.currentTarget.closest('.track').id;
  audio.src = infos[index]['url'];
  changeInfo();
  nowPlay(index);
  await audio.play();
}

// プレイリストからトラックを削除したとき、like一覧でunlikeしたときにつじつまを合わせる
function setDeleteButton(){
  for(var el of document.querySelectorAll('.delete-btn')){
    el.addEventListener('click', trDelete)
  }
}

setDeleteButton();

function trDelete(evt){
  let trackNum = evt.currentTarget.closest('.track').id
  console.log(trackNum);
  infos.splice(trackNum, 1);
  
  if(trackNum == index){
    if(index == (max-1)){
      index--;
    }
    audio.src = infos[index]['url'];
    audio.load();
    changeInfo();
    nowPlay(index + 1);
  }
  max--;
  trackNum++;
  for(var i = trackNum; i <= max; i++){
    const track = document.getElementById(`${i}`)
    track.setAttribute("id", `${i - 1}`);
    track.querySelector('.tr-number').innerHTML = i ;
  }
  setPlayButton();
  setDeleteButton();
}
