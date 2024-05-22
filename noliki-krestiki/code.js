function start(cells) {
    let i = 0; 
  
    for (let cell of cells) {
      cell.removeEventListener('click', cellClick); 
      cell.addEventListener('click', cellClick);
    }
    
    function cellClick() {
      if (this.textContent === '') { 
        if (i % 2 === 0) {
          this.textContent = 'X'; 
        } else {
          this.textContent = 'O'; 
        }
        i++; 
      }
    }
}


function isVictory(cells) {
    const lines = [
      [0, 1, 2], 
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6], 
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8], 
      [2, 4, 6]
    ];
  
    for (let line of lines) {
      const [a, b, c] = line;
      if (cells[a].textContent && cells[a].textContent === cells[b].textContent && cells[a].textContent === cells[c].textContent) {
        return true; 
      }
    }
  
    if ([...cells].every(cell => cell.textContent)) {
      alert('Ничья'); 
    }
  
    return false; 
}
  
  function start(cells) {
    let i = 0;
  
    for (let cell of cells) {
      cell.addEventListener('click', function step() {
        this.textContent = ['X', 'O'][i % 2];
        this.removeEventListener('click', step);
  
        if (isVictory(cells)) {
          alert(this.textContent); 
        }
  
        i++;
      });
    }
}
  
let cells = document.querySelectorAll('#field td');
start(cells);