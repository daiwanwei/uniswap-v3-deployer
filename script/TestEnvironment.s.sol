// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.12;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {UniswapV3Factory} from "@uniswap/v3-core/UniswapV3Factory.sol";
import {UniswapV3Pool} from "@uniswap/v3-core/UniswapV3Pool.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/ERC20Mock.sol";
import {TickMath} from "@uniswap/v3-core/libraries/TickMath.sol";

contract TestEnvironmentScript is Script {

    address public sender;

    ERC20Mock public token0;
    ERC20Mock public token1;

    UniswapV3Factory public factory;
    UniswapV3Pool public pool;



    function setUp() public {
        sender = vm.addr(vm.envUint("PRIVATE_KEY"));
    }

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        ERC20Mock tokenX = new ERC20Mock();
        ERC20Mock tokenY = new ERC20Mock();
        token0 = address(tokenX) < address(tokenY) ? tokenX : tokenY;
        token1 = address(tokenX) < address(tokenY) ? tokenY : tokenX;

        token0.mint(sender, 1_000_000_000);
        token1.mint(sender, 1_000_000_000);

        factory = new UniswapV3Factory();
        pool = UniswapV3Pool(factory.createPool(address(token0), address(token1), 3000));
        pool.initialize(14295128739);


        token0.approve(address(pool), type(uint256).max);
        token1.approve(address(pool), type(uint256).max);

        int24 tickLower = TickMath.getTickAtSqrtRatio(14295128739);
        int24 tickUpper = TickMath.getTickAtSqrtRatio(24295128739);


        // TODO: Mint
        // pool.mint(sender, tickLower, tickUpper, 1_000, new bytes(0));

        console.log("Token0 deployed at", address(token0));
        console.log("Token1 deployed at", address(token1));
        console.log("Factory deployed at", address(factory));
        console.log("Pool deployed at", address(pool));

        vm.stopBroadcast();
    }
}
