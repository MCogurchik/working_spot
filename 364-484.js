///////////365.1
let elem = document.querySelector('#elem');
let value = elem.getAttribute('value');

console.log(value);

///////////////365.2
let elem = document.querySelector('#elem');
let class = elem.getAttribute('class');

console.log(class);

/////////////////366.1
let elem = document.querySelector('#elem');
elem.setAttribute('class', 'valid');

//////////////367.1
let elem = document.querySelector('#elem');
elem.removeAttribute('value');

////////////////368.1
let elem = document.querySelector('#elem');
console.log(elem.hasAttribute('value'));

///////////////369.1
let elem = document.querySelector('#elem');
elem.addEventListener('click', function(){
	elem.textContent += elem.dataset.text;
	});

////////////369.2
let elem = document.querySelectorAll('div');
for (let elems of elem){
	elems.addEventListener('click', function(){
		elems.textContent += elems.dataset.num;
	});
}

////////////////369.3
let button1 = document.querySelector('#button1');
let button2 = document.querySelector('#button2');
let res = 0;
button1.addEventListener('click', function(){
		res ++;
	});
	button2.addEventListener('click', function(){
		button2.value = res;
	});

//////////369.4
let elem = document.querySelector('#elem');
elem.addEventListener('blur', function() {
	if (elem.value.length != elem.dataset.length) {
        alert ('no');
    }
});

//////////369.5
let elem = document.querySelector('#elem');
elem.addEventListener('blur', function() {
	if (elem.value.length < elem.dataset.min || elem.value.length > elem.dataset.max) {
        alert ('no');
    }
});

///////////////370.1
let elem = document.querySelector('#elem');
elem.addEventListener('click', function() {
    let res = elem.dataset.productPrice * elem.dataset.productAmount;
	elem.textContent += res;
});

//////////////371.1
let elem = document.querySelectorAll('p');
elem.forEach (function(el,ind){
el.setAttribute('data-num', ind + 1);
})

//////////////////372.1
let elem = document.querySelector('#elem');
let length = elem.classList.length;
console.log(length);

////////////////372.2
let elem = document.querySelector('#elem');
let classNames = elem.classList;
for (let className of classNames) {
	console.log(className);
}

//////////////373.1
let elem = document.querySelector('#elem');
elem.classList.add('xxx');

/////////////////374.1
let elem = document.querySelector('#elem');
elem.classList.remove('www');
elem.classList.remove('zzz');

/////////////////375.1
let elem = document.querySelector('#elem');

let contains = elem.classList.contains('ggg');
console.log(contains);

///////////////376.1
let elem = document.querySelector('#elem');
elem.classList.toggle('www');

//////////////////377
let elem = document.querySelector('#elem');
let but = document.querySelector('#button');
but.addEventListener('click', function() {
    elem.style.width = '100px';
    elem.style.hight = '100px';
    elem.style.border = "2px solid black";
});

///////////378
let elem = document.querySelector('#elem');
let but = document.querySelector('#button');
but.addEventListener('click', function() {
    elem.style.fontSize = '20px';
    elem.style.background = 'red';
});

/////////////379
let elem = document.querySelector('ul');
let li = document.querySelectorAll('li');
let button = document.querySelector('#button');
button.addEventListener('click', function(){
li.forEach(function(li){
li.style.float = 'left'
});
});

/////////////380
let elems = document.querySelectorAll('ul');
let but1 = document.querySelector('#button1');
let but2 = document.querySelector('#button2');
let but3 = document.querySelector('#button3');
but1.addEventListener('click', function() {
    elem.classList.add('colored');
});
but2.addEventListener('click', function() {
    elem.classList.add('colored2');
});
but3.addEventListener('click', function() {
    elem.classList.add('colored3');
});

/////////////381
let elems = document.querySelectorAll('ul');
let but1 = document.querySelector('#button1');
let but2 = document.querySelector('#button2');
let but3 = document.querySelector('#button3');
but1.addEventListener('click', function() {
    elem.classList.toggle('colored');
});
but2.addEventListener('click', function() {
    elem.classList.toggle('colored2');
});
but3.addEventListener('click', function() {
    elem.classList.toggle('colored3');
});

//////////////383.1
let elem = document.querySelector('#elem');
let txt = elem.firstElementChild;
txt.style.color = 'red';

////////////383.2
let elem = document.querySelector('#elem');
let txt = elem.lastElementChild;
txt.style.color = 'red';

///////////////383.3
let parent = document.querySelector('#elem');
let elems = parent.children;
for (let elem of elems) {
elems.textContent += '!';
}

///////////384
let elem = document.querySelector('#elem');
let per = elem.parentElement.style.border = 'solid 3px red';

/////////////385.1
let elem = document.querySelector('#elem');
let parent = elem.closest('div');

////////////385.2
let elem = document.querySelector('#elem');
let parent = elem.closest('.www');

////////////386.1
let elem = document.querySelector('#elem');
let sosed = elem.previousElementSibling.textContent;
if (sosed){
    sosed.textContent +='!';
}

