//////////223.1

function func() {
    return '!';
}

console.log(func);  увидим код функции

/////////224.1

function func() {
    return 'fff';
}

/////////224.2

function func() {
    return 'fff';
}
console.log(func()); 

/////////224.3

function func() {
    return 'fff';
}
console.log(func); 

/////////224.4

function func() {
    return 'fff';
}
func = 123; 
console.log(func); 

///////////225.1-3

function func1(){
    return 3;
}
let func2 = func1;
console.log(func1() + func2());

///////////226.1-3

let func1 = function() {
    return 1;
}
let func2 = function() {
    return 2;
}
alert (func1() + func2())

///////////229.1

func();
function func() {
    console.log('!');
}

///////////229.2

func(); 
let func = function() {
    console.log('!');
};

/////////230.1

let func1 = function() {console.log('!')};
let func2 = function() {
    console.log('!')
};
function func3() {
    console.log('!')
}

////////237.1

let arr = [
    function() {return 1},
    function() {return 2},
    function() {return 3},
];

////////237.2

console.log(arr[2]());

////////237.3

console.log(arr[0]() + arr[1]() + arr[2]());

////////237.4

for (let func of arr) {
   console.log(func());
}

/////////238.1

let obj = {
 func1: function() {return 1},
 func2: function() {return 2},
 func3: function() {return 3},
};

/////////238.2

console.log(obj.func1() + obj.func2() + obj.func3());
for (let key in obj) {
    console.log(obj[key]()); 
}

//////////239.1

let obj = {
    sum: function(arr) {
        let sum = 0;
        for (let elem of arr) {
        sum+=elem;
    } return sum; },
    square: function(arr) {
        let res = 1;
        for (let elem of arr) {
        res = elem ** 2;
    } return res; },
    cube: function(arr) {
        let res = 1;
        for (let elem of arr) {
        res = elem ** 3;
    } return res; },
}
let arr = [1, 2];
console.log(obj.sum(arr)); 
console.log(obj.square(arr)); 
console.log(obj.cube(arr));

////////240.1-3

test (
    function() {return 1;},
    function() {return 2;},
    function() {return 3;},
);
function test(func1, func2, func3){
    console.log(func1() + func2() + func3());
}

//////////241.1-3

function func1() {
    return 1;
}
function func2() {
    return 2;
}
function func3() {
    return 3;
}
function test(func1, func2, func3) {
    return func1() + func2() + func3();
}
console.log(test(func1, func2, func3)); 

function func1() {
    return 1;
}
function func2() {
    return 2;
}
function func3() {
    return 3;
}
function test(func1, func2, func3) {
    return func1() + func2() + func3();
}
console.log(test(func1, func2, func3)); 

let func1 = function() {
    return 1;
};
let func2 = function() {
    return 2;
};
let func3 = function() {
    return 3;
};
function test(func1, func2, func3) {
    return func1() + func2() + func3();
}
console.log(test(func1, func2, func3));

///////242.1-4

function test(func) {
 console.log(func(3));
}
function cube(num) {
    return num * num * num;
}
test(cube);

let test = function(func) {
 console.log(func(3));
};
function cube(num) {
    return num * num * num;
}
test(cube);

let test = function(func) {
 alert(func(2, 3));
}
function sum(num1, num2) {
    return num1 + num2;
}
test(sum);

////////////243.1

function test(num, func1, func2) {
    return func1(num) + func2(num);
}
 
function square(num) {
    return num * num;
}
 
function cube(num) {
    return num * num * num;
}
console.log(test(3, square, cube)); 

/////////244.1

function test(arr, func) {
 for (let i = 0; i < arr.length; i++) {
  arr[i] = func(arr[i]);
 }

 return arr;
}

///////244.2

let result = test([8, 2, 5], function(num) {
 return num * num * num;
});

console.log(result);

////////245.1 

function func(num1, num2) {
    function cube(num2) {
        return num2 * num2 * num2;
    }
    function square(num1) {
        return num1 * num1;
    }
   
    return square(num1) + cube(num2);
}

console.log(func(2, 3));

///////250.1

function func1() {
    return function() {
      return 1;
    };
}
 
function func2() {
    return function() {
      return 2;
    };
}
 
let sum = func1()() + func2()();
console.log(sum); 

/////////251.1

function func() {
    return function(){
        return function(){
            return function() {
                return function() {
                    return '!';
                };
            };
        };
    };
}

console.log( func()()()()() );

//////////////252.1

function func(num1) {
    return function (num2){
        return function(num3) {
            return num1 + num2 + num3;
        };
    };
}

console.log( func(2)(3)(4) );

//////////252.2 

