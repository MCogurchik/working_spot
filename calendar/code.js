let calendar = document.querySelector('#calendar');
let body = calendar.querySelector('.body');
let prev = calendar.querySelector('.prev');
let next = calendar.querySelector('.next');

let date = new Date();
let year = date.getFullYear();
let month = date.getMonth();

let monthNames = ['Янв', 'Фев', 'Март', 'Апр', 'Май', 'Июнь', 'Июль', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек'];

draw(body, year, month);

function draw(body, year, month) {
    let arr = range(getLastDay(year, month));

    let firstWeekDay = getFirstWeekDay(year, month);
    let lastWeekDay = getLastWeekDay(year, month);

    let nums = chunk(normalize(arr, firstWeekDay, 6 - lastWeekDay), 7);
    createTable(body, nums);
    updateInfo(month, year);

    function updateInfo(month, year) {
        let infoElement = document.querySelector('.info');
        infoElement.textContent = `${monthNames[month]} ${year}`;
    }
}
function createTable(parent, arr) {
  parent.textContent = '';
  let cells = [];

  for (let sub of arr) {
    let tr = document.createElement('tr');

    for (let num of sub) {
      let td = document.createElement('td');
      td.textContent = num;
      tr.appendChild(td);

      cells.push(td);
    }

    parent.appendChild(tr);
  }

  return cells;
}

function normalize(arr, left, right) {
  for (let i = 0; i < left; i++) {
    arr.unshift('');
  }
  for (var i = 0; i < right; i++) {
    arr.push('');
  }

  return arr;
}

function getFirstWeekDay(year, month) {
  let date = new Date(year, month, 1);
  let num  = date.getDay();

  if (num === 0) {
    return 6;
  } else {
    return num - 1;
  }
}

function getLastWeekDay(year, month) {
  let date = new Date(year, month + 1, 0);
  let num  = date.getDay();

  return num === 0 ? 6 : num - 1;
}

function getLastDay(year, month) {
  let date = new Date(year, month + 1, 0);
  return date.getDate();
}

function range(count) {
  let arr = [];

  for (let i = 1; i <= count; i++) {
    arr.push(i);
  }

  return arr;
}

function chunk(arr, n) {
  let result = [];
  let count = Math.ceil(arr.length / n);

  for (let i = 0; i < count; i++) {
    let elems = arr.splice(0, n);
    result.push(elems);
  }

  return result;
}

function getNextYear(currentYear, currentMonth) {
  return currentMonth === 11 ? currentYear + 1 : currentYear;
}

function getNextMonth(currentMonth) {
  return currentMonth === 11 ? 0 : currentMonth + 1;
}

function getPrevYear(currentYear, currentMonth) {
  return currentMonth === 0 ? currentYear - 1 : currentYear;
}

function getPrevMonth(currentMonth) {
  return currentMonth === 0 ? 11 : currentMonth - 1;
}

function updateInfo(month, year) {
  let infoElement = document.querySelector('.info');
  infoElement.textContent = `${monthNames[month]} ${year}`;
}

next.addEventListener('click', function () {
  year = getNextYear(year, month);
  month = getNextMonth(month);
  draw(body, year, month);
});

prev.addEventListener('click', function () {
  year = getPrevYear(year, month);
  month = getPrevMonth(month);
  draw(body, year, month);
});