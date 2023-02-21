// カウントダウン
let rest = 2
const countDown = ()=>{
  document.getElementById("count-down-number").innerText = rest
  rest--;
};

const answers = document.querySelectorAll(".answer-btn");

const searchMusic = (e) => {
  const keyword = e.target.value
  answers.forEach(e=>e.style.display = "none")
  if(keyword){
    answers.forEach(e => {
      if (e.innerHTML.toLowerCase().indexOf(keyword.toLowerCase()) !== -1){
        e.style.display = "inline-block"
      }else{
        e.style.display = "none"
      }
    })
  }else{
    answers.forEach(e=>{
      e.style.display = "inline-block"
    })
  }
}



quiz_index = 0
answer_audio = document.getElementById("answer-audio")
answer_audio.loop = true
answer_audio.volume = 0.08
const correct_SE = document.getElementById("correct")
correct_SE.volume = 0.1
const incorrect_SE = document.getElementById("incorrect")
incorrect_SE.volume = 0.1

const correct = async ()=>{
  answer_audio.pause();
  await correct_SE.play();
  quiz_index ++
  document.getElementById("point").innerHTML = `${quiz_index }/${gon.q_num}`
  if(quiz_index  < gon.q_num){
    document.getElementById(`ans${gon.ids[quiz_index]}`).removeEventListener("click", correct)
    await quiz();
  }else{
    document.getElementById("quiz-play").classList.add("d-none")
    currentTime = new Date(Date.now() - startTime);
    const m = currentTime.getMinutes()
    const s = currentTime.getSeconds()
    const ms = currentTime.getMilliseconds()
    const m_s  = String(m).padStart(2,"0");
    const s_s  = String(s).padStart(2,"0");
    const ms_s  = String(ms).padStart(2,"0");
    document.getElementById("clear-time").textContent = `${m_s}:${s_s}.${ms_s}`
    document.getElementById("clear").classList.replace("d-none", "show")
    document.querySelector("footer").classList.replace("d-none", "show")

    const clearTime = m*60000 + s*1000 + ms

    ("/quiz_results", {
      method: "POST", 
      headers: {"Content-Type": "application/json", 
                'X-CSRF-Token': getCsrfToken()},
      body: JSON.stringify({time: clearTime, intro_quiz_id: gon.q_id})}
    )
  }
}

false_count_node = document.getElementById("false-count")
false_count = 0
const incorrect = async ()=>{
  await incorrect_SE.play();
  false_count++;
  false_count_node.textContent = false_count;
}

const quiz = async ()=>{
  answers.forEach(e=>{e.removeEventListener("click", incorrect)})
  answers.forEach(e=>{e.removeEventListener("click", correct)})
  document.getElementById(`ans${gon.ids[quiz_index]}`).addEventListener("click", correct)
  document.querySelectorAll(".answer-btn").forEach(e=>{
    e.addEventListener("click", incorrect)
  })
  document.getElementById(`ans${gon.ids[quiz_index]}`).removeEventListener("click", incorrect)
  answer_audio.src = gon.infos_j[quiz_index ]["url"]
  await answer_audio.play();
}

// ストップウォッチ
const time = document.getElementById("time");
let startTime;
let timeoutID;

const displayTime = () => {
  currentTime = new Date(Date.now() - startTime);
  const m  = String(currentTime.getMinutes()).padStart(2,"0");
  const s  = String(currentTime.getSeconds()).padStart(2,"0");
  const ms  = String(currentTime.getMilliseconds()).padStart(2,"0");
  time.textContent = `${m}:${s}.${ms}`
  timeoutID = setTimeout(displayTime, 10);
}

document.getElementById("answer").addEventListener("input", searchMusic);
document.getElementById("start-btn").addEventListener("click", ()=> {
  document.getElementById("quiz-start").classList.add("d-none");
  document.getElementById("count-down").classList.remove("d-none");
  const countDownStart = setInterval(countDown, 1000);
  setTimeout(()=>{
    clearInterval(countDownStart);
    document.getElementById("count-down").classList.add("d-none");
    document.getElementById("quiz-play").classList.remove("d-none");
    quiz();
    startTime = Date.now();
    displayTime();
  }, 3000);
});

function audioPlayer() {
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
}
