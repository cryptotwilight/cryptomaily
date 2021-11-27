// SPDX-License-Identifier: Unlicensed

pragma solidity >=0.8.0 <0.9.0;


interface ICryptoMaily { 

    function getInboxMail() view external returns (address [] memory _messageAddresses);
    
    function getInboxMail(uint256 _dateMillis) external view returns (address [] memory _messageAddresses);

    function getSentMail() view external returns (address [] memory _messageAddresses);

    function getDrafts() external view returns (address [] memory _draftAddresses);

    function createMessage() external returns (address _messageAddress);

    function sendMessage(address _messageAddress) external returns (string memory _sendStatus);

    function deleteMessage(address _messageAddress) external returns (string memory _deleteStatus);

}