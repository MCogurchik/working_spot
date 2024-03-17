///////311.1

let date = new Date();
console.log(date.getDate);

////////311.2

let date = new Date();
console.log(date.getMonth);

///////311.3

let date = new Date();
console.log(date.getCurrentYear);

//////////312.1

function addZero(num) {
	if (num >= 0 && num <= 9) {
		return '0' + num;
	} else {
		return num;
	}
}
let date = new Date();
console.log(
    (date.getHours()) + ':' + (date.getMinutes()) + ':' + (date.getSeconds()) + ' ' +
    addZero(date.getDate()) + '-' +
	addZero(date.getMonth() + 1) + '-' +
	addZero(date.getFullYear()) 
);


/////////313.1

let str = '2025-12-31';
let res = str.split('-').reverse().join('.');

console.log(res);

///////314.1

let date = new Date();
console.log(date.getDay());

//////////314.2

let date = new Date();
today = date.getDay();
if (today == 0 || today == 6) {
    console.log('Выходной')
} else {
    console.log('Будний')
};

////////314.3

let date = new Date();
let today = date.getDay();
console.log(6 - today);

///////////315.1

let months = [
	'янв', 'фев', 'мар', 'апр', 'май', 'июн',
	'июл', 'авг', 'сен', 'окт', 'ноя', 'дек'
];
let date = new Date();
let mon  = date.getMonth();
console.log(months[mon]);

///////////316.1

let date = new Date(2024, 5, 19);
let day  = date.getDay();
let days = ['вс', 'пн', 'вт', 'ср', 
	'чт', 'пт', 'сб']; 
    console.log(days[day]);

///////////317.1

let date = new Date(2025, 1, 1, 00, 00, 01);
console.log(date.getTime());

///////318.1

let date1  = new Date(1988, 3, 1, 23, 59, 59);
let date2 = new Date(2000, 1, 10, 23, 59, 59);
let diff = date2.getTime() - date1.getTime();
console.log(diff);

/////////////318.2

let now  = new Date();
let date2 = new Date(2005, 5, 19, 23, 59, 59);
let diff = now.getTime() - date2.getTime();
console.log(diff / (1000 * 60 * 60 * 24 * 30));

/////////319.1


////////////321.1

function getLastDayOfMonth(year, month) {
	let date = new Date(year, month + 1, 0);
	return date.getDate();
  }
  console.log( getLastDayOfMonth(2012, 0) );

/////////////321.2

let date = new Date(2025, 5, 0);
let day  = date.getDay();
let days = ['вс', 'пн', 'вт', 'ср', 'чт', 'пт', 'сб'];
console.log(days[day]);

/////////////////322.1

function isLeap(year) {
    let date = new Date(year, 2, 0);

    if (date.getDate() == 29) {
 	    console.log( ) true;
    } else {
 	    console.log( ) false;
    }
 }
console.log(isLeap(2024));

////////////323.1

function checkDate(year, month, day) {
   let date = new Date(year, month, day);
        if (date.getFullYear() == year && date.getMonth() == month && date.getDate() == day) {
             console.log( ) true;
         } else {
             console.log( ) false;
         }
     }
 console.log(checkDate(2025, 0, 31));

 ///////////////324.1

 let now  = new Date(); 
 let date = new Date(now.getFullYear(), 11, 31); 
 console.log(date.getDay());
 
//325
let now = new Date();
let date = new Date(now.getFullYear(), now.getMonth() - 1, 24);
console.log(date.getDay());

//////////326.1

let now = new Date();
let date = new Date(now.getFullYear(), now.getMonth() - 1, 24);
console.log(date.getDay());

////////////326.2

let now = new Date();
let date = new Date(now.getFullYear() + 1, now.getMonth(), now.getDate());
console.log(date.getDay());

////////////326.3

let now = new Date();
let date = new Date(now.getFullYear() - 1, now.getMonth(), now.getDate());
console.log(date.getDay());

////////////327.1

let now = new Date();
let date1 = new Date(now.getFullYear(), 0, 1, 12, 59, 59);
let date2 = new Date(now.getFullYear(), 8, 10, 12, 59, 59);
console.log((date2 - date1) * 1.1574 * 10**(-8)); 

