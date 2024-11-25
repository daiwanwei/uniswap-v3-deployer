// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.12;

import {IUniswapV3Pool} from "@uniswap/v3-core/interfaces/IUniswapV3Pool.sol";
contract Counter {
    uint256 public number;

    function setNumber(uint256 newNumber) public {
        number = newNumber;

        IUniswapV3Pool pool = IUniswapV3Pool(address(this));
    }

    function increment() public {
        number++;
    }
}
