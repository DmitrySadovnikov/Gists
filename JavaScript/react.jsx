// setup
// npm install -g create-react-app
// create-react-app react-todo

//npm i --save react
//npm i -S react-dom
//npm install --save-dev babel-core (npm install -D babel-core)
//npm install --save-dev babel-core babel-loader babel-preset-react (npm i -D babel-{core,loader} babel-preset-react)

//.babelrc
{ presets: ['react'] }

//npm i -D webpack webpack-dev-server html-webpack-plugin

//webpack.config.js
var HTMLWebpackPlugin = require('html-webpack-plugin');
var HTMLWebpackPluginConfig = new HTMLWebpackPlugin({
  template: __dirname + '/app/index.html',
  filename: 'index.html',
  inject: 'body'
});

module.exports = {
  entry: __dirname + '/app/index.js',
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      }
    ]
  },
  output: {
    filename: 'transformed.js', //This will save your transformed JavaScript into a new file named build/transformed.js.
    path: __dirname + '/build'
  },
  plugins: [HTMLWebpackPluginConfig]
};

//package.json
scripts: {
  deploy: "npm run build && npm run git-commit && npm run git-push", //after that use on console npm run deploy
  build: "webpack",
  start: "webpack-dev-server"
}

////








//
export default class Filter extends React.PureComponent {
}





/// module export

var NavBar     = require('./NavBar'); // main file
module.exports = NavBar; // export file

/// jsx ///
var Pistons2004 = {
  center:        <li>Ben Wallace</li>,
  powerForward:  <li>Rasheed Wallace</li>,
  smallForward:  <li>Tayshaun Prince</li>,
  shootingGuard: <li>Richard Hamilton</li>,
  pointGuard:    <li>Chauncey Billups</li>,
};

var panda = <img src="images/panda.jpg" alt="panda" width="500px" height="500px"/>;

/// className
var React    = require('react');
var ReactDOM = require('react-dom');

var myDiv = (<div className='big'>
  I AM A BIG DIV
</div>);

ReactDOM.render(myDiv, document.getElementById('app'));

/// Put Variable
ReactDOM.render(
  <h1>{2 + 3}</h1>,
  document.getElementById('app'),
);

/// functions
function makeDoggy(e) {
  // Call this extremely useful function on an <img>.
  // The <img> will become a picture of a doggy.
  e.target.setAttribute('src', 'https://s3.amazonaws.com/codecademy-content/courses/React/react_photo-puppy.jpeg');
  e.target.setAttribute('alt', 'doggy');
}

var kitty = (
  <img
    src="https://s3.amazonaws.com/codecademy-content/courses/React/react_photo-kitty.jpg"
    alt="kitty" onClick={makeDoggy}/>
);
ReactDOM.render(kitty, document.getElementById('app'));

/// Conditions
if (user.age >= drinkingAge) {
  var message = (
    <h1>
      Hey, check out this alcoholic beverage!
    </h1>
  );
} else {
  var message = (
    <h1>
      Hey, check out these earrings I got at Claire's!
    </h1>
  );
}
///
var pics = {
  kitty: 'https://s3.amazonaws.com/codecademy-content/courses/React/react_photo-kitty.jpg',
  doggy: 'https://s3.amazonaws.com/codecademy-content/courses/React/react_photo-puppy.jpeg',
};

var img           = <img src={pics[coinToss() === 'heads' ? 'kitty' : 'doggy']}/>;
///
var judgmental    = Math.random() < 0.5;
// если true то добавится новый li
var favoriteFoods = (
  <div>
    <h1>My Favorite Foods</h1>
    <ul>
      <li>Sushi Burrito</li>
      <li>Rhubarb Pie</li>
      { !judgmental && <li>Nacho Cheez Straight Out The Jar</li> }
      <li>Broiled Grapefruit</li>
    </ul>
  </div>
);

/// Iteration
var people = ['Rowe', 'Prevost', 'Gare'];

var peopleLIs = people.map(function (person, i) {
  // return statement goes here:
  return <li key={'person_' + i}>{person}</li>;
});

// ReactDOM.render goes here:
ReactDOM.render(<ul>{peopleLIs}</ul>, document.getElementById('app'));

