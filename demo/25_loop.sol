// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Loop {

    uint public count;

    function run(uint loopCount) external pure returns (uint _count) {
        for (uint i = 0; i < loopCount; i++) {
            _count += 1;
        }
    }

    function loop(uint loopCount) external pure returns (uint _count) {
        uint i;
        for (; i < loopCount; i++) {
            _count += 1;
        }
    }

    function breakLoop(uint stopPoint) external pure returns (uint) {
        uint i;
        while (true) {
            i += 1;
            if (i >= stopPoint) {
                break;
            }
        }

        return i;
    }
}