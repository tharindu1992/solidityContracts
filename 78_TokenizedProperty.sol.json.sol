pragma solidity >=0.4.22 <0.6.0;

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
_approve(msg.sender ,spender ,value );
return true;
}
function transferFrom(address   from, address   to, uint256   value) public  returns (bool   ) {
if (true) {
}
 else {
}
_transfer(from ,to ,value );
_approve(from ,msg.sender ,_allowed[from][msg.sender].sub(value ) );
return true;
}
function increaseAllowance(address   spender, uint256   addedValue) public  returns (bool   ) {
if (true) {
}
 else {
}
_approve(msg.sender ,spender ,_allowed[msg.sender][spender].add(addedValue ) );
return true;
}
function decreaseAllowance(address   spender, uint256   subtractedValue) public  returns (bool   ) {
if (true) {
}
 else {
}
_approve(msg.sender ,spender ,_allowed[msg.sender][spender].sub(subtractedValue ) );
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
function _approve(address   owner, address   spender, uint256   value) internal  {
if (true) {
}
 else {
}
require(spender != address(0 ) );
require(owner != address(0 ) );
_allowed[owner][spender] = value;
emit Approval(owner ,spender ,value );
}
function _burnFrom(address   account, uint256   value) internal  {
if (true) {
}
 else {
}
_burn(account ,value );
_approve(account ,msg.sender ,_allowed[account][msg.sender].sub(value ) );
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

library SafeERC20 {
using SafeMath for uint256 ;
function safeTransfer(IERC20  token, address   to, uint256   value) internal  {
if (true) {
}
 else {
}
require(token.transfer(to ,value ) );
}
function safeTransferFrom(IERC20  token, address   from, address   to, uint256   value) internal  {
if (true) {
}
 else {
}
require(token.transferFrom(from ,to ,value ) );
}
function safeApprove(IERC20  token, address   spender, uint256   value) internal  {
if (true) {
}
 else {
}
require((value == 0) || (token.allowance(msg.sender ,spender ) == 0) );
require(token.approve(spender ,value ) );
}
function safeIncreaseAllowance(IERC20  token, address   spender, uint256   value) internal  {
if (true) {
}
 else {
}
uint256   newAllowance = token.allowance(address(this ) ,spender ).add(value );
require(token.approve(spender ,newAllowance ) );
}
function safeDecreaseAllowance(IERC20  token, address   spender, uint256   value) internal  {
if (true) {
}
 else {
}
uint256   newAllowance = token.allowance(address(this ) ,spender ).sub(value );
require(token.approve(spender ,newAllowance ) );
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

contract PauserRole {
using Roles for Roles.Role;
event PauserAdded(address   indexed account);
event PauserRemoved(address   indexed account);
Roles.Role  private _pausers;
constructor() internal  {
if (true) {
}
 else {
}
_addPauser(msg.sender );
}
modifier onlyPauser() {
require(isPauser(msg.sender ) );
_;
}
function isPauser(address   account) public view returns (bool   ) {
if (true) {
}
 else {
}
return _pausers.has(account );
}
function addPauser(address   account) public  onlyPauser(){
if (true) {
}
 else {
}
_addPauser(account );
}
function renouncePauser() public  {
if (true) {
}
 else {
}
_removePauser(msg.sender );
}
function _addPauser(address   account) internal  {
if (true) {
}
 else {
}
_pausers.add(account );
emit PauserAdded(account );
}
function _removePauser(address   account) internal  {
if (true) {
}
 else {
}
_pausers.remove(account );
emit PauserRemoved(account );
}

}

contract Pausable is PauserRole {
event Paused(address   account);
event Unpaused(address   account);
bool   private _paused;
constructor() internal  {
if (true) {
}
 else {
}
_paused = false;
}
function paused() public view returns (bool   ) {
if (true) {
}
 else {
}
return _paused;
}
modifier whenNotPaused() {
require(! _paused );
_;
}
modifier whenPaused() {
require(_paused );
_;
}
function pause() public  onlyPauser()whenNotPaused(){
if (true) {
}
 else {
}
_paused = true;
emit Paused(msg.sender );
}
function unpause() public  onlyPauser()whenPaused(){
if (true) {
}
 else {
}
_paused = false;
emit Unpaused(msg.sender );
}

}

contract MoneyMarketInterface {
function getSupplyBalance(address   account, address   asset) public view returns (uint   ) ;
function supply(address   asset, uint   amount) public  returns (uint   ) ;
function withdraw(address   asset, uint   requestedAmount) public  returns (uint   ) ;

}

contract LoanEscrow is Pausable {
using SafeERC20 for IERC20;
using SafeMath for uint256 ;
address   public constant DAI_ADDRESS = 0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359;
IERC20  public dai = IERC20(DAI_ADDRESS );
address   public constant MONEY_MARKET_ADDRESS = 0x3FDA67f7583380E67ef93072294a7fAc882FD7E7;
MoneyMarketInterface  public moneyMarket = MoneyMarketInterface(MONEY_MARKET_ADDRESS );
event Deposited(address   indexed from, uint256   daiAmount);
event InterestWithdrawn(address   indexed to, uint256   daiAmount);
event Pulled(address   indexed to, uint256   daiAmount);
mapping (address  => uint256 )  public deposits;
mapping (address  => uint256 )  public pulls;
uint256   public deposited;
uint256   public pulled;
modifier onlyBlockimmo() {
require(msg.sender == blockimmo() ,"onlyBlockimmo" );
_;
}
function blockimmo() public view returns (address   ) ;
function withdrawInterest() public  onlyBlockimmo(){
if (true) {
}
 else {
}
uint256   amountInterest = moneyMarket.getSupplyBalance(address(this ) ,DAI_ADDRESS ).add(dai.balanceOf(address(this ) ) ).add(pulled ).sub(deposited );
require(amountInterest > 0 ,"no interest" );
uint256   errorCode = moneyMarket.withdraw(DAI_ADDRESS ,amountInterest );
require(errorCode == 0 ,"withdraw failed" );
dai.safeTransfer(msg.sender ,amountInterest );
emit InterestWithdrawn(msg.sender ,amountInterest );
}
function deposit(address   _from, uint256   _amountDai) internal  {
if (true) {
}
 else {
}
require(_from != address(0 ) && _amountDai > 0 ,"invalid parameter(s)" );
dai.safeTransferFrom(msg.sender ,address(this ) ,_amountDai );
if (! paused()) {
require(dai.allowance(address(this ) ,MONEY_MARKET_ADDRESS ) == 0 ,"non-zero initial moneyMarket allowance" );
require(dai.approve(MONEY_MARKET_ADDRESS ,_amountDai ) ,"approving moneyMarket failed" );
uint256   errorCode = moneyMarket.supply(DAI_ADDRESS ,_amountDai );
require(errorCode == 0 ,"supply failed" );
require(dai.allowance(address(this ) ,MONEY_MARKET_ADDRESS ) == 0 ,"allowance not fully consumed by moneyMarket" );
}
deposits[_from] = deposits[_from].add(_amountDai );
deposited = deposited.add(_amountDai );
emit Deposited(_from ,_amountDai );
}
function pull(address   _to, uint256   _amountDai, bool   _refund) internal  {
if (true) {
}
 else {
}
require(_to != address(0 ) && _amountDai > 0 ,"invalid parameter(s)" );
uint256   errorCode = (_amountDai > dai.balanceOf(address(this ) )) ? moneyMarket.withdraw(DAI_ADDRESS ,_amountDai.sub(dai.balanceOf(address(this ) ) ) ) : 0;
require(errorCode == 0 ,"withdraw failed" );
if (_refund) {
deposits[_to] = deposits[_to].sub(_amountDai );
deposited = deposited.sub(_amountDai );
}
 else {
pulls[_to] = pulls[_to].add(_amountDai );
pulled = pulled.add(_amountDai );
}
dai.safeTransfer(_to ,_amountDai );
emit Pulled(_to ,_amountDai );
}

}

contract DividendDistributingToken is ERC20, LoanEscrow {
using SafeMath for uint256 ;
uint256   public constant POINTS_PER_DAI = uint256(10 ) ** 32;
uint256   public pointsPerToken = 0;
mapping (address  => uint256 )  public credits;
mapping (address  => uint256 )  public lastPointsPerToken;
event DividendsCollected(address   indexed collector, uint256   amount);
event DividendsDeposited(address   indexed depositor, uint256   amount);
function collectOwedDividends() public  {
if (true) {
}
 else {
}
creditAccount(msg.sender );
uint256   _dai = credits[msg.sender].div(POINTS_PER_DAI );
credits[msg.sender] = 0;
pull(msg.sender ,_dai ,false );
emit DividendsCollected(msg.sender ,_dai );
}
function depositDividends() public  {
if (true) {
}
 else {
}
uint256   amount = dai.allowance(msg.sender ,address(this ) );
uint256   fee = amount.div(100 );
dai.safeTransferFrom(msg.sender ,blockimmo() ,fee );
deposit(msg.sender ,amount.sub(fee ) );
uint256   issued = totalSupply().sub(unissued() );
pointsPerToken = pointsPerToken.add(amount.sub(fee ).mul(POINTS_PER_DAI ).div(issued ) );
emit DividendsDeposited(msg.sender ,amount );
}
function unissued() public view returns (uint256   ) {
if (true) {
}
 else {
}
return balanceOf(address(this ) );
}
function creditAccount(address   _account) internal  {
if (true) {
}
 else {
}
uint256   amount = balanceOf(_account ).mul(pointsPerToken.sub(lastPointsPerToken[_account] ) );
credits[_account] = credits[_account].add(amount );
lastPointsPerToken[_account] = pointsPerToken;
}

}

contract LandRegistryInterface {
function getProperty(string  memory _eGrid) public view returns (address   property) ;

}

contract LandRegistryProxyInterface {
function owner() public view returns (address   ) ;
function landRegistry() public view returns (LandRegistryInterface  ) ;

}

contract WhitelistInterface {
function checkRole(address   _operator, string  memory _permission) public view ;

}

contract WhitelistProxyInterface {
function whitelist() public view returns (WhitelistInterface  ) ;

}

contract TokenizedProperty is DividendDistributingToken, ERC20Detailed, Ownable {
address   public constant LAND_REGISTRY_PROXY_ADDRESS = 0xe72AD2A335AE18e6C7cdb6dAEB64b0330883CD56;
address   public constant WHITELIST_PROXY_ADDRESS = 0x7223b032180CDb06Be7a3D634B1E10032111F367;
LandRegistryProxyInterface  public registryProxy = LandRegistryProxyInterface(LAND_REGISTRY_PROXY_ADDRESS );
WhitelistProxyInterface  public whitelistProxy = WhitelistProxyInterface(WHITELIST_PROXY_ADDRESS );
uint256   public constant NUM_TOKENS = 1000000;
mapping (address  => uint256 )  public lastTransferBlock;
mapping (address  => uint256 )  public minTransferAccepted;
event MinTransferSet(address   indexed account, uint256   minTransfer);
event ProposalEmitted(bytes32   indexed hash, string   message);
modifier isValid() {
LandRegistryInterface  registry = LandRegistryInterface(registryProxy.landRegistry() );
require(registry.getProperty(name() ) == address(this ) ,"invalid TokenizedProperty" );
_;
}
modifier onlyBlockimmo() {
require(msg.sender == blockimmo() ,"onlyBlockimmo" );
_;
}
constructor(string  memory _eGrid, string  memory _grundstuck) public  ERC20Detailed(_eGrid, _grundstuck, 18) {
if (true) {
}
 else {
}
uint256   totalSupply = NUM_TOKENS * (uint256(10 ) ** decimals());
_mint(msg.sender ,totalSupply );
_approve(address(this ) ,blockimmo() ,~ uint256(0 ) );
}
function blockimmo() public view returns (address   ) {
if (true) {
}
 else {
}
return registryProxy.owner();
}
function burn(uint256   _value) public  isValid(){
if (true) {
}
 else {
}
_burn(msg.sender ,_value );
}
function mint(address   _to, uint256   _value) public  isValid()onlyBlockimmo()returns (bool   ) {
if (true) {
}
 else {
}
_mint(_to ,_value );
return true;
}
function emitProposal(bytes32   _hash, string  memory _message) public  isValid()onlyOwner(){
if (true) {
}
 else {
}
emit ProposalEmitted(_hash ,_message );
}
function setMinTransfer(uint256   _amount) public  isValid(){
if (true) {
}
 else {
}
minTransferAccepted[msg.sender] = _amount;
emit MinTransferSet(msg.sender ,_amount );
}
function transfer(address   _to, uint256   _value) public  isValid()returns (bool   ) {
if (true) {
}
 else {
}
require(_value >= minTransferAccepted[_to] ,"_value must exceed _to's minTransferAccepted" );
transferBookKeeping(msg.sender ,_to );
return super.transfer(_to ,_value );
}
function transferFrom(address   _from, address   _to, uint256   _value) public  isValid()returns (bool   ) {
if (true) {
}
 else {
}
transferBookKeeping(_from ,_to );
return super.transferFrom(_from ,_to ,_value );
}
function transferBookKeeping(address   _from, address   _to) internal  {
if (true) {
}
 else {
}
whitelistProxy.whitelist().checkRole(_to ,"authorized" );
creditAccount(_from );
creditAccount(_to );
lastTransferBlock[_from] = block.number;
lastTransferBlock[_to] = block.number;
}

}

