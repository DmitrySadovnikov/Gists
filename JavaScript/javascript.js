/// AJAX ///
var btn = document.getElementById("btn");

btn.addEventListener("click", function () {
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://randomword.setgetgo.com/get.php');
    ourRequest.onload  = function () {
        if (ourRequest.status >= 200 && ourRequest.status < 400) {
            var ourData = JSON.parse(ourRequest.responseText);
            renderHTML(ourData);
        } else {
            console.log("Server Error");
        }
        document.getElementById('word').innerHTML               = ourData;
        document.getElementsByClassName('background').innerHTML = "https://source.unsplash.com/category/buildings/1600x900";
    };
    ourRequest.onerror = function () {
        console.log("Connection error");
    };
    ourRequest.send();
});

////set timeout / interval /////
setInterval(function () {
    alert("прошла секунда")
}, 1000)
// => прошла секунда
// => прошла секунда
setTimeout(function () {
    alert("World")
}, 1000)
alert("Hello")
// => Hello асинхронность!
// => World
////////////////////////



// Arrays
arr = new Array;
arr = []
/////////



// Methods
prompt('What is you nane')     // ask user
confirm("I am ready to play!") // yes no
"Batman".substring(0, 3)       // Bat
///
typeof someObject;      // should print "object"
typeof 43;              // should print "number"
typeof 'aString';       // should print "string"
typeof Object.prototype // object
///
myObj.hasOwnProperty('name') // true or false
Object.prototype.hasOwnProperty('hasOwnProperty')
/////////



// case
var cashRegister = {
  total: 0,
  add(itemCost) {
    this.total += itemCost
    this.lastTransactionAmount = itemCost
  },
  scan(item, quantity) {
    switch (item) {
      case 'eggs': {
        this.add(0.98 * quantity)
        break
      }
      case 'milk': {
        this.add(1.23 * quantity)
        break
      }
      case 'magazine': {
        this.add(4.99 * quantity)
        break
      }
      case 'chocolate': {
        this.add(0.45 * quantity)
        break
      }
    }
    return true
  },
  voidLastTransaction() {
    this.total = this.total - this.lastTransactionAmount
  }
}
/////////



// Loops
for (var counter = 1; counter < 6; counter++) {
    console.log(counter);
}
///
while (coinFace === 0) {
    var coinFace = Math.floor(Math.random() * 2);
}
///
var nyc = {
    fullName: "New York City",
    mayor: "Bill de Blasio",
    population: 8000000,
    boroughs: 5
};
for(var prop_key in nyc) {
    console.log(prop_key)       // fullName, ...
    console.log(nyc[prop_key]); // "New York City", ...
}
///
var loopCondition = false;
do {
    console.log("I'm gonna stop looping 'cause my condition is " + loopCondition + "!");
} while (loopCondition);
/////////



// OBJECTS
var me  = {};
me.name = 'sd';
me.age  = 2000;
///
var me     = new Object();
me['name'] = 'allah';
me['age']  = 2000;
///
var myObject = {
    name: 'Eduardo',
    type: 'Most excellent',
};
myObject.type = 'Example';
///
function Person(name, age) {
    this.name = name;
    this.age  = age;
}
var bob = new Person("Bob Smith", 30);
///
var setAge = function (newAge) {
    this.age = newAge;
};
var bob    = new Object(); // now we make bob
bob.age    = 30;

bob.setAge = setAge; // Bob has method now
bob.setAge(50);
///
var buddy = new Dog("golden Retriever");
Dog.prototype.bark = function() { // This immediately teaches all Dogs the new method.
  console.log("Woof");
};
buddy.bark();
/////////



// inheritance
function Animal(name, numLegs) {
    this.name    = name;
    this.numLegs = numLegs;
    var bankBalance = 7500; // private variable

    this.getBalance = function() {
        return bankBalance;
    };
}
Animal.prototype.sayName = function () {
    console.log("Hi my name is " + this.name);
};

function Penguin(name) {
    this.name    = name;
    this.numLegs = 2;
}

Penguin.prototype = new Animal();

penguin = new Penguin('John');
penguin.sayName(); // => "Hi my name is John

function Emperor(name) {
    this.name = name;
}

Emperor.prototype = new Penguin();

emperor = new Emperor('John')
console.log(emperor.numLegs) // => 2
///
function Person() {
    var bankBalance = 7500;

    var returnBalance = function () {
        return bankBalance; // It returns a variable
    };

    this.askTeller = function () {
        return returnBalance; // It returns a METHOD itself, not a RESULT of function (parentheses do NOT needed)
    }
}

// Если функция возвращает другую функцию,           то скобки НЕ нужны
// Если функция возвращает результат другой функции, то скобки нужны

var john            = new Person();
var myBalanceMethod = john.askTeller(); // returns result of function (parentheses needed)
var myBalance       = myBalanceMethod();

console.log(myBalance);
/////////


// Methods
function Circle(radius) {
    this.radius = radius;
    // method
    this.area   = function () {
        return Math.PI * this.radius * this.radius;
    };
};
///
var james = {
    job:     "programmer",
    married: false,
    // method
    speak:   function (arg) {
        console.log("Hello, I am feeling " + arg);
    },
    sayJob: function() {
        console.log("Hi, I work as a " + this.job);
    }
};
james.speak("great"); // => Hello, I am feeling great
james.sayJob();       // => "Hi, I work as a programmer"
//////
