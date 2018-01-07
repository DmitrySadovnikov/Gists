var fs = require('fs');

// 3-й это колбэк в случае ошибки или по завершению работы с файлом можно сюда что-то добавить
fs.appendFile('hello.txt', '\nSome more content', function(err) { 

});

// Promise – это специальный объект, который содержит своё состояние. Вначале pending («ожидание»), 
// затем – одно из: fulfilled («выполнено успешно») или rejected («выполнено с ошибкой»).
// ПРОМИСЫ нужны для ассинхронной работы


// MVC
// app.js
const express = require('express');
const app = express();

app.get('/', (req, res)) => {
  res.send('Hello');
  res.sendFile(__dirname + '/public/index.html');
})

app.listen(3000);

// package.json
{
    "name": 'lol',
    "version": '1.0.0',
    "main": "app.js",
    "license": "MIT",
    "scripts": {
      "start": "node app.js"
  },
    "dependencies": {
      "express": "^.4.16.2"
  }
}

// index.html
<button onclick="contactServer()">Click here</button>
<script>
  function contactServer() {
    var xttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById("response").innerHTML = this.responseText;
      }
    };
    xhttp.open("GET", "ajax_info.txt", true);
    xhttp.send();
  }
</script>

// npm install -g ethereumjs-testrpc
// testrpc
// yarn start