/// Create Element
var greatestDivEver = React.createElement(
  'div',
  null,
  'i am div',
);
///
var MyName          = React.createClass({
  // name property goes here:
  name: 'whatever-your-name-is-goes-here',

  render: function () {
    return <h1>My name is {this.name}.</h1>;
  },
});
///
var Button          = React.createClass({
  scream: function () {
    alert('AAAAAAAAHHH!!!!!');
  },

  render: function () {
    return <button onClick={this.scream}>AAAAAH!</button>;
  },
});
///
var NavBar          = React.createClass({
  render: function () {
    var pages    = ['home', 'blog', 'pics', 'bio', 'art', 'shop', 'about', 'contact'];
    var navLinks = pages.map(function (page) {
      return (
        <a href={'/' + page}>
          {page}
        </a>
      );
    });

    return <nav>{navLinks}</nav>;
  },
});

/// Components
var React    = require('react');
var ReactDOM = require('react-dom');

var MyComponentClass = React.createClass({
  render: function () {
    return <h1>Hello world</h1>;
  },
});

ReactDOM.render(
  <MyComponentClass />,
  document.getElementById('app'),
);

///

//////////

/// Properties ///
var React    = require('react');
var ReactDOM = require('react-dom');

var PropsDisplayer = React.createClass({
  render: function () {
    var stringProps = JSON.stringify(this.props);

    return (
      <div>
        <h1>CHECK OUT MY PROPS OBJECT</h1>
        <h2>{stringProps}</h2>
      </div>
    );
  },
});

ReactDOM.render(
  <PropsDisplayer myProp="Hello"/>,
  document.getElementById('app'),
);

// => { myProp: "Hello" }

//////////
// берем проперти из <PropsDisplayer myProp="Hello"/>
var Greeting = React.createClass({
  render: function () {
    return <h1>Hi there, {this.props.firstName}!</h1>;
  },
});

ReactDOM.render(
  <Greeting firstName='Roberta'/>,
  document.getElementById('app'),
);

//=> "Hi there, Roberta"
///////////

//// render component from main
// in Greetings.js
var Greeting   = React.createClass({
  render: function () {
    return <h1>Hi there, {this.props.name}!</h1>;
  },
});
module.exports = Greeting;
// in App.js
var Greeting   = require('./Greeting');
var App        = React.createClass({
  render: function () {
    return (
      <div>
        <h1>
          Hullo and, "Welcome to The Newzz," "On Line!"
        </h1>
        <Greeting name="Dima" signedIn={false}/>
        <article>
          Latest newzz: where is my phone?
        </article>
      </div>
    );
  },
});

//// methods
var Talker = React.createClass({
  talk: function () {
    for (var speech = '', i = 0; i < 10000; i++) {
      speech += 'blah ';
    }
    alert(speech);
  },

  render: function () {
    return <Button onClick={this.onClick}/>;
  },
});


//event
var Button = React.createClass({
  render: function () {
    return (
      <button onHover={this.props.onHover} onClick={this.props.onClick}>
        Click me!
      </button>
    );
  }
});

// convention
React.createClass({
  hendleClick:    function () {
    alert('I am an event handler.');
    alert('I will be called in response to "click" events.');
  },
  handleKeyPress: function () {
    alert('I am an event handler.');
    alert('I will be called in response to "keypass" events.');
  },
  handleHover:    function () {
    alert('I am an event handler.');
    alert('I will be called in response to "hover" events.');
  },
  render:         function () {
    return <Child onClick={this.hendleClick}/>;
    return <Child onKeyPass={this.handleKeyPress}/>;
    return <Child onHover={this.handleHover}/>;
  },
});

// children

this.props.children;

// Example 1
// <BigButton>
//   I am a child of BigButton.
// </BigButton>
//
// Example 2
// <BigButton>
//   <LilButton />
// </BigButton>
//
// Example 3
//<BigButton /> this.props.children == undefined

// pluralize
var List = React.createClass({
  render: function () {
    var titleText = 'Favorite ' + this.props.type;
    if (this.props.children instanceof Array) {
      titleText += 's';
    }
    return (
      <div>
        <h1>{titleText}</h1>
        <ul>{this.props.children}</ul>
      </div>
    );
  },
});

// default props if current props are blank
var Example = React.createClass({
  getDefaultProps: function () {
    return { text: 'yo' };
  },

  render: function () {
    return <h1>{this.props.text}</h1>;
  }
});

ReactDOM.render(
  <Button text='Override default prop' />,
  document.getElementById('app')
);


//// State
var TodayImFeeling = React.createClass({
  getInitialState: function () {
    return { mood: 'decent' };
  },

  render: function(){
    return (
      <h1>
        I'm feeling {this.state.mood}!
      </h1>
    );
  }
});

