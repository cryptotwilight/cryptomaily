// SPDX-License-Identifier:  APACHE 2.0
pragma solidity >=0.8.0 <0.9.0;


interface IcmSushiLiquidityPoolProvider {

    function deposit(uint256 _amount) external payable returns (uint256 _depositedAmount);    

    function deposit(address _erc20, uint256 _amount) external payable returns (uint256 _depositedAmount); 

    function withdraw(address recipient) external returns (uint256 _returnedAmount); 

}