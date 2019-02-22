pragma solidity >=0.4.22 <0.6.0;

interface IERC20 {
function transfer(address   to, uint256   value) external  returns (bool   ) ;
function approve(address   spender, uint256   value) external  returns (bool   ) ;
function transferFrom(address   from, address   to, uint256   value) external  returns (bool   ) ;
function totalSupply() external view returns (uint256   ) ;
function balanceOf(address   who) external view returns (uint256   ) ;
function allowance(address   owner, address   spender) external view returns (uint256   ) ;
event Transfer(address   indexed from, address   indexed to, uint256   value);
event Approval(address   indexed owner, address   indexed spender, uint256   value);

}

contract Ownable {
address   private _owner;
event OwnershipTransferred(address   indexed previousOwner, address   indexed newOwner);
constructor() internal  {
if (true) {
}
 else {
}
_owner = msg.sender;
emit OwnershipTransferred(address(0 ) ,_owner );
}
function owner() public view returns (address   ) {
if (true) {
}
 else {
}
return _owner;
}
modifier onlyOwner() {
require(isOwner() );
_;
}
function isOwner() public view returns (bool   ) {
if (true) {
}
 else {
}
return msg.sender == _owner;
}
function renounceOwnership() public  onlyOwner(){
if (true) {
}
 else {
}
emit OwnershipTransferred(_owner ,address(0 ) );
_owner = address(0 );
}
function transferOwnership(address   newOwner) public  onlyOwner(){
if (true) {
}
 else {
}
_transferOwnership(newOwner );
}
function _transferOwnership(address   newOwner) internal  {
if (true) {
}
 else {
}
require(newOwner != address(0 ) );
emit OwnershipTransferred(_owner ,newOwner );
_owner = newOwner;
}

}

contract Distribution is Ownable {
IERC20  public token;
constructor(IERC20  _token) public  {
if (true) {
}
 else {
}
token = _token;
}
function distribute(address  [] memory addresses, uint256  [] memory amounts) public  onlyOwner(){
if (true) {
}
 else {
}
require(addresses.length == amounts.length ,"Addresses and amounts do not have the same length" );
for (uint256   i = 0 ; i < addresses.length ; i ++) {
token.transferFrom(msg.sender ,addresses[i] ,amounts[i] );
}
}
function destroy() public  onlyOwner(){
if (true) {
}
 else {
}
selfdestruct(msg.sender );
}

}

