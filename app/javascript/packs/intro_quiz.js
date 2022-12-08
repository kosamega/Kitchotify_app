// カウントダウン
let rest = 2
const countDown = ()=>{
  console.log(rest)
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

const getCsrfToken = () => {
  const metas = document.getElementsByTagName('meta');
  for (let meta of metas) {
      if (meta.getAttribute('name') === 'csrf-token') {
          console.log('csrf-token:', meta.getAttribute('content'));
          return meta.getAttribute('content');
      }
  }
  return '';
}

index = 0
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
  index++
  document.getElementById("point").innerHTML = `${index}/${gon.q_num}`
  if(index < gon.q_num){
    document.getElementById(gon.ids[index]).removeEventListener("click", correct)
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

    const clearTime = m*60000 + s*1000 + ms

    await fetch("/quiz_results", {
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
  document.getElementById(gon.ids[index]).addEventListener("click", correct)
  document.querySelectorAll(".answer-btn").forEach(e=>{
    e.addEventListener("click", incorrect)
  })
  document.getElementById(gon.ids[index]).removeEventListener("click", incorrect)
  answer_audio.src = gon.answers_j[index]["url"]
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
