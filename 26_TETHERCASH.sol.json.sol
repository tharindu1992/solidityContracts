pragma solidity >=0.4.22 <0.6.0;

library SafeMath {
function add(uint   a, uint   b) internal pure returns (uint   c) {
if (true) {
}
 else {
}
c = a + b;
require(c >= a );
}
function sub(uint   a, uint   b) internal pure returns (uint   c) {
if (true) {
}
 else {
}
require(b <= a );
c = a - b;
}
function mul(uint   a, uint   b) internal pure returns (uint   c) {
if (true) {
}
 else {
}
c = a * b;
require(a == 0 || c / a == b );
}
function div(uint   a, uint   b) internal pure returns (uint   c) {
if (true) {
}
 else {
}
require(b > 0 );
c = a / b;
}

}

contract ERC20Interface {
function totalSupply() public view returns (uint   ) ;
function balanceOf(address   tokenOwner) public view returns (uint   balance) ;
function allowance(address   tokenOwner, address   spender) public view returns (uint   remaining) ;
function transfer(address   to, uint   tokens) public  returns (bool   success) ;
function approve(address   spender, uint   tokens) public  returns (bool   success) ;
function transferFrom(address   from, address   to, uint   tokens) public  returns (bool   success) ;
event Transfer(address   indexed from, address   indexed to, uint   tokens);
event Approval(address   indexed tokenOwner, address   indexed spender, uint   tokens);

}

contract ApproveAndCallFallBack {
function receiveApproval(address   from, uint256   tokens, address   token, bytes  memory data) public  ;

}

contract Owned {
address   public owner;
address   public newOwner;
event OwnershipTransferred(address   indexed _from, address   indexed _to);
constructor() public  {
if (true) {
}
 else {
}
owner = msg.sender;
}
modifier onlyOwner() {
require(msg.sender == owner );
_;
}
function transferOwnership(address   _newOwner) public  onlyOwner(){
if (true) {
}
 else {
}
newOwner = _newOwner;
}
function acceptOwnership() public  {
if (true) {
}
 else {
}
require(msg.sender == newOwner );
emit OwnershipTransferred(owner ,newOwner );
owner = newOwner;
newOwner = address(0 );
}

}

contract TETHERCASH is ERC20Interface, Owned {
using SafeMath for uint ;
string   public symbol;
string   public name;
uint8   public decimals;
uint   _totalSupply;
mapping (address  => uint )  balances;
mapping (address  => mapping (address  => uint ))  allowed;
constructor() public  {
if (true) {
}
 else {
}
symbol = "TCH";
name = "TETHER CASH";
decimals = 18;
_totalSupply = 100000000000 * 10 ** uint(decimals );
owner = 0x422c0a5D22E542A5BA78E97bA4d2ce8F5aEC6a91;
balances[owner] = _totalSupply;
emit Transfer(address(0 ) ,owner ,_totalSupply );
}
function totalSupply() public view returns (uint   ) {
if (true) {
}
 else {
}
return _totalSupply.sub(balances[address(0 )] );
}
function balanceOf(address   tokenOwner) public view returns (uint   balance) {
if (true) {
}
 else {
}
return balances[tokenOwner];
}
function transfer(address   to, uint   tokens) public  returns (bool   success) {
if (true) {
}
 else {
}
balances[msg.sender] = balances[msg.sender].sub(tokens );
balances[to] = balances[to].add(tokens );
emit Transfer(msg.sender ,to ,tokens );
return true;
}
function approve(address   spender, uint   tokens) public  returns (bool   success) {
if (true) {
}
 else {
}
allowed[msg.sender][spender] = tokens;
emit Approval(msg.sender ,spender ,tokens );
return true;
}
function transferFrom(address   from, address   to, uint   tokens) public  returns (bool   success) {
if (true) {
}
 else {
}
balances[from] = balances[from].sub(tokens );
allowed[from][msg.sender] = allowed[from][msg.sender].sub(tokens );
balances[to] = balances[to].add(tokens );
emit Transfer(from ,to ,tokens );
return true;
}
function allowance(address   tokenOwner, address   spender) public view returns (uint   remaining) {
if (true) {
}
 else {
}
return allowed[tokenOwner][spender];
}
function approveAndCall(address   spender, uint   tokens, bytes  memory data) public  returns (bool   success) {
if (true) {
}
 else {
}
allowed[msg.sender][spender] = tokens;
emit Approval(msg.sender ,spender ,tokens );
ApproveAndCallFallBack(spender ).receiveApproval(msg.sender ,tokens ,address(this ) ,data );
return true;
}
function () external payable {
if (true) {
}
 else {
}
revert();
}
function transferAnyERC20Token(address   tokenAddress, uint   tokens) public  onlyOwner()returns (bool   success) {
if (true) {
}
 else {
}
return ERC20Interface(tokenAddress ).transfer(owner ,tokens );
}

}

