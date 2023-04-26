const rows = document.querySelectorAll("tbody tr");

const search = (e) => {
  const keyword = e.target.value
  rows.forEach(e=>e.style.display = "none")
  if(keyword){
    rows.forEach(e => {
      if (e.innerHTML.toLowerCase().indexOf(keyword.toLowerCase()) !== -1){
        e.style.display = "table-row"
      }else{
        e.style.display = "none"
      }
    })
  }else{
    rows.forEach(e=>{
      e.style.display = "table-row"
    })
  }
}

document.getElementById("artist-search").addEventListener("input", search);
