// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface Animal {
    function run(uint256 speed) external returns (uint256);
}

contract Cat is Animal {
    function run(uint256 speed) public pure override returns (uint256) {
        return speed * speed;
    }
}

contract Dog is Animal {
    function run(uint256 speed) public pure override returns (uint256) {
        return speed * speed;
    }
}
