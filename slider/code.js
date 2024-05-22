//37 
let div = document.getElementById('slider');
let texts = ['text1', 'text2', 'text3'];
let index = 0;
let timerId = setInterval(function(){
    div.textContent = texts[index];
    index = (index + 1) % texts.length;
}, 1000);

//38 
let left = document.getElementById('left');
let right = document.getElementById('right');
let div = document.getElementById('slider');
let texts = ['text1', 'text2', 'text3'];
let i = 0; 

left.addEventListener('click', function(event) {
    event.preventDefault();
    i = (i - 1 + texts.length) % texts.length;
    div.textContent = texts[i];
});
right.addEventListener('click', function(event) {
    event.preventDefault();
    i = (i + 1) % texts.length;
    div.textContent = texts[i];
});

//38.2
let left = document.getElementById('left');
let right = document.getElementById('right');
let div = document.getElementById('slider');
let texts = ['text1', 'text2', 'text3'];
let i = 0; 

left.addEventListener('click', function(event) {
    event.preventDefault();
    if (i > 0) {
        i--;
        div.textContent = texts[i];
    }
});

right.addEventListener('click', function(event) {
    event.preventDefault();
    if (i < texts.length - 1) {
        i++;
        div.textContent = texts[i];
    }
});

//39
let elem = document.getElementById('slider');
let texts = ['1.jpg', '2.jpg', '3.jpg'];
let index = 0;

let timerId = setInterval (function(){
    elem.src = texts[index];
    index = (index + 1) % texts.length;
}, 1000)

//39.2
let left = document.getElementById('left');
let right = document.getElementById('right');
let elem = document.getElementById('slider');
let texts = ['1.jpg', '2.jpg', '3.jpg'];
let index = 0;

let timerId = setInterval (function(){
    elem.src = texts[index];
    index = (index + 1) % texts.length;
}, 1000)


left.addEventListener('click', function(event) {
    event.preventDefault();
    index = (index - 1 + texts.length) % texts.length;
    elem.src = texts[index];
});
right.addEventListener('click', function(event) {
    event.preventDefault();
    index = (index + 1) % texts.length;
    elem.src = texts[index];
});

//40
let images = document.querySelectorAll('#slider img');
let index = 0;
function show(index) {
    for (let i = 0; i < images.length; i++) {
        images[i].style.display = 'none';
    }
    images[index].style.display = 'block';
}
function next() {
    index = (index + 1) % images.length;
    show(index);
}
show(index);
let timerId = setInterval(next, 1000);