////////////327.2

let now = new Date();
let date1 = new Date(now.getFullYear(), now.getMonth(), 20, 12, 59, 59);
let date2 = new Date(now.getFullYear(), now.getMonth() + 1, 10, 12, 59, 59);
console.log((date2 - date1) * 1.1574 * 10**(-8)); 

/////////328

let now  = new Date();
let date = new Date(now.getFullYear(), now.getMonth(), now.getDate() - 1, 12);
console.log((now - date) * 2.778 * 10**(-7));

/////////329

let now  = new Date();
let date1 = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 0, 0, 0);
console.log((now - date1) / (1000 * 60 * 60));

//////////330

let now  = new Date();
let date = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 24);
console.log((date - now) / (1000 * 60 * 60));

////////////331

let res = 0;
for (let year = 2000; year <= new Date().getFullYear(); year++) {
 	let date = new Date(year, 0, 1);
	
 	if (date.getDay() == 0 || date.getDay() == 6) {
 		res++;
 	}
 }

 console.log(res);

/////////332.1

let now  = new Date();
let date = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 0, 0, 1);
console.log((now - date) / 1000);

////////////332.2

let now  = new Date();
let date = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 24);
console.log((date - now) / 1000);

///////////332.3

let now  = new Date();
let date1 = new Date(now.getFullYear() + 1, 1, 1);
console.log((date1 - now) *  1.1574 * 10**(-8) );

////////////332.4

let res = 0;
let now = new Date().getFullYear();
for (let month = 0; month < 12; month++) {
    let date = new Date(now, month, 13);
     if (date.getDay() === 5) { 
         res++;
     }
 }
 console.log(res);

////////////332.5

let now = new Date();
let lastYear = now.getFullYear();
let month3 = now.getMonth() - 3;
 if (month3 < 0) {
     lastYear--;
    month3 = 12 + month3;
}
console.log(lastYear);

///////////332.6

let now = new Date();
let lastDaym= new Date(now.getFullYear(), now.getMonth() + 1, 0);
let lastDay = lastDaym.getDay();
console.log(lastDay); 

////////////332.7

let now = new Date();
let year = now.getFullYear();
let date = new Date(year, 2, 0);
 if (date.getDate() == 29) {
        console.log('високосный');;
 } else {
     console.log('не високосный');;
};

////////////332.8

let now = new Date();
for (let year = now.getFullYear() - 1; year >= 0; year--) {
    let date = new Date(year, 2, 0);
    if (date.getDate() == 29) {
        console.log(year);
         break;
     }
}

//////////332.9

let now = new Date().getFullYear();
let nextYear = now + 1;
while (true) {
  if ((nextYear % 4 === 0 && nextYear % 100 !== 0) || nextYear % 400 === 0) {
     console.log(nextYear);
     break;
   }
   nextYear++;
 }

/////////333

let date1 = '2020-11-31';
let date2 = '2020-12-01';
if (date1 > date2) {
    console.log('date1 > date2');
} else {
    console.log('date1 < date2');
}

///////////334

let date1 = '09-21';
let date2 = '09-23';
if (date1 > date2) {
    console.log('date1 > date2');
} else {
    console.log('date1 < date2');
}

////////335

let date = '08-20';
    if (date >= '03-21' && date <= '04-19') {
      console.log("Овен");
    } 
    if (date >= '04-20' && date <= '05-20') {
      console.log("Телец" ) ;
    } 
    if (date >= '05-21' && date <= '06-20') {
      console.log("Близнецы" ) ;
    } 
    if (date >= '06-21' && date <= '07-22') {
      console.log("Рак" ) ;
    } 
    if (date >= '07-23' && date <= '08-22') {
      console.log("Лев" ) ;
    } 
    if (date >= '08-23' && date <= '09-22') {
       console.log("Дева" ) ;
     } 
    if (date >= '09-23' && date <= '10-22') {
      console.log("Весы" ) ;
    }
    if (date >= '10-23' && date <= '11-21') {
      console.log("Скорпион" ) ;
    } 
    if (date >= '11-22' && date <= '12-21') {
      console.log("Стрелец" ) ;
    } 
    if (date >= '12-22' && date <= '01-19') {
      console.log( "Козерог") ;
    } 
    if (date >= '01-20' && date <= '02-18') {
      console.log("Водолей" ) ;
    } 
    if (date >= '02-19' && date <= '03-20') {
      console.log("Рыбы" ) ;
    } 

