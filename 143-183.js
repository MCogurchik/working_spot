/////143.1

let arr = ['a', 'b', 'c', 'd', 'e'];
for (let elem of arr) {
	console.log(elem);
}

///////////144.1

let obj = {x: 1, y: 2, z: 3};
for (let key in obj) {
    console.log(key);
}

///////////144.2

let obj = {x: 1, y: 2, z: 3};
for (let key in obj) {
    console.log(obj[key]);
}

//////////146.1
i=1;
while (i<=100) {
    console.log(i)
    i++;
}

//////////////146.2

i=11;
while (i<=33) {
    console.log(i)
    i++;
}

//////////146.3

i=100;
while (i<=1000) {
    console.log(i)
    i= i*3;
}

/////////147.1

for (let i = 0;i<=100;i++){
    console.log(i)
}

////////////147.2

for (let i = 11;i<=33;i++){
    console.log(i)
}

///////////147.3

for (let i = 2;i<=100;i+=2){
    console.log(i)
}

////////////147.4

for (let i = 1;i<=99;i+=2){
    console.log(i)
}

//////////147.5

for (let i = 100;i>0;i--){
    console.log(i)
}

///////////148.1

let arr = ['a', 'b', 'c', 'd', 'e'];
for (let i = 0; i <= arr.length - 1; i++) {
	console.log(arr[i]);
}

///////////148.2

let arr = ['a', 'b', 'c', 'd', 'e'];
for (let i = 0; i <= arr.length - 2; i++) {
	console.log(arr[i]);
}

//////////148.3

let arr = ['a', 'b', 'c', 'd', 'e'];
for (let i = arr.length - 1; i >= 0; i--) {
	console.log(arr[i]);
}

///////148.4

let arr = ['a', 'b', 'c', 'd', 'e'];		
for (let i = 0; i <= arr.length - 1; i++) {
	console.log(arr[i]);
}

//////149.1

let arr = [2, 5, 9, 15, 1, 4];
for (let elem of arr) {
	if (elem > 3 && elem < 10) {
		console.log(elem);
	}
}

//////////149.2

let obj = {a: 1, b: 2, c: 3, d: 4, e: 5};
for (key in obj){
    if(obj[key]%2 == 1){
        console.log(obj[key])
    }
}

//////////150.1

let res = 0;
for (i=2;i<=99;i+=2){
    res = res + i;
}
console.log(res)

/////////////167.1 

for (let i = 0;i<=100;i++){
    console.log(i)
}

/////////////167.2

for (let i = 100;i>=0;i=i-1){
    console.log(i)
}

///////////167.3

for (let i = 2;i<=100;i+=2){
    console.log(i)
}

////////////167.4

let arr = [];
let str = "x";
for (let i = 0;i<=10; i++){
    arr.push(str);
}
console.log(arr);

////////167.5

let arr = [];
for (let i = 0;i<=10; i++){
    arr.push(i);
}
console.log(arr);

//////167.6

let arr = [1, 2, 6, 78, 575, 52, 2625, 84];
for (let elem of arr) {
if (elem > 0 && elem <= 10) {
console.log(elem);
}
}

/////////167.7

let arr = [1,2,3,4,5,6,7,8,9,10];
for (let elem of arr) {
    if (elem == 5) {
    console.log(elem);
    }
    }

//////////167.8

let arr = [1, 4, 6, 8, 51, 98, 25, 81];
let res = 0;
for (let elem of arr) {
res += elem;
}
console.log(res);

//////////167.9

let arr = [1,2,3,4,5,6,7,8,9,10];
let res = 0;
let res1 = 0;
for (let elem of arr) {
    res1 = elem**2;
    res = res + res1;
    }
    console.log(res)

////////////167.10

let arr = [1,2,3,4,5];
let res = 0;
for (let elem of arr) {
    res = res+elem;
    }
	res = res / arr.length;
    console.log(res);

////////////167.11

let arr = [1,2,3,4,5];
let res = 1;
for (let elem of arr) {
        res = res * elem;   
}
console.log(res);

/////////////////167.12
let arr = [];
for (let i = 10; i >= 1; i--){
arr.push(i);
}
console.log(arr);

////////////167.13

