// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract EasyExample {
    uint count;
    constructor(uint _count) {
        count = _count;
    }

    function getCount() external view returns (uint) {
        return count;
    }

    function setCount(uint _count) external {
        count = _count;
    }
}