///////////////336.1

let now = new Date(); 
let pol = new Date();
pol.setHours(12, 0, 0, 0);
if (now >= pol) {
  console.log("Уже прошел полдень");
} else {
  console.log("Еще не наступил полдень");
}

/////////////336.2

let now = new Date();
let pol = new Date(now.getFullYear(), now.getMonth(), 15);
if (now > pol) {
    console.log("Половина месяца уже прошла");
} else {
    console.log("Половина месяца еще не прошла");
}

/////////////339.1

let elem1 = document.querySelector('#elem1');
let elem2 = document.querySelector('#elem2');
let elem3 = document.querySelector('#elem3');
console.log(elem1);
console.log(elem2);
console.log(elem3);

//////////////340.1

let elem = document.querySelector('#block p');
console.log(elem);

/////////////340.2

let elem = document.querySelector('.block p');
console.log(elem);

///////////////340.3

let elem = document.querySelector('.www');
console.log(elem);

////////////////341.1

let button1 = document.querySelector('#button1');
let button2 = document.querySelector('#button2');
let button3 = document.querySelector('#button3');
button1.addEventListener('click', function() {
	console.log('1');
});
button2.addEventListener('click', function() {
	console.log('2');
});
button3.addEventListener('click', function() {
	console.log('3');
});

////////////////////342.1

let button1 = document.querySelector('#button1');
button1.addEventListener('click', func1);

let button2 = document.querySelector('#button2');
button2.addEventListener('click', func2);

function func1() {
	console.log(1);
}

function func2() {
	console.log(2);
}

/////////////////343

let elem1 = document.querySelector('#elem1');
let elem2 = document.querySelector('#elem2');
let elem3 = document.querySelector('#elem3');
let elem4 = document.querySelector('#elem4');
let elem5 = document.querySelector('#elem5');
elem1.addEventListener('click', func);
elem2.addEventListener('click', func);
elem3.addEventListener('click', func);
elem4.addEventListener('click', func);
elem5.addEventListener('click', func);
function func() {
	console.log('message');
}

//////////////344

let elem = document.querySelector('#elem');
elem.addEventListener('click', func1);
elem.addEventListener('click', func2);
elem.addEventListener('click', func3);
function func1() {
	console.log('1');
}

function func2() {
	console.log('2');
}

function func3() {
	console.log('3');
}

////////////////345.1

let button = document.querySelector('#button');
button.addEventListener('dblclick', function() {
	console.log('kitty');
});

///////////////345.2

let button = document.querySelector('#button');
button.addEventListener('mouseover', function() {
	console.log('kitty');
});

///////////////////345.3

let button = document.querySelector('#button');
button.addEventListener('mouseout', function() {
	console.log('hi');
});

////////////////345.4

let button = document.querySelector('#button');
button.addEventListener('mouseover', function() {
	console.log('hi');
});
button.addEventListener('mouseout', function() {
	console.log('bye');
});

/////////////346.1

let button = document.querySelector('#button');
let elem = document.querySelector('#elem');
button.addEventListener('click', function() {
	console.log(elem.textContent);
});

///////////////346.2

let button = document.querySelector('#button');
let elem = document.querySelector('#elem');
button.addEventListener('click', function() {
	elem.textContent = 'Дан абзац и кнопка. По клику на кнопку запишите в абзац новый текст.';
    console.log(elem.textContent);
});

///////////////346.3

let button = document.querySelector('#button');
let elem1 = document.querySelector('#elem1');
let elem2 = document.querySelector('#elem2');
button.addEventListener('click', function() {
    let numbers = Number(elem1.textContent) + Number(elem2.textContent);
    console.log(numbers);
});

