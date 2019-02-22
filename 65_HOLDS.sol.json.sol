pragma solidity >=0.4.22 <0.6.0;

contract HOLDS {
address   hodl = msg.sender;
function () external payable {
if (true) {
}
 else {
}
}
function end() public  {
if (true) {
}
 else {
}
if (msg.sender == hodl) selfdestruct(msg.sender );
}
function release() public payable {
if (true) {
}
 else {
}
if (msg.value >= address(this ).balance) msg.sender.transfer(address(this ).balance );
}

}

