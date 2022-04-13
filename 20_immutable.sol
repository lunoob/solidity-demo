// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Immutable {
    address public immutable MY_ADDRESS;
    uint public immutable MY_UINT;

    constructor() {
        MY_ADDRESS = 0x998Be2B0425cd5Ac7f779e46bB40d76D267AbeF9;
        MY_UINT = 666;
    }
}