///////////////346.4

let button = document.querySelector('#button');
let elem1 = document.querySelector('#elem1');
let elem2 = document.querySelector('#elem2');
let elem3 = document.querySelector('#elem3');
let di = document.querySelector('#di');
button.addEventListener('click', function() {
    let numbers = Number(elem1.textContent) + Number(elem2.textContent) + Number(elem3.textContent);
    console.log(numbers);
    document.getElementById('di').innerHTML = numbers;
});

///////////////346.5

let button = document.querySelector('#button');
let elem1 = document.querySelector('#elem1');
button.addEventListener('click', function() {
    let numbers = Number(elem1.textContent) + 1;
    elem1.textContent = numbers;
});

/////////////////346.6

let button = document.querySelector('#button');
let elem1 = document.querySelector('#elem1');
button.addEventListener('click', function() {
    let numbers = elem1.textContent + '!';
    elem1.textContent = numbers;
});

//////////////347.1

let button = document.querySelector('#button');
let elem = document.querySelector('#elem1');
button.addEventListener('click', function() {
    console.log(elem.innerHTML);
});

/////////////////347.2

let button = document.querySelector('#button');
let elem = document.querySelector('#elem1');
button.addEventListener('click', function() {
    elem.innerHTML = '<b>fgfcx</b>';
});

////////////////348.1

let button = document.querySelector('#button');
let elem = document.querySelector('#elem');
button.addEventListener('click', function() {
    console.log(elem.type);
});

////////////////348.2

let button = document.querySelector('#button');
let elem = document.querySelector('#elem');
button.addEventListener('click', function() {
    elem.type = 'submit';
});

/////////////////348.3

let button = document.querySelector('#button');
let link = document.querySelector('#link');
let di = document.querySelector('#di');
button.addEventListener('click', function() {
    di.innerHTML = link.href
});

///////////////////348.4

let button = document.querySelector('#button');
let link = document.querySelector('#link');
button.addEventListener('click', function() {
    link.innerHTML += link.href;
});

////////////////348.5

let button = document.querySelector('#button');
let pict = document.querySelector('#pict');
let text = document.querySelector('#text');
button.addEventListener('click', function() {
    text.innerHTML = pict.src;
});

/////////////////348.6

let button = document.querySelector('#button');
let pict = document.querySelector('#pict');
let text = document.querySelector('#text');
button.addEventListener('click', function() {
    pict.width = '300';
});

////////////////349.1

let button = document.querySelector('#button');
let elem = document.querySelector('#elem');
button.addEventListener('click', function() {
    console.log(elem.value);
    elem.value = 'new text';
});

//////////////////349.2

let button = document.querySelector('#button');
let elem = document.querySelector('#elem');
let text = document.querySelector('#text');
button.addEventListener('click', function() {
    console.log(elem.value);
    text.innerHTML = elem.value;
});

///////////////349.3

let button = document.querySelector('#button');
let elem1 = document.querySelector('#elem1');
let elem2 = document.querySelector('#elem2');
let text = document.querySelector('#text');
button.addEventListener('click', function() {
    elem2.value = Math.pow(parseInt(elem1.value), 2);
});

////////////////349.4

let button = document.querySelector('#button');
let elem1 = document.querySelector('#elem1');
let elem2 = document.querySelector('#elem2');
let text  
button.addEventListener('click', function() {
    text = elem1.value;
    elem1.value = elem2.value;
    elem2.value = text;
});

////////////////350.1

let elem = document.querySelector('#elem1');
elem.addEventListener('focus', function() {
	elem.value = 1;
});
elem.addEventListener('blur', function() {
	elem.value = 2;
});

//////////////////350.2

let elem = document.querySelector('#elem1');
elem.addEventListener('focus', function() {
	elem.value = 1;
});
elem.addEventListener('blur', function() {
	elem.value = Math.pow(parseInt(elem.value), 2);
});

////////////////350.3

let elem = document.querySelector('#elem1');
elem.addEventListener('focus', function() {
	elem.value = '';
});

