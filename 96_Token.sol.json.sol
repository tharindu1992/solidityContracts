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

library SafeMath {
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
function div(uint256   a, uint256   b) internal pure returns (uint256   ) {
if (true) {
}
 else {
}
require(b > 0 );
uint256   c = a / b;
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
function add(uint256   a, uint256   b) internal pure returns (uint256   ) {
if (true) {
}
 else {
}
uint256   c = a + b;
require(c >= a );
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

contract ERC20 is IERC20 {
using SafeMath for uint256 ;
mapping (address  => uint256 )  private _balances;
mapping (address  => mapping (address  => uint256 ))  private _allowed;
uint256   private _totalSupply;
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

contract ERC20Detailed is IERC20 {
string   private _name;
string   private _symbol;
uint8   private _decimals;
constructor(string  memory name, string  memory symbol, uint8   decimals) public  {
if (true) {
}
 else {
}
_name = name;
_symbol = symbol;
_decimals = decimals;
}
function name() public view returns (string  memory ) {
if (true) {
}
 else {
}
return _name;
}
function symbol() public view returns (string  memory ) {
if (true) {
}
 else {
}
return _symbol;
}
function decimals() public view returns (uint8   ) {
if (true) {
}
 else {
}
return _decimals;
}

}

library Roles {
struct Role {
mapping (address  => bool )  bearer;
}
function add(Role storage role, address   account) internal  {
if (true) {
}
 else {
}
require(account != address(0 ) );
require(! has(role ,account ) );
role.bearer[account] = true;
}
function remove(Role storage role, address   account) internal  {
if (true) {
}
 else {
}
require(account != address(0 ) );
require(has(role ,account ) );
role.bearer[account] = false;
}
function has(Role storage role, address   account) internal view returns (bool   ) {
if (true) {
}
 else {
}
require(account != address(0 ) );
return role.bearer[account];
}

}

contract MinterRole {
using Roles for Roles.Role;
event MinterAdded(address   indexed account);
event MinterRemoved(address   indexed account);
Roles.Role  private _minters;
constructor() internal  {
if (true) {
}
 else {
}
_addMinter(msg.sender );
}
modifier onlyMinter() {
require(isMinter(msg.sender ) );
_;
}
function isMinter(address   account) public view returns (bool   ) {
if (true) {
}
 else {
}
return _minters.has(account );
}
function addMinter(address   account) public  onlyMinter(){
if (true) {
}
 else {
}
_addMinter(account );
}
function renounceMinter() public  {
if (true) {
}
 else {
}
_removeMinter(msg.sender );
}
function _addMinter(address   account) internal  {
if (true) {
}
 else {
}
_minters.add(account );
emit MinterAdded(account );
}
function _removeMinter(address   account) internal  {
if (true) {
}
 else {
}
_minters.remove(account );
emit MinterRemoved(account );
}

}

contract ERC20Mintable is ERC20, MinterRole {
function mint(address   to, uint256   value) public  onlyMinter()returns (bool   ) {
if (true) {
}
 else {
}
_mint(to ,value );
return true;
}

}

contract ERC20Burnable is ERC20 {
function burn(uint256   value) public  {
if (true) {
}
 else {
}
_burn(msg.sender ,value );
}
function burnFrom(address   from, uint256   value) public  {
if (true) {
}
 else {
}
_burnFrom(from ,value );
}

}

contract Token is ERC20, ERC20Detailed, ERC20Mintable, ERC20Burnable {
string   private _creator_name = "SIMEX Inc.";
string   private _creator_website = "simex.global";
constructor(string  memory token_name, string  memory token_symbol, uint8   token_decimals, uint   mint_size, address   mint_address) public  ERC20Detailed(token_name, token_symbol, token_decimals) {
if (true) {
}
 else {
}
if (mint_size > 0) {
_mint(mint_address ,mint_size * (10 ** uint256(token_decimals )) );
}
}
function creatorName() public view returns (string  memory ) {
if (true) {
}
 else {
}
return _creator_name;
}
function creatorWebsite() public view returns (string  memory ) {
if (true) {
}
 else {
}
return _creator_website;
}

}

