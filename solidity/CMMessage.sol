// SPDX-License-Identifier: Unlicensed

pragma solidity >=0.8.0 <0.9.0;

import "./IcmReadMessage.sol";
import "./IcmWriteMessage.sol";
import "./IcmPouch.sol";
import "./CMPouch.sol"; 
import "./IcmChainlinkOracle.sol";

contract CMMessage is IcmReadMessage, IcmWriteMessage {

    address sender; 
    address denomination_erc20; 
    string denomination_symbol; 
    address recipient; 
    string ipfsMessageHash;
    mapping(string=>address) pouchByName;
    mapping(string=>string) attachmentByName;

    string [] attachmentNames; 
    string [] attachmentHashes; 

    address [] pouchList; 
    uint256 pouchValueTotal; 
    uint256 pouchValueTotalDataDate; 

    string transferStatus       = "NIL";

    address postMan; 

    bool locked = false; 

    IcmChainlinkOracle chainlink;  

    address sushiLiquidityPoolProvider;
    address chainlinkOracleAddress; 

    uint256 attachmentCount; 

    constructor(address _sender, address _cmPostman, address _chainLinkOracle, address _sushiLiquidityPoolProvider) {
        sender = _sender;
        postMan = _cmPostman;  
        chainlink = IcmChainlinkOracle(_chainLinkOracle); 
        sushiLiquidityPoolProvider = _sushiLiquidityPoolProvider; 
        transferStatus = "DRAFT";
    }

    function setMessageDenomination(address _erc20, string memory _symbol) external returns (string memory _symb){
        isLocked();
        denomination_erc20 = _erc20; 
        denomination_symbol = _symbol; 
        return denomination_symbol;
    }

    function setRecipient(address _recipientAddress) external returns (address _recipient){
        isLocked();
        recipient = _recipientAddress;
        return recipient;
    }

    function setMessage(string memory _ipfsMessageHash) external returns (string memory _ipfsHash){
        isLocked();
        ipfsMessageHash = _ipfsMessageHash;
        return _ipfsHash;
    }

    function createPouch(string memory _name, address _pouchDenomination, string memory _pouchDenominationSymbol) external returns(address _pouchAddress){
        CMPouch pouch = new CMPouch(_name, address(this), sushiLiquidityPoolProvider, chainlinkOracleAddress, _pouchDenomination, _pouchDenominationSymbol);
        return address(pouch); // orphan pouch?
    }

    function addPouch(address _pouchAddress) external returns (uint256 _pouchCount, uint256 _totalPouchValue, string memory _messageDenomination){
        isLocked();
        IcmPouch pouch = IcmPouch(_pouchAddress);

        require(pouch.getOwner() == msg.sender, "pouch owner only");

        pouch.lock(recipient); // set the new owner to the destination of this message 

        pouchByName[pouch.getName()] = _pouchAddress; 
        pouchList.push(_pouchAddress);

        (uint256 fundsTotal_, string memory pouchDenomination_) = pouch.getFundsData();
       
       if(!isEqual(pouchDenomination_, denomination_symbol)){
       // convert to denomination with chainlink 
       uint256 denominatedValue_ = chainlink.getDenominatedValue(pouchDenomination_, denomination_symbol, fundsTotal_);

       // add to pouchValueTotal
            pouchValueTotal += denominatedValue_;
       }
       else { 
           pouchValueTotal += fundsTotal_; 
       }

       // update data date 
       pouchValueTotalDataDate = block.timestamp; 

       return (pouchList.length, pouchValueTotal, denomination_symbol);
    }

    function addAttachment(string memory _attachmentName, string memory _ipfsAttachmentHash) external returns (uint256 _attachmentCount){
        isLocked();
        attachmentByName[_attachmentName] = _ipfsAttachmentHash;
        return attachmentCount++;
    }

    function getTransferStatus() external view returns (string memory _transferStatus){
        return (transferStatus);
    }

    function getRecipient() external view returns (address _recipient){
        return recipient;
    }

    function getSender() external view returns (address _sender){
        return sender; 
    }

    function getMessage() external view returns (string memory _ipfsMessageHash){
        return ipfsMessageHash;
    }

    function getAttachments() external view returns (string [] memory attachmentTitle, string [] memory _ipfsAttachmentHashList){
        return (attachmentNames, attachmentHashes);
    }

    function getPouches() external view returns (address [] memory _pouchList, uint256 _totalPouchValue, string memory _messageDenomination, uint256 _date){
        return (pouchList, pouchValueTotal, denomination_symbol, _date);
    }

    function detachPouch(string memory _pouchName) external returns (address _pouchAddress){
        recipientOnly(); 
        IcmPouch pouch = IcmPouch(pouchByName[_pouchName]);
        pouch.unlock(); 
        return address(pouch);
    }

    function isLocked() view internal returns (bool) { 
        require(locked, "message is locked");
        return locked; 
    }

    function lock() external returns (bool ){
        postManOnly();
        locked = true; 
        return locked; 
    }

    function setTransferStatus(string memory _transferStatus) external returns (bool){
        postManOnly();
        transferStatus = _transferStatus; 
        return true; 
    }

    function postManOnly() view internal returns (bool) { 
        require(msg.sender == postMan, "postman only");
        return true; 
    }

    function recipientOnly() view internal returns (bool) {
        require(msg.sender == recipient, "recipient only");
        return true; 
    }

    function isEqual(string memory a, string memory b) pure internal returns (bool){
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }

}