// SPDX-License-Identifier:  APACHE 2.0

pragma solidity >=0.8.0 <0.9.0;


interface IcmWriteMessage {

  function getPouchList() external returns (address [] memory _pouchList);

  function getAttachmentList() external returns (string [] memory _attachmentName, string [] memory _ipfsAttachmentHash);

  function setMessageDenomination(address _erc20, string memory _symbol) external returns (string memory _symb);

  function setRecipient(address _recipientAddress) external returns (address _recipient); 

  function setMessage(address _recipientAddress, string memory _subject, string memory _ipfsMessageHash) external returns (bool _set);

  function createPouch(string memory _name, address _pouchDenomination, string memory _pouchDenominationSymbol) external returns(address _pouchAddress);

  function addPouch( address _pouchAddress) external returns (uint256 _pouchCount, uint256 _totalPouchValue, string memory _messageDenomination);

  function addAttachment(string memory _attachmentName, string memory _ipfsAttachmentHash) external returns (uint256 _attachmentCount);


}
