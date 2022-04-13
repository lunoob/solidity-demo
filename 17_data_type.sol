// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract DataType {
    int public minInt = type(int).min;
    int public maxInt = type(int).max;

    // default values
    int public defaultInt;
    bool public defaultBool;
    address public defaultAddress;
    uint public defaultUint;
}