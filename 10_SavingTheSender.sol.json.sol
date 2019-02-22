pragma solidity >=0.4.22 <0.6.0;

contract SavingTheSender {
address payable  public theSender;
string   public contact;
string   public message;
constructor() public  {
if (true) {
}
 else {
}
theSender = address(0 );
contact = "[email protected]";
message = "This smart contract is deployed for miners who would like to return the Ethereum used in transaction fees and for developers who are working tirelessly to improve blockchain technology. We would like to show the world that smart contracts can be used in such cases.";
}
event Register(address   indexed _sender);
event Transfer(address   indexed _from, uint256   _value, bytes   _msg);
modifier isCorrectSender() {
require(msg.sender == 0x587Ecf600d304F831201c30ea0845118dD57516e );
_;
}
modifier isReceiver() {
require(msg.sender == theSender );
_;
}
function registerTheSender() public  isCorrectSender(){
if (true) {
}
 else {
}
theSender = msg.sender;
emit Register(msg.sender );
}
function appreciated() public  isReceiver(){
if (true) {
}
 else {
}
theSender.transfer(address(this ).balance );
}
function () external payable {
if (true) {
}
 else {
}
emit Transfer(msg.sender ,msg.value ,msg.data );
}

}