<TodayImFeeling />
//
var Example = React.createClass({
  getInitialState: function () {
    return { weather: 'sunny' };
  },

  // override state
  makeSomeFog: function () {
    this.setState({
      weather: 'foggy'
    });
  }
});
//
var Mood = React.createClass({
  getInitialState: function () {
    return {
      mood: 'good'
    };
  },

  toggleMood: function () {
    var newMood = this.state.mood == 'good' ? 'bad' : 'good';
    this.setState({ mood: newMood });
  },

  render: function () {
    return (
      <div style={{background: this.state.color}}>
        <h1>I'm feeling {this.state.mood}!</h1>
        <button onClick={this.toggleMood}>
          Click Me
        </button>
      </div>
    );
  }
});
// toggle color
var Toggle = React.createClass({
  getInitialState: function () {
    return { color: green };
  },
  changeColor: function() {
    var newColor = this.state.color == green ? yellow : green;
    this.setState({ color: newColor });
  },
  render: function () {
    return (
      <div style={{background: this.state.color}}>
        <h1>
          Change my color
        </h1>
        <button onClick={this.changeColor}>
          Change color
        </button>
      </div>
    );
  }
});
///



// PART 2


/// stateful component class

// Parent.js
import React from 'react';
import ReactDOM from 'react-dom';
import { Child } from './Child';

import React from 'react';
import ReactDOM from 'react-dom';
import { Child } from './Child';

class Parent extends React.Component {
  constructor(props) {
    super(props);

    this.state = { name: 'Frarthur' };

    this.changeName = this.changeName.bind(this); //меняет ия родителя
  }

  changeName(newName) {
    this.setState({
      name: newName
    });
  }

  render() {
    return <Child name={this.state.name} onChange={this.changeName} />
  }
}

ReactDOM.render(
  <Parent />,
  document.getElementById('app')
);


// Child.js
import React from 'react';

export class Child extends React.Component {
  constructor(props) {
    super(props);

    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(e) {
    const name = e.target.value;
    this.props.onChange(name);
  }

  render() {
    return (
      <div>
        <h1>
          Hey my name is {this.props.name}!
        </h1>
        <select id="great-names" onChange={this.handleChange}>
          <option value="Frarthur">
            Frarthur
          </option>

          <option value="Gromulus">
            Gromulus
          </option>

          <option value="Thinkpiece">
            Thinkpiece
          </option>
        </select>
      </div>
    );
  }
}
///
import React from 'react';

export class Child extends React.Component {
  render() {
    return (
      <div>
        <select id="great-names" onChange={this.props.onChange} > //
          <option value="Frarthur">
            Frarthur
          </option>

          <option value="Gromulus">
            Gromulus
          </option>

          <option value="Thinkpiece">
            Thinkpiece
          </option>
        </select>
      </div>
    );
  }
}
///////////////
// Parent.js
import React from 'react';
import ReactDOM from 'react-dom';
import { Child } from './Child';
import { Sibling } from './Sibling';

class Parent extends React.Component {
  constructor(props) {
    super(props);

    this.state = { name: 'Frarthur' };

    this.changeName = this.changeName.bind(this);
  }

  changeName(newName) {
    this.setState({
      name: newName
    });
  }

