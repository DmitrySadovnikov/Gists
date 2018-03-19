//// class
class Names {
  constructor (names) {
    this.names = names;
  }

  contains(names) {
    return names.every((name) => this.names.indexOf(name) !== -1);
  }

  getMessage(message) {
    var result = '';

    for(var i = 0; i < this.names.length; i++) {
      result += this.names[i] + ' - ' + message + ', ';
    }

    return result;
  }
}

var countries = new Names(['UK', 'Italy', 'Germany', 'France']);
countries.contains(['UK', 'Germany']); // => true
countries.contains(['USA', 'Italy']);  // => false
countries.getMessage('country'); // UK - country, Italy - country, Germany - country, France - country,
////
function Person(firstName, lastName){
  // constructor
  this.firstName = firstName;
  this.lastName  = lastName;
}
////

//// 1 Function declaration: starts with "function"
function isNil(value) {
  return value == null;
}
////

//// 2 Function expression: starts with "var"
var isTruthy = function(value) {
  return !!value;
};

//// Function expression (IIFE): starts with "("
(function messageFunction(message) {
  return message + ' World!';
})('Hello');
////

//// 3 Shorthand method definition
var collection = {
  items: [],
  add(...items) { this.items.push(...items) },
  get(index)    { return this.items[index] }
};

collection.add('C', 'Java', 'PHP');
console.log(collection.get(1)); // => 'Java'

//// 3.1 Computed property names and methods (Metaprogramming)
var addMethod = 'add',
    getMethod = 'get';

var collection = {
  items: [],
  [addMethod](...items) { this.items.push(...items) },
  [getMethod](index)    { return this.items[index] }
};

collection[addMethod]('C', 'Java', 'PHP');
collection[getMethod](1) // => 'Java'
////

//// 4 Arrow function
var absValue = (number) => {
  if (number < 0) { return -number }
  return number;
}
absValue(-10); // => 10
absValue(5);   // => 5
////

//// 5. Generator function
// a. Function declaration form function* <name>():
function* indexGenerator(){
  var index = 0;
  while(true) {
    yield index++;
  }
}
var g = indexGenerator();
console.log(g.next().value); // => 0
console.log(g.next().value); // => 1

// b. Function expression form function* ():
var indexGenerator = function* () {
  var index = 0;
  while(true) {
    yield index++;
  }
};

// c. Shorthand method definition form *<name>():
var obj = {
  *indexGenerator() {
    var index = 0;
    while(true) {
      yield index++;
    }
  }
}
////

//// new Function (Metaprogramming)
var numberA = 'numberA',
    numberB = 'numberB';

var sumFunction = new Function(numberA, numberB, 'return numberA + numberB');
sumFunction(10, 15) // => 25
////


//// Comparison
  [10] ==   10    // is true
  [10] ===  10    // is false
  '10' ==   10    // is true
  '10' ===  10    // is false
  []   ==   0     // is true
  []   ===  0     // is false
  ''   ==   false // is true but true == "a" is false
  ''   ===  false // is false
  undefined, null, 0, false, NaN, '' // = false
////


// Arrays
arr = new Array;
arr = []
/////////



// Methods
prompt('What is you nane')     // ask user
confirm("I am ready to play!") // yes no
"Batman".substring(0, 3)       // Bat
[1, false, 5].filter(function(item) { return typeof item === 'number' }) // => [ 1, 5 ]
[1, 5, 10, 0].some(item => item === 0); // => true

///
typeof someObject;      // => "object"
typeof 43;              // => "number"
typeof 'aString';       // => "string"
typeof Object.prototype // => "object"

var arr = ["a", "b", "c"];
typeof arr;                // => "object"
arr instanceof Array       // => true

///
myObj.hasOwnProperty('name') // true or false
Object.prototype.hasOwnProperty('hasOwnProperty')

2.443242342.toFixed(4);                    // => 2.4432
(0.1 + 0.2) === 0.3                        // => false
(0.1 + 0.2).toFixed(1) === 0.3.toFixed(1); // => true

var from = 2;
[1,2,3,4,5].splice(from, 2) // => [ 3, 4 ]

'AAA'.toLowerCase();
'aaa'.toUpperCase();
"js - is lang".replace(/js/gi, 'JavaScript');            // => JavaScript is lang
' \r   \n   the string be with you   \v \f     '.trim()  // => the string be with you
'Super Powerful Slicing Ability'.charAt(0);              // => S
'50 plus 50 equals 100!'.match(/\d+/g);                  // => ["50", "50", "100"]
'one'.concat('two', 'three', 'four');                    // => onetwothreefour
'supercalifragilisticexpialidocious'.substr(0, 5)        // => super
'a.b'.split('.')                                         // => ["a", "b"]
new String('Jumping Jack Flash').valueOf();              // => Jumping Jack Flash
'The Force Is With Us!'.slice(0, 19)                     // => The Force Is With U
'gmail@google.com'.indexOf('@');                         //=> 5
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


//// Self-calling Function
(function(){
  // some private code that will be executed automatically
})();
(function(a, b){
  var result = a + b;
  return result;
})(10,20)
////


//// Get a random item from an array\
var items = [12, 548 , 'a' , 2 , 5478 , 'foo' , 8852, 'Doe' , 2145 , 119];
items[Math.floor(Math.random() * items.length)];
////


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
