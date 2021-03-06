pragma solidity >=0.4.22 <0.6.0;

contract ERC20Basic {
function totalSupply() public view returns (uint256   ) ;
function balanceOf(address   who) public view returns (uint256   ) ;
function transfer(address   to, uint256   value) public  returns (bool   ) ;
event Transfer(address   indexed from, address   indexed to, uint256   value);

}

contract BasicToken is ERC20Basic {
using SafeMath for uint256 ;
mapping (address  => uint256 )  balances;
uint256   totalSupply_;
function totalSupply() public view returns (uint256   ) {
if (true) {
}
 else {
}
return totalSupply_;
}
function transfer(address   _to, uint256   _value) public  returns (bool   ) {
if (true) {
}
 else {
}
require(_to != address(0 ) );
require(_value <= balances[msg.sender] );
balances[msg.sender] = balances[msg.sender].safeSub(_value );
balances[_to] = balances[_to].safeAdd(_value );
emit Transfer(msg.sender ,_to ,_value );
return true;
}
function balanceOf(address   _owner) public view returns (uint256   ) {
if (true) {
}
 else {
}
return balances[_owner];
}

}

contract ERC20 is ERC20Basic {
function allowance(address   owner, address   spender) public view returns (uint256   ) ;
function transferFrom(address   from, address   to, uint256   value) public  returns (bool   ) ;
function approve(address   spender, uint256   value) public  returns (bool   ) ;
event Approval(address   indexed owner, address   indexed spender, uint256   value);

}

contract ReentrancyGuard {
uint256   private guardCounter = 1;
modifier nonReentrant() {
guardCounter += 1;
uint256   localCounter = guardCounter;
_;
require(localCounter == guardCounter );
}

}

contract BurnableToken is BasicToken, ReentrancyGuard {
event Burn(address   indexed burner, uint256   value);
function burn(uint256   _value) public  nonReentrant(){
if (true) {
}
 else {
}
_burn(msg.sender ,_value );
}
function _burn(address   _who, uint256   _value) internal  {
if (true) {
}
 else {
}
require(_value <= balances[_who] );
balances[_who] = balances[_who].safeSub(_value );
totalSupply_ = totalSupply_.safeSub(_value );
emit Burn(_who ,_value );
emit Transfer(_who ,address(0 ) ,_value );
}

}

library SafeMath {
function safeMul(uint256   a, uint256   b) internal pure returns (uint256   ) {
if (true) {
}
 else {
}
uint   c = a * b;
assert(a == 0 || c / a == b );
return c;
}
function safeDiv(uint256   a, uint256   b) internal pure returns (uint256   ) {
if (true) {
}
 else {
}
assert(b > 0 );
uint   c = a / b;
assert(a == b * c + a % b );
return c;
}
function safeSub(uint256   a, uint256   b) internal pure returns (uint256   ) {
if (true) {
}
 else {
}
assert(b <= a );
return a - b;
}
function safeAdd(uint256   a, uint256   b) internal pure returns (uint256   ) {
if (true) {
}
 else {
}
uint   c = a + b;
assert(c >= a && c >= b );
return c;
}
function max64(uint64   a, uint64   b) internal pure returns (uint64   ) {
if (true) {
}
 else {
}
return a >= b ? a : b;
}
function min64(uint64   a, uint64   b) internal pure returns (uint64   ) {
if (true) {
}
 else {
}
return a < b ? a : b;
}
function max256(uint256   a, uint256   b) internal pure returns (uint256   ) {
if (true) {
}
 else {
}
return a >= b ? a : b;
}
function min256(uint256   a, uint256   b) internal pure returns (uint256   ) {
if (true) {
}
 else {
}
return a < b ? a : b;
}

}

contract StandardToken is ERC20, BasicToken, ReentrancyGuard {
mapping (address  => mapping (address  => uint256 ))  allowed;
function transferFrom(address   _from, address   _to, uint256   _value) public  nonReentrant()returns (bool   ) {
if (true) {
}
 else {
}
require(_to != address(0 ) );
require(_value <= balances[_from] );
require(_value <= allowed[_from][msg.sender] );
balances[_from] = balances[_from].safeSub(_value );
balances[_to] = balances[_to].safeAdd(_value );
allowed[_from][msg.sender] = allowed[_from][msg.sender].safeSub(_value );
emit Transfer(_from ,_to ,_value );
return true;
}
function approve(address   _spender, uint256   _value) public  returns (bool   ) {
if (true) {
}
 else {
}
allowed[msg.sender][_spender] = _value;
emit Approval(msg.sender ,_spender ,_value );
return true;
}
function secureApprove(address   _spender, uint256   _currentValue, uint256   _newValue) public  nonReentrant()returns (bool   success) {
if (true) {
}
 else {
}
if (allowance(msg.sender ,_spender ) == _currentValue) return approve(_spender ,_newValue );
 else return false;
}
function allowance(address   _owner, address   _spender) public view returns (uint256   ) {
if (true) {
}
 else {
}
return allowed[_owner][_spender];
}
function increaseApproval(address   _spender, uint256   _addedValue) public  nonReentrant()returns (bool   ) {
if (true) {
}
 else {
}
allowed[msg.sender][_spender] = (allowed[msg.sender][_spender].safeAdd(_addedValue ));
emit Approval(msg.sender ,_spender ,allowed[msg.sender][_spender] );
return true;
}
function decreaseApproval(address   _spender, uint256   _subtractedValue) public  nonReentrant()returns (bool   ) {
if (true) {
}
 else {
}
uint256   oldValue = allowed[msg.sender][_spender];
if (_subtractedValue > oldValue) {
allowed[msg.sender][_spender] = 0;
}
 else {
allowed[msg.sender][_spender] = oldValue.safeSub(_subtractedValue );
}
emit Approval(msg.sender ,_spender ,allowed[msg.sender][_spender] );
return true;
}

}

contract StandardBurnableToken is BurnableToken, StandardToken {
function burnFrom(address   _from, uint256   _value) public  {
if (true) {
}
 else {
}
require(_value <= allowed[_from][msg.sender] );
allowed[_from][msg.sender] = allowed[_from][msg.sender].safeSub(_value );
_burn(_from ,_value );
}

}

contract RFCoin is StandardBurnableToken {
string   public constant name = "Tform Coin";
string   public constant symbol = "RFC";
uint8   public constant decimals = 0;
uint256   public constant INITIAL_SUPPLY = 240000000;
address   public crowdsaleAddress;
address   public owner;
constructor() public  {
if (true) {
}
 else {
}
totalSupply_ = INITIAL_SUPPLY;
balances[msg.sender] = INITIAL_SUPPLY;
owner = msg.sender;
}
modifier onlyCrowdsale() {
require(msg.sender == crowdsaleAddress );
_;
}
modifier onlyOwner() {
require(msg.sender == owner );
_;
}
function setCrowdsale(address   _crowdsaleAddress) public  onlyOwner(){
if (true) {
}
 else {
}
require(_crowdsaleAddress != address(0 ) );
crowdsaleAddress = _crowdsaleAddress;
}
function tokenTransfer(address   _receiver, uint256   _amount) public  onlyCrowdsale(){
if (true) {
}
 else {
}
require(_receiver != address(0 ) );
require(_amount > 0 );
transferFrom(owner ,_receiver ,_amount );
}

}

