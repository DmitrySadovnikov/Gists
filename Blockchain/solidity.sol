// Typecasting

//uint8 a = 5;
//uint  b = 6;
//uint8 c = a * b; // throws an error because a * b returns a uint, not uint8:
//uint8 c = a * uint8(b); // we have to typecast b as a uint8 to make it work:
//
//keccak256("aaaac"); //b1f078126895a1424524de5321b339ab00408010b7cf0e6ed451514981e58aa9

pragma solidity ^0.4.0;


contract HelloWorldContract {
    string word = "Hello World";

    address issuer;

    function HelloWorldContract() public {
        issuer = msg.sender;
    }

    modifier ifIssuer() {
        if (issuer == msg.sender) {
            revert();
        }
        else {
            _;
        }
    }

    function setWord(string newWord) public ifIssuer returns (string) {
        word = newWord;
        return "This is the creator";
    }

    function getWord() public constant returns (string) {
        return word;
    }

    function getIssuer() public constant returns (address){
        return issuer;
    }
}

////////////////////

contract PayableContract {
    function PayableContract() {

    }

    function receiveFunds() payable {

    }

    function getter() constant returns(uint) {
        return this.balance;
    }
}

////////////////////

contract CustodialContract {
    address client;
    bool public _switch = false;

    event UpdateStatus(string _msg, uint _amount);
    event UserStatus(string _msg, address user, uint amount);

    function CustodialContract() {
        client = msg.sender;
    }

    modifier ifClient() {
        if(msg.sender != client) {
            throw;
        }
        _;
    }

    function depositFunds() payable {
        UserStatus('User transferred some money', msg.sender, msg.value);

    }

    function withdrawFunds(uint amount) ifClient {
        if(client.send(amount)) {
            UpdateStatus('User transferred some money', 0);
            _switch = true;
        } else {
            _switch = false;
        }
    }

    function getFunds() ifClient constant returns(uint) {
        return this.balance;
    }
}

////////////////////

contract CallerContract {
//    CallerContract toBeCalled = new CalledContract();
    CallerContract toBeCalled = CalledContract(0x0899887678);

    function getNumber() constant returns(uint) {
        return toBeCalled.getNumber();
    }

    function getWords() constant returns(bytes32) {
        return toBeCalled.getWords();
    }
}

contract CalledContract {
    uint number = 42;
    bytes32 words = "Hello World";

    function getNumber() constant returns(uint) {
        return number;
    }

    function setNumber(uint _number) {
        number = _number;
    }


    function getWords() constant returns(bytes32) {
        return words;
    }
}


// require
contract Xxx {
  function sayHiToVitalik(string _name) public returns (string) {
    // Compares if _name equals "Vitalik". Throws an error and exits if not true.
    // (Side note: Solidity doesn't have native string comparison, so we
    // compare their keccak256 hashes to see if the strings are equal)
    require(keccak256(_name) == keccak256("Vitalik"));
    // If it's true, proceed with the function:
    return "Hi!";
  }
}
////


// inheritance
contract Doge {
  function catchphrase() public returns (string) {
    return "So Wow CryptoDoge";
  }
}

contract BabyDoge is Doge {
  function anotherCatchphrase() public returns (string) {
    return "Such Moon BabyDoge";
  }
}
////

// storage & memory
contract SandwichFactory {
  struct Sandwich {
    string name;
    string status;
  }

  Sandwich[] sandwiches;

  function eatSandwich(uint _index) public {
    // Sandwich mySandwich = sandwiches[_index];

    // ^ Seems pretty straightforward, but solidity will give you a warning
    // telling you that you should explicitly declare `storage` or `memory` here.

    // So instead, you should declare with the `storage` keyword, like:
    Sandwich storage mySandwich = sandwiches[_index];
    // ...in which case `mySandwich` is a pointer to `sandwiches[_index]`
    // in storage, and...
    mySandwich.status = "Eaten!";
    // ...this will permanently change `sandwiches[_index]` on the blockchain.

    // If you just want a copy, you can use `memory`:
    Sandwich memory anotherSandwich = sandwiches[_index + 1];
    // ...in which case `anotherSandwich` will simply be a copy of the
    // data in memory, and...
    anotherSandwich.status = "Eaten!";
    // ...will just modify the temporary variable and have no effect
    // on `sandwiches[_index + 1]`. But you can do this:
    sandwiches[_index + 1] = anotherSandwich;
    // ...if you want to copy the changes back into blockchain storage.
  }
}
////

//Internal and External
//In addition to public and private, Solidity has two more types of visibility for functions: internal and external.
//
//internal is the same as private, except that it's also accessible to contracts that inherit from this contract. (Hey, that sounds like what we want here!).
//
//external is similar to public, except that these functions can ONLY be called outside the contract — they can't be called by other functions inside that contract. We'll talk about why you might want to use external vs public later.
//
//For declaring internal or external functions, the syntax is the same as private and public:

contract Sandwich {
  uint private sandwichesEaten = 0;

  function eat() internal {
    sandwichesEaten++;
  }
}

contract BLT is Sandwich {
  uint private baconSandwichesEaten = 0;

  function eatWithBacon() public returns (string) {
    baconSandwichesEaten++;
    // We can call this here because it's internal
    eat();
  }
}

// interface
contract NumberInterface {
  function getNum(address _myAddress) public view returns (uint);
}


// named arguments
contract C {
  function f(uint key, uint value) public {

  }

  function g() public {
    f({value : 2, key : 3});
  }
}
////

// call another contract
contract InfoFeed {
  function info() public payable returns (uint ret) { return 42; }
}

contract Consumer {
  InfoFeed feed;
  function setFeed(address addr) public { feed = InfoFeed(addr); }
  function callFeed() public { feed.info.value(10).gas(800)(); }
}

//

contract D {
  uint x;
  function D(uint a) public payable {
    x = a;
  }
}

contract C {
  D d = new D(arg);

  function createD(uint arg) public {
    D newD = new D(arg);
  }

  function createAndEndrowD(uint arg, uint amount) public payable {
    D newD = D.value(amount)(arg);
  }
}

// multiple named return

contract Simple {
  function arithmetic(uint _a, uint _b)
  public pure
  returns (uint o_sum, uint o_prodict) {
    o_sum = _a + _b;
    o_product = _a * _b;
  }
}