//////////////386.2
let elem = document.querySelector('#elem');
let sosed = elem.nextElementSibling.textContent;
if (sosed) {
sosed.textContent += "!";
}

////////////386.3
let elem = document.querySelector('#elem');
let sosed = elem.nextElementSibling;
let sosed1 = sos.nextElementSibling;
if (sosed1) {
sosed1.textContent += "!";
}

///////////386.4
let elem = document.querySelector('#elem');
let prev = elem.previousElementSibling;
let next = elem.nextElementSibling;
if (prev) {
let res = prev.textContent;
prev.textContent = next.textContent;
next.textContent = res;
}

//////////////387
let elem = document.getElementById('elem');
elem.textContent = 'dsfjjedf';

/////////////388
let text = document.getElementsByTagName('li');
for (let elem of text) {
elem.style.color = 'red';
}

/////////////389
let elem = document.getElementsByClassName('www');
for (let el of elem) {
el.style.color = 'red';
}

//////////////390
let parent = document.querySelector('#parent');
let elem1 = parent.querySelectorAll('.www');
let elem2 = parent.querySelectorAll('.ggg');

/////////////////391.1
let elem = document.querySelector('#elem');
console.log(elem.lastChild);
console.log(elem.lastElementChild);

////////////////391.2
let elem = document.querySelector('#elem');
console.log(elem.nextSibling);
console.log(elem.nextElementSibling);

///////////////391.3
let elem = document.querySelector('#elem');
console.log(elem.previousSibling);
console.log(elem.previousElementSibling);

/////////////392
let elem = document.querySelector('#elem');
for (let node of elem.childNodes) {
console.log(node);
}

//////////////////393
let elem = document.querySelector('#elem');
let nodes = elem.childNodes;
for (let node of nodes) {
console.log(node.nodeName);
}

///////////////////394
let elem = document.querySelector('#elem');
for (let node of elem.childNodes) {
if ( node.nodeType == 1 node.nodeType == 3){
console.log(node.nodeName);
}
}

////////////////395.1
let elem = document.querySelector('#elem');
for (let node of elem.childNodes) {
console.log(node.textContent);
}

////////////////395.2
let elem = document.querySelector('#elem');
for (let node of elem.childNodes) {
if ( node.nodeType == 8 node.nodeType == 3){
console.log(node.textContent);
}
}

//////////////395.3
let elem = document.querySelector('#elem');
for (let node of elem.childNodes) {
    if ( node.nodeType == 1 node.nodeType == 3){
    console.log(node.textContent);
    }
}

///////////////395.4
let elem = document.querySelector('#elem');
for (let node of elem.childNodes) {
    node.textContent += node.nodeType;
}

////////////////396.1
let elem = document.querySelector('#elem');
let par = document.querySelector('#par');
elem.addEventListener('blur', function() {
    par.textContent = elem.value;
});

////////////////397.1
let elem = document.querySelector('#elem');
let button = document.querySelector('#button');
button.addEventListener('click', function() {
    elem.disabled = true;
});

////////////////397.2
let elem = document.querySelector('#elem');
let button1 = document.querySelector('#button1');
let button2 = document.querySelector('#button2');
button1.addEventListener('click', function() {
    elem.disabled = true;
});
button2.addEventListener('click', function() {
    elem.disabled = false;
});

////////////////397.3
let elem = document.querySelector('#elem');
let button = document.querySelector('#button');
button.addEventListener('click', function() {
    console.log(elem.disabled);
});

//////////////398.1
let elem = document.querySelector('#elem');
let button1 = document.querySelector('#button1');
let button2 = document.querySelector('#button2');
button1.addEventListener('click', function() {
    elem.checked = true;
});
button2.addEventListener('click', function() {
    elem.checked = false;
});

//////////////398.2
let elem = document.querySelector('#elem');
let button = document.querySelector('#button');
let par = document.querySelector('#par');
button.addEventListener('click', function() {
    if (elem.checked){
        par.textContent = 'привет';
    } else {
        par.textContent = 'пока';
    }
});

/////////////////399.2
let elem = document.querySelector('#elem');
let button = document.querySelector('#button');
button.addEventListener('click', function() {
	if (elem.checked) {
		elem.checked = false;
	} else {
		elem.checked = true;
	}
});

///////////////400.1
let radios = document.querySelectorAll('input[type="radio"]');
let button = document.querySelector('#button');
let par = document.querySelector('#par');
button.addEventListener('click', function() {
	for (let radio of radios) {
		if (radio.checked) {
			par.textContent = radio.value;
		}
	}
});

//////////////401.1
let elem = document.querySelector('#elem');
let par = document.querySelector('#par');
elem.addEventListener('change', function() {
	par.textContent = elem.value;
});

///////////////401.2
let elem = document.querySelector('#elem');
let par = document.querySelector('#par');
elem.addEventListener('change', function() {
	par.textContent = elem.checked;
});

////////////401.4
let elem = document.querySelector('#elem');
elem.addEventListener('change', function() {
	if (elem.value.length < 5){
        elem.style.border = "solid 2px red";
    } else {
        elem.style.border = "solid 2px green";
    }
});

