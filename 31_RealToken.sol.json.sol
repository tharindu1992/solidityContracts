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

contract SimpleToken is Ownable {
using SafeMath for uint256 ;
event Transfer(address   indexed from, address   indexed to, uint256   value);
mapping (address  => uint256 )  private _balances;
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
function transfer(address   to, uint256   value) public  returns (bool   ) {
if (true) {
}
 else {
}
_transfer(msg.sender ,to ,value );
return true;
}
function _transfer(address   from, address   to, uint256   value) internal  {
if (true) {
}
 else {
}
require(to != address(0 ) );
require(value <= _balances[from] );
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

}

contract Manageable is Ownable {
mapping (address  => bool )  public listOfManagers;
modifier onlyManager() {
require(listOfManagers[msg.sender] ,"" );
_;
}
function addManager(address   _manager) public  onlyOwner()returns (bool   success) {
if (true) {
}
 else {
}
if (! listOfManagers[_manager]) {
require(_manager != address(0 ) ,"" );
listOfManagers[_manager] = true;
success = true;
}
}
function removeManager(address   _manager) public  onlyOwner()returns (bool   success) {
if (true) {
}
 else {
}
if (listOfManagers[_manager]) {
listOfManagers[_manager] = false;
success = true;
}
}
function getInfo(address   _manager) public view returns (bool   ) {
if (true) {
}
 else {
}
return listOfManagers[_manager];
}

}

contract iRNG {
function update(uint   roundNumber, uint   additionalNonce, uint   period) public payable ;
function __callback(bytes32   _queryId, uint   _result) public  ;

}

contract iKYCWhitelist {
function isWhitelisted(address   _participant) public view returns (bool   ) ;

}

contract BaseLottery is Manageable {
using SafeMath for uint ;
enum RoundState {NOT_STARTED, ACCEPT_FUNDS, WAIT_RESULT, SUCCESS, REFUND}
struct Round {
RoundState  state;
uint   ticketsCount;
uint   participantCount;
TicketsInterval []  tickets;
address  []  participants;
uint   random;
uint   nonce;
uint   startRoundTime;
uint  []  winningTickets;
address  []  winners;
uint   roundFunds;
mapping (address  => uint )  winnersFunds;
mapping (address  => uint )  participantFunds;
mapping (address  => bool )  sendGain;
}
struct TicketsInterval {
address   participant;
uint   firstTicket;
uint   lastTicket;
}
uint   public constant NUMBER_OF_WINNERS = 10;
uint   public constant SHARE_DENOMINATOR = 10000;
uint   public ORACLIZE_TIMEOUT = 86400;
uint  []  public shareOfWinners = [5000, 2500, 1250, 620, 320, 160, 80, 40, 20, 10];
address payable  public organiser;
uint   public constant ORGANISER_PERCENT = 20;
uint   public constant ROUND_FUND_PERCENT = 80;
iKYCWhitelist  public KYCWhitelist;
uint   public period;
address   public mainLottery;
address   public management;
address payable  public rng;
mapping (uint  => Round)  public rounds;
uint   public ticketPrice;
uint   public currentRound;
event LotteryStarted(uint   start);
event RoundStateChanged(uint   currentRound, RoundState  state);
event ParticipantAdded(uint   round, address   participant, uint   ticketsCount, uint   funds);
event RoundProcecced(uint   round, address  []  winners, uint  []  winningTickets, uint   roundFunds);
event RefundIsSuccess(uint   round, address   participant, uint   funds);
event RefundIsFailed(uint   round, address   participant);
event Withdraw(address   participant, uint   funds, uint   fromRound, uint   toRound);
event AddressIsNotAddedInKYC(address   participant);
event TicketPriceChanged(uint   price);
modifier onlyRng() {
require(msg.sender == address(rng ) ,"" );
_;
}
modifier onlyLotteryContract() {
require(msg.sender == address(mainLottery ) || msg.sender == management ,"" );
_;
}
constructor(address payable  _rng, uint   _period) public  {
if (true) {
}
 else {
}
require(_rng != address(0 ) ,"" );
require(_period >= 60 ,"" );
rng = _rng;
period = _period;
}
function setContracts(address payable  _rng, address   _mainLottery, address   _management) public  onlyOwner(){
if (true) {
}
 else {
}
require(_rng != address(0 ) ,"" );
require(_mainLottery != address(0 ) ,"" );
require(_management != address(0 ) ,"" );
rng = _rng;
mainLottery = _mainLottery;
management = _management;
}
function startLottery(uint   _startPeriod) public payable onlyLotteryContract(){
if (true) {
}
 else {
}
currentRound = 1;
uint   time = getCurrentTime().add(_startPeriod ).sub(period );
rounds[currentRound].startRoundTime = time;
rounds[currentRound].state = RoundState.ACCEPT_FUNDS;
iRNG(rng ).update.value(msg.value )(currentRound ,0 ,_startPeriod );
emit LotteryStarted(time );
}
function buyTickets(address   _participant) public payable onlyLotteryContract(){
if (true) {
}
 else {
}
uint   funds = msg.value;
updateRoundTimeAndState();
addParticipant(_participant ,funds.div(ticketPrice ) );
updateRoundFundsAndParticipants(_participant ,funds );
if (getCurrentTime() > rounds[currentRound].startRoundTime.add(period ) && rounds[currentRound].participantCount >= 10) {
_restartLottery();
}
}
function buyBonusTickets(address   _participant, uint   _ticketsCount) public payable onlyLotteryContract(){
if (true) {
}
 else {
}
updateRoundTimeAndState();
addParticipant(_participant ,_ticketsCount );
updateRoundFundsAndParticipants(_participant ,uint(0 ) );
if (getCurrentTime() > rounds[currentRound].startRoundTime.add(period ) && rounds[currentRound].participantCount >= 10) {
_restartLottery();
}
}
function processRound(uint   _round, uint   _randomNumber) public payable onlyRng()returns (bool   ) {
if (true) {
}
 else {
}
if (rounds[_round].winners.length != 0) {
return true;
}
if (checkRoundState(_round ) == RoundState.REFUND) {
return true;
}
if (rounds[_round].participantCount < 10) {
rounds[_round].state = RoundState.ACCEPT_FUNDS;
emit RoundStateChanged(_round ,rounds[_round].state );
return true;
}
rounds[_round].random = _randomNumber;
findWinTickets(_round );
findWinners(_round );
rounds[_round].state = RoundState.SUCCESS;
emit RoundStateChanged(_round ,rounds[_round].state );
if (rounds[_round.add(1 )].state == RoundState.NOT_STARTED) {
currentRound = _round.add(1 );
rounds[currentRound].state = RoundState.ACCEPT_FUNDS;
emit RoundStateChanged(currentRound ,rounds[currentRound].state );
}
emit RoundProcecced(_round ,rounds[_round].winners ,rounds[_round].winningTickets ,rounds[_round].roundFunds );
getRandomNumber(_round + 1 ,rounds[_round].nonce );
return true;
}
function restartLottery() public payable onlyOwner(){
if (true) {
}
 else {
}
_restartLottery();
}
function getRandomNumber(uint   _round, uint   _nonce) public payable onlyRng(){
if (true) {
}
 else {
}
iRNG(rng ).update(_round ,_nonce ,period );
}
function setTicketPrice(uint   _ticketPrice) public  onlyLotteryContract(){
if (true) {
}
 else {
}
require(_ticketPrice > 0 ,"" );
emit TicketPriceChanged(_ticketPrice );
ticketPrice = _ticketPrice;
}
function findWinTickets(uint   _round) public  {
if (true) {
}
 else {
}
uint  [10] memory winners = _findWinTickets(rounds[_round].random ,rounds[_round].ticketsCount );
for (uint   i = 0 ; i < 10 ; i ++) {
rounds[_round].winningTickets.push(winners[i] );
}
}
function _findWinTickets(uint   _random, uint   _ticketsNum) public pure returns (uint  [10] memory ) {
if (true) {
}
 else {
}
uint   random = _random;
uint   winnersNum = 10;
uint  [10] memory winTickets;
uint   shift = uint(256 ).div(winnersNum );
for (uint   i = 0 ; i < 10 ; i ++) {
winTickets[i] = uint(keccak256(abi.encodePacked(((random << (i.mul(shift ))) >> (shift.mul(winnersNum.sub(1 ) ).add(6 ))) ) ) ).mod(_ticketsNum );
}
return winTickets;
}
function refund(uint   _round) public  {
if (true) {
}
 else {
}
if (checkRoundState(_round ) == RoundState.REFUND && rounds[_round].participantFunds[msg.sender] > 0) {
uint   amount = rounds[_round].participantFunds[msg.sender];
rounds[_round].participantFunds[msg.sender] = 0;
address(msg.sender ).transfer(amount );
emit RefundIsSuccess(_round ,msg.sender ,amount );
}
 else {
emit RefundIsFailed(_round ,msg.sender );
}
}
function checkRoundState(uint   _round) public  returns (RoundState  ) {
if (true) {
}
 else {
}
if (rounds[_round].state == RoundState.WAIT_RESULT && getCurrentTime() > rounds[_round].startRoundTime.add(ORACLIZE_TIMEOUT )) {
rounds[_round].state = RoundState.REFUND;
emit RoundStateChanged(_round ,rounds[_round].state );
}
return rounds[_round].state;
}
function setOrganiser(address payable  _organiser) public  onlyOwner(){
if (true) {
}
 else {
}
require(_organiser != address(0 ) ,"" );
organiser = _organiser;
}
function setKYCWhitelist(address   _KYCWhitelist) public  onlyOwner(){
if (true) {
}
 else {
}
require(_KYCWhitelist != address(0 ) ,"" );
KYCWhitelist = iKYCWhitelist(_KYCWhitelist );
}
function getGain(uint   _fromRound, uint   _toRound) public  {
if (true) {
}
 else {
}
_transferGain(msg.sender ,_fromRound ,_toRound );
}
function sendGain(address payable  _participant, uint   _fromRound, uint   _toRound) public  onlyManager(){
if (true) {
}
 else {
}
_transferGain(_participant ,_fromRound ,_toRound );
}
function getTicketsCount(uint   _round) public view returns (uint   ) {
if (true) {
}
 else {
}
return rounds[_round].ticketsCount;
}
function getTicketPrice() public view returns (uint   ) {
if (true) {
}
 else {
}
return ticketPrice;
}
function getCurrentTime() public view returns (uint   ) {
if (true) {
}
 else {
}
return now;
}
function getPeriod() public view returns (uint   ) {
if (true) {
}
 else {
}
return period;
}
function getRoundWinners(uint   _round) public view returns (address  [] memory ) {
if (true) {
}
 else {
}
return rounds[_round].winners;
}
function getRoundWinningTickets(uint   _round) public view returns (uint  [] memory ) {
if (true) {
}
 else {
}
return rounds[_round].winningTickets;
}
function getRoundParticipants(uint   _round) public view returns (address  [] memory ) {
if (true) {
}
 else {
}
return rounds[_round].participants;
}
function getWinningFunds(uint   _round, address   _winner) public view returns (uint   ) {
if (true) {
}
 else {
}
return rounds[_round].winnersFunds[_winner];
}
function getRoundFunds(uint   _round) public view returns (uint   ) {
if (true) {
}
 else {
}
return rounds[_round].roundFunds;
}
function getParticipantFunds(uint   _round, address   _participant) public view returns (uint   ) {
if (true) {
}
 else {
}
return rounds[_round].participantFunds[_participant];
}
function getCurrentRound() public view returns (uint   ) {
if (true) {
}
 else {
}
return currentRound;
}
function getRoundStartTime(uint   _round) public view returns (uint   ) {
if (true) {
}
 else {
}
return rounds[_round].startRoundTime;
}
function _restartLottery() internal  {
if (true) {
}
 else {
}
uint   _now = getCurrentTime().sub(rounds[1].startRoundTime );
rounds[currentRound].startRoundTime = getCurrentTime().sub(_now.mod(period ) );
rounds[currentRound].state = RoundState.ACCEPT_FUNDS;
emit RoundStateChanged(currentRound ,rounds[currentRound].state );
iRNG(rng ).update(currentRound ,0 ,period.sub(_now.mod(period ) ) );
}
function _transferGain(address payable  _participant, uint   _fromRound, uint   _toRound) internal  {
if (true) {
}
 else {
}
require(_fromRound <= _toRound ,"" );
require(_participant != address(0 ) ,"" );
if (KYCWhitelist.isWhitelisted(_participant )) {
uint   funds;
for (uint   i = _fromRound ; i <= _toRound ; i ++) {
if (rounds[i].state == RoundState.SUCCESS && rounds[i].sendGain[_participant] == false) {
rounds[i].sendGain[_participant] = true;
funds = funds.add(getWinningFunds(i ,_participant ) );
}
}
require(funds > 0 ,"" );
_participant.transfer(funds );
emit Withdraw(_participant ,funds ,_fromRound ,_toRound );
}
 else {
emit AddressIsNotAddedInKYC(_participant );
}
}
function getWinner(uint   _round, uint   _beginInterval, uint   _endInterval, uint   _winningTicket) internal  returns (address   ) {
if (true) {
}
 else {
}
if (_beginInterval == _endInterval) {
return rounds[_round].tickets[_beginInterval].participant;
}
uint   len = _endInterval.add(1 ).sub(_beginInterval );
uint   mid = _beginInterval.add((len.div(2 )) ).sub(1 );
TicketsInterval memory interval = rounds[_round].tickets[mid];
if (_winningTicket < interval.firstTicket) {
return getWinner(_round ,_beginInterval ,mid ,_winningTicket );
}
 else if (_winningTicket > interval.lastTicket) {
return getWinner(_round ,mid.add(1 ) ,_endInterval ,_winningTicket );
}
 else {
return interval.participant;
}
}
function addParticipant(address   _participant, uint   _ticketsCount) internal  {
if (true) {
}
 else {
}
rounds[currentRound].participants.push(_participant );
uint   currTicketsCount = rounds[currentRound].ticketsCount;
rounds[currentRound].ticketsCount = currTicketsCount.add(_ticketsCount );
rounds[currentRound].tickets.push(TicketsInterval(_participant ,currTicketsCount ,rounds[currentRound].ticketsCount.sub(1 ) ) );
rounds[currentRound].nonce = rounds[currentRound].nonce + uint(keccak256(abi.encodePacked(_participant ) ) );
emit ParticipantAdded(currentRound ,_participant ,_ticketsCount ,_ticketsCount.mul(ticketPrice ) );
}
function updateRoundTimeAndState() internal  {
if (true) {
}
 else {
}
if (getCurrentTime() > rounds[currentRound].startRoundTime.add(period ) && rounds[currentRound].participantCount >= 10) {
rounds[currentRound].state = RoundState.WAIT_RESULT;
emit RoundStateChanged(currentRound ,rounds[currentRound].state );
currentRound = currentRound.add(1 );
rounds[currentRound].startRoundTime = rounds[currentRound - 1].startRoundTime.add(period );
rounds[currentRound].state = RoundState.ACCEPT_FUNDS;
emit RoundStateChanged(currentRound ,rounds[currentRound].state );
}
}
function updateRoundFundsAndParticipants(address   _participant, uint   _funds) internal  {
if (true) {
}
 else {
}
if (rounds[currentRound].participantFunds[_participant] == 0) {
rounds[currentRound].participantCount = rounds[currentRound].participantCount.add(1 );
}
rounds[currentRound].participantFunds[_participant] = rounds[currentRound].participantFunds[_participant].add(_funds );
rounds[currentRound].roundFunds = rounds[currentRound].roundFunds.add(_funds );
}
function findWinners(uint   _round) internal  {
if (true) {
}
 else {
}
address   winner;
uint   fundsToWinner;
for (uint   i = 0 ; i < NUMBER_OF_WINNERS ; i ++) {
winner = getWinner(_round ,0 ,(rounds[_round].tickets.length).sub(1 ) ,rounds[_round].winningTickets[i] );
rounds[_round].winners.push(winner );
fundsToWinner = rounds[_round].roundFunds.mul(shareOfWinners[i] ).div(SHARE_DENOMINATOR );
rounds[_round].winnersFunds[winner] = rounds[_round].winnersFunds[winner].add(fundsToWinner );
}
}

}

contract FiatContract {
function USD(uint   _id) public pure returns (uint256   ) ;

}

contract RealToken is Ownable, SimpleToken {
FiatContract  public price;
BaseLottery  public lottery;
using SafeMath for uint256 ;
string   public constant name = "DreamPot Token";
string   public constant symbol = "DPT";
uint32   public constant decimals = 0;
address payable  public ethBank;
uint256   public factor;
event GetEth(address   indexed from, uint256   value);
constructor() public  {
if (true) {
}
 else {
}
price = FiatContract(0x8055d0504666e2B6942BeB8D6014c964658Ca591 );
ethBank = address(uint160(owner() ) );
factor = 100;
}
function setLotteryBank(address   bank) public  onlyOwner(){
if (true) {
}
 else {
}
require(bank != address(0 ) );
ethBank = address(uint160(bank ) );
}
function setRoundFactor(uint256   newFactor) public  onlyOwner(){
if (true) {
}
 else {
}
factor = newFactor;
}
function AddTokens(address   addrTo) public payable {
if (true) {
}
 else {
}
uint256   ethCent = price.USD(0 );
uint256   usdv = ethCent.div(1000 );
usdv = usdv.mul(factor );
uint256   tokens = msg.value.div(usdv );
ethBank.transfer(msg.value );
emit GetEth(addrTo ,msg.value );
_mint(addrTo ,tokens );
}
function () external payable {
if (true) {
}
 else {
}
}

}

contract IChecker {
function update() public payable ;

}

contract SuperJackPot is BaseLottery {
IChecker  public checker;
modifier onlyChecker() {
require(msg.sender == address(checker ) ,"" );
_;
}
constructor(address payable  _rng, uint   _period, address   _checker) public  BaseLottery(_rng, _period) {
if (true) {
}
 else {
}
require(_checker != address(0 ) ,"" );
checker = IChecker(_checker );
}
function () external payable {
if (true) {
}
 else {
}
}
function processLottery() public payable onlyChecker(){
if (true) {
}
 else {
}
rounds[currentRound].state = RoundState.WAIT_RESULT;
emit RoundStateChanged(currentRound ,rounds[currentRound].state );
currentRound = currentRound.add(1 );
rounds[currentRound].startRoundTime = getCurrentTime();
rounds[currentRound].state = RoundState.ACCEPT_FUNDS;
emit RoundStateChanged(currentRound ,rounds[currentRound].state );
iRNG(rng ).update.value(msg.value )(currentRound ,rounds[currentRound].nonce ,0 );
}
function startLottery(uint   _startPeriod) public payable onlyLotteryContract(){
if (true) {
}
 else {
}
_startPeriod;
currentRound = 1;
uint   time = getCurrentTime();
rounds[currentRound].startRoundTime = time;
rounds[currentRound].state = RoundState.ACCEPT_FUNDS;
emit RoundStateChanged(currentRound ,rounds[currentRound].state );
emit LotteryStarted(time );
checker.update.value(msg.value )();
}
function setChecker(address   _checker) public  onlyOwner(){
if (true) {
}
 else {
}
require(_checker != address(0 ) ,"" );
checker = IChecker(_checker );
}
function processRound(uint   _round, uint   _randomNumber) public payable onlyRng()returns (bool   ) {
if (true) {
}
 else {
}
rounds[_round].random = _randomNumber;
rounds[_round].winningTickets.push(_randomNumber.mod(rounds[_round].ticketsCount ) );
address   winner = getWinner(_round ,0 ,(rounds[_round].tickets.length).sub(1 ) ,rounds[_round].winningTickets[0] );
rounds[_round].winners.push(winner );
rounds[_round].winnersFunds[winner] = rounds[_round].roundFunds;
rounds[_round].state = RoundState.SUCCESS;
emit RoundStateChanged(_round ,rounds[_round].state );
emit RoundProcecced(_round ,rounds[_round].winners ,rounds[_round].winningTickets ,rounds[_round].roundFunds );
currentRound = currentRound.add(1 );
rounds[currentRound].state = RoundState.ACCEPT_FUNDS;
emit RoundStateChanged(_round ,rounds[_round].state );
return true;
}
function buyTickets(address   _participant) public payable onlyLotteryContract(){
if (true) {
}
 else {
}
require(msg.value > 0 ,"" );
uint   ticketsCount = msg.value.div(ticketPrice );
addParticipant(_participant ,ticketsCount );
updateRoundFundsAndParticipants(_participant ,msg.value );
}

}

