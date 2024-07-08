// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import "../src/Genset.sol";

contract GensetScript is Script {
    function setUp() public {}

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        Gensets genset = new Gensets();

        console.log("Genset deployed to:", address(genset));
        console.log("Genset Owner:", genset.owner());

        vm.stopBroadcast();
    }
}
