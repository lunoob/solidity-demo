// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract A {
    function foo() external virtual pure returns (string memory) {
        return "A";
    }
    function baz() external virtual pure returns (string memory) {
        return "A";
    }
}

contract B is A {
    function foo() external override pure returns (string memory) {
        return "B";
    }
}