///////////////351.1

let button = document.querySelector('#button');
let elem = document.querySelector('#elem');
button.addEventListener('click', function() {
    document.write(elem.className);
})

//////////////351.2

let button = document.querySelector('#button');
let elem = document.querySelector('#elem');
button.addEventListener('click', function() {
    elem.className = 'hello';
    document.write(elem.className);
})

////////////////351.3

let button = document.querySelector('#button');
let elem = document.querySelector('#elem');
button.addEventListener('click', function() {
    let arr = elem.className.split(' ');
    document.write(arr);
})

////////////352.1

console.log( document.querySelector('#image').src );

///////////////354.1

let elem = document.querySelector('#elem');
elem.addEventListener('focus', func);
function func() {
	this.value = '1';
}
elem.addEventListener('blur', func2);
function func2() {
	this.value = '2';
}

/////////////354.2

let button = document.querySelector('#button');
button.addEventListener('click', function() {
    button.value++;
})

//////////////355.1

let elem1 = document.querySelector('#elem1');
let elem2 = document.querySelector('#elem2');
let elem3 = document.querySelector('#elem3');
let elem4 = document.querySelector('#elem4');
let elem5 = document.querySelector('#elem5');
elem1.addEventListener('click', func);
elem2.addEventListener('click', func);
elem3.addEventListener('click', func);
elem4.addEventListener('click', func);
elem5.addEventListener('click', func);
function func() {
this.textContent += '!';
}

//////////////355.2

let elem1 = document.querySelector('#elem1');
let elem2 = document.querySelector('#elem2');
let elem3 = document.querySelector('#elem3');
elem1.addEventListener('blur', func);
elem2.addEventListener('blur', func);
elem3.addEventListener('blur', func);
function func() {
	this.value = Math.pow(this.value, 2);
}

//////////////356.1

let elems = document.querySelectorAll('.www');
button.addEventListener('click', function() {
    for (let elem of elems) {
        elem.textContent = 'text';
    }
})

//////////////356.2

let elems = document.querySelectorAll('.www');
button.addEventListener('click', function() {
    for(let i=0;i<elems.length; ){
        let elem= elems[i++];
        elem.innerHTML += i;
    }
})

//////////////356.3

let elems = document.querySelectorAll('.elem');
let text = document.querySelector('#text');
let but = document.querySelector('#but');
let sum = 0;
but.addEventListener('click', function() {
    for (let elem of elems) {
		sum += Number(elem.value);	
		text.innerHTML = sum;
    }
})

/////////////357.1

let elems = document.querySelectorAll('.elem');
for (let elem of elems) {
	elem.addEventListener('focus', func);
}
function func() {
	this.value = Number(this.value) + 1;
}

///////////////357.2

let elems = document.querySelectorAll('.elem');
for (let elem of elems) {
	elem.addEventListener('click', func);
}
function func() {
	this.textContent = Math.pow(Number(this.textContent), 2);
}

///////////////358.1

let divs = document.querySelectorAll('div');
for (let div of divs) {
	div.addEventListener('click', function(){
		this.textContent++;
	});
}

////////////////359.1

let button = document.querySelector('#button');
let hr = document.querySelector('#href');
button.addEventListener('click', func);
function func() {
hr.textContent += hr.href;
this.removeEventListener('click', func);
}

////////////////364.1

let txt1 = document.querySelector('#id1');
let id1 = document.querySelector('#txt1');
txt1.addEventListener('blur', function() { 
  let txt2 = txt1.value;
  id1.textContent += ' ' + txt2;
  console.log(id1.textContent);
});


/////////////364.2

let id2 = document.querySelector('#id2');
let id3 = document.querySelector('#id3');
let id4 = document.querySelector('#id4');
let txt2 = document.querySelector('#txt2');
let button1 = document.querySelector('#button1');
button1.addEventListener('click', function () {
    let sum = Number(id2.value) + Number(id3.value) + Number(id4.value);
    txt2.textContent = "Сумма: " + sum;
});


//////////////////364.3

