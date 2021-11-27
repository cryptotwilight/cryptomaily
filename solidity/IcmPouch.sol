// SPDX-License-Identifier: Unlicensed

pragma solidity >=0.8.0 <0.9.0;


interface IcmPouch {

    function getCreator() external view returns (address _pouchCreatorAddress);

    function getOwner() external view returns (address _pouchOwnerAddress);

    function getName() external view returns (string memory pouchName);

    function getFundsData() external view returns (uint256 _fundsTotal, string memory _pouchDenomination);

    function getStatus() external view  returns (bool _isDetached, string memory _status, uint256 _fundsTotal, string memory _pouchDenomination, uint256 _nftCount);

    function storeFunds(uint256 _funds, address _erc20) external payable returns (uint256 _pouchTotal);

    function pullFunds() external returns (address [] memory _erc20List, uint256 _pouchTotal);

    function storeNFT(uint256 _id, address _eip1559) external returns (uint256 _nftTotal);

    function pullNFTs() external returns (address [] memory _nftContractList, uint256 _nftTotal);

    function transferTo(address _newOnwer) external returns (bool _isTransfered);

    function lock(address _owner) external returns (bool _locked);

    function unlock() external returns (bool _locked);

}