///////////402.1
let elem = document.querySelector('#elem');
let p =document.querySelector('p');
elem.addEventListener('input', function(){
let length = elem.value.length;
if (length>5){
p.textContent = 'input > 5';
}
})

//////////////402.2
let elem = document.querySelector('#elem');
let p = document.querySelector('p');
elem.addEventListener('input', function(){
let length = 5 - elem.value.length;
p.textContent = 'осталось ' + length + ' символа';
if (length<0){
let sum = elem.value.length - 5;
p.textContent = 'привышение допустимых символов на ' + sum;
}
})

/////////////403.1
let elem = document.querySelector('#elem');
let elem2 = document.querySelector('#elem2');
elem.addEventListener('input', function(){
    if (elem.value.length == 2) {
    elem2.focus();
}
})
elem2.addEventListener('input', function(){
    if (elem2.value.length == 2) {
    elem2.blur();
    }
})

////////////////404.1
let textarea = document.querySelector('textarea');
let div = document.querySelector('div');

textarea.addEventListener('blur', function() {
div.textContent = textarea.value;
});

///////////////404.2
let checkbox = document.querySelector('input');
let button = document.querySelector('button');
let div = document.querySelector('div');

button.addEventListener('click', function() {
if (checkbox.checked) {
div.textContent = '111';
} else {
div.textContent = '222';
}
});

////////////////404.3
let checkbox = document.querySelector('input[type="checkbox"]');
let button = document.querySelector('button');

button.addEventListener('click', function() {
if (checkbox.checked) {
console.log('+++');
} else {
console.log('---');
}
});

///////////////////405.1
let select = document.querySelector('select');
let btn = document.querySelector('input');
let p = document.querySelector('p');
btn.addEventListener('click', function(){
p.textContent = select.value;
});

///////////////405.2
let select = document.querySelector('select');
let p = document.querySelector('p');
select.addEventListener('change', function(){
let op = +select.value;
if (op % 4 == 0 op % 400 == 0){
p.textContent = 'високосный';
} else {
p.textContent = 'не високосный';
}
});

////////////////406.1
let select = document.querySelector('select');
let p = document.querySelector('p');
select.addEventListener('change', function(){
    if (this.value <= 5){
        p.textContent = 'будни';
    } else {
        p.textContent = 'выходной';
    }
});

////////////////407.1
let select = document.querySelector('select');
let button = document.querySelector('#button');
let month = new Date().getMonth();
button.addEventListener('click', function(){
    select.value = month;
});

/////////////////408.1
let elem = document.querySelector('#select');
let inp = document.querySelector('#btn');
inp.addEventListener('blur', function(){
elem.selectedIndex = inp.value - 1;
})

//////////////////////408.2
let m = new Date().getDay();
let elem = document.querySelector('#select');
let btn = document.querySelector('#btn');
select.value = m;

////////////410
let select = document.querySelector('#select');
for (let option of select) {
option.textContent = option.textContent + ' ' + option.value;
}

////////////////411
let select = document.querySelector('#select');
select.addEventListener('change', function(){
for (let option of select) {
if (option.selected) {
option.textContent += '!';
} else {
option.textContent += '?';
}
}
})

/////////////412.1
let select = document.querySelector('#select');
let btn = document.querySelector('#btn');
btn.addEventListener('click', function(){
let options = select.options;
options[options.length - 1].selected = true;
})

////////////////413.1
let select = document.querySelector('#select');
let btn = document.querySelector('#btn');
btn.addEventListener('click', function(){
console.log(select[select.selectedIndex].innerHTML);
})

///////////413.2
let select = document.querySelector('#select');
let btn = document.querySelector('#btn');
btn.addEventListener('click', function(){
select[select.selectedIndex].innerHTML += '!';
})

///////////////414.1
let elem = document.querySelector('#elem');
elem.addEventListener('click', function(event) {
console.log(event);
});

///////////////////415.1
let elem = document.getElementById('elem');
document.addEventListener('mousemove', function(event) {
	elem.innerHTML = event.clientX + ' : ' + event.clientY;
});

/////////////416.1
let elem = document.querySelector('#elem');
elem.addEventListener('click', func);
elem.addEventListener('dblclick', func);
function func(event) {
if (event.type == 'click'){
elem.style.color = 'green';
}
else {
elem.style.color = 'red';
}
}

//////////////////////////417
let elem = document.querySelector('#elem');
elem.addEventListener('click', function(event){
if (event.target.tagName == 'LI') {
event.target.textContent += '!';
} else {
console.log('tfrsy');
}
})

/////////////418.1
let elem = document.querySelector('input');
elem.addEventListener('keypress', function(event) {
console.log(event.key);
console.log(event.code);
});

/////////////418.5
let elem = document.querySelector('input');
let p = document.querySelector('p');
elem.addEventListener('keypress', function(event) {
if (event.code == 'Enter'){
p.textContent = this.value;
this.value = '';
}
});