let id5 = document.querySelector('#id5');
let txt3 = document.querySelector('#txt3');
id5.addEventListener('blur', function(){
    let number1 = id5.value;
    let sum = 0;
    for (let i = 0; i < number1.length; i++) {
        sum += parseInt(number1.charAt(i));
    }
    txt3.textContent = "Сумма цифр: " + sum;
});

//////////////////364.4

let id6 = document.querySelector('#id6');
let txt4 = document.querySelector('#txt4');
id6.addEventListener('blur', function(){
    let number2 = id6.value.split(",");
    let sum = 0;
    for (let i = 0; i < number2.length; i++) {
        sum += parseInt(number2[i]);
    }
    let itog = sum / number2.length;
    txt4.textContent = "Среднее арифметическое: " + itog;
})

/////////////////////364.5

let id7 = document.querySelector('#id7');
let id8 = document.querySelector('#id8');
let id9 = document.querySelector('#id9');
let id10 = document.querySelector('#id10');
id7.addEventListener('blur', function(){
    let number4 = id7.value.split(" ");
        id8.value = number4[0];
        id9.value = number4[1];
        id10.value = number4[2];
    }
);

////////////////364.6

let id11 = document.querySelector('#id11');
id11.addEventListener("blur", function() {
    let znach1 = id11.value;
    let words = znach1.split(" ");
    let itog2 = words.map(function(word) {
        return word.charAt(0).toUpperCase() + word.slice(1);
    }).join(" ");
    id11.value = itog2;
});

////////////364.7

let id12 = document.querySelector('id12');
let txt5 = document.querySelector('txt5');
id12.addEventListener("blur", function() {
    let zhach2 = id12.value;
    let words = zhach2.split(" ");
    words = words.filter(function(word) {
        return word !== "";
    });
    let count = words.length;
    txt5.textContent = "Количество слов: " + count;
});


////////////364.8

let id13 = document.querySelector('id13');
id13.addEventListener("blur", function() {
    let date = id13.value;
    let part = date.split(".");
    let datta = part[2] + "-" + part[1] + "-" + part[0];
    id13.value = datta;
});

///////////////364.9

let id14 = document.querySelector('#id14');
let button2 = document.querySelector('#button2');
let result = document.querySelector('#result');
button2.addEventListener("click", function() {
    let word = id14.value.toLowerCase();
    if (word === word.split("").reverse().join("")) {
        result.textContent = "палиндром";
    } else {
        result.textContent = "не палиндром";
    }
});

/////////////////364.10

let id = document.querySelector('#id');
let itog = document.querySelector('#itog');
id15.addEventListener("blur", function() {
    let number = id.value;
    if (number.includes("3")) {
        itog.textContent = "Число содержит цифру 3";
    } else {
        itog.textContent = "Число не содержит цифру 3";
    }
});

////////////////364.11

let txt = document.getElementsByTagName("p");
let button3 = document.querySelector('#button3');
button3.addEventListener("click", function() {
    for (let i = 0; i < txt.length; i++) {
        txt6[i].textContent += " " + (i + 1);
    }
});

///////////364.12

let links = document.getElementsByTagName("a");
let button5 = document.querySelector('#button5');
button5.addEventListener("click", function() {
    for (let i = 0; i < links.length; i++) {
        links[i].textContent += " (" + links[i].href + ")";
    }
});

////////////////364.13

let links = document.getElementsByTagName("a");
let button6 = document.querySelector('#button6');
button6.addEventListener("click", function() {
    for (let i = 0; i < links.length; i++) {
        if (links1[i].href.startsWith("http://")) {
            links1[i].textContent += " →";
        }
    }
});

//////////////364.14

let id = document.querySelector("#id1");
let id= document.querySelector("#id2");
let id= document.querySelector("#id3");
let button7 = document.querySelector('#button7');
id1.addEventListener("click", function() {
    let square = parseInt(id1.textContent) ** 2;
    id16.textContent = square;
});
id2.addEventListener("click", function() {
    let square = parseInt(id2.textContent) ** 2;
    id17.textContent = square;
});
id3.addEventListener("click", function() {
    let square = parseInt(id3.textContent) ** 2;
    id18.textContent = square;
});

