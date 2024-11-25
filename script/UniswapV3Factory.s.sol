// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.12;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {UniswapV3Factory} from "@uniswap/v3-core/UniswapV3Factory.sol";

contract UniswapV3FactoryScript is Script {
    UniswapV3Factory public factory;

    function setUp() public {}

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        factory = new UniswapV3Factory();

        console.log("Factory deployed at", address(factory));

        vm.stopBroadcast();
    }
}
