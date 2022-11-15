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
    const m  = String(currentTime.getMinutes()).padStart(2,"0");
    const s  = String(currentTime.getSeconds()).padStart(2,"0");
    const ms  = String(currentTime.getMilliseconds()).padStart(2,"0");
    document.getElementById("clear-time").textContent = `${m}:${s}.${ms}`
    document.getElementById("clear").classList.replace("d-none", "show")
  }
}

const incorrect = async ()=>{
  await incorrect_SE.play();
}

document.get

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
  quiz();
  startTime = Date.now();
  displayTime();
});
