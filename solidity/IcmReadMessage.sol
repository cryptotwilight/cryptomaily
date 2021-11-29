// SPDX-License-Identifier:  APACHE 2.0

pragma solidity >=0.8.0 <0.9.0;


interface IcmReadMessage {

    function getTransferStatus() external view returns (string memory _transferStatus);

    function getRecipient() external view returns (address _recipient);

    function getSender() external view returns (address _sender);

    function getSubject() external view returns (string memory _subject); 

    function getMessage() external view returns (string memory _ipfsMessageHash);

    function getAttachments() external view returns (string [] memory attachmentTitle, string [] memory _ipfsAttachmentHashList);

    function getPouches() external view returns ( address [] memory _pouchList, uint256 _totalPouchValue, string memory _messageDenomination, uint256 _date);

    function detachPouch(string memory _pouchName) external returns (address _pouchAddress);

}