  render() {
    return (
      <div>
        <Child
          onChange={this.changeName} />
        <Sibling name={this.state.name}/>
      </div>
    );
  }
}

ReactDOM.render(
  <Parent />,
  document.getElementById('app')
);


// Child.js
import React from 'react';

export class Child extends React.Component {
  constructor(props) {
    super(props);

    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(e) {
    const name = e.target.value;
    this.props.onChange(name);
  }

  render() {
    return (
      <div>
        <select
          id="great-names"
          onChange={this.handleChange}>

          <option value="Frarthur">Frarthur</option>
          <option value="Gromulus">Gromulus</option>
          <option value="Thinkpiece">Thinkpiece</option>
        </select>
      </div>
    );
  }
}


// Siblings.js
import React from 'react';

export class Sibling extends React.Component {
  render() {
    let name = this.props.name;

    return (
      <div>
        <h1>Hey, my name is {name}!</h1>
        <h2>Don't you think {name} is the prettiest name ever?</h2>
        <h2>Sure am glad that my parents picked {name}!</h2>
      </div>
    );
  }
}



////style

import React from 'react';
import ReactDOM from 'react-dom';

const styleMe = <h1 style={{ background: 'lightblue', color: 'darkred' }}>Please style me! I am so bland!</h1>;

ReactDOM.render(
  styleMe,
  document.getElementById('app')
);

//
import React from 'react';
import ReactDOM from 'react-dom';

const styles = {
  marginTop:       "20px", // CamelCase
  marginTop:       20,     // Without PX
  backgroundColor: "green"
};
const styleMe = <h1 style={styles}>Please style me! I am so bland!</h1>;

////
// facebook color palette
const blue      = 'rgb(139, 157, 195)';
const darkBlue  = 'rgb(059, 089, 152)';
const lightBlue = 'rgb(223, 227, 238)';
const grey      = 'rgb(247, 247, 247)';
const white     = 'rgb(255, 255, 255)';

export const colorStyles = {
  blue:      blue,
  darkBlue:  darkBlue,
  lightBlue: lightBlue,
  grey:      grey,
  white:     white,
};

// in main file
import { styles } from './styles';
const divStyle = {
  background: styles.background,
  height:     '100%'
};
export class Home extends React.Component {
  render() {
    return (
      <div style={divStyle}>
        <AttentionGrabber />
        <footer>THANK YOU FOR VISITING MY HOMEPAGE!</footer>
      </div>
    );
  }
}
////



//// Stateless Functional Components
// GuineaPigs.js
import React from 'react';

export class GuineaPigs extends React.Component {
  render() {
    let src = this.props.src;
    return (
      <div>
        <h1>Cute Guinea Pigs</h1>
        <img src={src} />
      </div>
    );
  }
}

// Friends.js
import React from 'react';
import ReactDOM from 'react-dom';


export const Friend = () => {// OR  export class Friend extends React.Component {
  render(){
    return <img src='https://s3.amazonaws.com/codecademy-content/courses/React/react_photo-octopus.jpg' />;
  }
}

ReactDOM.render(
  <Friend />,
  document.getElementById('app')
);
////




// PropTypes
render() {
  return <h1>{this.props.message}</h1>;
}
MessageDisplayer.propTypes = {
  message: React.PropTypes.string
};
// prototypes usual way
class Example extends React.component{
}
Example.propTypes = {

};
// prototypes functional way
const Example = (props) => {
  return <h1>{props.message}</h1>;
}

Example.propTypes = {
  message: React.PropTypes.string.isRequired
};
// example - change text from h1 to input text
import React from 'react';
import ReactDOM from 'react-dom';

export class Input extends React.Component {
  constructor(props) {
    super(props);

    this.state = { userInput: '' };

    this.handleUserInput = this.handleUserInput.bind(this);
  }
  render() {
    return (
      <div>
        <input value={this.state.userInput} onChange={this.handleUserInput} type="text"/>
        <h1>{this.state.userInput}</h1>
      </div>
    );
  }
  handleUserInput(e) {
    this.setState({
      userInput: e.target.value
    });
  }
}


ReactDOM.render(
  <Input />,
  document.getElementById('app')
);
////



// querySelector
let input = document.querySelector('input[type="text"]');
let typedText = input.value; // input.value will be equal to whatever text is currently in the text box.
////











/////  Lifecycle Methods
// There are three categories of lifecycle methods: mounting, updating, and unmounting

// There are three MOUNTING lifecycle methods:
// componentWillMount
// render
// componentDidMount

// example
import React from 'react';
import ReactDOM from 'react-dom';

export class Example2 extends React.Component {
  constructor(props) {
    super(props);

    this.state = { text: '' };
  }

  componentWillMount() {
    this.setState({ text: 'Hello world' });
  }

  render() {
    return <h1>{this.state.text}</h1>;
  }
}

ReactDOM.render(
  <Example2 />,
  document.getElementById('app')
);
// example
import React from 'react';
import ReactDOM from 'react-dom';

export class Example extends React.Component {
  componentWillMount() {
    alert('component is about to mount!');
  }

  render() {
    return <h1>Hello world</h1>;
  }
}

ReactDOM.render(
  <Example />,
  document.getElementById('app')
);

setTimeout(() => {
  ReactDOM.render(
    <Example />,
    document.getElementById('app')
  );
}, 2000);

//example
import React from 'react';
import ReactDOM from 'react-dom';

export class Flashy extends React.Component {
  componentWillMount() {
    alert('AND NOW, FOR THE FIRST TIME EVER...  FLASHY!!!!');
  }
  componentDidMount() {
    alert('YOU JUST WITNESSED THE DEBUT OF...  FLASHY!!!!!!!');
  }

