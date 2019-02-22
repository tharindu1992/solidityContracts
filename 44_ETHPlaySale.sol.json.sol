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

contract ReentrancyGuard {
uint256   private _guardCounter;
constructor() internal  {
if (true) {
}
 else {
}
_guardCounter = 1;
}
modifier nonReentrant() {
_guardCounter += 1;
uint256   localCounter = _guardCounter;
_;
require(localCounter == _guardCounter );
}

}

contract ETHPlaySale is ReentrancyGuard {
using SafeMath for uint256 ;
using SafeERC20 for IERC20;
IERC20  private _token;
address payable  private _wallet;
uint256   private _rate;
uint256   private _weiRaised;
event TokensPurchased(address   indexed purchaser, address   indexed beneficiary, uint256   value, uint256   amount);
constructor(uint256   rate, address payable  wallet, IERC20  token) public  {
if (true) {
}
 else {
}
require(rate > 0 );
require(wallet != address(0 ) );
require(address(token ) != address(0 ) );
_rate = rate;
_wallet = wallet;
_token = token;
}
function () external payable {
if (true) {
}
 else {
}
buyTokens(msg.sender );
}
function token() public view returns (IERC20  ) {
if (true) {
}
 else {
}
return _token;
}
function wallet() public view returns (address payable  ) {
if (true) {
}
 else {
}
return _wallet;
}
function rate() public view returns (uint256   ) {
if (true) {
}
 else {
}
return _rate;
}
function weiRaised() public view returns (uint256   ) {
if (true) {
}
 else {
}
return _weiRaised;
}
function buyTokens(address   beneficiary) public payable nonReentrant(){
if (true) {
}
 else {
}
uint256   weiAmount = msg.value;
_preValidatePurchase(beneficiary ,weiAmount );
uint256   tokens = _getTokenAmount(weiAmount );
_weiRaised = _weiRaised.add(weiAmount );
_processPurchase(beneficiary ,tokens );
emit TokensPurchased(msg.sender ,beneficiary ,weiAmount ,tokens );
_updatePurchasingState(beneficiary ,weiAmount );
_forwardFunds();
_postValidatePurchase(beneficiary ,weiAmount );
}
function _preValidatePurchase(address   beneficiary, uint256   weiAmount) internal view {
if (true) {
}
 else {
}
require(beneficiary != address(0 ) );
require(weiAmount != 0 );
}
function _postValidatePurchase(address   beneficiary, uint256   weiAmount) internal view {
if (true) {
}
 else {
}
}
function _deliverTokens(address   beneficiary, uint256   tokenAmount) internal  {
if (true) {
}
 else {
}
_token.safeTransfer(beneficiary ,tokenAmount );
}
function _processPurchase(address   beneficiary, uint256   tokenAmount) internal  {
if (true) {
}
 else {
}
_deliverTokens(beneficiary ,tokenAmount );
}
function _updatePurchasingState(address   beneficiary, uint256   weiAmount) internal  {
if (true) {
}
 else {
}
}
function _getTokenAmount(uint256   weiAmount) internal view returns (uint256   ) {
if (true) {
}
 else {
}
return weiAmount.mul(_rate );
}
function _forwardFunds() internal  {
if (true) {
}
 else {
}
_wallet.transfer(msg.value );
}

}