/////////419.1
let elem = document.querySelector('#elem');
elem.addEventListener('click', function(event){
if (event.altKey){
this.style.color = 'red';
}
})

//////////////419.2
let elem = document.querySelector('#elem');
elem.addEventListener('click', function(event){
if(event.ctrlKey){
event.target.textContent += '1';
}
if(event.shiftKey){
event.target.textContent += '2';
}
})

//////////////420.1
let elem = document.querySelector('#elem');
elem.addEventListener('click', function(event) {
event.preventDefault();
event.target.textContent += elem.href;
});

////////////420.2
let elem = document.querySelector('#elem');
let a = document.querySelector('#a');
let b = document.querySelector('#b');
let p = document.querySelector('p')
elem.addEventListener('click', function(event) {
event.preventDefault();
p.textContent = +a.value + +b.value;
});

///////////////421
let elem1 = document.querySelector('#elem1');
let elem2 = document.querySelector('#elem2');
let elem3 = document.querySelector('#elem3');
elem1.addEventListener('click', function() {
alert('1');
});
elem2.addEventListener('click', function() {
alert('2');
});
elem3.addEventListener('click', function() {
alert('3');
});

////////////422
let div = document.querySelector('div');
div.addEventListener('click', function(event){
console.log(event.target);
})

/////////////////////422.2
let div = document.querySelector('div');
div.addEventListener('click', function(event){
if (event.target.tagName == 'LI'){
event.target.textContent += '!';
}
if (event.target.tagName == 'UL'){
console.log('клик по ul');
}
})

//////////////426
let parent = document.querySelector('#parent');
let button = document.querySelector('button');
let block = document.querySelector('#block');
button.addEventListener('click', function(event) {
block.classList.add('active');
event.stopPropagation();
});
parent.addEventListener('click', function(event) {
block.classList.remove('active');
event.stopPropagation();
});

////////////430.1
list.addEventListener('click', function(event) {
	let li = event.target.closest('li');
	
	if (li) {
		li.textContent = li.textContent + '!';
	}
});

////////////435.1
"use strict";
let elem = document.querySelector('#elem');
elem.addEventListener('blur', func);
function func() {
    let self = this;
	function square() {
		return self.value * self.value;
	}
    alert( square() );
}

////////////////436.1
"use strict";
let elem = document.querySelector('#elem');
elem.addEventListener('blur', func);
function func() {
	alert( square(this) );
	function square(param) {
		return param.value * param.value;
	} 
}

/////////////437.1
"use strict";
let elem = document.querySelector('#elem');
elem.addEventListener('blur', func);
function func() {
		let square = () => {
		return this.value * this.value;
	}
    alert( square() );
}

////////////438.1
let elem1 = document.querySelector('#elem1');
let elem2 = document.querySelector('#elem2');
let elem3 = document.querySelector('#elem3');
function func() {
	console.log(this.value);
}
func.call(elem1);
func.call(elem2);
func.call(elem3);

////////////439.1
let elem = document.querySelector('#elem');
function func(name, surname) {
	console.log(this.value + ', ' + name + ' ' + surname);
}
func.call(elem, 'John', 'Smit');

////////////440
let elem = document.querySelector('#elem');
function func(surname, name) {
	console.log(this.value + ', ' + name + ' ' + surname);
}
func.apply(elem40, ['Smit', 'John']); 

/////////////442
setInterval(()=> {
	console.log('!');
}, 3000);

///////////443
let i = 100;
setInterval(()=> {
	console.log(--i);
}, 1000);

////////////444
let i = 10;
let timer = setInterval(function() {
	console.log(--i);
	if (i == 0) {
		clearInterval(timer);
	}
}, 1000);

////////////445
let i = 100;
let button = document.querySelector('#button');
button.addEventListener('click', ()=>{
    setInterval(()=> {
	console.log(--i);
}, 1000);
});

///////////447
let i = 100;
let timer;
let button1 = document.querySelector('#button1');
let button2 = document.querySelector('#button2');
button1.addEventListener('click', ()=>{
    timer = setInterval(function() {
        console.log(--i);
        if (i == 0) {
            clearInterval(timer);
        }
    }, 1000);
});
button2.addEventListener('click', ()=>{
    clearInterval(timer);
});

///////////////448
let elem = document.querySelector('#elem');
let i = elem.value;
let timer = setInterval(function() {
	elem.value = --i;
	if (i == 0) {
		clearInterval(timer);
	}
}, 1000);

////////////450.1
let number = document.getElementById('number');
let button = document.getElementById('button');
let timer;
button.addEventListener('click', () => {
    timer = setInterval(() => {
        number.textContent = parseInt(number.textContent) + 1;
    }, 1000);
});

////////////450.2
let number = document.getElementById('number');
let button = document.getElementById('button');
let timer;
button.addEventListener('click', () => {
    timer = setInterval(() => {
        let currentNumber = parseInt(number.textContent);
        if (currentNumber > 0) {
            number.textContent = currentNumber - 1;
        } else {
            clearInterval(timer);
        }
    }, 1000);
});

