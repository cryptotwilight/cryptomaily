// SPDX-License-Identifier: Unlicensed

pragma solidity >=0.8.0 <0.9.0;

import "./IcmSushiLiquidityPoolProvider.sol";

contract SushiStub is IcmSushiLiquidityPoolProvider {

    function deposit(uint256 _amount) external payable returns (uint256 _depositedAmount){
        return _amount; 
    }

    function deposit(address _erc20, uint256 _amount) external payable returns (uint256 _depositedAmount){
        return _amount; 
    }

    function withdraw(address recipient) external returns (uint256 _returnedAmount){
        return 0; 
    }

}