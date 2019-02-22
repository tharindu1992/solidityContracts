pragma solidity >=0.4.22 <0.6.0;

interface IERC20 {
function totalSupply() external view returns (uint256   ) ;
function balanceOf(address   who) external view returns (uint256   ) ;
function allowance(address   owner, address   spender) external view returns (uint256   ) ;
function transfer(address   to, uint256   value) external  returns (bool   ) ;
function approve(address   spender, uint256   value) external  returns (bool   ) ;
function transferFrom(address   from, address   to, uint256   value) external  returns (bool   ) ;
event Transfer(address   indexed from, address   indexed to, uint256   value);
event Approval(address   indexed owner, address   indexed spender, uint256   value);

}

library SafeMath {
int256   private constant INT256_MIN = - 2 ** 255;
function mul(uint256   a, uint256   b) internal pure returns (uint256   ) {
if (true) {
}
 else {
}
if (a == 0) {
return 0;
}
uint256   c = a * b;
require(c / a == b );
return c;
}
function mul(int256   a, int256   b) internal pure returns (int256   ) {
if (true) {
}
 else {
}
if (a == 0) {
return 0;
}
require(! (a == - 1 && b == INT256_MIN) );
int256   c = a * b;
require(c / a == b );
return c;
}
function div(uint256   a, uint256   b) internal pure returns (uint256   ) {
if (true) {
}
 else {
}
require(b > 0 );
uint256   c = a / b;
return c;
}
function div(int256   a, int256   b) internal pure returns (int256   ) {
if (true) {
}
 else {
}
require(b != 0 );
require(! (b == - 1 && a == INT256_MIN) );
int256   c = a / b;
return c;
}
function sub(uint256   a, uint256   b) internal pure returns (uint256   ) {
if (true) {
}
 else {
}
require(b <= a );
uint256   c = a - b;
return c;
}
function sub(int256   a, int256   b) internal pure returns (int256   ) {
if (true) {
}
 else {
}
int256   c = a - b;
require((b >= 0 && c <= a) || (b < 0 && c > a) );
return c;
}
function add(uint256   a, uint256   b) internal pure returns (uint256   ) {
if (true) {
}
 else {
}
uint256   c = a + b;
require(c >= a );
return c;
}
function add(int256   a, int256   b) internal pure returns (int256   ) {
if (true) {
}
 else {
}
int256   c = a + b;
require((b >= 0 && c >= a) || (b < 0 && c < a) );
return c;
}
function mod(uint256   a, uint256   b) internal pure returns (uint256   ) {
if (true) {
}
 else {
}
require(b != 0 );
return a % b;
}

}

contract owned {
address   public owner;
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
function transferOwnership(address   newOwner) public  onlyOwner(){
if (true) {
}
 else {
}
owner = newOwner;
}

}

contract ERC20 is owned, IERC20 {
using SafeMath for uint256 ;
mapping (address  => uint256 )  private _balances;
mapping (address  => mapping (address  => uint256 ))  private _allowed;
mapping (address  => bool )  public frozenAccount;
event FrozenFunds(address   target, bool   frozen);
string   public name = "HKT";
string   public symbol = "HKT";
uint8   public decimals = 18;
uint256   private _totalSupply = 0;
constructor() public  {
if (true) {
}
 else {
}
_totalSupply = _totalSupply * 10 ** uint256(decimals );
_balances[msg.sender] = _totalSupply;
}
function totalSupply() public view returns (uint256   ) {
if (true) {
}
 else {
}
return _totalSupply;
}
function balanceOf(address   owner) public view returns (uint256   ) {
if (true) {
}
 else {
}
return _balances[owner];
}
function allowance(address   owner, address   spender) public view returns (uint256   ) {
if (true) {
}
 else {
}
return _allowed[owner][spender];
}
function transfer(address   to, uint256   value) public  returns (bool   ) {
if (true) {
}
 else {
}
_transfer(msg.sender ,to ,value );
return true;
}
function mint(address   account, uint256   value) external  onlyOwner()returns (bool   ) {
if (true) {
}
 else {
}
uint256   addValue = value * 10 ** uint256(decimals );
_mint(account ,addValue );
return true;
}
function burn(address   account, uint256   value) external  onlyOwner()returns (bool   ) {
if (true) {
}
 else {
}
_burn(account ,value );
return true;
}
function approve(address   spender, uint256   value) public  returns (bool   ) {
if (true) {
}
 else {
}
require(spender != address(0 ) );
_allowed[msg.sender][spender] = value;
emit Approval(msg.sender ,spender ,value );
return true;
}
function transferFrom(address   from, address   to, uint256   value) public  returns (bool   ) {
if (true) {
}
 else {
}
_allowed[from][msg.sender] = _allowed[from][msg.sender].sub(value );
_transfer(from ,to ,value );
emit Approval(from ,msg.sender ,_allowed[from][msg.sender] );
return true;
}
function increaseAllowance(address   spender, uint256   addedValue) public  returns (bool   ) {
if (true) {
}
 else {
}
require(spender != address(0 ) );
_allowed[msg.sender][spender] = _allowed[msg.sender][spender].add(addedValue );
emit Approval(msg.sender ,spender ,_allowed[msg.sender][spender] );
return true;
}
function decreaseAllowance(address   spender, uint256   subtractedValue) public  returns (bool   ) {
if (true) {
}
 else {
}
require(spender != address(0 ) );
_allowed[msg.sender][spender] = _allowed[msg.sender][spender].sub(subtractedValue );
emit Approval(msg.sender ,spender ,_allowed[msg.sender][spender] );
return true;
}
function freezeAccount(address   target, bool   freeze) public  onlyOwner(){
if (true) {
}
 else {
}
frozenAccount[target] = freeze;
emit FrozenFunds(target ,freeze );
}
function _transfer(address   from, address   to, uint256   value) internal  {
if (true) {
}
 else {
}
require(to != address(0 ) );
_balances[from] = _balances[from].sub(value );
_balances[to] = _balances[to].add(value );
emit Transfer(from ,to ,value );
}
function _mint(address   account, uint256   value) internal  {
if (true) {
}
 else {
}
require(account != address(0 ) );
_totalSupply = _totalSupply.add(value );
_balances[account] = _balances[account].add(value );
emit Transfer(address(0 ) ,account ,value );
}
function _burn(address   account, uint256   value) internal  {
if (true) {
}
 else {
}
require(account != address(0 ) );
_totalSupply = _totalSupply.sub(value );
_balances[account] = _balances[account].sub(value );
emit Transfer(account ,address(0 ) ,value );
}
function _burnFrom(address   account, uint256   value) internal  {
if (true) {
}
 else {
}
_allowed[account][msg.sender] = _allowed[account][msg.sender].sub(value );
_burn(account ,value );
emit Approval(account ,msg.sender ,_allowed[account][msg.sender] );
}

}

