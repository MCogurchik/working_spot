let name   = document.querySelector('#name');
let price  = document.querySelector('#price');
let amount = document.querySelector('#amount');
let add    = document.querySelector('#add');
let table  = document.querySelector('#table');
let total  = document.querySelector('#total');

function createCell(tr, value, name) {
  let td = document.createElement('td');
  td.textContent = value;
  td.classList.add(name);
  tr.appendChild(td);
  return td;
}

function recountTotal() {
  let costs = table.querySelectorAll('.cost');
  let sum = 0;

  if (costs.length > 0) {
    costs.forEach(cost => {
      sum += parseFloat(cost.textContent);
    });
  }

  total.textContent = sum.toFixed(2);
}

function allowEdit(td) {
  td.addEventListener('dblclick', function () {
    let text = td.textContent;
    td.textContent = '';

    let input = document.createElement('input');
    input.value = text;
    input.focus();
    td.appendChild(input);

    input.addEventListener('keydown', function (event) {
      if (event.key === 'Enter') {
        td.textContent = this.value;

        if (td.classList.contains('price') || td.classList.contains('amount')) {
          
          let row = td.parentElement;
          let price = parseFloat(row.querySelector('.price').textContent);
          let amount = parseFloat(row.querySelector('.amount').textContent);
          let cost = price * amount;

          
          row.querySelector('.cost').textContent = cost;

          
          recountTotal();
        }
      }
    });
  });
}

add.addEventListener('click', function() {
  let tr = document.createElement('tr');

  let nameCell = createCell(tr, name.value, 'name');
  let priceCell = createCell(tr, price.value, 'price');
  let amountCell = createCell(tr, amount.value, 'amount');

  createCell(tr, price.value * amount.value, 'cost');

  let removeCell = createCell(tr, 'удалить', 'remove');
  removeCell.addEventListener('click', function() {
    
    tr.remove();
    
    recountTotal();
  });

 
  table.appendChild(tr);
  
  allowEdit(nameCell);
  allowEdit(priceCell);
  allowEdit(amountCell);

  recountTotal();
});