let arr = [1, -4, 6, -8, -51, -98, 25, -81];
let res = 0;
for (let i = 0; i < arr.length; i++) {
if (arr[i] > 0){
res += arr[i];
}
}
console.log(res);

//////////167.14

let arr = [10, 20, 30, 50, 235, 3000];

for (let i = 0; i < arr.length; i++) {
  let num = String(arr[i]);
  let check = num[0];
  if (check == 1 || check == 2 || check == 5) {
    console.log(num);
  }
}

/////////////////////167.15

let arr = [10, 20, 30, 50, 235, 3000];
for (i = arr.length-1; i>=0 ; i--) {
    console.log(arr[i]);
}
 
/////////////////////////167.16

let arr = [1, 4, 2, 8, 51, 98, 6, 81];

for (let i = 0; i <= arr.length - 1; i++) {
  let arrEl = arr[i];
  if (arrEl === i) {
    console.log(arr[i]);
  }
}

////////////////////////167.17

let arr = [1, 4, 2, 8, 51, 98, 6, 81];

for (let i = 0; i <= arr.length-1; i++) {
 document.write(arr[i] + '<br>');
}

////////////////////////////167.18

let arr = [1, 4, 2, 8, 51, 98, 6, 81];

for (let i = 0; i <= arr.length-1; i++) {
 document.write(arr[i] + '<br>');
}

//////////////////167.19