function func(x) {
    return function(y) {
        return function(z) {
            return function(w) {
                return [x, y, z, w];
            };
        };
    };
}
const result = func(2)(3)(4)(5);
console.log(result); 

//////////253.1-3

function each(arr, callback) {
    let result = [];
    for (let i = 0; i < arr.length; i++) {
      result.push(callback(arr[i]));
    }
    return result;
}
let array = [1, 2, 3, 4, 5];
let resultarr = each(array, function(num) {
    return num * 2;
});

console.log(resultarr);

function each(arr, callback) {
    let result = [];
    for (let i = 0; i < arr.length; i++) {
      result.push(callback(arr[i]));
    }
    return result;
}
let string = [ "world", "Hellow"];
let resultstr = each(string, function(str) {
    return str.split('').reverse().join('');
});
console.log(resultstr);

function each(arr, callback) {
    let result = [];
    for (let i = 0; i < arr.length; i++) {
      result.push(callback(arr[i]));
    }
    return result;
}
let string = [ "world", "hellow"];
let resultstr = each(string, function(str) {
    return str.slice(0, 1).toUpperCase() + str.slice(1);
});
console.log(resultstr);

/////////254.1

function each(arr, callback) {
    let result = [];
    for (let i = 0; i < arr.length; i++) {
        result.push(callback(arr[i]));
    }
    return result;
}
function cube(num) {
    return num ** 3;
}
let resultarr = each([1, 2, 3, 4, 5], cube);
console.log(resultarr);

//////////256.1

let result = filter([1, 2, 3, 4, 5], elem => elem > 0);

////////261.1

function test() {
	let num = 1;
	return function() {
		console.log(num);
		num++;
	}
}
let func = test();
func();
func();

///////261.2

function test() {
	let num = 10;
	return function() {
		console.log(num);
		num--;
	}
}
let func = test();
func();
func();

////////////269.1

(function() {
	return function() {
		console.log('!');
	};
})()()();

/////////269.2

(function(num1) {
    return function (num2) {
        alert(num1 + num2);
    }
})(1)(2);

////////269.3

(function(num1) {
    return function (num2) {
        return function (num3) {
            alert(num1 + num2 + num3);
        }
    }
})(1)(2)(3);

////////////272.1

let func = (function () {
    let num = 1;
    return function () {
        if (num == 5){
            console.log(num);
            num = 1;
        } else {
            console.log(num);
            num++;
        }
    }
})();
func();
func();
func();
func();
func();
func();
func();
func();
func();

///////////275.1

let arr = [1, 2, 3, 4, 5];
function getSum(arr) {
	let sum = arr.shift();
	if (arr.length !== 0) {
		sum += getSum(arr);
	}
	return sum;
}
console.log(getSum(arr));

////////////278.1

const arr = [1, [2, 7, 8], [3, 4], [5, [6, 7]]];
function squareElements(arr) {
    return arr.map((element) => {
        if (Array.isArray(element)) {
            return squareElements(element);
        } else {
            return Math.pow(element, 2);
        }
    });
}
const squaredArr = squareElements(arr);
console.log(squaredArr);

/////////279.1

let arr = [2,4,6];
    let res = arr.map(function(elem) {
	return Math.sqrt(elem);
});
console.log(res);

////////279.2

let arr = ['a', 'b', 'c'];
let res = arr.map(function(elem) {
	return elem + '!';
});
console.log(res);

///////279.3

let arr = ['abc', 'bce', 'cde'];
let res = arr.map(function(elem) {
	return elem.split('').reverse().join('');
});
console.log(res);

///////279.4

let arr = ['123', '456', '789'];
let res = arr.map(function(elem) {
elem.split("");
return arr.push(Number(elem));
});
console.log(res);

///////279.5

let arr = [1,2,3];
let res = arr.map(function(elem, index) {
    return elem * index;
    });
    console.log(res);

////////280.1

let arr = [1,2,3];
let sum = 0;
arr.forEach(function(elem) {
    sum += elem ** 2;
});
    console.log(sum);

///////281.1

let arr = [-1, -3, 1, 2, 3];
let res = arr.filter(elem => {
	return elem >= 0;
});

console.log(res);

/////////281.2

let arr = [-1, -3, 1, 2, 3];
let res = arr.filter(elem => {
	return elem <= 0;
});

console.log(res);

////////281.3

let arr = [-1, -3, 1, 2, 3, 22];
let res = arr.filter(elem => {
	return elem >= 0 & elem <=10;
});

console.log(res);

/////////281.4

let arr = ['skibidi','dop','dop','yesyes'];
let res = arr.filter(elem => {
	return elem.length > 5;
});

console.log(res);

