// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Counter {
    uint public count;

    function dec() public {
        count -= 1;
    }

    function inc() public {
        count += 1;
    }
}