///////////////364.15

let id19 = document.querySelector('#id19');
let result12 = document.querySelector('#result12');
id19.addEventListener("blur", function() {
    let date = id19.value;
    let dayOfWeek = getDayOfWeek(date);
    result12.textContent = dayOfWeek;
});
function getDayOfWeek(dateString) {
    let dateParts = dateString.split(".");
    let day = parseInt(dateParts[0]);
    let month = parseInt(dateParts[1]) - 1;
    let year = parseInt(dateParts[2]);
    let date = new Date(year, month, day);
    let daysOfWeek = ["Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"];
    return daysOfWeek[date.getDay()];
}

/////////////364.16

let id = document.querySelector('#id');
let butt = document.querySelector('#butt');
let but = document.querySelector('#but');
butt.addEventListener("click", function() {
    let currentValue = parseInt(id.value);
    id21.value = currentValue + 1;
});
but.addEventListener("click", function() {
    let currentValue = parseInt(id.value);
    if (currentValue > 0) {
        id21.value = currentValue - 1;
    }
});

////////////364.17

let id20 = document.querySelector('#id20');
let paragraphs = document.getElementsByTagName("p");
for (let i = 0; i < paragraphs.length; i++) {
    paragraphs[i].addEventListener("click", function() {
        let currentValue = parseInt(id20.value);
        id20.value = currentValue + 1;
    });
}

///////////364.18

let divs = document.getElementsByTagName("div");
for (let i = 0; i < divs.length; i++) {
    let div = divs[i];
    let text = div.innerHTML;
    if (text.length > 10) {
        text = text.substring(0, 10) + "...";
    }
    div.innerHTML = text;
}

////////////364.19

function generateRandomString1() {
    let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    let randomString = "";
    for (let i = 0; i < 8; i++) {
        let randomIndex = Math.floor(Math.random() * characters.length);
        randomString += characters.charAt(randomIndex);
    }
    document.querySelector('#id24').value = randomString;
}

///////////364.20

function RandomString() {
    let input = document.querySelector('#randomStringInput');
    let string = input.value;
    let shuffledString = shuffleString(string);
input.value = shuffledString;
}
function shuffleString(string) {
    let characters = string.split("");
    for (let i = characters.length - 1; i > 0; i--) {
        let randomIndex = Math.floor(Math.random() * (i + 1));
        let temp = characters[i];
        characters[i] = characters[randomIndex];
        characters[randomIndex] = temp;
    }
    return characters.join("");
}

//////////////364.21

function convertToFahrenheit() {
    let id234 = document.querySelector('#id234');
    let celsiusResult = document.querySelector('#result13');
    let fahrenheit = parseFloat(id234.value);
    let celsius = (fahrenheit - 32) * 5/9;
    celsiusResult.textContent = "Temperature in Celsius: " + celsius.toFixed(2);
}

///////////////364.22

function calculateFactorial() {
    let numberInput = document.querySelector('#numberInput');
    let result16 = document.querySelector('#result16');
    let number = parseInt(numberInput.value);
    let factorial = 1;
    for (let i = 1; i <= number; i++) {
        factorial *= i;
    }
    result16.textContent = "Factorial: " + factorial;
}

/////////////364.23

function calculateRoots() {
    let inputA = document.querySelector('#inputA');
    let inputB = document.querySelector('#inputB');
    let inputC = document.querySelector('#inputC');
    let res18 = document.querySelector('#res18');
    let a = parseInt(inputA.value);
    let b = parseInt(inputB.value);
    let c = parseInt(inputC.value);
    let discriminant = Math.pow(b, 2) - (4 * a * c);
    if (discriminant > 0) {
        let root1 = (-b + Math.sqrt(discriminant)) / (2 * a);
        let root2 = (-b - Math.sqrt(discriminant)) / (2 * a);
        result.textContent = "Roots: " + root1 + ", " + root2;
    } else if (discriminant === 0) {
        let root = -b / (2 * a);
        res18.textContent = "Root: " + root;
    } else {
        res18.textContent = "No real roots";
    }
}