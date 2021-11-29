// SPDX-License-Identifier:  APACHE 2.0

pragma solidity >=0.8.0 <0.9.0;

interface IcmChainlinkOracle {

    function getDenominatedValue(string memory _fromSymbol, string memory _toSymbol, uint256 _value) external view returns (uint256 _denominatedValue);

    function getDenominatedValue(address _fromErc20, address toErc20, uint256 _value) external view returns (uint256 _denominatedValue);

}