let arr = ['Monday', 'Thuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
let week = '';

for (let i = 0; i <= arr.length-3; i++) {
 week += arr[i] + ' ';
}
document.write(week + '<b>' + 'Saturday' + '</b>' + '<b>' + 'Sunday' + '</b>');

////////////////////////167.20

let day = 'ср';
let arr = ['пн','вт','ср','чт','пт','сб','вс',];

for (let i = 0; i < 1; i++){
    for (let elem of arr){
    if (elem == day){
              document.write('<i>' + elem + '</i>')
        }
    document.write(elem + '<br>')  
    }
}

/////////////////////////167.21

let obj = {
 employee1: 100,
 employee2: 200,
 employee3: 300,
 employee4: 400,
 employee5: 500,
 employee6: 600,
 employee7: 700,
 };

for (let key in obj) {
 str = obj[key] + obj[key] * 0.1;
 console.log(str);
 }

///////////////////////////167.22

let obj = {
 employee1: 100,
 employee2: 200,
 employee3: 300,
 employee4: 400,
 employee5: 500,
 employee6: 600,
 employee7: 700,
  };
  
  for (let key in obj){
   if (obj[key] >= 400){
   str = obj[key] + obj[key] * 0.1;
 console.log('Увеличенные зарплаты:' + '<br>');
   console.log('<br>' + str);
   }
  }

////////////////////////167.23

let arr1 = [1, 2, 3, 4, 5];
let arr2 = [6, 7, 8, 9, 10];
let arr = {};
for (let i = 0; i < arr1.length; i++) {
    let key = arr1[i];
    arr[key] = arr2[i];
}
console.log(arr)

/////////////////////////167.24

let obj = {1: 6, 2: 7, 3: 8, 4: 9, 5: 10};
let sum = 0;
let sum2 = 0;

for (let key in obj) {
sum += Number(key);
sum2 += Number(obj[key]);
}
console.log(sum/sum2);

////////////////////////167.25

let obj = {'a': 1, 'b': 2, 'c': 3, 'd': 4, 'e': 5};
let arr1 = [];
let arr2 = [];

for (let key in obj) {
arr1.push(key);
arr2.push(obj[key]);
}

console.log(arr1);
console.log(arr2);

///////////////////167.26

let obj = {
 1: 125,
 2: 225,
 3: 128,
 4: 356,
 5: 145,
 6: 281,
 7: 452,
  };
  let arr = [];
  for (let key in obj){ 
 let z = String(obj[key]);
   if (z[0] == 1 || z[0] == 2){
    arr.push(Number(z))
   }
  }
  console.log(arr);

/////////////////167.27

let keys = [ 1, 2, 3, 4, 5];
let values = ['a', 'b', 'c', 'd', 'e'];
let obj = {};

for (let i = 0; i <= 4; i++) {
 let key = keys[i];
 let value = values[i];
 
 obj[key] = value;
}

console.log(obj);

////////////////167.28

let keys = ['a', 'b', 'c', 'd', 'e'];
let values = [ 1, 2, 3, 4, 5];
let obj = {};

for (let i = 0; i <= 4; i++) {
 let key = keys[i];
 let value = values[i];
 
 obj[key] = value;
}

console.log(obj);


///////////168.1

let arr = [
	['a', 'b', 'c'],
	['d', 'e', 'f'],
	['g', 'h', 'i'],
	['j', 'k', 'l'],
];
console.log(arr[3][2], arr[1][1], arr[2][0], arr[0][0])

////////////168.2

let arr = [[1, 2],
           [3, 4],
           [5, 6]];
console.log(arr[0][0] + arr[0][1] +arr[1][0] +arr[1][1] +arr[2][0] +arr[2][1])

//////169.1

let arr = [
	[
		[1, 2],
		[3, 4],
	],
	[
		[5, 6],
		[7, 8],
	],
];
console.log(arr[0][0][0] + arr[0][0][1] + arr[0][1][0] + arr[0][1][1] + arr[1][0][0] + arr[1][0][1] + arr[1][1][0] + arr[1][1][1])

////////////////////////170.1

let arr = [
    [1, 2, 3,
           [4, 5, 
            [6, 7]
            ]
    ],
    [8, 
        [9, 10]
    ]
];

console.log(arr [0][0] + arr [0][1] + arr [0][2] + arr [0][3][0] + arr [0][3][1] + arr [0][3][2][0] + arr [0][3][2][1] + arr[1][0] + arr [1][1][0] + arr [1][1][1])

/////////////////////171.1

let arr = [[1, 2, 3], [4, 5], [6]];
let res = 0;
for (let subArr of arr) {
	for (let elem of subArr) {
        res += elem;
	}
}console.log(res);

////////////171.2

let arr = [[[1, 2], [3, 4]], [[5, 6], [7, 8]]];
let res = 0;
for (let subArr of arr) {
	for (let subar2 of subArr) {
        for (let elem of subar2){
            res += elem;
        }
	}
}console.log(res);

//////////////172.1
let arr = [[1, 2, 3], [4, 5], [6]];
let res = 0;
for (let i = 0; i < arr.length; i++) {
for (let j = 0; j < arr[i].length; j++) {
res += arr[i][j];
}
}
console.log(res);

//////////////172.2
let arr = [[[1, 2], [3, 4]], [[5, 6], [7, 8]]];
let res = 0;
for (let i = 0; i < arr.length; i++) {
for (let j = 0; j < arr[i].length; j++) {
for (let k = 0; k < arr[j].length; k++) {
res += arr[i][j][k];
}
}
}
console.log(res);

///////////173.1

let arr = [];
for (let i = 0; i < 3; i++) {
    arr[i] = [];
    
    for (let j = 0; j < 5; j++) {
        arr[i].push(j + 1);
    }
}
console.log(arr);

/////////////173.2

let arr = [];
for (let i = 0; i < 3; i++){
    arr[i] = [];

    for (j = 0; j <= 3; j++){
        arr[i].push('x');
    }
} console.log(arr)


///////////173.3

let arr = [];
for(let i = 0; i < 3; i++) {
arr[i] = [];

for(let j = 0; j < 2; j++) {
arr[i].push([]);

for(let k = 0; k < 5; k++) {
arr[i][j][k] = k+1;
}
}
}
console.log(arr)

////////////////174.1

let arr = [];

for (let i = 0; i < 3; i++) {
    arr[i] = [];
	for (let j = 1; j <= 5; j++) {
		arr[i].push(j);
	}
}

console.log(arr);

////////////////174.2

let arr = [];

for (let i = 0; i < 3; i++) {
	arr[i] = [];
	
	for (let j = 1; j <= 5; j++) {
		arr[i].push(j);
	}
}

console.log(arr);

////////////174.3

let arr = [];

for (let i = 0; i < 3; i++) {
	arr[i] = [];
	
	for (let j = 1; j <= 5; j++) {
		arr[i].push(j);
	}
}

console.log(arr);

/////////////174.4

let arr = [];

for (let i = 0; i < 3; i++) {
	arr[i] = [];
	
	for (let j = 1; j <= 5; j++) {
		arr[i].push(j);
	}
}

console.log(arr);

//////////////174.5

let arr = [];

for (let i = 0; i < 3; i++) {
	arr[i] = [];
	
	for (let j = 1; j <= 5; j++) {
		arr[i].push(j);
	}
}

console.log(arr);

////////////////////174.6

let arr = [];

for (let i = 0; i < 3; i++) {
	arr[i] = [];
	
	for (let j = 1; j <= 5; j++) {
		arr[i].push(j);
	}
}

console.log(arr);

///////////////175.1

let arr = [];

for (let i = 0, k = 1; i < 4; i++) {
	arr[i] = [];
	
	for (let j = 0; j < 2; j++) {
		arr[i].push(k++);
	}
}

console.log(arr);

/////////////175.2 

let arr = [];

for (let i = 0, k = 0; i < 4; i++) {
	arr[i] = [];
	
	for (let j = 0; j < 3; j++) {
		arr[i].push(k += 2);
	}
}

console.log(arr);

////////////////////175.3

let arr = [];
let g = 1;
    for (let i = 0; i < 2; i++) {
        arr[i] = [];
    for (let j = 0; j < 2; j++) {
        arr[i].push([]);
    for (let k = 0; k < 2; k++) {
        arr[i][j][k] = g;
        g++;
        }
    }
}
console.log(arr);

////////////////////////////175.4

let arr = [];

for (let i = 0, k = 1; i < 3; i++) {
arr[i] = [];

for (let j = 0; j < 3; j++) {
arr[i][j] = k;
k++;
}
}

console.log(arr);

////////////////////175.5

let arr = [];

for (let i = 0, k = 1; i < 3; i++) {
arr[i] = [];

for (let j = 0; j < 3; j++) {
arr[i][j] = (k++);
}
}

console.log(arr);

/////////////////////175.6

let arr = [];

for (let i = 0, k = 1; i < 3; i++) {
arr[i] = [];

for (let j = 0; j < 3; j++) {
arr[i][j] = k;
k++;
}
}

console.log(arr);

////////////////////175.7

let arr = [];
let k = 0;

for (let i = 0; i < 3; i++) {
arr[i] = [];

for (let j = 0; j < 3; j++) {
arr[i][j] = k;
k++;
}
}

console.log(arr);

/////////////////////175.8

let arr = [];

for (let i = 0, k = 1; i < 3; i++) {
arr[i] = [];

for (let j = 0; j < 3; j++) {
arr[i][j] = k++;
}
}

console.log(arr);

/////////////////////////175.9

let arr = [];

for (let i = 0, k = 1; i < 3; i++) {
arr[i] = [];

for (let j = 0; j < 3; j++) {
arr[i][j] = k++;
}
}

console.log(arr);

///////////////////////////175.10

let arr = [];

for (let i = 0, k = 1; i < 3; i++) {
arr[i] = [];

for (let j = 0; j < 3; j++) {
arr[i][j] = k++;
}
}

console.log(arr);

/////////////////////////////////175.11

let arr = [];

for (let i = 0, k = 1; i < 3; i++) {
arr[i] = [];

for (let j = 0; j < 3; j++) {
arr[i][j] = k++;
}
}

console.log(arr);

/////////////////////////////175.12

let arr = [];
let k = 1;

for (let i = 0; i < 3; i++) {
arr[i] = [];

for (let j = 0; j < 3; j++) {
arr[i][j] = k;
k++;
}
}

console.log(arr);

/////////////////////////175.13

let arr = [];

for (let i = 0, k = 1; i < 3; i++) {
arr[i] = [];

for (let j = 0; j < 3; j++) {
arr[i][j] = k++;
}
}

console.log(arr);

////////////////////176.1

let obj = {
    key1: {
    key1: 1,
    key2: 2,
    key3: 3,
    },
    key2: {
    key1: 4,
    key2: 5,
    key3: 6,
    },
    key3: {
    key1: 7,
    key2: 8,
    key3: 9,
    },
    }
    console.log(obj.key1.key1 + obj.key1.key2 + obj.key1.key3 + obj.key2.key1 + obj.key2.key2 + obj.key2.key3 + obj.key3.key1 + obj.key3.key2 + obj.key3.key3);
    
    ////////////////////176.2

    let obj = {
    1: {
    1: 'a1',
    2: 'a2',
    3: 'a3',
    },
    2: {
    1: 'b1',
    2: 'b2',
    3: 'b3',
    },
    3: {
    1: 'c1',
    2: 'c2',
    3: 'c3',
    },
    }
    console.log(obj[2][2]);
    console.log(obj[3][1]);
    
    ////////////////176.3

    let obj = {
    key1: {
    a: 1, b: 2, c: {
    d: 3,
    e: 4,
    }, f: 5,
    },
    key2: {
    g: 6, h: 7,
    },
    }
    console.log(obj.key1.a + obj.key1.b + obj.key1.c.d + obj.key1.c.e + obj.key1.f + obj.key2.g + obj.key2.h);
    
    //////////////////177.1

    let obj = {
    1: {
    1: 11,
    2: 12,
    3: 13,
    },
    2: {
    1: 21,
    2: 22,
    3: 23,
    },
    3: {
    1: 24,
    2: 25,
    3: 26,
    },
    }
    let res = 0;
    for (let key in obj) {
        let subObj = obj[key];
    
    for (let subKey in subObj) {
        res += subObj[subKey];
    
    }
    }
    console.log(res);
    
    ////////////177.2

    let obj = {
    1: {
    1: {
    1: 111,
    2: 112,
    3: 113,
    },
    2: {
    1: 121,
    2: 122,
    3: 123,
    },
    },
    2: {
    1: {
    1: 211,
    2: 212,
    3: 213,
    },
    2: {
    1: 221,
    2: 222,
    3: 223,
    },
    },
    3: {
    1: {
    1: 311,
    2: 312,
    3: 313,
    },
    2: {
    1: 321,
    2: 322,
    3: 323,
    },
    },
    }
    let res = 0;
        for (let key in obj) {
            let subObj = obj[key];
        for (let subKey in subObj) {
            let subsubObj = subObj[subKey];
        for (let subsubKey in subsubObj){
            res += subsubObj[subsubKey];
    }
    }
    }console.log(res);
    
    ///////////////178.1

    let students = {
    'group1': ['name11', 'name12', 'name13'],
    'group2': ['name21', 'name22', 'name23'],
    'group3': ['name31', 'name32', 'name33'],
    };
    console.log(students['group3'][0]);
    
    ////////////////////179.1

    let data = {
    1: [
    'data11',
    'data12',
    'data13',
    ],
    2: [
    'data21',
    'data22',
    'data23',
    ],
    3: [
    'data31',
    'data32',
    'data33',
    ],
    4: [
    'data41',
    'data42',
    'data43',
    ],
    };
    for (let date in data) {
        for (let count of data[date]) {
            console.log(count);
        }
    }

/////////////////179.2

    let data = [
        {
        1: 'data11',
        2: 'data12',
        3: 'data13',
        },
        {
        1: 'data21',
        2: 'data22',
        3: 'data33',
        },
        {
        1: 'data31',
        2: 'data32',
        3: 'data33',
        },
        ];
        for (let elem of data) {
            for (let res in elem) {
                console.log(elem[res]);
        }
        }

//////////////179.3

let data = [
	{
		1: [
			'data111',
			'data112',
			'data113',
		],
		2: [
			'data121',
			'data122',
			'data123',
		],
	},
	{
		1: [
			'data211',
			'data212',
			'data213',
		],
		2: [
			'data221',
			'data222',
			'data223',
		],
	},
	{
		1: [
			'data411',
			'data412',
			'data413',
		],
		2: [
			'data421',
			'data422',
			'data423',
		],
	},
];

for (let elem of data) {
    for (let res in elem) {
        console.log(String(elem[res]));
}
}

//////////180.1

let employees = [
	{
		name: 'name1',
		salary: 300,
	},
	{
		name: 'name2',
		salary: 400,
	},
	{
		name: 'name3',
		salary: 500,
	},
];

for (let elem of employees){
    console.log(elem.name + ' - ' + elem.salary)
}

////////////////180.2

let employees = [
	{
		name: 'name1',
		salary: 300,
	},
	{
		name: 'name2',
		salary: 400,
	},
	{
		name: 'name3',
		salary: 500,
	},
];
let sum = 0;
    for (let elem of employees){
        sum += elem.salary;
        
} console.log(sum)

/////////////180.3

let employees = [
	{
		name: 'name1',
		salary: 300,
		age: 28,
	},
	{
		name: 'name2',
		salary: 400,
		age: 29,
	},
	{
		name: 'name3',
		salary: 500,
		age: 30,
	},
	{
		name: 'name4',
		salary: 600,
		age: 31,
	},
	{
		name: 'name5',
		salary: 700,
		age: 32,
	},
];

let sum = 0;
    for (let elem of employees){
        if (elem.age >= 30){
           sum += elem.salary; 
        } 
} console.log(sum)

/////////////181.1

let months = {
	'ru': [
		'январь',
		'февраль',
		'март',
		'апрель',
		'май',
		'июнь',
		'июль',
		'август',
		'сентябрь',
		'октябрь',
		'ноябрь',
		'декабрь',
	],
	'en': [
		'january',
		'february',
		'march',
		'april',
		'may',
		'june',
		'july',
		'august',
		'september',
		'october',
		'november',
		'december',
	],
};
let lang = 'ru'; 
let month = 5;
console.log(months['ru'][5])

/////////////////181.2

let affairs = {
	'2018': {
		11: {
			29: ['дело111', 'дело112', 'дело113'],
			30: ['дело121', 'дело122', 'дело123'],
		},
		12: {
			30: ['дело211', 'дело212', 'дело213'],
			31: ['дело221', 'дело222', 'дело223'],
		},
	},
	'2019': {
		12: {
			29: ['дело311', 'дело312', 'дело313'],
			30: ['дело321', 'дело322', 'дело323'],
			31: ['дело331', 'дело332', 'дело333'],
		}
	},
}
let year = '2018';
let month = 11;
let day = 29;
console.log(affairs[year][month][day])

/////////////////181.3

let obj = {
    key1: {
    key2: '12',
    key3: '13',
    },
    key2: {
    key4: '24',
    key5: '25',
    },
    }
    
    let key1 = 'key2';
    let key2 = 'key4';
    console.log(obj[key1][key2]);

/////////////181.4

let obj = {
    key1: {
    key2: '12',
    key3: '13',
    },
    key2: {
    key4: '24',
    key5: '25',
    },
    }
    
    let key1 = 'key2';
    let key2 = 'key4';
    console.log(obj[key1][key2]);

///////////////181.5

let obj = {
    key1: {
    key2: '12',
    key3: '13',
    },
    key2: {
    key4: '24',
    key5: '25',
    },
    }
    
    let key1 = 'key2';
    let key2 = 'key4';
    console.log(obj[key1][key2]);

////////////////181.6

let obj = {
    key1: {
    key2: '12',
    key3: '13',
    },
    key2: {
    key4: '24',
    key5: '25',
    },
    }
    
    let key1 = 'key2';
    let key2 = 'key4';
    console.log(obj[key1][key2]);

/////////////182.1

let employees = [
	{
		name: 'name1',
		salary: 300,
		age: 28,
	},
	{
		name: 'name2',
		salary: 400,
		age: 29,
	},
	{
		name: 'name3',
		salary: 500,
		age: 30,
	},
];
employees.push({
	name: 'name4',
	salary: 500,
	age: 30,
});

/////////////183.1-3

let affairs = {
	'2019-12-28': ['data11', 'data12', 'data13'],
	'2019-12-29': ['data21', 'data22', 'data23'],
	'2019-12-30': ['data31', 'data32', 'data33'],
}
affairs['2019-12-29'].push('data24');
affairs['2019-12-30'].push('data34');
affairs['2019-12-30'].push('data35');
console.log(affairs)

////////////183.4-7

let students = {
	'group1': {
		'subgroup11': ['student111', 'student112', 'student113'],
		'subgroup12': ['student121', 'student122', 'student123'],
	},
	'group2': {
		'subgroup21': ['student211', 'student212', 'student213'],
		'subgroup22': ['student221', 'student222', 'student223'],
	},
	'group3': {
		'subgroup31': ['student311', 'student312', 'student313'],
		'subgroup32': ['student321', 'student322', 'student323'],
	},
};
students.group1.subgroup11.push('student114');
students.group1.subgroup13 = [];
students.group4 = [];
students.group4.subgroup41 = [];
students.group4.subgroup41.push('student411');
console.log(students)