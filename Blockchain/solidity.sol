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

