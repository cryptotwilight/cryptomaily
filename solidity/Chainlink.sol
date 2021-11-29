
// SPDX-License-Identifier:  APACHE 2.0

pragma solidity >=0.8.0 < 0.9.0;

import "./IcmChainlinkOracle.sol";
import "./IERC20.sol"; 

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


contract Chainlink is IcmChainlinkOracle {

    uint256 version = uint256(2);

    address administrator;    

    IERC20 link;  

    mapping(string=>AggregatorV3Interface) feedBySymbol; 
    mapping(address=>string) symbolByERc20Address; 

    string [] symbols; 
    address [] erc20Addresses; 
    address [] feeds; 

    constructor(address _administrator, address _linkAddress){
        administrator = _administrator; 
        link = IERC20(_linkAddress);
    
    }

    function getVersion() external view returns (uint256 _version ){
        return version; 
    }

    function getConfig() external view returns (string [] memory _symbols, address [] memory _erc20Addresses, address [] memory _feedAddresses, uint256 _availableLink){
        return (symbols, erc20Addresses, feeds, link.balanceOf(address(this)) );
    }

    function getDenominatedValue(string memory _fromSymbol, string memory _toSymbol, uint256 _value) external view returns (uint256 _denominatedValue){
        uint256 fromPrice = uint256(getPrice(_fromSymbol)); 
        uint256 toPrice = uint256(getPrice(_toSymbol)); 

        _denominatedValue = (fromPrice/toPrice) * _value; 
        
        return _denominatedValue; 
    }

    function getDenominatedValue(address _fromErc20, address _toErc20, uint256 _value) external view returns (uint256 _denominatedValue){
        string memory fromSymbol_ = symbolByERc20Address[_fromErc20];
        string memory toSymbol_ = symbolByERc20Address[_toErc20];
        return this.getDenominatedValue(fromSymbol_, toSymbol_, _value);
    }

    function getPrice(string memory symbol) internal view returns (int _price){
        AggregatorV3Interface feed = feedBySymbol[symbol];
         (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = feed.latestRoundData();

        return price; 
    }

    function addFeed(string memory _symbol, address _erc20Address, address _chainlinkFeedAddress) external returns (uint256 _feedCount) { 
        administratorOnly();
        symbols.push( _symbol);
        erc20Addresses.push(_erc20Address);
        feeds.push(_chainlinkFeedAddress);

        feedBySymbol[_symbol] = AggregatorV3Interface(_chainlinkFeedAddress);
        symbolByERc20Address[_erc20Address] = _symbol;

        return feeds.length;      

    }

    function fundLink(uint256 _amount) external returns (uint256 _fundsAvailable) {
        administratorOnly();        
        link.transferFrom(administrator, address(this) , _amount);
        return link.balanceOf(address(this)); 
    }

    function recoverFunds() external returns (uint256 _recoveredFunds) {
        administratorOnly();
        uint256 bal = link.balanceOf(address(this));
        link.transfer(administrator, bal);
        return bal; 
    }

    function administratorOnly() internal view returns (bool isAdmin){
        require(msg.sender == administrator, "administrator only"); 
        return true; 
    }

}