//////////////450.3
let input = document.getElementById('input');
let square = document.getElementById('square');
setInterval(() => {
    square.textContent = Math.pow(parseInt(input.value), 2);
}, 1000);

//////////////450.4
let input= document.getElementById('input');
let count = document.getElementById('count');
input.addEventListener('blur', () => {
    let count2 = parseInt(input.value);
    let timer = setInterval(() => {
        count.textContent = count2;
        count2--;
        if (count2 < 0) {
            clearInterval(timer);
        }
    }, 1000);
});

///////////////450.5
let input = document.getElementById('input');
let start = document.getElementById('start');
let count = document.getElementById('count');
startCount.addEventListener('click', () => {
    count.textContent = input.value;
    let count2 = parseInt(input.value);
    let timer = setInterval(() => {
        count.textContent = count2;
        count2--;
        if (count2 < 0) {
            clearInterval(timer);
        }
    }, 1000);
});

/////////////450.6
let timer = document.getElementById('timer');
let start = document.getElementById('start');
let stop = document.getElementById('stop');
let timer;
startBtn.addEventListener('click', () => {
    let count = 1;
    timer = setInterval(() => {
        timerText.textContent = count;
        count++;
    }, 1000);
});
stopBtn.addEventListener('click', () => {
    clearInterval(timer);
});

//////////////450.7
let color = document.getElementById('color');
setInterval(() => {
    if (color.style.color === 'red') {
        color.style.color = 'green';
    } else {
        color.style.color = 'red';
    }
}, 1000);

//////////////451
let p = document.querySelector('#p');
setTimeout(function() {
    p51.textContent = 'hello';
}, 10000);

///////////////452
let i = 0;
function timer() {
	setTimeout(function() {
		console.log(++i);
		timer(); 
	}, 1000);
}
timer();

////////////////453
let elem = document.querySelector('#elem');
let li = document.createElement('li');
li.textContent = 'первый пункт';
elem53.appendChild(li);

//////////////453.2
let elem = document.querySelector('#elem');
let but = document.querySelector('#button');
let li = document.createElement('li');
li.textContent = 'item';
but.addEventListener('click', ()=>{
    elem.appendChild(li);
});

//////////////454
let elem = document.querySelector('#elem');
let but = document.querySelector('#button');
let li = document.createElement('');
li.textContent = 'text';
but.addEventListener('click', ()=>{
    elem54.appendChild(li);
});
elem.addEventListener('click', ()=>{
    elem.textContent += '!';
});

/////////////455
let ul = document.querySelector('#ul');
for (let i = 1; i <= 9; i++) {
	let li = document.createElement('li');
	li.textContent += i;
	ul.appendChild(li);
}

////////////////456
let div = document.querySelector('#elem');
let p = document.querySelector('#p');
for (let i = 1; i <= 5; i++) {
	let input = document.createElement('input');
	div.appendChild(input);
    input.addEventListener('blur',()=>{
        p.textContent += input.value;
    });
}

//////////////457
let elems = document.querySelectorAll('#li');
for (let elem of elems) {
	elem.addEventListener('click', function() {
		elem.remove();
	});
}

///////////////458
let elem = document.querySelector('#elem');
let li = document.createElement('li');
li.textContent = 'start';
let li = document.createElement('li');
li.textContent = 'finish';
elem.prepend(li);
elem.append(li);

////////////////459
let elem = document.querySelector('#elem');
let li = document.querySelector('#li');
let new = document.createElement('li');
new.textContent = 'new';
elem.insertBefore(new, li);

//////////////460.1
let p = document.createElement('p');
p.textContent = '!!!';
let elem = document.querySelector('#elem');
elem.insertAdjacentElement('beforeBegin', p);

//////////////460.2
let p = document.createElement('p');
p.textContent = '!!!';
elem.insertAdjacentElement('afterEnd', p);

///////////////460.3
let p = document.createElement('p');
p.textContent = '!!!';
elem.insertAdjacentElement('afterBegin', p);

/////////////460.4
let p = document.createElement('p');
p.textContent = '!!!';
elem.insertAdjacentElement('beforeEnd', p);

/////////////461
let elem = document.querySelector('#elem');
elem.insertAdjacentHTML('beforeBegin', '<div class="www"><p>text</p><p>text</p><input></div>');

//////////////462
let input = document.getElementById('input');
let but = document.getElementById('but');
let div = document.getElementById('div');
but.addEventListener('click', () => {
    let clone = input.cloneNode(true);
    div.appendChild(clone);
});

///////////463.1
let elem = document.querySelector('#elem');
console.log(elem.matches('.www'));

/////////////463.2
console.log(elem.matches('p'));

/////////////465.1
let elem = document.querySelector('#elem');
let arr = [1, 2, 3, 4, 5];
for (let elems of arr) {
	let li = document.createElement('li');
	li.textContent = elems;
	elem.appendChild(li);
    //465.2
    li.addEventListener('click',()=>{
        let p = document.createElement('p');
        p.textContent = li.textContent;
    })
}