///////////281.5

let arr = [-1, -3, 1, 2, 3, 22];
let res = arr.filter(function(elem, index) {
    return (elem * index) < 30;
    });
    console.log(res);

////////////281.6

let arr = [1, 2, [3, 4], 5, [6, 7]];
let filtrate = arr.filter(Array.isArray);
console.log(filtrate)

/////282.1

let arr = [1, 2, 3, 4, 5];
let check = arr.every(function(elem) {
	if (elem >= 0) {
		return true;
	} else {
		return false;
	}
});
console.log(check);

///////282.2

let arr = [1, 2, 3, 4, 5];
let check = arr.every(function(elem, index) {
	if (elem * index < 30) {
		return true;
	} else {
		return false;
	}
});
console.log(check);

/////////283.1

let arr = [2, 4, 6, 8];
let result = arr.some(elem => elem > 0);
console.log(result);

////////283.2

let arr = [2, 4, 6, 8];
let result = arr.some(function(elem, index) {
	return elem * index > 30;
});
console.log(result);

////////286.1

let arr = [1, 2, 3, 4, 5];
function func(num1, num2, num3, num4, num5) {
	return num1 + num2 + num3 + num4 + num5;
}
console.log(func(...arr));

///////288.1

let arr = [1, 2, 3, 4, 5];
let min = Math.min(...arr);
console.log(min)

//////293.1

function func(...nums) {
	console.log(nums);
}
func(1, 2, 3);
function func(...nums) {
	let sum = 0;
	for (let num of nums) {
		sum += num;
	}
	
	return sum / nums.length;
}
let result = func(1, 2, 3);
console.log(result);

//////296.1

let arr = ['John', 'Smit', 'development', 
	'programmer', 2000]; 

let [Name, surname, department, position, salary] = arr;
console.log(surname);

//////297.1

function func() {
	return ['John', 'Smit', 'development', 
		'programmer', 2000]; 
}

let arr = func();
let [Name, surname, department, position, salary] = func();
console.log(surname);

///////298.1

let arr = ['John', 'Smit', 'development', 
	'programmer', 2000]; 
let [,,department,position] = arr;
console.log(position);

///////300.1

let arr = ['John', 'Smit', 'development', 
	'programmer', 2000]; 
let [name, surname, ...info] = arr;
console.log(position);

//////301.1

let arr = ['John', 'Smit', 'development', 'programmer'];
let [name, surname, department, position, date=2000] = arr;
let position;
if (arr[3] !== undefined) {
	position = arr[3];
} else {
	position = 'trainee';
}

////////302.1

let arr = [,,];
function funcDay() {
	return (new Date).getDate();
}
function funcMonth() {
	return (new Date).getMonth();
}
function funcYear() {
	return (new Date).getFullYear();
}
let [year = funcYear(), month = funcMonth(), day = funcDay()] = arr;
console.log(year,month,day);

/////////304.1

let options = {
color: 'red',
width: 400,
height: 500,
};
let {color, width, height} = options;
console.log(height);
    
/////////////305.1

let options = {
color: 'red',
width: 400,
height: 500,
};
let {color: c, width: w , height: h} = options
console.log(w);
    
////////////306.1

let options = {
width: 400,
height: 500,
};
let {color = 'black', width, height} = options
console.log(color);
    
//////////////307.1

let options = {
width: 400,
height: 500,
};
let {color:c = 'black', width, height} = options
console.log(c);
    
//////////////309.1

func( ['John', 'Smit', 'development', 'programmer', 2000] );
function func([name, surname, department, position, salary]) {
console.log(department);
console.log(position);
console.log(name);
console.log(surname);
console.log(salary);
}
    
///////////////309.2

func( ['John', 'Smit', 'development', 'programmer', 2000] );
function func([name, surname, ...info]) {
console.log(name);
console.log(surname);
console.log(info);
}
    
/////////////////309.3

func( ['John', 'Smit', 'development'] );
function func([name, surname, department, position = 'джуниор']) {
console.log(name);
console.log(surname);
console.log(department);
console.log(position);
}

/////////////309.4

func('development', ['John', 'Smit'], [2018, 12, 31] );
function func(department, [name, surname], [year, month, day]) {
console.log(department);
console.log(name);
console.log(surname);
console.log(year);
console.log(month);
console.log(day);
}

/////////310.1

function func({color, width, height}) {
console.log(color);
console.log(width);
console.log(height);
}   
func( {color: 'red', width: 400, height: 500} );
    
/////////////310.2

function func({color = 'black', width, height}) {
console.log(color);
console.log(width);
console.log(height);
}  
func( {color: 'red', width: 400, height: 500} );
