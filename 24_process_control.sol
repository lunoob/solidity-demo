// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ProcessControl {

    function check(uint count) public pure returns (uint) {
        if (count == 1) {
            return 123;
        } else if (count >= 5) {
            return 5;
        } else {
            return 10;
        }
    }
}