/////////////466.1
let table = document.querySelector('#table');
for (let i = 0; i < 5; i++) {
  let tr = document.createElement('tr');
  for (let i = 0; i < 5; i++) {
    let td = document.createElement('td');
    tr.appendChild(td);
  }
  table.appendChild(tr);
}

/////////////466.2 - 3
let table = document.querySelector('#table');
for (let i = 0; i < 10; i++) {
  let tr = document.createElement('tr');
  for (let i = 0; i < 5; i++) {
    let td = document.createElement('td');
        td.textContent = 'x';
    tr.appendChild(td);
  }
  table.appendChild(tr);
}

////////////466.4
let table = document.querySelector('#table');
let width = document.querySelector('#width')
let height = document.querySelector('#height');
let btn = document.querySelector('#btn');
btn.addEventListener('click', function(){
    let w = width.value;
    let h = height.value;
    for (let i = 0; i < h; i++) {
        let tr = document.createElement('tr');
        for (let i = 0; i < w; i++) {
            let td = document.createElement('td');
            td.textContent = 'x';
            tr.appendChild(td);
        }
        table.appendChild(tr);
    }
})


///////////////467
let table = document.querySelector('#table');
let k = 1; 
for (let i = 0; i < 5; i++) {
  let tr = document.createElement('tr');
  for (let i = 0; i < 5; i++) {
    let td = document.createElement('td');
    td.textContent = k; 
    k++;  
    tr.appendChild(td);
  }
  table.appendChild(tr);
}

//////////////467.2
let table = document.querySelector('#table');
let k = 2; 
for (let i = 0; i < 5; i++) {
  let tr = document.createElement('tr');  
  for (let i = 0; i < 5; i++) {
    let td = document.createElement('td');
    td.textContent = k; 
    k += 2;
    tr.appendChild(td);
  }
  table.appendChild(tr);
}


//////////468
let arr = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12]];
let table = document.querySelector('#table');

for (let subArr of arr) {
  let tr = document.createElement('tr');
  for (let elem of subArr) {
    let td = document.createElement('td');
    td.textContent = elem;
    tr.appendChild(td);
  }
  table.appendChild(tr);
}

////////////468.2
let arr = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12]];
let table = document.querySelector('#table');
for (let subArr of arr) {
  let tr = document.createElement('tr');
  
  for (let elem of subArr) {
    let td = document.createElement('td');
    td.textContent = elem ** 2;
    tr.appendChild(td);
  }
  table.appendChild(tr);
}

/////////////469
let employees = [
  {name: 'employee1', age: 30, salary: 400},
  {name: 'employee2', age: 31, salary: 500},
  {name: 'employee3', age: 32, salary: 600},
];
let table = document.getElementById('table');
for (let elem of elems) {
  elem.addEventListener('click', function() {
    elem.remove();
  });
}

////////////////470.1
let table = document.querySelector('#table');
let btn = document.querySelector('#btn');
let tr = document.createElement('tr');

btn.addEventListener('click', function(){
    for (let i = 1; i <= 3; i++) {
        let td = document.createElement('td');
        tr.appendChild(td);
    }   
})
table.appendChild(tr);

/////////////470.2
let table = document.querySelector('#table');
let btn = document.querySelector('#btn');
let tr = document.createElement('tr');
let trs = document.querySelectorAll('#table tr');

btn.addEventListener('click', function(){
    for (let i = 1; i <= 3; i++) {
        let td = document.createElement('td');
        tr.appendChild(td);
    }
    for (let tr of trs) {
        let td = document.createElement('td');
        tr.appendChild(td);
    }   
})
table.appendChild(tr);

/////////////471
let table = document.querySelector('#table');
let tds = document.querySelectorAll('#table td');
let btn = document.querySelector('#btn');
btn.addEventListener('click', function(){
    for (let td of tds) {
        td.textContent = +td.textContent * 2 ;
    }
})

/////////////472
let parent = document.querySelector('#parent');
let btn = document.querySelector('#button');
btn.addEventListener('click', function(){
    let li = document.createElement('li');
    li.textContent = 'bghjb';
    parent.appendChild(li);    
})
parent.addEventListener('click', function(event){
    if(event.target.tagName == 'LI'){
        event.target.remove();
    }
})

////////////////473
let elem   = document.querySelector('#elem');
let remove = document.querySelector('#remove');
remove.addEventListener('click', function(event) {
  elem.remove();
  event.preventDefault(); 
});

/////////////474.1
let elems = document.querySelectorAll('#parent li');
for (let elem of elems) {
  let remove = document.createElement('a');
  remove.href = '';
  remove.textContent = 'remove';
  elem.appendChild(remove); 
  remove.addEventListener('click', function(event) {
    elem.remove();
    event.preventDefault();
  });
}

//////////////474.2
let tr = document.createElement('tr');
let elems = document.querySelectorAll('#table tr');
for (let elem of elems) {
  let remove = document.createElement('a');
  remove.href = '';
  remove.textContent = 'remove';
  elem.appendChild(remove);
  remove.addEventListener('click', function(event) {
    elem.remove();
    event.preventDefault();
  });
}

