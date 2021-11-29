// SPDX-License-Identifier:  APACHE 2.0

pragma solidity >=0.8.0 <0.9.0;

import "./IcmPouch.sol";
import "./IcmSushiLiquidityPoolProvider.sol"; 
import "./IcmChainlinkOracle.sol";
import "./IERC20.sol"; 


contract CMPouch is IcmPouch {

    uint256 version = uint256(2);

    IcmSushiLiquidityPoolProvider sushi; 
    IcmChainlinkOracle chainlink;

    address creator;     
    address owner; 
    address messageAddress; 

    string name; 
    
    string pouchDenominationSymbol;
    address pouchDenomination; 
    
    uint256 pouchFundsTotal;  
    uint256 nftCount; 

    string status; 

    address NATIVE = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE; 

    IERC20 [] erc20List; 
    address [] erc20AddressList;

    bool locked = false; 

    constructor (string memory _name, 
                    address _messageAddress, 
                    address _sushiLiquidityPoolProvider, 
                    address _chainlinkOracleAddress, address _pouchDenomination, string memory _pouchDenominationSymbol ) {

        creator = msg.sender; 
        name = _name; 
        messageAddress = _messageAddress; 
        pouchDenomination = _pouchDenomination; 
        pouchDenominationSymbol = _pouchDenominationSymbol;

        sushi = IcmSushiLiquidityPoolProvider(_sushiLiquidityPoolProvider);
        chainlink = IcmChainlinkOracle(_chainlinkOracleAddress);

    }

    function getVersion() external view returns (uint256 _version) {
        return version;  
    }

    function getCreator() external view returns (address _pouchCreatorAddress){
        return creator; 
    }

    function getOwner() external view returns (address _pouchOwnerAddress){
        return owner; 
    }

    function getName() external view returns (string memory _pouchName){
        return name; 
    }

    function getFundsData() external view returns (uint256 _fundsTotal, string memory _pouchDenominationSymbol){
        return (pouchFundsTotal, pouchDenominationSymbol); 
    }

    function getStatus() external view  returns (bool _isLocked, string memory _status, uint256 _fundsTotal, string memory _pouchDenominationSymbol, uint256 _nftCount){
        return(locked, status, pouchFundsTotal, pouchDenominationSymbol, nftCount);
    }

    function storeFunds(uint256 _funds, address _erc20) external payable returns (uint256 _pouchTotal){
        require(msg.value == _funds, "insufficient funds transmitted");
        IERC20 erc20 = IERC20(_erc20);
        if(_erc20 == NATIVE){
            sushi.deposit{value : _funds}(_funds);
        }
        else {
            
            erc20.transferFrom(msg.sender, address(this), _funds); 

            erc20.approve(address(sushi), _funds);
            sushi.deposit(_erc20, _funds); 
        }
        
        erc20List.push(erc20);
        erc20AddressList.push(_erc20);

        if (_erc20 == pouchDenomination){
            pouchFundsTotal += _funds;
        }
        else {
            pouchFundsTotal += chainlink.getDenominatedValue(_erc20,pouchDenomination,_funds );
        }
        status = "FUNDED";
        return pouchFundsTotal;
    }

    function pullFunds() external returns (address [] memory _erc20List, uint256 _pouchTotal){
        ownerOnly();
        sushi.withdraw(owner);
        status = "LIQUIDATED";
        return (erc20AddressList, pouchFundsTotal);
    }
    
    //@todo
    function storeNFT(uint256 _id, address _eip1559) external returns (uint256 _nftTotal){
    
    }

    //@todo
    function pullNFTs() external returns (address [] memory _nftContractList, uint256 _nftTotal){

    }

    function transferTo(address _newOwner) external returns (bool _isTransfered){
        isLocked();
        owner = _newOwner; 
        return true; 
    }    

    function lock(address _owner) external returns (bool _locked){
        messageOnly();
        owner = _owner; 
        locked = true; 
        return locked; 
    }
    
    function unlock() external returns (bool _locked){
        messageOnly(); 
        locked = false;  
        return locked;    
    }

    function isLocked() view internal returns (bool _locked) {
        require(locked, "pouch locked.");
        return locked; 
    }


    function ownerOnly() view internal returns (bool) {
        require(msg.sender == owner, "owner only");
        return true; 
    }


    function messageOnly() view internal returns (bool) { 
        require(msg.sender == messageAddress, "message only");
        return true; 
    }

}