// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
// 多线继承
contract A {
    function foo() external virtual pure returns (string memory) {
        return "A";
    }

    function baz() external virtual pure returns (string memory) {
        return "A";
    }

    function x() external pure returns (string memory) {
        return "A";
    }
}

contract B is A {
    function foo() external virtual override pure returns (string memory) {
        return "B";
    }

    function y() external virtual pure returns (string memory) {
        return "B";
    }
}

contract C is A, B {
    function foo() external override(A, B) pure returns (string memory) {
        return "C";
    }

    function y() external virtual override pure returns (string memory) {
        return "C";
    }
}