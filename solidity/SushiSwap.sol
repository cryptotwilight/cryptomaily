// SPDX-License-Identifier:  APACHE 2.0
pragma solidity >=0.6.12;

import "./IcmSushiLiquidityPoolProvider.sol";
import "./IERC20.sol"; 


contract SushiSwap is IcmSushiLiquidityPoolProvider {

    function deposit(uint256 _amount) external payable returns (uint256 _depositedAmount){

    }    

    function deposit(address _erc20, uint256 _amount) external payable returns (uint256 _depositedAmount){
    
    }

    function withdraw(address recipient) external returns (uint256 _returnedAmount){
    
    }

}