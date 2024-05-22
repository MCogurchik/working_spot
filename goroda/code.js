let field = document.querySelector('#field');
let message = document.querySelector('#message');
let cities = [];
function checkCity(city) {
  if (cities.length === 0) {
    cities.push(city);
    return true;
  } else {
    let lastCity = cities[cities.length - 1];
    if (city[0].toLowerCase() === lastCity[lastCity.length - 1].toLowerCase() && !cities.includes(city)) {
      cities.push(city);
      return true;
    } else {
      return false;
    }
  }
}
field.addEventListener('keypress', function(e) {
  if (e.key === 'Enter') {
    let inputCity = field.value.trim();
    if (inputCity === '') {
      message.textContent = 'Введите название города';
    } else if (!/^[a-zA-Z]+$/.test(inputCity)) {
      message.textContent = 'Название города должно содержать только буквы';
    } else {
      if (checkCity(inputCity)) {
        message.textContent = 'Город принят. Следующий ход.';
      } else {
        message.textContent = 'Этот город уже был или не подходит. Попробуйте другой.';
      }
    }
    field.value = '';
  }
});

 