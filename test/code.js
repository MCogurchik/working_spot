let questions = [
    {
      text: 'Сколько хромосом у человека?',
      variants: ['46', '47', '1488'],
      right: 0
    },
    {
      text: 'Что нужно для роста мышц?',
      variants: ['Вода', 'Белок', 'Пасито'],
      right: 1
    },
    {
      text: 'Сколько подписчиков у Киселёва А.С.?',
      variants: ['1337', 'много', 'вОсЕмЬдесят ПяТь!'],
      right: 2
    },
    {
      text: 'Кто из них иноагент?',
      variants: ['Поперечный', 'Байден', 'Маканчик'],
      right: 0
    }
];

let html = '';

  questions.forEach((question, index) => {
    html += `<div>
      <p>${question.text}</p>
      ${question.variants.map((variant, i) => `
        <label>
          <input type="radio" name="question${index}" value="${i}">
          ${variant}
        </label>
      `).join('')}
    </div>`;
  });

  document.getElementById('test').innerHTML = html;

  document.getElementById('button').addEventListener('click', function() {
    let answers = questions.map(question => question.right);
    const questionsDivs = document.querySelectorAll('#test > div');
    questionsDivs.forEach((questionDiv, index) => {
      const inputs = questionDiv.querySelectorAll('input[type="radio"]');
      inputs.forEach((input, i) => {
        if (input.checked) {
          if (i === answers[index]) {
            input.parentElement.classList.add('right');
          } else {
            input.parentElement.classList.add('wrong');
          }
        }
      });
    });
  });