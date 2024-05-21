function getRandomElement(array) {
    const randomIndex = Math.floor(Math.random() * array.length);
    return array[randomIndex];
  }
  
  let rows = 3;
  let cols = 3;
  
  let colors = ['red', 'green', 'blue'];
  
  let field = document.getElementById('field');
  for (let i = 0; i < rows; i++) {
    let row = field.insertRow();
    for (let j = 0; j < cols; j++) {
      let cell = row.insertCell();
      let randomColor = getRandomElement(colors);
      cell.classList.add(randomColor);
    }
  }
  
  function getNextElement(array, currentElement) {
    const currentIndex = array.indexOf(currentElement);
    const nextIndex = (currentIndex + 1) % array.length;
    return array[nextIndex];
  }
  
  
  function handleClick() {
    let currentColor = this.className; 
    let nextColor = getNextElement(colors, currentColor); 
  
    this.classList.remove(currentColor); 
    this.classList.add(nextColor); 
  }
  
  
  let cells = document.querySelectorAll('#field td');
  cells.forEach(cell => {
    cell.addEventListener('click', handleClick);
  });
  function checkVictory(cells) {
   
    const firstCellClass = cells[0].className;
  
    for (let cell of cells) {
      if (cell.className !== firstCellClass) {
        return false; 
      }
    }
  
    return true; 
  }
  
  function handleClick() {
    let currentColor = this.className; 
    let nextColor = getNextElement(colors, currentColor); 
  
    this.classList.remove(currentColor); 
    this.classList.add(nextColor); 
  
    if (checkVictory(cells)) {
      alert('Победа!');
    }
  }
  let clickCount = 0; 
  
  let clickCountElement = document.createElement('div');
  clickCountElement.textContent = `Количество нажатий: ${clickCount}`;
  document.body.insertBefore(clickCountElement, field);
  
  
  function handleClick() {
    let currentColor = this.className; 
    let nextColor = getNextElement(colors, currentColor); 
  
    this.classList.remove(currentColor); 
    this.classList.add(nextColor); 
  
    clickCount++; 
    clickCountElement.textContent = `Количество нажатий: ${clickCount}`; 
  
    if (checkVictory(cells)) {
      alert(`Победа! Количество нажатий: ${clickCount}`);
    }
  }