//485.1
function setText(id, text) {
	let elems = document.getElementsByTagName('p');
    for (let elem of elems) {
	elem.textContent = text;
    }
}
  
//485.2
function setAttr(selector, attributeName, attributeValue) {
    let element = document.querySelector(selector);
    if (element) {
      element.setAttribute(attributeName, attributeValue);
    } else {
      console.log("Element not found");
    }
  }
  setAttr("#elem1", "title", "Title elem1");
  setAttr(".class1", "data-id", "12345");
  
//486.1
function appendText(selector, text) {
    let elements = document.querySelectorAll(selector);
    if (elements.length > 0) {
      elements.forEach(function(element) {
        element.textContent += text;
      });
    } else {
      console.log("Element not found");
    }
  }
  appendText("#elem1", " Additional text for elem1");
  appendText(".class1", " Additional text for class1");
  

//487.1
function addMark() {
    let paragraphs = document.querySelectorAll('p');
    paragraphs.forEach(function(paragraph) {
      paragraph.textContent += '!';
    });
  }
  addMark();

//488.1
function addMark() {
    let paragraphs = document.querySelectorAll('p');
    paragraphs.forEach(function(paragraph, index) {
      paragraph.textContent = (index + 1) + '. ' + paragraph.textContent;
    });
  }
  addMark();

//489.1
  function appendText(element, text) {
    element.textContent += text;
  }
  let paragraph1 = document.getElementById('paragraph1');
  appendText(paragraph1, ' Дополнительный текст.');
 
//489.2
  function appendText(element, text) {
    element.textContent += text;
  }
  let paragraph1 = document.getElementById('paragraph1');
  appendText(paragraph1, '!');

  let paragraph2 = document.getElementById('paragraph2');
  appendText(paragraph2, '!');

  let paragraph3 = document.getElementById('paragraph3');
  appendText(paragraph3, '!');

//489.3
function setValue(input, text) {
    input.value = text;
  }
  let inputField = document.getElementById('inputField');
  setValue(inputField, 'Пример текста для инпута');

//490.1
function appendText(elements, text) {
    elements.forEach(function(element) {
      element.innerHTML += text;
    });
  }
  let paragraphs = [document.getElementById('paragraph1'), document.getElementById('paragraph2')];
  appendText(paragraphs, ' Дополнительный текст');

//490.2
function appendElem(ulElement, text) {
    let newLi = document.createElement('li');
    newLi.appendChild(document.createTextNode(text));
    ulElement.appendChild(newLi);
  }
  let ul = document.getElementById('list');
  appendElem(ul, 'Новый элемент');

//490.3
function appendElem(ulElement, text) {
    let newLi = document.createElement('li');
    newLi.appendChild(document.createTextNode(text));
    ulElement.appendChild(newLi);
  }

  let ul = document.getElementById('list');
  let arr = ['Элемент 3', 'Элемент 4', 'Элемент 5'];

  arr.forEach(function(item) {
    appendElem(ul, item);
  });

//491 
function createTable(rows, cols, parent) {  
    let table = document.createElement('table');  
    for (let i = 0; i < rows; i++) { 
      let row = table.insertRow(); 
      for (let j = 0; j < cols; j++) { 
        let cell = row.insertCell(); 
        cell.textContent = Row ${i + 1}, Cell ${j + 1}; 
      } 
    } 
    parent.appendChild(table);  
} 
 
//492.1 
function createTable(rows, cols) {  
    let table = document.createElement('table');  
    for (let i = 0; i < rows; i++) { 
      let row = table.insertRow(); 
      for (let j = 0; j < cols; j++) { 
        let cell = row.insertCell(); 
        cell.textContent = Row ${i + 1}, Cell ${j + 1}; 
      } 
    } 
    return table;  
  } 
  let div = document.querySelector('#elem');  
  let table = createTable(3, 4);  
  table.style.color = 'red';  
  div.appendChild(table); 
 
//492.2 
function createTable() { 
    let table = document.createElement('table'); 
    table.style.color = 'red'; 
    let tbody = document.createElement('tbody'); 
    for (let i = 1; i <= 3; i++) { 
      let row = document.createElement('tr'); 
      for (let j = 1; j <= 4; j++) { 
        let cell = document.createElement('td'); 
        cell.textContent = 'Row ' + i + ', Cell ' + j; 
        row.appendChild(cell); 
      } 
      tbody.appendChild(row); 
    } 
    table.appendChild(tbody); 
    return table; 
} 
  let newTable = createTable(); 
  let elem = document.getElementById('elem'); 
  elem.appendChild(newTable);

//497 
function calculateSum() { 
    let num1 = +document.getElementById('num1').value; 
    let num2 = +document.getElementById('num2').value; 
    let num3 = +document.getElementById('num3').value; 
    let sum = num1 + num2 + num3; 
    console.log('sum is: ' + sum); 
} 
  document.getElementById('calculate').addEventListener('click', calculateSum);

//501 
;(function() { 
 let str1 = 'переменная модуля'; 
 let str2 = 'переменная модуля'; 
 let str3 = 'переменная модуля'; 
  
 function func1() { 
  alert('функция модуля'); 
 } 
 function func2() { 
  alert('функция модуля'); 
 } 
 function func3() { 
  alert('функция модуля'); 
 } 
})(); 
let str1 = 'переменная модуля'; 
function func1() { 
  alert('функция модуля'); 
} 
function func2() { 
  alert('функция модуля'); 
} 
export { str1, func1, func2 }; 
 
//502  
;(function() {
	let str1 = 'переменная модуля';
	let str2 = 'переменная модуля';
	let str3 = 'переменная модуля';
	
	function func1() {
		alert('функция модуля');
	}
	function func2() {
		alert('функция модуля');
	}
	function func3() {
		alert('функция модуля');
	}
	function func4() {
		alert('функция модуля');
	}
	function func5() {
		alert('функция модуля');
	}
})();
let str1 = 'переменная модуля'; 
function func1() { 
  alert('функция модуля'); 
} 
function func2() { 
  alert('функция модуля'); 
} 
export { str1, func1, func2 }; 
 
import { str1, func1, func2 } from './module.js'; 
console.log(str1); 
func1(); 
func2(); 
 
//503
function avg1(arr) {  
    return sum(arr, 1) / arr.length;  
}  
   function avg2(arr) {  
    return sum(arr, 2) / arr.length;  
}  
   function avg3(arr) {  
    return sum(arr, 3) / arr.length;  
} 
   export { avg1, avg2, avg3 }; 
   import { avg1, avg2, avg3 } from './module.js'; 
   console.log(avg1([1, 2, 3]));  
   console.log(avg2([1, 2, 3]));  
   console.log(avg3([1, 2, 3]));  
   function sum(arr, pow) { 
    let res = 0; 
    for (let elem of arr) { 
     res += elem ** pow; 
    } 
    return res; 
}