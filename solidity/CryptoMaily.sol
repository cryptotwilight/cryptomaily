// SPDX-License-Identifier: Unlicensed

pragma solidity >=0.8.0 <0.9.0;

import "./ICryptoMaily.sol";
import "./CMMessage.sol";

contract CryptoMaily is ICryptoMaily {

    struct MailBox {

        address owner; 
        address [] drafts; 
        address [] sent; 
        address [] recieved; 

        mapping(uint256=>bool) hasDateStatusByDate; 
        mapping(uint256=>address[]) messagesByDate; 
    }

    mapping(address=>MailBox) mailBoxByAddress; 
    mapping(address=>bool) hasMailboxStatusByAddress; 

    uint256 mailboxCount;

    address administrator;
    address chainlinkOracleAddress;
    address sushiLiquidityPoolProviderAddress; 

    mapping(address=>CMMessage) messageByMessageAddress; 

    constructor(address _administrator, address _chainlinkOracleAddress, address _sushiLiquidityPoolProviderAddress) {
        administrator = _administrator; 
        chainlinkOracleAddress = _chainlinkOracleAddress;
        sushiLiquidityPoolProviderAddress = _sushiLiquidityPoolProviderAddress; 
    }

    function getConfig() view external returns (address _chainLink, address _sushi, address _administrator, uint256 _mailboxCount){
        return (chainlinkOracleAddress, sushiLiquidityPoolProviderAddress, administrator, mailboxCount);
    }

    function getInboxMail() view external returns (address [] memory _messageAddresses){
        MailBox storage mailbox = mailBoxByAddress[msg.sender];
        return mailbox.recieved; 
    }
    
    function getInboxMail(uint256 _dateMillis) external view returns (address [] memory _messageAddresses){
        if(_dateMillis == 0) {
            _dateMillis = block.timestamp; 
        }
        MailBox storage mailbox = mailBoxByAddress[msg.sender];
        return mailbox.messagesByDate[getDay(_dateMillis)];
    }

    function getSentMail() view external returns (address [] memory _messageAddresses){
        MailBox storage mailbox = mailBoxByAddress[msg.sender];
        return mailbox.sent; 
    }    

    function getDrafts() external view returns (address [] memory _draftAddresses) {
        MailBox storage mailbox = mailBoxByAddress[msg.sender];
        return mailbox.drafts; 
    }

    function createMessage() external returns (address _messageAddress){
        MailBox storage mailbox = mailBoxByAddress[msg.sender];
        CMMessage message = new CMMessage(msg.sender, address(this), chainlinkOracleAddress, sushiLiquidityPoolProviderAddress);
        mailbox.drafts.push(address(message));
        return address(message); 
    }

    function sendMessage(address _messageAddress) external returns (string memory _sendStatus){
        CMMessage message = messageByMessageAddress[_messageAddress];
        message.lock(); 
              
        MailBox storage mailbox = mailBoxByAddress[message.getRecipient()];
        address msgAddress = address(message); 
        mailbox.recieved.push(msgAddress);
        
        message.setTransferStatus("SENT");

        uint256 moment = block.timestamp; 

        uint256 day = getDay(moment);

        mailbox.messagesByDate[day].push(msgAddress);
        // emit event 
        message.setTransferStatus("SENT");

        MailBox storage sourceMailbox = mailBoxByAddress[message.getSender()];
        sourceMailbox.sent.push(msgAddress);
        sourceMailbox.drafts = deleteAddress(msgAddress, sourceMailbox.drafts);

        return "SENT";
    }

    function deleteMessage(address _messageAddress) external returns (string memory _deleteStatus){

        CMMessage message = CMMessage(_messageAddress);
        string memory transferStatus  = message.getTransferStatus(); 
        MailBox storage mailbox = mailBoxByAddress[msg.sender];

        if(isEqual("DRAFT", transferStatus)) { 
            mailbox.drafts = deleteAddress(_messageAddress,  mailbox.drafts);
            return "DELETED - DRAFT";
        }
        if(isEqual("SENT", transferStatus)){
            if(message.getSender() == msg.sender){
                mailbox.sent = deleteAddress(_messageAddress,  mailbox.sent);
                return "DELETED - SENT";
            }
            else{
                mailbox.recieved = deleteAddress(_messageAddress,  mailbox.recieved);
                return "DELETED - RECIEVED";
            }                
        }

    }

    function setChainlink(address _chainlinkOracleAddress) external returns (address _chainlink){
        administratorOnly();
        chainlinkOracleAddress = _chainlinkOracleAddress; 
        return chainlinkOracleAddress;
    }

    function setSuchiLiquidityPoolProvider(address _sushiAddress) external returns (address _sushi){
        administratorOnly(); 
        sushiLiquidityPoolProviderAddress = _sushiAddress; 
        return sushiLiquidityPoolProviderAddress;
    }

    function setAdministrator (address _administrator ) external returns (address _admin){
        administratorOnly(); 
        administrator = _administrator; 
        return administrator; 
    }


     
    function administratorOnly() internal view returns (bool _admin){
        require(msg.sender == administrator," administrator only ");
        return true; 
    }

    function deleteAddress(address ad, address [] memory  addresses) internal pure returns (address [] memory _addresses) { 
        address [] memory newList = new address[](addresses.length-1); 
        uint256 y = 0; 
        for(uint256 x = 0; x < addresses.length; x ++) { 
            if(ad != addresses[x]){
                addresses[x] = newList[y];
                y++;
            }
        }
        return newList; 
    } 
    
    function getDay(uint256 _moment) internal pure returns (uint256 _day){
        return _moment - (_moment % 64800);
    }


    function isEqual(string memory a, string memory b) pure internal returns (bool){
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }
}