////////////475
let elem = document.querySelector('#elem');
let input = document.querySelector('#input');
input.value = elem.textContent; 
input.addEventListener('input', function() {
  elem.textContent = this.value;
});

/////////////////475.2
let elem = document.querySelector('#elem');
elem.addEventListener('click', function() {
  let input = document.createElement('input');
  input.value = elem.textContent;
  input.addEventListener('blur', function() {
    elem.textContent = this.value;
    this.remove(); 
  });
  elem.parentElement.appendChild(input);
});

///////////476
let elem = document.querySelector('#elem');
elem.addEventListener('click', function func() {
  let input = document.createElement('input');
  input.value = elem.textContent; 
  elem.textContent = '';
  elem.appendChild(input); 
  input.addEventListener('blur', function() {
    elem.textContent = this.value;
    elem.addEventListener('click', func); 
  });
  elem.removeEventListener('click', func);
});

/////////////477
let elems = document.querySelectorAll('#parent li');
for (let elem of elems) {
  elem.addEventListener('click', function func() {
    let input = document.createElement('input');
    input.value = elem.textContent;  
    elem.textContent = '';
    elem.appendChild(input);  
    input.addEventListener('blur', function() {
      elem.textContent = this.value;
      elem.addEventListener('click', func);
    });   
    elem.removeEventListener('click', func);
  });
}

//////////////477.2
let elems = document.querySelectorAll('#table tr td');
for (let elem of elems) {
  elem.addEventListener('click', function func() {
    let input = document.createElement('input');
    input.value = elem.textContent; 
    elem.textContent = '';
    elem.appendChild(input);
    input.addEventListener('blur', function() {
      elem.textContent = this.value;
      elem.addEventListener('click', func);
    });
    elem.removeEventListener('click', func);
  });
}

//////////478
let elems = document.querySelectorAll('#parent span');
for (let elem of elems) {
  elem.addEventListener('click', function func() {
    let input = document.createElement('input');
    input.value = elem.textContent;
    elem.textContent = '';
    elem.appendChild(input);
    input.addEventListener('blur', function() {
      elem.textContent = this.value;
      elem.addEventListener('click', func);
    });
    elem.removeEventListener('click', func);
  });
  let remove = document.createElement('a');
  remove.href = '';
  remove.textContent = 'удалить';
  elem.appendChild(remove);
    remove.addEventListener('click', function(event) {
    elem.remove();
    event.preventDefault();
  });
}

//////////////478.2
let elems = document.querySelectorAll('#parent p');
for (let elem of elems) {
  elem.addEventListener('click', function func() {
        let span = document.createElement('span');
        span.textContent = elem.textContent;
        elem.textContent = '';
        elem.appendChild(span);
    let input = document.createElement('input');
    input.value = elem.textContent;
    elem.textContent = '';
    elem.appendChild(input);
    input.addEventListener('blur', function() {
      elem.textContent = this.value;
      elem.addEventListener('click', func);
    });
    elem.removeEventListener('click', func);
  });
  let remove = document.createElement('a');
  remove.href = '';
  remove.textContent = 'удалить';
  elem.appendChild(remove);
    remove.addEventListener('click', function(event) {
    elem.remove();
    event.preventDefault();
  });

}

///////////////////479.1 - 2
let elems = document.querySelectorAll('p');
for (let elem of elems) {
    let span = document.createElement('span');
    elem.appendChild(span);
    let remove = document.createElement('a');
    remove.href = '';
    remove.textContent = 'зачеркнуть';
    remove.addEventListener('click', function(event) {
        elem.classList.toggle('an');
        remove.remove();
        event.preventDefault();
    });
    elem.appendChild(remove);
}

///////////////479.3 - 4
let tr = document.createElement('tr');
let elems = document.querySelectorAll('#table tr');
for (let elem of elems) {
  let remove = document.createElement('a');
  remove.href = '';
  remove.textContent = 'remove';
  elem.appendChild(remove);
  remove.addEventListener('click', function(event) {
    elem.classList.toggle('r');
    event.preventDefault();
  });
}

////////////480
let elem = document.querySelector('#elem');
let btn = document.querySelector('#btn');
btn.addEventListener('click', function() {
  elem.classList.toggle('hidden');
});

////////481
let buttons = document.querySelectorAll('button');
for (let button of buttons) {
  button.addEventListener('click', function() {
    let elem = document.querySelector('#' + this.dataset.elem);
    elem.classList.toggle('hidden');
  });
}

///////////481.2
let buttons = document.querySelectorAll('button');
let elems   = document.querySelectorAll('p');
for (let i = 0; i < buttons.length; i++) {
  buttons[i].addEventListener('click', function() {
    elems[i].classList.toggle('hidden');
  });
}

//////////481.3
let buttons = document.querySelectorAll('button');
for (let button of buttons) {
  button.addEventListener('click', function() {
    this.previousElementSibling.classList.toggle('hidden');
  });
}

/////////////482
let li = document.querySelectorAll('#parent li');
for (let l of li) {
  l.addEventListener('click', function() {
    this.classList.toggle('active');
  });
}