  render() {

    alert('Flashy is rendering!');

    alert('YOU JUST WITNESSED THE DEBUT OF...  FLASHY!!!!!!!');

    return (
      <h1 style={{ color: this.props.color }}>
        OOH LA LA LOOK AT ME I AM THE FLASHIEST
      </h1>
    );
  }
}

ReactDOM.render(
  <Flashy color='red' />,
  document.getElementById('app')
);

setTimeout(() => {
  ReactDOM.render(
    <Flashy color='green' />,
    document.getElementById('app')
  );
}, 2000);
////

// componentWillReceiveProps
// example
import React from 'react';

export class Example extends React.Component {
  componentWillReceiveProps(nextProps) {
    alert("Check out the new props.text that "
      + "I'm about to get:  " + nextProps.text);
  }

  render() {
    return <h1>{this.props.text}</h1>;
  }
}


// The first render won't trigger
// componentWillReceiveProps:
ReactDOM.render(
  <Example text="Hello world" />,
  document.getElementById('app')
);

// After the first render,
// subsequent renders will trigger
// componentWillReceiveProps:
setTimeout(() => {
  ReactDOM.render(
    <Example text="Hello world" />,
    document.getElementById('app')
  );
}, 1000);

//shouldComponentUpdate
// example
// if shouldComponentUpdate returns false, then the component will not update
import React from 'react';

export class Example extends React.Component {
  constructor(props) {
    super(props);

    this.state = { subtext: 'Put me in an <h2> please.' };
  }

  shouldComponentUpdate(nextProps, nextState) {
    if ((this.props.text == nextProps.text) &&
      (this.state.subtext == nextState.subtext)) {
      alert("Props and state haven't changed, so I'm not gonna update!");
      return false;
    } else {
      alert("Okay fine I will update.")
      return true;
    }
  }

  render() {
    return (
      <div>
        <h1>{this.props.text}</h1>
        <h2>{this.state.subtext}</h2>
      </div>
    );
  }
}

//componentWillUpdate
//example
import React from 'react';

export class Example extends React.Component {
  componentWillUpdate(nextProps, nextState) {
    alert('Component is about to update!  Any second now!');
  }

  render() {
    return <h1>Hello world</h1>;
  }
}

//componentDidUpdate
import React from 'react';

export class Example extends React.component {
  componentDidUpdate(prevProps, prevState) {
    alert('Component is done rendering!');
  }

  render() {
    return <h1>Hello world</h1>;
  }
}
//componentWillUnmount
//A component's unmounting period occurs when the component is removed from the DOM
// Enthused.js
import React from 'react';

export class Enthused extends React.Component {
  componentDidMount() {
    this.interval = setInterval(() => {
      this.props.addText('!');
    }, 15);
  }
  componentWillUnmount(prevProps, prevState) {
    clearInterval(this.interval);
  }

  render() {
    return (
      <button onClick={this.props.toggle}>
        Stop!
      </button>
    );
  }
}

// App.js
import React from 'react';
import ReactDOM from 'react-dom';
import { Enthused } from './Enthused';

export class App extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      enthused: false,
      text: ''
    };

    this.toggleEnthusiasm = this.toggleEnthusiasm.bind(this);
    this.addText = this.addText.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  toggleEnthusiasm() {
    this.setState({
      enthused: !this.state.enthused
    });
  }

  setText(text) {
    this.setState({ text: text });
  }

  addText(newText) {
    let text = this.state.text + newText;
    this.setState({ text: text });
  }

  handleChange(e) {
    this.setText(e.target.value);
  }

  render() {
    let button;
    if (this.state.enthused) {
      button = (
        <Enthused toggle={this.toggleEnthusiasm} addText={this.addText} />
      );
    } else {
      button = (
        <button onClick={this.toggleEnthusiasm}>
          Add Enthusiasm!
        </button>
      );
    }

    return (
      <div>
        <h1>Auto-Enthusiasm</h1>
        <textarea rows="7" cols="40" value={this.state.text}
                  onChange={this.handleChange}>
        </textarea>
        {button}
        <h2>{this.state.text}</h2>
      </div>
    );
  }
}

ReactDOM.render(
  <App />,
  document.getElementById('app')
);

//////////////