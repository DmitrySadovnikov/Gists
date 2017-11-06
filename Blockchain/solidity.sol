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