////////////483
let tds = document.querySelectorAll('#table td');
let color = 'color1';
for (let td of tds) {
  td.addEventListener('click', function() {
    if (color == 'color1') {
      color = 'color2'
    } else {
      color = 'color1'
    }
    this.classList.toggle(color);
  });
}

////////////484
let arr = [1, 2, 'rdd'];
let parent = document.querySelector('#parent');
for (let elem of arr){
    let li = document.createElement('li');
    li.textContent = elem;
    parent.appendChild(li);
    li.addEventListener('click', function func(){
        let input = document.createElement('input');
        input.value = elem;
        li.textContent = '';
        li.appendChild(input);
        input.addEventListener('blur', function() {
            li.textContent = this.value;
            li.addEventListener('click', func);
        });
        li.removeEventListener('click', func);   
    })

    let remove = document.createElement('a');
    remove.textContent = 'удалить';
    remove.href = '';
    remove.addEventListener('click', function(event){
        event.preventDefault();
        parent.removeChild(li);
    })
    li.appendChild(remove);
    let re = document.createElement('a');
    re.href = '';
    re.textContent = 'зачеркнуть';
    re.addEventListener('click', function(event) {
        li.classList.toggle('an');
        event.preventDefault();
    });
    li.appendChild(re);   
}

///////////484.6 - 9
let employees = [
  {name: 'employee1', age: 30, salary: 400},
  {name: 'employee2', age: 31, salary: 500},
  {name: 'employee3', age: 32, salary: 600},
];

let table = document.getElementById('table');

for (let em of employees) {
  let tr = document.createElement('tr');
  

  let td1 = document.createElement('td');
  td1.textContent = em.name;
  tr.appendChild(td1);
    td1.addEventListener('click', func);

  
  let td2 = document.createElement('td');
  td2.textContent = em.age;
  tr.appendChild(td2);
    td2.addEventListener('click', func);
  
  let td3 = document.createElement('td');
  td3.textContent = em.salary;
  tr.appendChild(td3);
    td3.addEventListener('click', func)
  table.appendChild(tr);

    function func(){
        let input = document.createElement('input');
        input.value = this;
        this.textContent = '';
        this.appendChild(input);
        let self = this;
        input.addEventListener('blur', function() {
            this.textContent = self.value;
            this.addEventListener('click', func);
        });
            this.removeEventListener('click', func);   
    }
     let remove = document.createElement('a');
          remove.href = '';
          remove.textContent = 'удалить';
          table.appendChild(remove);
            remove.addEventListener('click', function(event) {
            tr.remove();
                this.remove();
            event.preventDefault();
          });
        
    }
    
    let name = document.getElementById('name');
    let age = document.getElementById('age');
    let salary = document.getElementById('salary');
    let add = document.getElementById('add');
    
    add.addEventListener('click', function() {
        let obj = {
            name: name.value,
            age: age.value,
            salary: salary.value
        };
    
        employees.push(obj);
        let tr = document.createElement('tr');
        for (let key in obj) {
            let td = document.createElement('td');
            td.textContent = obj[key];
            tr.appendChild(td);
        }
        table.appendChild(tr);
    
        name.value = '';
        age.value = '';
        salary.value = '';
    
        let remove = document.createElement('a');
          remove.href = '';
          remove.textContent = 'удалить';
          table.appendChild(remove);
            remove.addEventListener('click', function(event) {
            tr.remove();
                this.remove();
            event.preventDefault();
          });
    });
    
//////////484.10 - 13
    let employees = [
      {name: 'employee1', age: 30, salary: 400},
      {name: 'employee2', age: 31, salary: 500},
      {name: 'employee3', age: 32, salary: 600},
    ];
    let parent = document.querySelector('#parent');
    employees.forEach(function(employee) {
        let li = document.createElement('li');
        li.textContent = employee.name + ' ' + employee.age + ' ' + employee.salary;
        parent.appendChild(li);
        li.addEventListener('click', function func() {
            let input = document.createElement('input');
            input.value = li.textContent; 
            li.textContent = '';
            li.appendChild(input);           
            input.addEventListener('blur', function() {
                li.textContent = this.value;
                li.addEventListener('click', func); 
            });           
            li.removeEventListener('click', func);
        });
    
        let remove = document.createElement('a');
              remove.href = '';
              remove.textContent = 'удалить';
              li.appendChild(remove);
                remove.addEventListener('click', function(event) {
                li.remove();
                event.preventDefault();
              });
        
    })
    
    let name = document.getElementById('name');
    let age = document.getElementById('age');
    let salary = document.getElementById('salary');
    let add = document.getElementById('add');
    add.addEventListener('click', function() {
        let obj = {
            name: name.value,
            age: age.value,
            salary: salary.value
        };
        employees.push(obj);
        let li = document.createElement('li');
        li.textContent = name.value + ' ' + age.value + ' ' + salary.value;
        parent.appendChild(li); 
        name.value = '';
        age.value = '';
        salary.value = '';
    })